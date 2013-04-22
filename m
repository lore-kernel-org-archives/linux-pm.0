From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 0/6] thermal:exynos4: Thermal Measurement Unit fixes for
 Samsung SoCs
Date: Tue, 23 Apr 2013 01:51:50 +0900
Message-ID: <51756AA6.3000906@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 04/20/13 01:38, Lukasz Majewski wrote:
> This patch series provide various fixes for TMU block.
> Namely, support for common clock framework and proper regulator VDD_TS has been
> added.
> Moreover device tree definitions and documentation entry are now in place.
>
> Lukasz Majewski (6):
>    clk:exynos4:TMU Thermal Measurement Unit clock added to common clock
>      framework
>    thermal:exynos4: TMU Common clock framework support for TMU (Thermal
>      Monitoring Unit)
>    thermal:exynos4: TMU device tree support for Exynos4412 targets
>    thermal: Support for TMU regulator defined at device tree
>    thermal:exynos4: Enable support for Exynos4412 SoCs
>    thermal:exynos4: Add documentation for Exynos SoC thermal bindings
>
>   .../devicetree/bindings/clock/exynos4-clock.txt    |    1 +
>   .../devicetree/bindings/thermal/exynos-thermal.txt |   22 +++++++++++
>   arch/arm/boot/dts/exynos4x12.dtsi                  |   10 +++++
>   drivers/clk/samsung/clk-exynos4.c                  |    6 ++-
>   drivers/thermal/exynos_thermal.c                   |   41 +++++++++++++++-----
>   5 files changed, 70 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>
Lukasz, please address comments from ml.

Others looks good to me.

- Kukjin
