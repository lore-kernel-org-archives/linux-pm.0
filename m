From: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/8] thermal:cpu cooling:fix: Provide thermal core fixes with
 deferred probe for several drivers
Date: Thu, 13 Nov 2014 18:02:37 +0100
Message-ID: <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1411547232-21493-1-git-send-email-l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Presented fixes are a response for problem described below:
http://thread.gmane.org/gmane.linux.kernel/1793821/match=thermal+core+fix+initialize+max_state+variable+0

In short - it turned out that two trivial fixes (included in this patch set)
require support for deferred probe in thermal drivers.

This situation shows up when CPU frequency reduction is used as a thermal cooling
device for a thermal zone.
It happens that during initialization, the call to thermal probe will be executed
before cpufreq probe (it can be observed at ./drivers/Makefile).
In such a situation thermal will not be properly configured until cpufreq policy
is setup.

In the current code (without included fixes) there is a time window in which thermal
can try to use not configured cpufreq and possibly crash the system.


Proposed solution was based on the code already available in the imx_thermal.c file.

/db8500_thermal.c:                      -> NOT NEEDED
/intel_powerclamp.c:                    -> NOT NEEDED - INTEL (x86)
/intel_powerclamp.c:                    -> NOT NEEDED - INTEL (x86)
/ti-soc-thermal/ti-bandgap.c:           -> FIXED  [omap2plus_defconfig]
/dove_thermal.c:                        -> NOT NEEDED - CPU_COOLING NOT AVAILABLE
                                                        [dove_defconfig]
/spear_thermal.c:                       -> FIXED  [spear3xx_defconfig]
/samsung/exynos_tmu.c:                  -> NOT NEEDED (nasty hack - will be reworked in later patches)
/imx_thermal.c:                         -> OK (deferred probe already in place)
/int340x_thermal/int3402_thermal.c:     -> NOT NEEDED - ACPI x86 - Intel specific
/int340x_thermal/int3400_thermal.c:     -> NOT NEEDED - ACPI x86 - Intel specific
/tegra_soctherm.c:                      -> FIXED  [tegra_defconfig]
/kirkwood_thermal.c:                    -> FIXED  [multi_v5_defconfig]
/armada_thermal.c:                      -> FIXED  [multi_v7_defconfig]
/rcar_thermal.c:                        -> FIXED  [shmobile_defconfig]
/db8500_cpufreq_cooling.c:              -> OK (deferred probe already in place) [multi_v7_defconfig]
/st/st_thermal_syscfg.c:                -> NOT NEEDED (Those two are enabled by e.g. ARMADA)
/st/st_thermal_memmap.c:


I only possess Exynos boards and Beagle Bone Black, so I'd be grateful for
testing proposed solution on other boards. The posted code is compile tested.

This code applies on Eduardo's ti-soc-thermal-next tree:
SHA1: 208a97042d66d9bfbcfab0d4a00c9fe317bb73d3

Lukasz Majewski (8):
  thermal:cpu cooling:armada: Provide deferred probing for armada driver
  thermal:cpu cooling:kirkwood: Provide deferred probing for kirkwood
    driver
  thermal:cpu cooling:rcar: Provide deferred probing for rcar driver
  thermal:cpu cooling:spear: Provide deferred probing for spear driver
  thermal:cpu cooling:tegra: Provide deferred probing for tegra driver
  thermal:cpu cooling:ti: Provide deferred probing for ti drivers
  thermal:core:fix: Initialize the max_state variable to 0
  thermal:core:fix: Check return code of the ->get_max_state() callback

 drivers/thermal/armada_thermal.c            | 7 +++++++
 drivers/thermal/kirkwood_thermal.c          | 7 +++++++
 drivers/thermal/rcar_thermal.c              | 7 +++++++
 drivers/thermal/spear_thermal.c             | 7 +++++++
 drivers/thermal/tegra_soctherm.c            | 7 +++++++
 drivers/thermal/thermal_core.c              | 8 +++++---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 7 +++++++
 7 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.0.0.rc2
