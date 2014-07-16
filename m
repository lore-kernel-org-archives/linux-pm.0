From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 3/7] ARM: dts: Add PPMU device tree support for
 Exynos5250
Date: Wed, 16 Jul 2014 12:56:50 +0200
Message-ID: <53C65A72.7000406@samsung.com>
References: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
 <1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35093 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaGPK53 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 06:57:29 -0400
In-reply-to: <1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

Actually one more comment.

On 15.07.2014 20:34, Abhilash Kesavan wrote:

[snip]

> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 834fb5a..5284f00 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -778,4 +778,12 @@
>  		clocks = <&clock CLK_SSS>;
>  		clock-names = "secss";
>  	};
> +
> +	ppmu@10C40000 {
> +		compatible = "samsung,exynos5250-int-busfreq";
> +		reg = <0x10C40000 0x2000	/* PPMU_DDR_C */
> +		       0x10C50000 0x2000	/* PPMU_DDR_L */
> +		       0x10CB0000 0x2000	/* PPMU_DDR_R */
> +		       0x13660000 0x2000>;	/* PPMU_RIGHT */
> +	};
>  };
> 

Please separate patches adding the binding from patches modifying device
tree sources. Those are two logically separate changes.

Best regards,
Tomasz
