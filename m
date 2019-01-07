From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 11/16] x86, olpc: Use a correct version when making up a battery node
Date: Mon,  7 Jan 2019 19:34:34 +0100
Message-ID: <20190107183439.50626-12-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature. Add a different compatible string to the 1.5
battery.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Avoid splitting string literals

 arch/x86/platform/olpc/olpc_dt.c | 84 +++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index b4ab779f1d47..8557add82752 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -217,10 +217,28 @@ static u32 __init olpc_dt_get_board_revision(void)
 	return be32_to_cpu(rev);
 }
=20
-void __init olpc_dt_fixup(void)
+int olpc_dt_compatible_match(phandle node, const char *compat)
 {
-	int r;
 	char buf[64];
+	int plen;
+	char *p;
+	int len;
+
+	plen =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
+	if (plen <=3D 0)
+		return 0;
+
+	len =3D strlen(compat);
+	for (p =3D buf; p < buf + plen; p +=3D strlen(p) + 1) {
+		if (strcmp(p, compat) =3D=3D 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+void __init olpc_dt_fixup(void)
+{
 	phandle node;
 	u32 board_rev;
=20
@@ -228,41 +246,51 @@ void __init olpc_dt_fixup(void)
 	if (!node)
 		return;
=20
-	/*
-	 * If the battery node has a compatible property, we are running a new
-	 * enough firmware and don't have fixups to make.
-	 */
-	r =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
-	if (r > 0)
-		return;
-
-	pr_info("PROM DT: Old firmware detected, applying fixes\n");
-
-	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery@0\" find-device"
-		" \" olpc,xo1-battery\" +compatible"
-		" device-end");
-
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
=20
 	if (board_rev >=3D olpc_board_pre(0xd0)) {
+		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
+			return;
+
+		/* Add olpc,xo1.5-battery compatible marker to battery node */
+		olpc_dt_interpret("\" /battery@0\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1.5-battery\" +compatible");
+		olpc_dt_interpret("device-end");
+
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
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
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
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
+		olpc_dt_interpret("\" /rtc\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1-rtc\" +compatible");
+		olpc_dt_interpret("device-end");
 	}
+
+	/* Add olpc,xo1-battery compatible marker to battery node */
+	olpc_dt_interpret("\" /battery@0\" find-device");
+	olpc_dt_interpret("  \" olpc,xo1-battery\" +compatible");
+	olpc_dt_interpret("device-end");
 }
=20
 void __init olpc_dt_build_devicetree(void)
--=20
2.20.1
