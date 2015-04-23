From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC/RFT 0/6] qcom: Add runtime PM support
Date: Thu, 23 Apr 2015 14:15:38 +0530
Message-ID: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46783 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbbDWIp5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 04:45:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>

The patches add runtime PM support (using PM clocks) for 
devices in qcom SoCs. Also converts serial/sdhci/i2c and
spi drivers to cleanup clock handling and use runtime PM
apis instead.

There are a couple [1][2] of other patch series that this one is
based off, so I have pushed a branch [3] with all the dependecies
if anyone wants to play with this series.
I have been able to test the serial and sdhci driver changes to a
fair extent, i2c for a sucessfull probe and could not test anything
on spi. So any testing on these drivers is highly appreciated.

[1] https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg14157.html
[2] https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg14268.html
[3] https://github.com/rrnayak/linux/tree/v4.0/runtime-rfc

Rajendra Nayak (6):
  PM / clock_ops: Make pm_clk_notify() do nothing in case DT passes
    power-domains
  clk: qcom: Add runtime support to handle clocks using PM clocks
  serial: msm: convert driver to use runtime PM apis
  mmc: sdhci-msm: convert driver to use runtime PM apis
  i2c: qup: Get rid of clock handling as its done using runtime
    callbacks
  spi: qup: Get rid of clock handling as its done using runtime
    callbacks

 drivers/base/power/clock_ops.c  |  8 ++++-
 drivers/clk/qcom/gdsc.c         | 20 +++++++++++
 drivers/i2c/busses/i2c-qup.c    | 74 +++++++++--------------------------------
 drivers/mmc/host/sdhci-msm.c    | 46 ++++++-------------------
 drivers/spi/spi-qup.c           | 54 ++++++------------------------
 drivers/tty/serial/msm_serial.c | 33 +++++++++---------
 6 files changed, 80 insertions(+), 155 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

