From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v5 7/8] drivers: cpuidle: initialize Exynos driver through
 DT
Date: Wed, 25 Jun 2014 17:23:38 +0200
Message-ID: <5019714.S4WTdsyrXS@amdc1032>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-8-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32316 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbaFYPYB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 11:24:01 -0400
In-reply-to: <1403705421-17597-8-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>Ch


Hi,

On Wednesday, June 25, 2014 03:10:20 PM Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for
> ARM can now initialize idle states data through properties in the device
> tree.
> 
> This patch adds code to the Exynos CPUidle driver to dynamically
> initialize idle states data through the updated device tree source
> files.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
> Compile tested, I am not sure I patched the right dts files, please check.

cpuidle-exynos driver is currently working properly in deeper cpuidle
mode (AFTR) on Exynos4210 and Exynos5250 (please also see the following
patch from Tomasz Figa: [1]).  There is ongoing work to AFTR mode work
also on Exynos4x12 and Exynos3250 but it is not complete yet.  Exynos5410
OTOH should probably use the generic big little cpuidle driver (this SoC
is similar to Exynos5420 one for which Chander Kashyap has developed
cpuidle-big_little support [2]).

Making long story short, I think that your patch should depend on patch
[1] and update only exynos4210.dtsi and exynos5250.dtsi.  Also for your
patch #6 there needs to be some coordination with merging of Chander's
patchset ([2]).

[1] http://www.spinics.net/lists/arm-kernel/msg341023.html
[2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg664470.html

>  .../devicetree/bindings/arm/exynos/idle-states.txt | 27 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos3250.dtsi                  | 16 ++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  | 15 +++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi                  | 17 +++++++++++++
>  drivers/cpuidle/Kconfig.arm                        |  1 +
>  drivers/cpuidle/cpuidle-exynos.c                   | 29 +++++++++++++---------
>  6 files changed, 93 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/exynos/idle-states.txt

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

