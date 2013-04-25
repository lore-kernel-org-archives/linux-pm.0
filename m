From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 0/4] Thermal:exynos: Thermal Measurement Unit fix and
 Samsung SoCs support
Date: Thu, 25 Apr 2013 18:28:43 +0200
Message-ID: <20130425182843.70a2d7d3@amdc308.digital.local>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
 <51794E3A.10009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <51794E3A.10009@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> Hello Lukasz,
> 
> On 25-04-2013 08:30, Lukasz Majewski wrote:
> > This patch series provide various fixes for TMU block.
> > First of all it fixes a problem with get_cpu_frequency() lockup at
> > cpu_cooling.c.
> >
> > Secondly a proper regulator definition (VDD_TS) has been added.
> > Moreover device tree definitions and documentation entry are now in
> > place.
> >
> > Dependencies (those patches shall be applied on top of):
> > - "clk: exynos4: Add clock entries for TMU"
> 
> Is this one same as  [1/6] clk:exynos4:TMU Thermal Measurement Unit 
> clock added to common clock framework in your previous series?

Yes, this is a similar patch. However I've changed more clocks to
clk_prepare_enable (clk_unprepare_disable). I've spoken about this with
Sachin recently.

> 
> > - "Thermal: exynos: Add clk_{un}prepare APIs"
> Same as
> thermal:exynos4: TMU Common clock framework support for TMU (Thermal 
> Monitoring Unit)
> in your previous series?

Yes.

> 
> > - "Thermal: exynos: Add compatible string for exynos4412"
> >
> This should be same as thermal:exynos4: Enable support for Exynos4412 
> SoCs in your previous series?

Yes.

> 
> 
> >
> > Lukasz Majewski (4):
> >    ARM: dts: thermal: exynos4: TMU device tree support for
> > Exynos4412 targets
> >    Thermal: exynos: Support for TMU regulator defined at device tree
> >    ARM: dts: thermal: exynos4: Add documentation for Exynos SoC
> > thermal bindings
> >    ARM:TMU:fix: Avoid lockup when first frequency table entry is
> >      CPUFREQ_ENTRY_INVALID
> 
> The above, as stated at the patch may not be needed.
> 
> >
> >   .../devicetree/bindings/thermal/exynos-thermal.txt |   25
> > ++++++++++++++++++++
> > arch/arm/boot/dts/exynos4x12.dtsi                  |   10 ++++++++
> > drivers/thermal/cpu_cooling.c                      |    3 +--
> > drivers/thermal/exynos_thermal.c                   |   19
> > +++++++++++++++ 4 files changed, 55 insertions(+), 2 deletions(-)
> > create mode 100644
> > Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> >
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
