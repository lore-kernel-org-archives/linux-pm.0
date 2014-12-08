From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 0/5] thermal: of: of-thermal.c API extensions
Date: Mon, 08 Dec 2014 18:04:16 +0100
Message-ID: <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
References: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34612 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaLHRFH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 12:05:07 -0500
In-reply-to: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>, navneet kumar <navneetk@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>

Provided patch series extend of-thermal.c file API. It is necessary 
for ongoing Exynos TMU rework.

First version of this code can be found at:
http://www.spinics.net/lists/linux-samsung-soc/msg37719.html

Second version:
http://www.spinics.net/lists/kernel/msg1872274.html

This code provides methods to access some of-thermal local data.
Moreover it provides a read only access to of-thermal trip points.

Lukasz Majewski (5):
  thermal: of: Extend of-thermal.c to provide number of trip points
  thermal: of: Extend of-thermal.c to provide check if trip point is
    valid
  thermal: of: Rename struct __thermal_trip to struct thermal_trip
  thermal: of: Extend of-thermal to export table of trip points
  thermal: of: Extend current of-thermal.c code to allow setting
    emulated temp

 drivers/thermal/of-thermal.c   | 109 ++++++++++++++++++++++++++++++++++-------
 drivers/thermal/thermal_core.h |  18 +++++++
 include/linux/thermal.h        |  18 +++++++
 3 files changed, 127 insertions(+), 18 deletions(-)

-- 
2.0.0.rc2

