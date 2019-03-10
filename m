From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 02/10] x86, olpc: Don't split string literals when fixing up the DT
Date: Sun, 10 Mar 2019 17:24:11 +0100
Message-ID: <20190310162419.11861-3-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

It was pointed out in a review, and checkpatch.pl complains about this.
Breaking it down into multiple ofw evaluations works just as well, and
perhaps even reads better.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v5:
- This patch was split off from "x86, olpc: Use a correct version when
  making up a battery node"

 arch/x86/platform/olpc/olpc_dt.c | 33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index b4ab779f1d47..b69c50cb9742 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -239,9 +239,9 @@ void __init olpc_dt_fixup(void)
 	pr_info("PROM DT: Old firmware detected, applying fixes\n");
=20
 	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery@0\" find-device"
-		" \" olpc,xo1-battery\" +compatible"
-		" device-end");
+	olpc_dt_interpret("\" /battery@0\" find-device");
+	olpc_dt_interpret("  \" olpc,xo1-battery\" +compatible");
+	olpc_dt_interpret("device-end");
=20
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
@@ -249,19 +249,24 @@ void __init olpc_dt_fixup(void)
=20
 	if (board_rev >=3D olpc_board_pre(0xd0)) {
 		/* XO-1.5: add dcon device */
-		olpc_dt_interpret("\" /pci/display@1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end");
+		olpc_dt_interpret("\" /pci/display@1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
 	} else {
 		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
-		olpc_dt_interpret("\" /pci/display@1,1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end"
-			" \" /rtc\" find-device"
-			" \" olpc,xo1-rtc\" +compatible"
-			" device-end");
+		olpc_dt_interpret("\" /pci/display@1,1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
+
+		olpc_dt_interpret("\" /rtc\" find-device");
+		olpc_dt_interpret(" \" olpc,xo1-rtc\" +compatible");
+		olpc_dt_interpret("device-end");
 	}
 }
=20
--=20
2.20.1
