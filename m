From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 00/17] thermal: exynos: Thermal code rework to use
 device tree
Date: Wed, 10 Dec 2014 15:19:25 +0100
Message-ID: <20141210151925.61a0b091@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <20141210102712.GA2919@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32548 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930AbaLJOTr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 09:19:47 -0500
In-reply-to: <20141210102712.GA2919@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Eduardo,

> On Wed, Dec 10, 2014 at 01:09:39PM +0100, Lukasz Majewski wrote:
> > 1. Introduction
> > 
> > Following patches aim to clean up the current implementation of the
> > thermal framework on Exynos devices.
> > 
> > The main goal was to use a generic code for reading thermal
> > configuration (of-thermal.c). Due to that redundant
> > exynos_thermal_common.[h|c] files were removed.
> > 
> 
> Very good! Thanks for cleaning the code.
> 
> Given the decision to be DT only, my only question now is if you need
> to support non-DT booting systems. Do you (Exynos platforms in
> general) care about booting without DT?

As fair as I know all Exynos systems have been ported to DT. Support
for new Exynos based devices is only accepted if configuration is DT
based.

> 
> If not, then removing makes completely sense to me.
> 
> 
> > Around 400 lines of code (LOC) were removed directly by this patch,
> > which is around 20% of the Exynos thermal code base.
> > 
> 
> Great!
> 
> > This work should NOT bring any functional changes to Exynos thermal 
> > subsystem.
> > 
> 
> OK.
> 
> > 2. Patch-set structure
> > 
> > Then the cpu_cooling functionality has been preserved to allow
> > cooling devices by reducing operating frequency. Definition of trip
> > points and cpufreq's cooling properties were moved to device tree.
> > 
> 
> uhh.. OK. but, by supporting of-thermal that means drivers should
> never care about loading cpu cooling. That is done via cpufreq-dt.

Up till now exynos has a Kbuild option to enable cpu_cooling for its
thermal subsystem.

cpufreq for Exynos also undergo major rework (done by Tomas Abraham):
"cpufreq: use generic cpufreq drivers for exynos platforms" [1]

It converts some Exynos 4 and 5 platform to use cpufreq-dt/cpufreq-bL
and is pretty close to be added in this merge window.

Unfortunately not all devices were converted (e.g. Exynos 4412) and old
legacy cpufreq code is used (I simply wait with porting Exynos4412 for
"base" patches landing in the kernel).

Although, this shouldn't be a problem.

> That is why we had the cycle with cpufreq folks, remember?
> 
> (I will have a look in your patches)

It would be great if those patches could find their way to therma -next.
Then also Abhilash could benefit from them.

> 
> > Then the rework of the way in which configuration data is provided
> > to the Exynos thermal subsystem was performed. Now device tree is
> > used for configuration.
> 
> This is very good. Do you care sending feedback if you need extra
> configuration or does of-thermal cover your scenarios (a part from the
> amendments you already did)?

Changes, which I did recently to of-thermal.c are enough.

> 
> I know people (tegra and rockchip) are interested in hw trip points,
> which I believe should be of your interest too. Of course, that is
> maybe an off-topic for this series.

With this patch series I've tried to preserve previous functionality.
I've got some ideas for improvements, but those are for other
discussion.

