From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH] drivers: thermal: Mark function as static in
 x86_pkg_temp_thermal.c
Date: Wed, 18 Dec 2013 23:16:02 +0530
Message-ID: <20131218174602.GA27918@rashika>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:34662 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3LRRqM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 12:46:12 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, josh@joshtriplett.org

Mark function sys_set_trip_temp() as static in x86_pkg_temp_thermal.c
because it is not used outside this file.

This eliminates the following warning in x86_pkg_temp_thermal.c:
drivers/thermal/x86_pkg_temp_thermal.c:218:5: warning: no previous prot=
otype for =E2=80=98sys_set_trip_temp=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/thermal/x86_pkg_temp_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x=
86_pkg_temp_thermal.c
index 7722cb9..972e1c7 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -215,7 +215,7 @@ static int sys_get_trip_temp(struct thermal_zone_de=
vice *tzd,
 	return 0;
 }
=20
-int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
+static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip=
,
 							unsigned long temp)
 {
 	u32 l, h;
--=20
1.7.9.5

