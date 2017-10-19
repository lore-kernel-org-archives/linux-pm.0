From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal: new material for hikey for 4.15 #2
Date: Thu, 19 Oct 2017 19:05:32 +0200
Message-ID: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:51611 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJSRFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 13:05:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id j14so9033209wre.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2017 10:05:35 -0700 (PDT)
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Keerthy <j-keerthy@ti.com>, ldewangan@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi Eduardo,

** I'm not if I took the right branch **

The changes are based on top of the thermal-soc branch.

Note from the previous pull I removed the hikey960 support series in
order to sort out the multiple threshold before submitting again.

The pull request contains the following changes:

 - Reworked the hikey6220 thermal driver by improving the code, fixing
the interrupt setup issues and removed the locks. Set the scene for the
hikey3660 support (Daniel Lezcano)

 - Switched tz request to devm version in order to be consistent with
the devm API used in the driver (Daniel Lezcano)

 - Fixed temperature regulation misbehavior with the step wise governor
leading to a hikey hard reset (Daniel Lezcano)

 - Moved clock setup in the setup function and used rounded step value
to prevent pointless roundup function (Kevin Wangtao)

-----------------------------------------------------------------------

The following changes since commit 7a348799d5d9087bbc2e60767f5e6da9f70cc7ca:

  Merge branches 'mediatek-mt2712', 'rockchip-rk3328' and
'uniphier-thermal' into thermal-soc (2017-09-08 11:17:53 +0800)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git thermal/hikey-next

for you to fetch changes up to ef32377640799ce62610f05d43db75ce0d34e42e:

  thermal/drivers/qcom-spmi: Use devm_iio_channel_get (2017-10-18
16:34:17 +0200)

----------------------------------------------------------------
Daniel Lezcano (16):
      thermal/drivers/hisi: Fix missing interrupt enablement
      thermal/drivers/hisi: Remove the multiple sensors support
      thermal/drivers/hisi: Fix kernel panic on alarm interrupt
      thermal/drivers/hisi: Simplify the temperature/step computation
      thermal/drivers/hisi: Fix multiple alarm interrupts firing
      thermal/drivers/hisi: Remove pointless lock
      thermal/drivers/hisi: Encapsulate register writes into helpers
      thermal/drivers/hisi: Fix configuration register setting
      thermal/drivers/hisi: Remove costly sensor inspection
      thermal/drivers/hisi: Rename and remove unused field
      thermal/drivers/hisi: Convert long to int
      thermal/drivers/hisi: Remove thermal data back pointer
      thermal/drivers/hisi: Remove mutex_lock in the code
      thermal/drivers/step_wise: Fix temperature regulation misbehavior
      thermal/drivers/generic-iio-adc: Switch tz request to devm version
      thermal/drivers/qcom-spmi: Use devm_iio_channel_get

Kevin Wangtao (2):
      thermal/drivers/hisi: Move the clk setup in the corresponding
functions
      thermal/drivers/hisi: Use round up step value

 drivers/thermal/hisi_thermal.c         | 396
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------
 drivers/thermal/qcom-spmi-temp-alarm.c |  43 ++++++----------
 drivers/thermal/step_wise.c            |  11 +++--
 drivers/thermal/thermal-generic-adc.c  |  24 ++-------
 4 files changed, 227 insertions(+), 247 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
