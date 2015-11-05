From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #3
Date: Thu, 5 Nov 2015 09:34:09 -0800
Message-ID: <20151105173408.GA15781@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

This is the third and last pull for 4.4-rc1. Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus
  
to receive third Thermal-SoC Management updates for v4.4-rc1 with top-most

e35dbb4d4b4499e8a013564f0753dabc1c49e9d9:

  thermal: exynos: Directly return 0 instead of using local ret variable (2015-11-04 11:10:39 -0800)

on top of commit 7e38a5b1daa12cbaace3c76402999a84460df3e2:

  thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r (2015-11-03 09:57:42 -0800)

Specifics:
- Fixes on devfreq cooling device
- Fixes on exynos thermal driver
- This branch has been compiled tested and boot tested by Linaro kernelci bot [1,2].

Still checking what is pending. But what comes now should go via next
rcs or next merge window. If I missed your patch, ping me.

[1] - http://kernelci.org/boot/all/job/evalenti/kernel/v4.3-rc3-62-ge35dbb4d4b44/ 
[2] - http://kernelci.org/build/evalenti/kernel/v4.3-rc3-62-ge35dbb4d4b44/ 

BR,

----------------------------------------------------------------
Dan Carpenter (1):
      devfreq_cooling: return on allocation failure

Krzysztof Kozlowski (5):
      thermal: exynos: Fix unbalanced regulator disable on probe failure
      thermal: exynos: Fix first temperature read after registering sensor
      thermal: exynos: Use IS_ERR() because regulator cannot be NULL
      thermal: exynos: Remove unneeded semicolon
      thermal: exynos: Directly return 0 instead of using local ret variable

 drivers/thermal/devfreq_cooling.c    |  2 +-
 drivers/thermal/samsung/exynos_tmu.c | 68 ++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 31 deletions(-)
