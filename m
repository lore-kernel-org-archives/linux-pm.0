From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 0/4] Thermal:exynos: Thermal Measurement Unit fix and
 Samsung SoCs support
Date: Thu, 25 Apr 2013 11:39:38 -0400
Message-ID: <51794E3A.10009@ti.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com> <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40166 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286Ab3DYPj5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 11:39:57 -0400
In-Reply-To: <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, eduardo.valentin@ti.com

Hello Lukasz,

On 25-04-2013 08:30, Lukasz Majewski wrote:
> This patch series provide various fixes for TMU block.
> First of all it fixes a problem with get_cpu_frequency() lockup at cpu_cooling.c.
>
> Secondly a proper regulator definition (VDD_TS) has been added.
> Moreover device tree definitions and documentation entry are now in place.
>
> Dependencies (those patches shall be applied on top of):
> - "clk: exynos4: Add clock entries for TMU"

Is this one same as  [1/6] clk:exynos4:TMU Thermal Measurement Unit 
clock added to common clock framework in your previous series?

> - "Thermal: exynos: Add clk_{un}prepare APIs"
Same as
thermal:exynos4: TMU Common clock framework support for TMU (Thermal 
Monitoring Unit)
in your previous series?

> - "Thermal: exynos: Add compatible string for exynos4412"
>
This should be same as thermal:exynos4: Enable support for Exynos4412 
SoCs in your previous series?


>
> Lukasz Majewski (4):
>    ARM: dts: thermal: exynos4: TMU device tree support for Exynos4412
>      targets
>    Thermal: exynos: Support for TMU regulator defined at device tree
>    ARM: dts: thermal: exynos4: Add documentation for Exynos SoC thermal
>      bindings
>    ARM:TMU:fix: Avoid lockup when first frequency table entry is
>      CPUFREQ_ENTRY_INVALID

The above, as stated at the patch may not be needed.

>
>   .../devicetree/bindings/thermal/exynos-thermal.txt |   25 ++++++++++++++++++++
>   arch/arm/boot/dts/exynos4x12.dtsi                  |   10 ++++++++
>   drivers/thermal/cpu_cooling.c                      |    3 +--
>   drivers/thermal/exynos_thermal.c                   |   19 +++++++++++++++
>   4 files changed, 55 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>

