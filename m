From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 0/7] thermal: rcar_gen3_thermal: add support for interrupt triggerd trip points
Date: Wed, 29 Mar 2017 20:43:49 +0200
Message-ID: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

Hi,

This series adds support for hardware backed trip point windows. It is
based on top of v4.11-rc1 and is tested on R-Car H3 and M3-W.

The series starts out by fixing three issues (1/7, 2/7, 3/7) that should
have been fixed by me before the initial driver where submitted to
upstream. Sorry for not spotting the issues sooner.

The series then extends the rcar_gen3_thermal driver with hardware
interrupts for trip point windows by implementing the .set_trips()
callback of struct thermal_zone_of_device_ops (4/7, 5/7). It then adds
suspend and resume handlers so that the hardware interrupts are
preserved across suspend/resume cycles (6/7, 7/7).

* Changes since v2
- Corrected spelling
- Collected Reviewed-by tags
- Move num_tscs to bellow the pointers inside struct 
  rcar_gen3_thermal_priv to avoid implicit gap
- Assign num_tscs after the TSCs loop instead of increment it once each 
  loop iteration.
- Use bool instead of int for on parameter in rcar_thermal_irq_set()
- Merge 'val' variable declaration and assignment in 
  rcar_thermal_irq_set().
- Use spin_lock instead of spin_lock_irqsave in the ISR.
- Add comment about that the driver only uses 2 of the 3 available c
  interrupts.

* Changes since v1
- Added check that at least one TSC is found
- Record number of TSC in private data structure
- Request interrupts separately from TSCs
- Have only one function which controls both IRQ on and off
- Check return value from of_thermal_get_ntrips()
- Fixed spelling in commit messages
- Add Reviewed-by tags

Niklas Söderlund (7):
  thermal: rcar_gen3_thermal: add delay in .thermal_init on r8a7796
  thermal: rcar_gen3_thermal: remove unneeded mutex
  thermal: rcar_gen3_thermal: check that TSC exists before memory
    allocation
  thermal: rcar_gen3_thermal: record and check number of TSCs found
  thermal: rcar_gen3_thermal: enable hardware interrupts for trip points
  thermal: rcar_gen3_thermal: store device match data in private
    structure
  thermal: rcar_gen3_thermal: add suspend and resume support

 drivers/thermal/rcar_gen3_thermal.c | 199 +++++++++++++++++++++++++++++++++---
 1 file changed, 184 insertions(+), 15 deletions(-)

-- 
2.12.1
