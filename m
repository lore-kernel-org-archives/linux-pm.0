From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/4] constify thermal_zone_of_device_ops structures
Date: Sat,  5 Aug 2017 22:37:13 +0200
Message-ID: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:55704
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751434AbdHEVCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Aug 2017 17:02:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-rpi-kernel@lists.infradead.org

The thermal_zone_of_device_ops structures are only passed as the fourth
argument to thermal_zone_of_sensor_register, which is declared as const.
Thus the thermal_zone_of_device_ops structures themselves can be const.

Done with the help of Coccinelle.

---

 drivers/thermal/broadcom/bcm2835_thermal.c |    2 +-
 drivers/thermal/qoriq_thermal.c            |    2 +-
 drivers/thermal/samsung/exynos_tmu.c       |    2 +-
 drivers/thermal/zx2967_thermal.c           |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
