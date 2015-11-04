From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #2
Date: Tue, 3 Nov 2015 21:44:56 -0800
Message-ID: <20151104054454.GA8850@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive second Thermal-SoC Management updates for v4.4-rc1 with top-most

7e38a5b1daa12cbaace3c76402999a84460df3e2:

  thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r (2015-11-03 09:57:42 -0800)

on top of commit 8fb2b9ac2aadd6d87f89071c2c85f8c12b41c943:

  thermal: underflow bug in imx_set_trip_temp() (2015-10-30 11:35:50 -0700)

Specifics:
- Rockchip thermal driver now has pinctrl support  
- First round of fixes on devfreq cooling device.
- This branch has been compiled tested and boot tested by Linaro kernelci bot [1,2].

This is a second round of pull after going through the pending patches
on patchwork. Still trying to reduce the patchwork counts. The rockchip
support has already been reviewed. And there is no point in waiting
for the devfreq fixes.

Still checking what is pending. If I missed your patch, ping me.

[1] - http://kernelci.org/boot/all/job/evalenti/kernel/v4.3-rc3-56-g7e38a5b1daa1/
[2] - http://kernelci.org/build/evalenti/kernel/v4.3-rc3-56-g7e38a5b1daa1/

BR,

Eduardo Valentin
----------------------------------------------------------------
Caesar Wang (2):
      dt-bindings: rockchip-thermal: Add the pinctrl states in this document
      thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r

Javi Merino (2):
      thermal: devfreq_cooling: use a thermal_cooling_device for register and unregister
      thermal: devfreq_cooling: Make power a u64

 .../devicetree/bindings/thermal/rockchip-thermal.txt   | 11 +++++++++--
 drivers/thermal/devfreq_cooling.c                      | 18 +++++++++++-------
 drivers/thermal/rockchip_thermal.c                     |  4 ++++
 include/linux/devfreq_cooling.h                        | 16 ++++++++--------
 4 files changed, 32 insertions(+), 17 deletions(-)
