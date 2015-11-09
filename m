From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4 00/10] Better compatible for the rockchip thermal and
 support RK3368 SoCs
Date: Mon,  9 Nov 2015 12:48:52 +0800
Message-ID: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Thank you all for providing inputs and comments on previous versions of
this patchset.
Especially thanks to the (Eduardo, Dmitry, Heiko,....).

This series patchs are working for RK3368 on Rockchip platform.

-----
This patchset are based on linus master branch.
Note: Need add the following thermal patchs for thermal driver before
apply this series patchs.
(the patchs 1) 2) 3) 4) have merged in thermal-soc git tree which can be found at
 git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git)

1) thermal: rockchip: fix handling of invalid readings
(https://patchwork.kernel.org/patch/6973101/)

2) thermal: rockhip: fix setting thermal shutdown polarity
(https://patchwork.kernel.org/patch/6973131/)

3) dt-bindings: rockchip-thermal: Add the pinctrl states in this document
(https://patchwork.kernel.org/patch/7472021/)

4) thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
(https://patchwork.kernel.org/patch/7472051/)

5) thermal: rockchip: fix compile error
(https://patchwork.kernel.org/patch/7578271/)

The git log oneline my local branch as follows:
9a3d129 arm64: dts: Enable the Thermal on R88 board
4299e7a arm64: dts: Add main Thermal info to rk3368.dtsi
b95724c arm64: dts: Add the thermal data found on RK3368
c76f603 thermal: rockchip: Support the RK3368 SoCs in thermal drivers
a3f4fdd thermal: rockchip: consistently use int for temperatures
558b4d1ce thermal: rockchip: Add the sort flag for adc value increment or decrement
2438be4 thermal: rockchip: improve the conversion function
74b701d thermal: rockchip: trivial: fix typo in commit
2d85d32 thermal: rockchip: better to compatible the driver for different SoCs
1f2ef67 dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible

87d83ce thermal: rockchip: fix compile error
c0a5991 thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
11e4d6c dt-bindings: rockchip-thermal: Add the pinctrl states in this document
6d30517 thermal: rockhip: fix setting thermal shutdown polarity
2b50ab8 thermal: rockchip: fix handling of invalid readings

ce5c2d2 arm64: fixup for mm renames
ad804a0 Merge branch 'akpm' (patches from Andrew)
ab9f2fa Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma
75021d2 Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial
6f1da31 Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid
99aaa9c Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching

----
This series are tested on RK3368 board.
build on arm & x86, and tested the r88 board.
Sorry for the v3 series patchs compiling error.

root@rk3368_32:/ # cat proc/version
Linux version 4.3.0+ (wxt@ubuntu) (gcc version 4.9 20140514 (prerelease) (GCC) ) #6 SMP PREEMPT Mon Nov 9 12:35:52 CST 2015

while true;do ls >/dev/null; done&

while true; do grep "" /sys/class/thermal/thermal_zone[0-1]/temp; sleep
.5; done &

You can get the temperature form sensors.

/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:22500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:32500
/sys/class/thermal/thermal_zone0/temp:25000
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:27500
/sys/class/thermal/thermal_zone1/temp:30000
/sys/class/thermal/thermal_zone0/temp:27500
/sys/class/thermal/thermal_zone1/temp:32500
/sys/class/thermal/thermal_zone0/temp:27500
....


Changes in v4:
- rename the flag as mode.
- with enum type instead of bool type.
- fix the warning from the print message.
- :%s/sort_flag/mode.
- rename the 'drivers' to 'driver' in subject.
- Missing the ";" caused compile error.

Changes in v3:
- As Eduardo comments, let's change data_mask type with 'u32' instead of
  'unsigned long'.
- rename the flag-> sort_flag.
- fix the indentation.
- change the pr_err information.
- As the Patch v2 comments, Add a new patch to fix it.
- :%s/flag/sort_flag
- fix the rk3368 sort_flag as increment mode.

Changes in v2:
- As Eduardo comments on patch v1, split in smaller changes.
- make the conversion table in as a parameter both code_to_temp
  and temp_to_code function.
- remove some unused, completed on other patchs.
- fix a copy wrong name.

Changes in v1:
- %s/thermal/rockchip-thermal in subject.
- add a new patch for thermal driver to support more SoCs.
- As Dmitry comment, make the conversion table in as a parameterm.
- support the opt gpio pinctrl state.

Caesar Wang (10):
  dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible
  thermal: rockchip: better to compatible the driver for different SoCs
  thermal: rockchip: trivial: fix typo in commit
  thermal: rockchip: improve the conversion function
  thermal: rockchip: Add the sort mode for adc value increment or
    decrement
  thermal: rockchip: consistently use int for temperatures
  thermal: rockchip: Support the RK3368 SoCs in thermal driver
  arm64: dts: Add the thermal data found on RK3368
  arm64: dts: Add main Thermal info to rk3368.dtsi
  arm64: dts: Enable the Thermal on R88 board

 .../bindings/thermal/rockchip-thermal.txt          |   4 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   6 +
 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi   | 112 +++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  36 +++
 drivers/thermal/rockchip_thermal.c                 | 328 +++++++++++++++------
 5 files changed, 397 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi

-- 
1.9.1