> 
> 
> > 
> > Patch series end with removing exynos5250/exynos3250 TMU
> > compatibles. Both SoCs have thermal management unit (TMU)
> > compatible with the one first introduced at Exynos4412.
> 
> OK. I will have a look in DT changes you did. But in general, removing
> support needs to be done carefully for backward compatibility :-(.

Essentially this is a clean up, not removing support. The trick here is
that Exynos4412 (which was added first to mainline), Exynos5250 and
Exynos3250 use the same TMU IP block.

> 
> > 
> > 3. Dead code removal
> > 
> > Thermal support for some SoCs, previously available in the
> > exynos_tmu_data.c file, was removed since, as of (almost) 3.19-rc1,
> > they didn't have TMU bindings.
> > 
> > Moreover, support for cpu_cooling devices was preserved only on
> > those SoCs which had available and working cpufreq driver.
> 
> 
> Have you tried your series with cpufreq-dt?

Since I don't know if [1] will be finally accepted - I've used already
available cpufreq code (with exynos_defconfig + cpu_cooling enabled).

I don't think that there should be any problem with using cpufreq-dt.
Moreover, we would have enough time for potential fixes before next
kernel (3.19) is released.

> 
> > 
> > 4. Testing
> > 
> > Test devices:
> > - Exynos4210 - Trats (TMU zone + cpu_cooling)
> > - Exynos4412 - Trats2/Odroid U3 (TMU zone + cpu_cooling)
> > - Exynos5250 - Arndale (TMU zone + cpu_cooling)
> > - Exynos5420 - Arndale-octa (only TMU zones)
> > 
> > Unfortunately, I don't posses Exynos5440 for testing. Its
> > functionality has been preserved in the code, but not tested on the
> > hardware. I would be grateful for help in testing.
> > 
> > 5. This work apply on the following tree:
> > 
> > kernel.org: 'linux-soc-thermal/next' - Eduardo Velentin's tree
> > SHA1: c42c7a44c7a543dcb388c1ee1a798e6ed76ad8cf
> > 
> > 
> > Lukasz Majewski (17):
> >   thermal: exynos: cosmetic: Correct comment format
> >   thermal: exynos: Provide thermal_exynos.h file to be included in
> >     device tree files
> >   thermal: dts: trats: Enable TMU on the Exynos4210 trats device
> >   thermal: dts: exynos: Add LD010 regulator node necessary for TMU
> > on Odroid
> >   thermal: dts: Enable TMU at Exynos4412 based Odroid U3 device
> >   thermal: cpu_cooling: dts: Define device tree bindings for Exynos
> > cpu cooling functionality
> >   thermal: cpu_cooling: Modify exynos thermal code to use device
> > tree for cpu cooling configuration
> >   thermal: exynos: dts: Add default definition of the TMU sensor
> >     parameter
> >   thermal: dts: Default trip points definition for Exynos5420 SoCs
> >   thermal: exynos: dts: Define default thermal-zones for Exynos4
> >   thermal: dts: exynos: Trip points and sensor configuration data
> > for Exynos5440
> >   thermal: exynos: dts: Provide device tree bindings identical to
> > one in exynos_tmu_data.c
> >   thermal: samsung: core: Exynos TMU rework to use device tree for
> >     configuration
> >   thermal: exynos: Remove exynos_thermal_common.[c|h] files
> >   thermal: exynos: Remove exynos_tmu_data.c file
> >   thermal: exynos: Make Exynos5250 TMU compatible with Exynos4412
> >   thermal: exynos: Make Exynos3250 TMU compatible with Exynos4412
> > 
> >  arch/arm/boot/dts/exynos3250.dtsi                 |   6 +-
> >  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi        |  52 +++
> >  arch/arm/boot/dts/exynos4.dtsi                    |   5 +
> >  arch/arm/boot/dts/exynos4210-trats.dts            |  19 +
> >  arch/arm/boot/dts/exynos4210.dtsi                 |  43 ++-
> >  arch/arm/boot/dts/exynos4212.dtsi                 |  20 +
> >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |  27 ++
> >  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |  24 ++
> >  arch/arm/boot/dts/exynos4412-trats2.dts           |  15 +
> >  arch/arm/boot/dts/exynos4412.dtsi                 |  32 ++
> >  arch/arm/boot/dts/exynos4x12.dtsi                 |   3 +
> >  arch/arm/boot/dts/exynos5250.dtsi                 |  29 +-
> >  arch/arm/boot/dts/exynos5420-trip-points.dtsi     |  35 ++
> >  arch/arm/boot/dts/exynos5420.dtsi                 |  33 ++
> >  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi |  25 ++
> >  arch/arm/boot/dts/exynos5440-trip-points.dtsi     |  25 ++
> >  arch/arm/boot/dts/exynos5440.dtsi                 |  18 +
> >  drivers/cpufreq/exynos-cpufreq.c                  |  23 +-
> >  drivers/thermal/samsung/Makefile                  |   2 -
> >  drivers/thermal/samsung/exynos_thermal_common.c   | 427
> > ----------------------
> > drivers/thermal/samsung/exynos_thermal_common.h   | 106 ------
> > drivers/thermal/samsung/exynos_tmu.c              | 337
> > ++++++++++------- drivers/thermal/samsung/exynos_tmu.h
> > |  80 +--- drivers/thermal/samsung/exynos_tmu_data.c         | 264
> > ------------- include/dt-bindings/thermal/thermal_exynos.h      |
> > 37 ++ 25 files changed, 669 insertions(+), 1018 deletions(-)
> 
> Good!
> 
> >  create mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
> >  create mode 100644
> > arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi create mode
> > 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi create mode
> > 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi create
> > mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi delete
> > mode 100644 drivers/thermal/samsung/exynos_thermal_common.c delete
> > mode 100644 drivers/thermal/samsung/exynos_thermal_common.h delete
> > mode 100644 drivers/thermal/samsung/exynos_tmu_data.c create mode
> > 100644 include/dt-bindings/thermal/thermal_exynos.h
> > 
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
