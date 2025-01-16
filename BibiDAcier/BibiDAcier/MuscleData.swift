//
//  MuscleData.swift
//  BibiDAcier
//
//  Created by neoxia on 16/01/2025.
//

import SwiftUI

// Structure pour représenter un groupe musculaire
struct MuscleGroup {
    let name: String
    let imageName: String
    let exercises: [String]
    let exerciseDetails: [String: String]
}
let muscleGroups: [MuscleGroup] = [
    MuscleGroup(
        name: "Arrières d'épaule",
        imageName: "arrièred'épaules_icon",
        exercises: ["Tirage corde", "Élévations latérales"],
        exerciseDetails: [
            "Tirage corde": "Le tirage corde, réalisé sur une poulie, est un exercice ciblant les deltoïdes postérieurs, les trapèzes et les muscles stabilisateurs de l'épaule. Cet exercice consiste à tirer une corde vers le visage, tout en gardant les coudes élevés et en contrôlant le mouvement.",
            "Élévations latérales": "Les élévations latérales pour l'arrière d'épaule se font en inclinant légèrement le buste vers l'avant, puis en levant les bras sur les côtés jusqu'à la hauteur des épaules. Ce mouvement isole les deltoïdes postérieurs."
        ]
    ),
    MuscleGroup(
        name: "Épaules",
        imageName: "épaules_icon",
        exercises: ["Élévation latérales poids libres/ poulie", "Press épaule", "Développé militaire banc"],
        exerciseDetails: [
            "Élévation latérales poids libres/ poulie": "Les élévations latérales consistent à lever les bras sur les côtés jusqu'à la hauteur des épaules, en utilisant des haltères ou une poulie. Cet exercice isole le faisceau moyen des deltoïdes, responsable de la largeur des épaules.",
            "Press épaule": "Le press épaule, réalisé avec des haltères, une barre ou sur une machine, consiste à pousser la charge au-dessus de la tête tout en maintenant une posture droite. Cet exercice sollicite principalement les deltoïdes antérieurs, tout en engageant les triceps et le haut du dos.",
            "Développé militaire banc": "Le développé militaire se pratique en position assise ou debout, avec une barre ou des haltères. Le mouvement consiste à pousser une charge de la hauteur des épaules jusqu’à l’extension complète des bras."
        ]
    ),
    MuscleGroup(
        name: "Pectoraux",
        imageName: "pectoraux_icon",
        exercises: ["Développé couché barre", "Développé couché haltères", "Convergente", "Pec Fly"],
        exerciseDetails: [
            "Développé couché barre": "Le développé couché avec barre est un exercice de base pour les pectoraux. Allongé sur un banc, vous poussez une barre de la poitrine vers le haut jusqu'à l'extension complète des bras. Cet exercice sollicite principalement les pectoraux, ainsi que les triceps et les deltoïdes antérieurs.",
            "Développé couché haltères": "Le développé couché avec haltères est similaire à la version avec barre, mais permet une plus grande amplitude de mouvement. Chaque bras travaille de manière indépendante, favorisant un meilleur équilibre musculaire.",
            "Convergente": "La presse convergente, réalisée sur une machine, guide le mouvement pour cibler efficacement les pectoraux. En position assise, vous poussez les poignées vers l’avant dans un mouvement convergent, simulant un développé.",
            "Pec Fly": "Le pec fly peut se faire sur une machine ou avec des haltères. Cet exercice consiste à écarter puis à rapprocher les bras en gardant une légère flexion des coudes, ce qui isole les pectoraux."
        ]
    ),
    MuscleGroup(
        name: "Triceps",
        imageName: "triceps_icon",
        exercises: ["Skull crusher", "Extensions triceps pouli corde/barre", "Dips"],
        exerciseDetails: [
            "Skull crusher": "Le skull crusher, ou extension couché avec barre, est un exercice qui cible les trois faisceaux du triceps. Allongé sur un banc, vous abaissez une barre (ou haltères) vers votre front avant de la repousser à l’extension complète des bras.",
            "Extensions triceps pouli corde/barre": "Les extensions à la poulie consistent à tirer une corde ou une barre vers le bas, en gardant les coudes fixes et près du corps. Cet exercice permet une tension continue sur les triceps tout au long du mouvement.",
            "Dips": "Les dips sont un exercice au poids du corps où vous descendez et remontez entre deux barres parallèles, en utilisant les triceps pour pousser le corps vers le haut."
        ]
    ),
    MuscleGroup(
        name: "Biceps",
        imageName: "biceps_icon",
        exercises: ["Curl classique barre/poids libres", "Curl pupitre barre/poids libres"],
        exerciseDetails: [
            "Curl classique barre/poids libres": "Le curl classique est un exercice fondamental pour développer les biceps. Il peut être réalisé avec une barre droite ou des haltères, et consiste à fléchir les coudes pour amener la charge vers les épaules, puis à redescendre lentement à la position initiale. Cet exercice cible principalement les biceps brachiaux, et peut être effectué debout ou assis. Il permet de développer la masse et la force des biceps tout en engageant également les muscles stabilisateurs des avant-bras.",
            "Curl pupitre barre/poids libres": "Le curl pupitre est réalisé sur un banc incliné (appelé pupitre), ce qui permet d'isoler davantage les biceps en limitant l'implication des autres muscles. En utilisant une barre ou des haltères, vous effectuez le mouvement de flexion du coude, mais avec un soutien qui évite de tricher. Cet exercice met l'accent sur la contraction des biceps dans une position plus isolée, réduisant l'élan et favorisant une meilleure activation musculaire. Il permet de cibler la partie inférieure des biceps, ce qui aide à obtenir une forme plus définie."
        ]
    ),
    MuscleGroup(
        name: "Dos",
        imageName: "dos_icon",
        exercises: ["Tirage verticale", "Tirage horizontale","Pull down"],
        exerciseDetails: [
            "Tirage verticale": "Le tirage vertical, réalisé à la poulie haute avec une barre ou une corde, est un exercice classique pour renforcer le dos. Il consiste à tirer la barre vers le bas, en gardant les coudes légèrement fléchis, jusqu'à la hauteur de la poitrine. Cet exercice sollicite principalement les muscles du dos, notamment les latissimus dorsi, les trapèzes et les rhomboïdes. Il aide à élargir le dos, améliorer la posture et augmenter la force des muscles du haut du dos.",
            "Tirage horizontale": "Le tirage horizontal se réalise généralement avec une poulie basse ou une machine à câble, en tirant la poignée vers soi tout en maintenant les coudes près du corps. Ce mouvement est essentiel pour travailler la partie médiane du dos. Cet exercice cible les muscles du dos moyen, comme les rhomboïdes et les trapèzes. Il renforce également les biceps et les épaules, tout en améliorant la posture et la stabilité du tronc.",
            "Pull down": "Le pull down à la barre est similaire au tirage vertical, mais avec une barre plus large et souvent utilisée avec une prise plus large. L'exercice consiste à tirer la barre vers le bas jusqu'à la poitrine tout en contrôlant le mouvement. Cet exercice sollicite principalement les latissimus dorsi (lats), mais fait également travailler les trapèzes et les biceps. Il est idéal pour élargir le dos et améliorer la force de tirage. Ce mouvement est particulièrement utile pour ceux qui souhaitent développer une musculature en V."
        ]
    ),
    MuscleGroup(
        name: "Quadriceps",
        imageName: "quadriceps_icon",
        exercises: ["Leg press", "Hack squat","Leg curl"],
        exerciseDetails: [
            "Leg press": "Le leg press est un exercice de musculation réalisé sur une machine spécifique où vous poussez une charge avec les jambes, en position assise ou inclinée. L'exercice sollicite principalement les quadriceps, mais aussi les fessiers et les ischio-jambiers. Cet exercice permet de travailler les quadriceps de manière intense tout en réduisant le stress sur le bas du dos, ce qui en fait une excellente option pour ceux qui cherchent à développer la force et la masse musculaire des jambes. Il offre également une grande possibilité de surcharge progressive.",
            "Hack squat": "Le hack squat se pratique sur une machine inclinée, où l'on effectue un mouvement similaire à celui du squat traditionnel, mais avec une position plus contrôlée. Les pieds sont placés sur la plateforme, et l'on abaisse le corps vers le bas en fléchissant les genoux. Cet exercice met particulièrement l'accent sur les quadriceps, tout en sollicitant les fessiers et les muscles stabilisateurs. Il est idéal pour ceux qui cherchent à cibler spécifiquement l'avant des cuisses, en toute sécurité. Il est souvent préféré par ceux qui veulent isoler les quadriceps tout en évitant de mettre trop de pression sur le bas du dos.",
            "Leg curl": "Le leg curl est un exercice qui se pratique avec une machine à ischio-jambiers et consiste à plier les genoux pour amener les talons vers les fessiers. Bien qu’il cible principalement les ischio-jambiers, il est souvent intégré dans des routines qui incluent des exercices pour les quadriceps, pour un travail complet des jambes. Bien que l'exercice cible les muscles opposés aux quadriceps, le leg curl contribue à l'équilibre musculaire des jambes. Il améliore la flexibilité et la force des ischio-jambiers, ce qui aide à prévenir les blessures et améliore la performance dans des mouvements comme le squat et le sprint."
        ]
    ),
    MuscleGroup(
        name: "Ischio",
        imageName: "ischio_icon",
        exercises: ["Curl inversé debout/allongé"],
        exerciseDetails: [
            "Curl inversé debout": "Le curl inversé debout se réalise avec une machine spécifique pour les ischio-jambiers. Debout, vous placez vos chevilles sous des coussinets, puis vous fléchissez les genoux pour amener les talons vers les fessiers, avant de redescendre lentement à la position de départ.Cet exercice cible les ischio-jambiers, mais il engage aussi les fessiers et les muscles stabilisateurs du tronc. Il est idéal pour développer la force et la masse musculaire des ischio-jambiers tout en prévenant les déséquilibres musculaires entre l’avant et l’arrière des jambes. Le fait de se tenir debout permet également de solliciter davantage les muscles stabilisateurs.",
            "Curl inversé allongé": "Le curl inversé allongé se fait sur une machine où vous vous allongez sur le ventre, avec vos chevilles placées sous des coussinets. À partir de cette position, vous fléchissez les genoux pour rapprocher les talons de vos fessiers. Cet exercice isole les ischio-jambiers de manière plus ciblée en limitant l'implication des autres muscles. Il permet d'étirer et de contracter les ischio-jambiers de manière optimale, favorisant leur développement musculaire et leur force. Il est également excellent pour améliorer la flexibilité et prévenir les blessures en renforçant cette zone souvent négligée."
        ]
    ),
    MuscleGroup(
        name: "Mollets",
        imageName: "mollets_icon",
        exercises: ["Extensions"],
        exerciseDetails: [
            "Extensions": "Les extensions de mollets sont un exercice classique pour cibler les muscles du mollet, notamment le gastrocnémien et le soléaire. Cet exercice peut être réalisé debout sur une machine ou assis, en utilisant une charge pour forcer les mollets à se contracter en élevant les talons et en tendant les chevilles. L'extension des mollets debout se fait en poussant contre une plateforme tout en maintenant une posture droite, tandis que l'extension des mollets assis cible davantage le soléaire en fléchissant les genoux. Ce mouvement permet de renforcer les mollets, d'améliorer leur endurance et de développer leur masse musculaire. Il est essentiel pour l’équilibre musculaire des jambes et aide à améliorer les performances dans des activités comme la course et les sauts."
        ]
    ),
    MuscleGroup(
        name: "Fessier",
        imageName: "fessier_icon",
        exercises: ["Leg press", "Hack squat", "Squat"],
        exerciseDetails: [
            "Leg press": "Le leg press est un exercice réalisé sur une machine où vous poussez une charge avec les jambes en position assise ou inclinée. Bien qu’il cible principalement les quadriceps, il engage aussi les fessiers et les ischio-jambiers, selon la position des pieds sur la plateforme. En ajustant la position des pieds (plus larges ou plus haut sur la plateforme), cet exercice peut accentuer le travail sur les fessiers, permettant ainsi de développer la force et la masse musculaire de cette zone. C'est un excellent moyen de solliciter les fessiers en toute sécurité, sans trop de stress sur le bas du dos.",
            "Hack squat": "Le hack squat est effectué sur une machine inclinée, et consiste à effectuer un squat avec les épaules et les hanches soutenues, permettant un travail intense des jambes, avec un accent particulier sur les fessiers. Cet exercice, similaire au squat traditionnel, met l'accent sur les fessiers tout en sollicitant également les quadriceps et les ischio-jambiers. Il permet de cibler spécifiquement les muscles du bas du corps, notamment les fessiers, tout en réduisant les risques de blessure, grâce à la position stable de la machine.",
            "Squat": "sLe squat est l'un des exercices les plus efficaces pour travailler les fessiers, les quadriceps et les ischio-jambiers. Il consiste à fléchir les genoux tout en maintenant une posture droite, et peut être réalisé avec ou sans charge (barre, haltères, kettlebells). Le squat sollicite fortement les fessiers, notamment lorsqu’il est effectué avec une profondeur importante. Il est essentiel pour renforcer le bas du corps, améliorer la stabilité et la mobilité des hanches et des genoux, et sculpter les fessiers. C'est un exercice fonctionnel qui aide à améliorer la performance dans de nombreuses activités physiques et sportives."
        ]
    ),
]
