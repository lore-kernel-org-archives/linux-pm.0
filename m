From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 03/10] x86, olpc: Trivial code move in DT fixup
Date: Sun, 10 Mar 2019 17:24:12 +0100
Message-ID: <20190310162419.11861-4-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

This makes the following patch more concise.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v5:
- This patch was split off from "x86, olpc: Use a correct version when
  making up a battery node"

 arch/x86/platform/olpc/olpc_dt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index b69c50cb9742..adf98b5623c0 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -238,11 +238,6 @@ void __init olpc_dt_fixup(void)
=20
 	pr_info("PROM DT: Old firmware detected, applying fixes\n");
=20
-	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery@0\" find-device");
-	olpc_dt_interpret("  \" olpc,xo1-battery\" +compatible");
-	olpc_dt_interpret("device-end");
-
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
@@ -268,6 +263,11 @@ void __init olpc_dt_fixup(void)
 		olpc_dt_interpret(" \" olpc,xo1-rtc\" +compatible");
 		olpc_dt_interpret("device-end");
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
