From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 02/16] Platform: OLPC: Remove an unused include
Date: Mon,  7 Jan 2019 19:34:25 +0100
Message-ID: <20190107183439.50626-3-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

Also, the header is x86 specific, while there are non-x86 OLPC machines.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/platform/olpc/olpc-ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 374a8028fec7..981955dce926 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
=20
 struct ec_cmd_desc {
 	u8 cmd;
--=20
2.20.1
