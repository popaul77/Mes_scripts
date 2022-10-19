<?php
// diaporama.php
/* Ce script montre comment faire un diaporama en PHP

		On n'affiche successivement toute les diapo d'un répertoire et on revient
		à la première quand on a terminer ou on fait l'inverse.
		Normalement si on rajoute ou enlève des diapos entre deux clics on met
		de l'incertitude temporaire dans la chronologie mais l'algorithme ne plante pas.

		Chaque appel doit fournir le répertoire et un n° de diapo
		dans la chaîne de requête suivant l'url
		On utilise la methode GET car on utilise des envoi par le menu.
		Deux utilisations réalistes pour lancer ce script:
			a) Un menu passe l'url du script et le n° de diapo 0 (zéro)
			b) Dans une série de vignettes, le clic sur l'une d'elles
					passe l'url du script et le n° de la vignette


*/



error_reporting(E_ALL &~E_NOTICE);	// EasyPhp n'affiche pas les notices

// Initialisations

$b_diapo = false;			// à priori, je n'ai pas de diapo (Pessimiste ?)
$texte = '';					// futur contenu du <body> html
$filtre = '\.(jpg|gif|png)';	// régex d'identification des extensions de diapo
$hauteur = '450';			// hauteur d'affichage des diapo en pixels

// A - C'est là que ça commence
// Est-ce que je connais le répertoire et le n° de la diapo ?
// 	Normalement comme dit ci-dessus, je peux recevoir ces informations grâce
// 	à un choix dans un menu. Le cas ci-dessous (par formulaire) risque d'être
//  peu utilisé
//  Mais c'est quand même là quil faut vérifier que l'uri est valide

if ( (isset($_GET['dir'])) && (isset($_GET['nr'])) ) {
	$dir = $_GET['dir'];
	$nr = $_GET['nr'];
	$b_diapo = true;
	}


if (!($b_diapo)) {
	// Si je n'ai pas mes infos, je les demande
	// renvoi au module appelant, à la page d'accueil ...
	// ou, comme ici, par un formulaire
	// (Le répertoire, est le répertoire relatif à celui du script)
	$texte .= '<form action="'.$_SERVER['PHP_SELF'].'" method="get" name="diaporama">'
						.'<input type="hidden" name="nr" value="0" />'
						.'<input type="text"  name="dir" value=""/>'
						.'<input type="submit"  value="Valider"/>'
						.'</form>'
						;
	}
	else {
	// 	B - C'est là que ça recommence
	//	Je connais le répertoire et le n° de la diapo
		// 	1. je repère toutes les diapos du répertoire et je
		//		 met leurs noms dans un tableau
	if ( $handle = opendir($dir) ) {
		while (false !== ($file = readdir($handle))) {
			if (preg_match('/'.$filtre.'/s',strtolower($file))) {
				$diapos[] = $file; // élément 0 du tableau puis suivants ;
				}
			}	// on pourrait s'arrêter au n° de la diapo
		closedir($handle);
		} else {echo $dir.' NON TROUVE ';}
		// 2. Si j'ai des diapos
	if (isset($diapos[0])) {
		$max = count($diapos);	// nombre de diapo trouvées
		if (!($nr<$max)) {	// au cas ou on m'a oté des diapos entre-temps, je réduit le N°
			$nr = $max-1;
			}
		// 3. J'affiche la diapo
		$texte .= '<img src="'.$dir.'/'.$diapos[$nr].'" alt="" height="'.$hauteur.'" />';
		// 4. Je fais un menu
		$texte .= '<ul class="suivante">';
			// (nr + (max+1)) modulo max  = n° précédent
			$texte .= '<li><a href="'
				.$_SERVER['PHP_SELF'].'?dir='.$dir.'&nr='.strval(($nr+($max-1))%$max).'" >'
				.'&nbsp; << Précédente &nbsp;'
				.'</a></li>'
				;
			$texte .= ' ';
			// Retour au module d'où je venais (event. modifier l'url)
			$texte .= '<li><a href="'
				.$_SERVER['PHP_SELF'].'" >'
				.'&nbsp;  ^Retour^ &nbsp;'
				.'</a></li>'
				;
			$texte .= ' ';
			// (nr + 1) modulo max  = n° suivant
			$texte .= '<li><a href="'
				.$_SERVER['PHP_SELF'].'?dir='.$dir.'&nr='.strval(($nr+1)%$max).'" >'
				.'&nbsp; Suivante >> &nbsp;'
				.'</a></li>'
				;
		$texte .= '</ul>';
		}
		else { 	echo $_GET['dir'].' vide';}

		// NB. l'utilisation de $_SERVER['PHP_SELF'] (moi-même) comme url
		// permet de faire fonctionner ce script quelque soit son nom

	}

?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>Choisir un image</title>
<!-- Pour avoir mon menu sur une seule ligne -->
<style type="text/css">
	.suivante li {display: inline;}
 </style>
</head>

<body>

<?php

echo $texte;

 ?>

</body>
</html>
