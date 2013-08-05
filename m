From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH] MAINTAINERS: drivers/power: add entry for SmartReflex AVS drivers
Date: Mon,  5 Aug 2013 09:29:37 -0700
Message-ID: <1375720177-20063-1-git-send-email-khilman@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

The SmartReflex AVS driver evolved out of the OMAP kernel and now
lives under drivers/power/avs.

I've historically been maintainer of this but Nishanth Menon is doing
most of the heavy lifting now.  Add us both as co-maintainers.

Cc: Anton Vorontsov <anton@enomsg.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index defc053..466ca61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6450,6 +6450,14 @@ S:	Maintained
 F:	include/linux/power_supply.h
 F:	drivers/power/
 
+SMARTREFLEX DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
+M:	Kevin Hilman <khilman@kernel.org>
+M:	Nishanth Menon <nm@ti.com>
+S:	Maintained
+F:	drivers/power/avs/smartreflex.c
+F:      include/linux/power/smartreflex.h
+L:	linux-pm@vger.kernel.org
+
 PNP SUPPORT
 M:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 M:	Bjorn Helgaas <bhelgaas@google.com>
-- 
1.8.3
