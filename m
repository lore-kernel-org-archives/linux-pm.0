From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [RFC PATCH 0/4] Tegra124: EMC scaling
Date: Mon, 16 Jun 2014 15:35:09 +0200
Message-ID: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

here is an initial implementation of EMC scaling for Tegra124, I'm most
interested in feedback on the approach.

The present incarnation is very much specific to Tegra, but I'm sure that we
could find an API that can be shared across SoC families.

I have looked at using existing frameworks (common clock, pm_qos and devfreq)
to cover this use case, but it always felt like trying to fit a square peg in a
round hole. These are our requirements:

    1. Ceiling frequencies (for thermal and other power management components)

    2. Floor frequencies (determined from load statistics that are often
maintained by some firmware, to avoid frequent interrupts)

    3. Let misc. device drivers such as display controllers or USB set their
bandwidth requirements, which would be aggregated to calculate the final
effective frequency.

    4. The EMC on the Tegra124 has per-consumer latency allowance registers
that influence how memory access requests are arbitrated, and these depend on
the clock frequency.

1 and 2 could be implemented as additions to the common clock framework, but I
feel that 3 should live at a higher level (as not all clocks are used to drive
memory buses), and 4 doesn't seem related to clocks at all.

For past discussions on this see: https://lkml.org/lkml/2014/5/13/469

Tomeu Vizoso (4):
  memory: tegra124-emc: Add EMC driver
  ARM: tegra: Add Tegra124 EMC support
  drm/tegra: Request memory bandwidth for the display controller
  cpufreq: tegra: Register a minimum EMC frequency based on the CPU
    clock

 .../bindings/arm/tegra/nvidia,tegra124-emc.txt     |  26 ++++
 arch/arm/boot/dts/tegra124.dtsi                    |   9 ++
 drivers/cpufreq/tegra-cpufreq.c                    |  20 +--
 drivers/gpu/drm/tegra/dc.c                         |   9 ++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/tegra124-emc.c                      | 173 +++++++++++++++++++++
 include/linux/platform_data/tegra_emc.h            |  23 +++
 8 files changed, 254 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra124-emc.txt
 create mode 100644 drivers/memory/tegra124-emc.c

-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
