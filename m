From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 00/18] thermal: exynos: Thermal code rework to use
 device tree
Date: Mon, 23 Feb 2015 13:28:54 +0100
Message-ID: <20150223132854.232d0da8@amdc2363>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
 <20150124214955.GA14443@developer.hsd1.ca.comcast.net>
 <54CAC3A2.5060804@kernel.org> <20150223111338.11ca4b6c@amdc2363>
 <039101d04f5a$80147660$803d6320$@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <039101d04f5a$80147660$803d6320$@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: 'Eduardo Valentin' <edubezval@gmail.com>, 'Zhang Rui' <rui.zhang@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Lukasz Majewski' <l.majewski@majess.pl>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, 'Abhilash Kesavan' <kesavan.abhilash@gmail.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Kukjin,

> Lukasz Majewski wrote:
> > 
> > Hi Kukjin, Eduardo
> > 
> Hi,
> 
> > > On 01/25/15 06:49, Eduardo Valentin wrote:
> > > > On Fri, Jan 23, 2015 at 01:09:53PM +0100, Lukasz Majewski wrote:
> > > >> 1. Introduction
> > > >>
> > > >> Following patches aim to clean up the current implementation of
> > > >> the thermal framework on Exynos devices.
> > > >>
> > > >> The main goal was to use a generic code for reading thermal
> > > >> configuration (of-thermal.c). Due to that redundant
> > > >> exynos_thermal_common.[h|c] files were removed.
> > > >>
> > > >> Around 400 lines of code (LOC) were removed directly by this
> > > >> patch, which is around 20% of the Exynos thermal code base.
> > > >>
> > > >> This work should NOT bring any functional changes to Exynos
> > > >> thermal subsystem.
> > > >>
> > > >> 2. Patch-set structure
> > > >>
> > > >> Then the cpu_cooling functionality has been preserved to allow
> > > >> cooling devices by reducing operating frequency. Definition of
> > > >> trip points and cpufreq's cooling properties were moved to
> > > >> device tree.
> > > >>
> > > >> Then the rework of the way in which configuration data is
> > > >> provided to the Exynos thermal subsystem was performed. Now
> > > >> device tree is used for configuration.
> > > >>
> > > >> 3. Dead code removal
> > > >>
> > > >> Thermal support for some SoCs, previously available in the
> > > >> exynos_tmu_data.c file, was removed since, as of (almost)
> > > >> 3.19-rc3, they didn't have TMU bindings.
> > > >>
> > > >> Moreover, support for cpu_cooling devices was preserved only on
> > > >> those SoCs which had available and working cpufreq driver.
> > > >>
> > > >> 4. Testing
> > > >>
> > > >> Test devices:
> > > >> - Exynos4210 - Trats (TMU zone + cpu_cooling)
> > > >> - Exynos4412 - Trats2/Odroid U3 (TMU zone + cpu_cooling)
> > > >> - Exynos5250 - Arndale (TMU zone + cpu_cooling)
> > > >> - Exynos5420 - Arndale-octa (only TMU zones)
> > > >>
> > > >> Unfortunately, I don't posses Exynos5440 for testing. Its
> > > >> functionality has been preserved in the code, but not tested on
> > > >> the hardware. I would be grateful for help in testing.
> > > >>
> > > >>
> > > >> 5. This work apply on the following tree:
> > > >>
> > > >> kernel.org: 'linux-soc-thermal/next' - Eduardo Velentin's tree
> > > >> SHA1: 1813d80874699145f04af6b05ebab0a6419001fb
> > > >>
> > > >>
> > > >> Lukasz Majewski (18):
> > > >
> > > > I have applied the following patches to my -fixes branch (for
> > > > next rc cycle)
> > > >
> > > >>   thermal: exynos: cosmetic: Correct comment format
> > > >>   thermal: exynos: Provide thermal_exynos.h file to be
> > > >> included in device tree files
> > > >>   thermal: exynos: Modify exynos thermal code to use device
> > > >> tree for cpu cooling configuration
> > > >>   cpufreq: exynos: Use device tree to determine if cpufreq
> > > >> cooling should be registered
> > > >>   dts: Documentation: Extending documentation entry for
> > > >> exynos-thermal dts: Documentation: Update exynos-thermal.txt
> > > >> example for Exynos5440 thermal: samsung: core: Exynos TMU
> > > >> rework to use device tree for configuration
> > > >>   thermal: exynos: Remove exynos_thermal_common.[c|h] files
> > > >>   thermal: exynos: Remove exynos_tmu_data.c file
> > > >
> > > > The patches below should go via platform tree:
> > > >
> > > >>   arm: dts: trats: Enable TMU on the Exynos4210 trats device
> > > >>   arm: dts: odroid: Add LDO10 regulator node necessary for TMU
> > > >> on Odroid arm: dts: odroid: Enable TMU at Exynos4412 based
> > > >> Odroid U3 device arm: dts: Adding CPU cooling binding for
> > > >> Exynos SoCs thermal: exynos: dts: Add default definition of
> > > >> the TMU sensor parameter
> > > >>   thermal: dts: Default trip points definition for Exynos5420
> > > >> SoCs thermal: exynos: dts: Define default thermal-zones for
> > > >> Exynos4 thermal: dts: exynos: Trip points and sensor
> > > >> configuration data for Exynos5440
> > > >>   thermal: exynos: dts: Provide device tree bindings identical
> > > >> to the one in exynos_tmu_data.c
> > > >
> > >
> > > I've applied above patches with small subject changes.
> > >
> > > BTW unfortunately, since missing the
> > > "include/dt-bindings/thermal/thermal_exynos.h" in my tree, I
> > > couldn't merge it into for-next yet.
> > 
> > As of this writing: (Kernel 4.0-rc1) the
> > "include/dt-bindings/thermal/thermal_exynos.h" file is in the kernel
> > tree.
> > 
> I know.
> 
> > Kukjin, could you add missing DTS files and send this to upstream.
> > 
> Unfortunately, I couldn't take the DT changes in Samsung tree at that
> time because of missing header file and it causes build error. 

The header problem was due to splitting this patch set to -samsung and
-thermal trees.
The intention was to merge it all at once, but unfortunately it was
split.

> Now I
> can pick them into Samsung tree but I'm not sure it can be sent to
> upstream during this -rc...
> 
> Eduardo, Lukasz,
> Do you guys think the DT changes are really fixes for 4.0?

The thermal Samsung rework has been merged, so without this DTS files
we have regression, since boards like Trats2, Odroid will not have
thermal support in 4.0 final release.

Additionally we are now at -rc1 state, so some extra time is left to
handle unexpected situation (although there shouldn't be any).

> 
> > Thanks in advance.
> > 
> > >
> > > Can you please provide a topic branch for it? If not, this cannot
> > > be handled in arm-soc tree in this time, I think.
> > >
> > > - Kukjin
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
