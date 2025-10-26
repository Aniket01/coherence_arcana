# 🧩 Coherence Arcana
Coherence Arcana is a strategy–memory puzzle set in the mysterious realm of quantum circuits.
As Player, your task is simple but perilous — recreate a fleeting quantum circuit before decoherence consumes it.

You’ll glimpse a quantum circuit for a few seconds. Then, using draggable circuit cards, you must rebuild it from memory on the game board. Each drag or drop increases your Decoherence Meter — fill it, and the circuit collapses.

As you build, the **Decoherence Meter** rises with each action. If it fills up, your circuit collapses and you’ll have to reset.
Use your limited **Artifact Cards** to undo mistakes or stabilize the system, but remember — every artifact use comes at a price.

# 🎮 Play The Game Here ⬇️:
[Android APK](https://github.com/Aniket01/coherence_arcana/releases/download/v1.0.0/coherence_arcana_v1.0.apk) <br/>
[Ready to play Web Version](https://coherence-arcana-v1-0-0.netlify.app/)

## 🎮 Gameplay Overview

1.  **Observe:**
    At the start of each round, you’ll briefly see a completed quantum circuit.

2.  **Recreate:**
    Use drag-and-drop controls to rebuild the circuit on the board.

3.  **Manage Decoherence:**
    Each move increases the **Decoherence Meter**. If it reaches the top, you lose coherence and must reset.

4.  **Use Artifacts Wisely:**
    *Artifact Cards* can:
    * **Stabilizer Card:** Remove a wrongly placed card from the board.
    * **Noise Filter:** Discard unnecessary cards from your hand.
    * **Coherent Qubit:** Decrease the Decoherence Meter’s progress.

    Each artifact use costs **10 points**.

5.  **Measure:**
    Once your circuit is ready, press **Measure** to finalize it and calculate your score.

## 🧮 Scoring System

| Action | Points |
| :--- | :--- |
| ✅ Correct circuit measured | 100 pts |
| ❌ Wrong circuit measured | 0 pts |
| 🔄 Extra moves (beyond minimum) | –5 pts each |
| 🪄 Artifact used | –10 pts each |
| 🃏 Non-discarded cards in hand | –5 pts each |

## ⚛️ Core Mechanics

* **Memory & Precision:** Quickly recall and rebuild quantum circuits.
* **Strategic Planning:** Balance your actions against decoherence buildup.
* **Risk vs Reward:** Use artifacts to recover from mistakes, but at a cost.

## 🚀 Technologies Used

* **Language:** Dart/Flutter
* **Platform:** Web, Android
