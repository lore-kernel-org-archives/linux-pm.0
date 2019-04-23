From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v3 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Date: Tue, 23 Apr 2019 23:14:12 +0900
Message-ID: <20190423141414.24264-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, erosca@de.adit-jv.com, george_davis@mentor.com, joshua_frkuska@mentor.com
List-Id: linux-pm@vger.kernel.org

There are issues with interrupt handling in rcar_gen3_thermal driver.

Currently IRQ is remain enabled after .remove, later if device is probed,
IRQ is requested before .thermal_init, this may cause IRQ function be
triggered but not able to clear IRQ status, thus cause system to hang.

Since the irq line isn't shared between different devices,
so the proper interrupt type flag should be IRQF_ONESHOT.

This patch-set fix these interrupt handling retated issues.

---
v3: fix to use correct code base
    remove unused "flag" variable in rcar_gen3_thermal_irq

v2: use irq type IRQF_ONESHOT instead of IRQF_SHARED
    disable interrupt in .remove

v1: initial version

Jiada Wang (2):
  thermal: rcar_gen3_thermal: fix interrupt type
  thermal: rcar_gen3_thermal: disable interrupt in .remove

Jiada Wang (2):
  thermal: rcar_gen3_thermal: fix interrupt type
  thermal: rcar_gen3_thermal: disable interrupt in .remove

 drivers/thermal/rcar_gen3_thermal.c | 37 +++++++----------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

-- 
2.19.2
