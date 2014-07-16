From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 3/7] ARM: dts: Add PPMU device tree support for
 Exynos5250
Date: Wed, 16 Jul 2014 12:55:40 +0200
Message-ID: <53C65A2C.8010504@samsung.com>
References: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
 <1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:52717 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaGPK4S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 06:56:18 -0400
In-reply-to: <1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh+dt@kernel.org>

Hi Abhilash,

Please see my comments inline. Also CCing some DT maintainers.

On 15.07.2014 20:34, Abhilash Kesavan wrote:
> PPMU is required by the exynos5250 devfreq driver. Add a device
> tree node for it.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  .../bindings/arm/exynos/ppmu-exynos5.txt           |   26 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    8 ++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
> new file mode 100644
> index 0000000..a6a2eba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
> @@ -0,0 +1,26 @@
> +Exynos PPMU driver
> +-------------------
> +
> +Performance events are primitive values used to get performance data. These
> +events provide information about the behavior of the SoC that can be used
> +when analyzing system performance. These events are made visible using the
> +PPMU logic.
> +Exynos PPMU driver is used by the exynos5 devfreq drivers to control the
> +bus frequency/voltage.
> +
> +Required properties:
> +- compatible: "samsung,exynos5250-int-busfreq", "samsung,exynos5420-int-busfreq"

If this is a binding for PPMU, shouldn't the compatible string contain
the "ppmu" string too? E.g. "samsung,exynos5250-ppmu",
"samsung,exynos5420-ppmu".

> +- reg:
> +	* physical base address of the PPMUs (e.g DDR, Right Bus, Left bus etc)
> +	and length of memory mapped region.

Since PPMU are separate IP blocks, they should have their own device
nodes with only address ranges of their own. Representing all PPMUs in
the SoC with a single node is incorrect.

Best regards,
Tomasz
