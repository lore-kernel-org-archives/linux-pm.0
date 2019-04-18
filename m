From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v7 04/10] x86/platform/olpc: Use a correct version when making up a battery node
Date: Thu, 18 Apr 2019 16:46:49 +0200
Message-ID: <20190418144655.18758-5-lkundrak@v3.sk>
References: <20190418144655.18758-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature. We need to use a different compatible string for the
XO-1.5 battery.

Previously olpc_dt_fixup() used the presence of the battery node's
compatible property to decide whether the DT is up to date. Now we need
to look for a particular value in the compatible string, to decide

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

---
Changes since v6:
- s/od/of/ in the commit message
- Coalesce variables of the same type
- Fix block comment style
- Ack from Thomas Gleixner
- Fix the subject prefix to "x86/platform/olpc:"

Changes since v5:
- Split the "x86, olpc: Don't split string literals when fixing up the DT=
"
  and "x86, olpc: trivial code move in DT fixup" parts off from this
- Clarify some comments

Changes since v1:
- Avoid splitting string literals

 arch/x86/platform/olpc/olpc_dt.c | 64 +++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index 820236b511b3..0296c5b55e6f 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -220,10 +220,26 @@ static u32 __init olpc_dt_get_board_revision(void)
 	return be32_to_cpu(rev);
 }
=20
+int olpc_dt_compatible_match(phandle node, const char *compat)
+{
+	char buf[64], *p;
+	int plen, len;
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
 void __init olpc_dt_fixup(void)
 {
-	int r;
-	char buf[64];
 	phandle node;
 	u32 board_rev;
=20
@@ -231,22 +247,31 @@ void __init olpc_dt_fixup(void)
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
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
=20
 	if (board_rev >=3D olpc_board_pre(0xd0)) {
-		/* XO-1.5: add dcon device */
+		/* XO-1.5 */
+
+		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
+			return;
+
+		/* Add olpc,xo1.5-battery compatible marker to battery node */
+		olpc_dt_interpret("\" /battery@0\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1.5-battery\" +compatible");
+		olpc_dt_interpret("device-end");
+
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
+			/*
+			 * If we have a olpc,xo1-battery compatible, then we're
+			 * running a new enough firmware that already has
+			 * the dcon node.
+			 */
+			return;
+		}
+
+		/* Add dcon device */
 		olpc_dt_interpret("\" /pci/display@1\" find-device");
 		olpc_dt_interpret("  new-device");
 		olpc_dt_interpret("    \" dcon\" device-name");
@@ -254,7 +279,18 @@ void __init olpc_dt_fixup(void)
 		olpc_dt_interpret("  finish-device");
 		olpc_dt_interpret("device-end");
 	} else {
-		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
+		/* XO-1 */
+
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
+			/*
+			 * If we have a olpc,xo1-battery compatible, then we're
+			 * running a new enough firmware that already has
+			 * the dcon and RTC nodes.
+			 */
+			return;
+		}
+
+		/* Add dcon device, mark RTC as olpc,xo1-rtc */
 		olpc_dt_interpret("\" /pci/display@1,1\" find-device");
 		olpc_dt_interpret("  new-device");
 		olpc_dt_interpret("    \" dcon\" device-name");
--=20
2.21.0
