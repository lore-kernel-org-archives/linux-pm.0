From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
Date: Tue,  8 Jan 2019 18:58:10 +0100
Message-ID: <20190108175818.705110-8-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

Just a cosmetic tidy-up.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- This patch was added to the set.

 include/linux/olpc-ec.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index e28f72416a57..c4602364e909 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OLPC_EC_H
 #define _LINUX_OLPC_EC_H
=20
+#include <linux/bits.h>
+
 /* XO-1 EC commands */
 #define EC_FIRMWARE_REV			0x08
 #define EC_WRITE_SCI_MASK		0x1b
@@ -17,17 +19,16 @@
 #define EC_EXT_SCI_QUERY		0x85
=20
 /* SCI source values */
-#define EC_SCI_SRC_EMPTY        0x00
-#define EC_SCI_SRC_GAME         0x01
-#define EC_SCI_SRC_BATTERY      0x02
-#define EC_SCI_SRC_BATSOC       0x04
-#define EC_SCI_SRC_BATERR       0x08
-#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
-#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
-#define EC_SCI_SRC_ACPWR        0x40
-#define EC_SCI_SRC_BATCRIT      0x80
-#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
-#define EC_SCI_SRC_ALL          0x1FF
+#define EC_SCI_SRC_GAME         BIT(0)
+#define EC_SCI_SRC_BATTERY      BIT(1)
+#define EC_SCI_SRC_BATSOC       BIT(2)
+#define EC_SCI_SRC_BATERR       BIT(3)
+#define EC_SCI_SRC_EBOOK        BIT(4)    /* XO-1 only */
+#define EC_SCI_SRC_WLAN         BIT(5)    /* XO-1 only */
+#define EC_SCI_SRC_ACPWR        BIT(6)
+#define EC_SCI_SRC_BATCRIT      BIT(7)
+#define EC_SCI_SRC_GPWAKE       BIT(8)   /* XO-1.5 only */
+#define EC_SCI_SRC_ALL          GENMASK(8, 0)
=20
 struct platform_device;
=20
--=20
2.20.1
