From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC v2 4/7] ARM: dts: Add PPMU device tree support for
 Exynos5420
Date: Thu, 22 May 2014 21:50:45 +0400
Message-ID: <537E38F5.4020200@cogentembedded.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com> <1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:52009 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaEVRun (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:50:43 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so2930010lab.17
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2014 10:50:41 -0700 (PDT)
In-Reply-To: <1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: kesavan.abhilash@gmail.com

On 05/22/2014 09:21 PM, Abhilash Kesavan wrote:

> PPMU is required by the exynos5420 devfreq driver. Add a device
> tree node for it.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5420.dtsi |    7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 8e7e35c..6ab7b03 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -833,4 +833,11 @@
>   		samsung,pmu-syscon = <&pmu_system_controller>;
>   		#phy-cells = <1>;
>   	};
> +
> +	ppmu {

    Shouldn't it have the unit-address part, like "ppmu@10d00000"?

> +		compatible = "samsung,exynos5420-int-busfreq";
> +		reg = <0x10D00000 0x2000	/* PPMU_DMC_0_0 */
> +		       0x10D10000 0x2000	/* PPMU_DMC_0_1 */
> +		       0x10D60000 0x2000>;	/* PPMU_DMC_1_0 */
> +	};
>   };

WBR, Sergei

