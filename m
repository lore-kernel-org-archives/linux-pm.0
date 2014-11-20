From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 0/4] thermal: of: of-thermal.c API extensions
Date: Thu, 20 Nov 2014 17:21:24 +0100
Message-ID: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Provided patch series extend of-thermal.c file API. It is necessary 
for ongoing Exynos TMU rework.
First version of this code can be found at:
http://www.spinics.net/lists/linux-samsung-soc/msg37719.html

This code provides some methods to access some of-thermal local data.
Moreover it provides a read only copy of trip points.

Lukasz Majewski (4):
  thermal: of: Extend of-thermal.c to provide number of trip points
  thermal: of: Extend of-thermal.c to provide check if trip point is
    enabled
  thermal: of: Extend of-thermal to export table of trip points
  thermal: of: Extend current of-thermal.c code to allow setting
    emulated temp

 drivers/thermal/of-thermal.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h | 17 ++++++++
 include/linux/thermal.h        | 15 +++++++
 3 files changed, 129 insertions(+)

-- 
2.0.0.rc2
