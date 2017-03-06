From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/7] thermal: rcar_gen3_thermal: add support for interrupt triggerd trip points
Date: Mon,  6 Mar 2017 21:03:54 +0100
Message-ID: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
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
not have been fixed by me before the initial driver where submitted to 
upstream. Sorry for not spotting the issues sooner.

The series then extends the rcar_gen3_thermal driver with hardware 
interrupts for trip point windows by implementing the .set_trips() 
callback of struct thermal_zone_of_device_ops (4/7, 5/7). It then adds 
suspend and resume handlers so that the hardware interrupts are 
preserved across suspend/resume cycles (6/7, 7/7).

Niklas Söderlund (7):
  thermal: rcar_gen3_thermal: add delay in .thermal_init on r8a7796
  thermal: rcar_gen3_thermal: fix probe error path
  thermal: rcar_gen3_thermal: remove unneeded mutex
  thermal: rcar_gen3_thermal: record more information about each TSC
  thermal: rcar_gen3_thermal: enable hardware interrupts for trip points
  thermal: rcar_gen3_thermal: store device match data in private
    structure
  thermal: rcar_gen3_thermal: add suspend and resume support

 drivers/thermal/rcar_gen3_thermal.c | 199 +++++++++++++++++++++++++++++++++---
 1 file changed, 187 insertions(+), 12 deletions(-)

-- 
2.12.0
