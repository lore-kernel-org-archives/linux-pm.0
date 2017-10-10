From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal: new material for hikey for 4.15
Date: Tue, 10 Oct 2017 20:02:40 +0200
Message-ID: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Keerthy <j-keerthy@ti.com>, ldewangan@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui, Eduardo,

** this is my first pull request for thermal, so I may have choose the
wrong branch **

The changes are based on top of the thermal-soc branch.

The pull request contains the following changes:

 - Reworked the hikey6220 thermal driver by improving the code, fixing
the interrupt setup issues and removed the locks. Set the scene for the
hikey3660 support (Daniel Lezcano)

 - Switched tz request to devm version in order to be consistent with
the devm API used in the driver (Daniel Lezcano)

 - Fixed temperature regulation misbehavior with the step wise governor
leading to a hikey hard reset (Daniel Lezcano)

 - Added support for the hikey3660 thermal driver (Kevin Wangtao)

Thanks!

  -- Daniel

-------------------------------------------------------------------------

The following changes since commit 7a348799d5d9087bbc2e60767f5e6da9f70cc7ca:

  Merge branches 'mediatek-mt2712', 'rockchip-rk3328' and
'uniphier-thermal' into thermal-soc (2017-09-08 11:17:53 +0800)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git thermal/hikey-next

for you to fetch changes up to 0b860d941472c97d16d65d4f1acd7fd2c2b29cb0:

  arm64: dts: Register Hi3660's thermal sensor (2017-10-10 19:53:42 +0200)

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
      thermal/drivers/generic-iio-adc: Switch tz request to devm version
      thermal/drivers/step_wise: Fix temperature regulation misbehavior
      thermal/drivers/qcom-spmi: Use devm_iio_channel_get

Kevin Wangtao (9):
      thermal/drivers/hisi: Move the clk setup in the corresponding
functions
      thermal/drivers/hisi: Use round up step value
      thermal/drivers/hisi: Put platform code together
      thermal/drivers/hisi: Add platform prefix to function name
      thermal/drivers/hisi: Prepare to add support for other hisi platforms
      thermal/drivers/hisi: Add support for multi temp threshold
      dt-bindings: Document the hi3660 thermal sensor binding
      thermal/drivers/hisi: Add support for hi3660 SoC
      arm64: dts: Register Hi3660's thermal sensor

 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt |   9 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       |   8 ++
 drivers/thermal/hisi_thermal.c                                  | 623
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
 drivers/thermal/qcom-spmi-temp-alarm.c                          |  43
+++------
 drivers/thermal/step_wise.c                                     |  11 ++-
 drivers/thermal/thermal-generic-adc.c                           |  24 +----
 6 files changed, 453 insertions(+), 265 deletions(-)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
