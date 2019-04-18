From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v7 03/10] x86/platform/olpc: Trivial code move in DT fixup
Date: Thu, 18 Apr 2019 16:46:48 +0200
Message-ID: <20190418144655.18758-4-lkundrak@v3.sk>
References: <20190418144655.18758-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

This makes the following patch more concise.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

---
Changes since v6:
- Collect ack from Thomas Gleixner
- Fix the subject prefix to "x86/platform/olpc:"

Changes since v5:
- This patch was split off from "x86, olpc: Use a correct version when
  making up a battery node"

 arch/x86/platform/olpc/olpc_dt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index 87e1d81684c6..820236b511b3 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -241,11 +241,6 @@ void __init olpc_dt_fixup(void)
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
@@ -271,6 +266,11 @@ void __init olpc_dt_fixup(void)
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
2.21.0
