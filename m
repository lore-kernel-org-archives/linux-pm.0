From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v7 04/13] dt-bindings: ddr: rename lpddr2 directory
Date: Mon,  6 May 2019 17:11:52 +0200
Message-ID: <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Change directory name to be ready for new types of memories.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/ddr/lpddr2-timings.txt     |  52 +++++++++++
 Documentation/devicetree/bindings/ddr/lpddr2.txt   | 102 +++++++++++++++++++++
 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |  52 -----------
 .../devicetree/bindings/lpddr2/lpddr2.txt          | 102 ---------------------
 4 files changed, 154 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
 delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt

diff --git a/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
new file mode 100644
index 0000000..9ceb19e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
@@ -0,0 +1,52 @@
+* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
+
+Required properties:
+- compatible : Should be "jedec,lpddr2-timings"
+- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
+- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and the default unit is ps (pico seconds). Parameters with
+a different unit have a suffix indicating the unit such as 'tRAS-max-ns'
+- tRCD
+- tWR
+- tRAS-min
+- tRRD
+- tWTR
+- tXP
+- tRTP
+- tDQSCK-max
+- tFAW
+- tZQCS
+- tZQinit
+- tRPab
+- tZQCL
+- tCKESR
+- tRAS-max-ns
+- tDQSCK-max-derated
+
+Example:
+
+timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+	compatible	= "jedec,lpddr2-timings";
+	min-freq	= <10000000>;
+	max-freq	= <400000000>;
+	tRPab		= <21000>;
+	tRCD		= <18000>;
+	tWR		= <15000>;
+	tRAS-min	= <42000>;
+	tRRD		= <10000>;
+	tWTR		= <7500>;
+	tXP		= <7500>;
+	tRTP		= <7500>;
+	tCKESR		= <15000>;
+	tDQSCK-max	= <5500>;
+	tFAW		= <50000>;
+	tZQCS		= <90000>;
+	tZQCL		= <360000>;
+	tZQinit		= <1000000>;
+	tRAS-max-ns	= <70000>;
+};
diff --git a/Documentation/devicetree/bindings/ddr/lpddr2.txt b/Documentation/devicetree/bindings/ddr/lpddr2.txt
new file mode 100644
index 0000000..ddd4012
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr2.txt
@@ -0,0 +1,102 @@
+* LPDDR2 SDRAM memories compliant to JEDEC JESD209-2
+
+Required properties:
+- compatible : Should be one of - "jedec,lpddr2-nvm", "jedec,lpddr2-s2",
+  "jedec,lpddr2-s4"
+
+  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
+
+  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
+
+  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
+
+- density  : <u32> representing density in Mb (Mega bits)
+
+- io-width : <u32> representing bus width. Possible values are 8, 16, and 32
+
+Optional properties:
+
+The following optional properties represent the minimum value of some AC
+timing parameters of the DDR device in terms of number of clock cycles.
+These values shall be obtained from the device data-sheet.
+- tRRD-min-tck
+- tWTR-min-tck
+- tXP-min-tck
+- tRTP-min-tck
+- tCKE-min-tck
+- tRPab-min-tck
+- tRCD-min-tck
+- tWR-min-tck
+- tRASmin-min-tck
+- tCKESR-min-tck
+- tFAW-min-tck
+
+Child nodes:
+- The lpddr2 node may have one or more child nodes of type "lpddr2-timings".
+  "lpddr2-timings" provides AC timing parameters of the device for
+  a given speed-bin. The user may provide the timings for as many
+  speed-bins as is required. Please see Documentation/devicetree/
+  bindings/ddr/lpddr2-timings.txt for more information on "lpddr2-timings"
+
+Example:
+
+elpida_ECB240ABACN : lpddr2 {
+	compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+	density		= <2048>;
+	io-width	= <32>;
+
+	tRPab-min-tck	= <3>;
+	tRCD-min-tck	= <3>;
+	tWR-min-tck	= <3>;
+	tRASmin-min-tck	= <3>;
+	tRRD-min-tck	= <2>;
+	tWTR-min-tck	= <2>;
+	tXP-min-tck	= <2>;
+	tRTP-min-tck	= <2>;
+	tCKE-min-tck	= <3>;
+	tCKESR-min-tck	= <3>;
+	tFAW-min-tck	= <8>;
+
+	timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+		compatible	= "jedec,lpddr2-timings";
+		min-freq	= <10000000>;
+		max-freq	= <400000000>;
+		tRPab		= <21000>;
+		tRCD		= <18000>;
+		tWR		= <15000>;
+		tRAS-min	= <42000>;
+		tRRD		= <10000>;
+		tWTR		= <7500>;
+		tXP		= <7500>;
+		tRTP		= <7500>;
+		tCKESR		= <15000>;
+		tDQSCK-max	= <5500>;
+		tFAW		= <50000>;
+		tZQCS		= <90000>;
+		tZQCL		= <360000>;
+		tZQinit		= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+	timings_elpida_ECB240ABACN_200mhz: lpddr2-timings@1 {
+		compatible	= "jedec,lpddr2-timings";
+		min-freq	= <10000000>;
+		max-freq	= <200000000>;
+		tRPab		= <21000>;
+		tRCD		= <18000>;
+		tWR		= <15000>;
+		tRAS-min	= <42000>;
+		tRRD		= <10000>;
+		tWTR		= <10000>;
+		tXP		= <7500>;
+		tRTP		= <7500>;
+		tCKESR		= <15000>;
+		tDQSCK-max	= <5500>;
+		tFAW		= <50000>;
+		tZQCS		= <90000>;
+		tZQCL		= <360000>;
+		tZQinit		= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+}
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt b/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
deleted file mode 100644
index 9ceb19e..0000000
--- a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
-
-Required properties:
-- compatible : Should be "jedec,lpddr2-timings"
-- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
-- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
-
-Optional properties:
-
-The following properties represent AC timing parameters from the memory
-data-sheet of the device for a given speed-bin. All these properties are
-of type <u32> and the default unit is ps (pico seconds). Parameters with
-a different unit have a suffix indicating the unit such as 'tRAS-max-ns'
-- tRCD
-- tWR
-- tRAS-min
-- tRRD
-- tWTR
-- tXP
-- tRTP
-- tDQSCK-max
-- tFAW
-- tZQCS
-- tZQinit
-- tRPab
-- tZQCL
-- tCKESR
-- tRAS-max-ns
-- tDQSCK-max-derated
-
-Example:
-
-timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
-	compatible	= "jedec,lpddr2-timings";
-	min-freq	= <10000000>;
-	max-freq	= <400000000>;
-	tRPab		= <21000>;
-	tRCD		= <18000>;
-	tWR		= <15000>;
-	tRAS-min	= <42000>;
-	tRRD		= <10000>;
-	tWTR		= <7500>;
-	tXP		= <7500>;
-	tRTP		= <7500>;
-	tCKESR		= <15000>;
-	tDQSCK-max	= <5500>;
-	tFAW		= <50000>;
-	tZQCS		= <90000>;
-	tZQCL		= <360000>;
-	tZQinit		= <1000000>;
-	tRAS-max-ns	= <70000>;
-};
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt b/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
deleted file mode 100644
index 58354a0..0000000
--- a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-* LPDDR2 SDRAM memories compliant to JEDEC JESD209-2
-
-Required properties:
-- compatible : Should be one of - "jedec,lpddr2-nvm", "jedec,lpddr2-s2",
-  "jedec,lpddr2-s4"
-
-  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
-
-  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
-
-  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
-
-- density  : <u32> representing density in Mb (Mega bits)
-
-- io-width : <u32> representing bus width. Possible values are 8, 16, and 32
-
-Optional properties:
-
-The following optional properties represent the minimum value of some AC
-timing parameters of the DDR device in terms of number of clock cycles.
-These values shall be obtained from the device data-sheet.
-- tRRD-min-tck
-- tWTR-min-tck
-- tXP-min-tck
-- tRTP-min-tck
-- tCKE-min-tck
-- tRPab-min-tck
-- tRCD-min-tck
-- tWR-min-tck
-- tRASmin-min-tck
-- tCKESR-min-tck
-- tFAW-min-tck
-
-Child nodes:
-- The lpddr2 node may have one or more child nodes of type "lpddr2-timings".
-  "lpddr2-timings" provides AC timing parameters of the device for
-  a given speed-bin. The user may provide the timings for as many
-  speed-bins as is required. Please see Documentation/devicetree/
-  bindings/lpddr2/lpddr2-timings.txt for more information on "lpddr2-timings"
-
-Example:
-
-elpida_ECB240ABACN : lpddr2 {
-	compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
-	density		= <2048>;
-	io-width	= <32>;
-
-	tRPab-min-tck	= <3>;
-	tRCD-min-tck	= <3>;
-	tWR-min-tck	= <3>;
-	tRASmin-min-tck	= <3>;
-	tRRD-min-tck	= <2>;
-	tWTR-min-tck	= <2>;
-	tXP-min-tck	= <2>;
-	tRTP-min-tck	= <2>;
-	tCKE-min-tck	= <3>;
-	tCKESR-min-tck	= <3>;
-	tFAW-min-tck	= <8>;
-
-	timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
-		compatible	= "jedec,lpddr2-timings";
-		min-freq	= <10000000>;
-		max-freq	= <400000000>;
-		tRPab		= <21000>;
-		tRCD		= <18000>;
-		tWR		= <15000>;
-		tRAS-min	= <42000>;
-		tRRD		= <10000>;
-		tWTR		= <7500>;
-		tXP		= <7500>;
-		tRTP		= <7500>;
-		tCKESR		= <15000>;
-		tDQSCK-max	= <5500>;
-		tFAW		= <50000>;
-		tZQCS		= <90000>;
-		tZQCL		= <360000>;
-		tZQinit		= <1000000>;
-		tRAS-max-ns	= <70000>;
-	};
-
-	timings_elpida_ECB240ABACN_200mhz: lpddr2-timings@1 {
-		compatible	= "jedec,lpddr2-timings";
-		min-freq	= <10000000>;
-		max-freq	= <200000000>;
-		tRPab		= <21000>;
-		tRCD		= <18000>;
-		tWR		= <15000>;
-		tRAS-min	= <42000>;
-		tRRD		= <10000>;
-		tWTR		= <10000>;
-		tXP		= <7500>;
-		tRTP		= <7500>;
-		tCKESR		= <15000>;
-		tDQSCK-max	= <5500>;
-		tFAW		= <50000>;
-		tZQCS		= <90000>;
-		tZQCL		= <360000>;
-		tZQinit		= <1000000>;
-		tRAS-max-ns	= <70000>;
-	};
-
-}
-- 
2.7.4
