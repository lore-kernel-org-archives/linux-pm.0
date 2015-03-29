From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] MAINTAINERS: Add me as maintainer of Nokia N900 power supply drivers
Date: Sun, 29 Mar 2015 15:35:54 +0200
Message-ID: <1427636154-20874-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 MAINTAINERS |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72a08ef..50df61e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6917,6 +6917,17 @@ T:	git git://git.rocketboards.org/linux-socfpga-=
next.git
 S:	Maintained
 F:	arch/nios2/
=20
+NOKIA N900 POWER SUPPLY DRIVERS
+M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
+S:	Maintained
+F:	include/linux/power/bq2415x_charger.h
+F:	include/linux/power/bq27x00_battery.h
+F:	include/linux/power/isp1704_charger.h
+F:	drivers/power/bq2415x_charger.c
+F:	drivers/power/bq27x00_battery.c
+F:	drivers/power/isp1704_charger.c
+F:	drivers/power/rx51_battery.c
+
 NTB DRIVER
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
--=20
1.7.9.5
