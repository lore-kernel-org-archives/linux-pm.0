From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/2] constify thermal_zone_of_device_ops structures
Date: Tue, 30 Oct 2018 16:14:58 +0100
Message-ID: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The thermal_zone_of_device_ops structures can be const as they are
only passed as the last argument of a thermal_zone_of_sensor_register
function and the corresponding parameter is declared as const.

Done with the help of Coccinelle.

---

 drivers/thermal/armada_thermal.c           |    2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
