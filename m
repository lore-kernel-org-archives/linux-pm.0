From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Add CPU Frequency scaling support on Armada 37xx
Date: Thu, 07 Dec 2017 18:14:22 +0100
Message-ID: <88999738.5axjmjKUcc@aspire.rjw.lan>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171207135616.23670-1-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 7, 2017 2:56:09 PM CET Gregory CLEMENT wrote:
> Hi,
> 
> This is the second version of a series adding the CPU Frequency
> support on Armada 37xx using DVFS. It is based on the initial work of
> Evan Wang and Victor Gu.
> 
> The main change since the first version was a bug fixed in the
> "cpufreq: Add DVFS support for Armada 37xx" patch which was preventing
> to register the opp. An other noticeable change is the 4th patch which
> is new adding the use of dev_pm_opp_remove and removing an comment
> became wrong. The other changes are described in the change log.
> 
> DVFS control is done by a set of registers from the North Bridge Power
> Management block. The binding for this block is documented in patch 1.
> 
> While adding a new cpufreq driver I found that the Kconfig and
> Makefile were no more in order, so it is fixed by patch 2 and 3.
> 
> The 5th patch is just about updating the MAINTAINERS file with the new
> driver.
> 
> The next patch is the real purpose of the series. The main goal of
> this driver is to setup the CPU load level in the hardware to
> associate them to CPU frequencies and register a standard cpufreq
> driver. Note that the hardware also capable of doing AVS (Adaptive
> Voltage Scaling), by associating a voltage on each level beside the
> CPU frequency. However, this support is not yet ready, so it is not
> part of this series.
> 
> Finally, the last patch is for arm-soc the arm-soc subsystem through
> mvebu and update the device tree to support the CPU frequency scaling.
> 
> An update on the CPU clock driver is needed in order to take into
> account the DVFS setting. It's the purpose of an other series already
> sent, but is no dependencies between the series (for building or at
> runtime).
> 
> Thanks,
> 
> Gregory
> 
> Changelog:
> 
> v1 -> v2:
> 
>  - using syscon instead of nb_pm for the binding of the North bridge
>    power management unit: reported by Rob Herring
> 
>  - fix sorting inside the big LITTLE section for the Kconfig: reported
>    by Viresh Kumar
> 
>  - fix the bogus freq calculation in armada37xx_cpufreq_driver_init,
>    bug reported by Andre Heider
> 
>  - use dev_pm_opp_remove() on the previous opp if dev_pm_opp_add()
>    failed, reported by Viresh Kumar
> 
>  - add the Tested-by flag from Andre Heider on "cpufreq: Add DVFS
>    support for Armada 37xx" patch
> 
> Gregory CLEMENT (7):
>   dt-bindings: marvell: Add documentation for the North Bridge PM on
>     Armada 37xx
>   cpufreq: ARM: sort the Kconfig menu
>   cpufreq: sort the drivers in ARM part
>   cpufreq: mvebu: Use dev_pm_opp_remove()
>   MAINTAINERS: add new entries for Armada 37xx cpufreq driver
>   cpufreq: Add DVFS support for Armada 37xx
>   arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support
> 
>  .../bindings/arm/marvell/armada-37xx.txt           |  19 ++
>  MAINTAINERS                                        |   1 +
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   1 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   7 +
>  drivers/cpufreq/Kconfig.arm                        |  89 ++++----
>  drivers/cpufreq/Makefile                           |   9 +-
>  drivers/cpufreq/armada-37xx-cpufreq.c              | 241 +++++++++++++++++++++
>  drivers/cpufreq/mvebu-cpufreq.c                    |  11 +-
>  8 files changed, 327 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/cpufreq/armada-37xx-cpufreq.c

I'd like you to split patches [2-3/7] off this series as they aren't
exactly related to the other changes in it.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
