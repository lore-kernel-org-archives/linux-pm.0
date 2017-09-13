From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [RFC 0/3] thermal: rcar_gen3_thermal: read calibration from hardware
Date: Wed, 13 Sep 2017 13:01:34 +0200
Message-ID: <20170913110137.13490-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:42018 "EHLO
        smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdIMLB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2017 07:01:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

Hi,

This series extend the Renesas R-Car Gen3 thermal driver to try and read 
its calibration constants from hardware instead of using pseudo values 
hard-coded in the driver.

Unfortunately one registers involved in are not yet documented in 
datasheets and I don't have access to any board where the calibration 
data is fused. For the not documented register the BSP code was used as 
a reference. I do believe the code is ready for upstream consumption but 
pending new datasheet and/or access to hardware where calibration is 
fused to test it marked it as RFC. Once I have addressed one or both of 
these concerns I will resend without the RFC prefix.

The code is tested on H3 and M3-W where the calibration registers are 
not fused so only the fallback logic to pseudo values are truly tested.

Niklas Söderlund (3):
  thermal: rcar_gen3_thermal: read calibration from hardware
  arm64: dts: r8a7795: update register size for thermal
  arm64: dts: r8a7796: update register size for thermal

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi |  2 +-
 drivers/thermal/rcar_gen3_thermal.c      | 70 +++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 4 deletions(-)

-- 
2.14.1
