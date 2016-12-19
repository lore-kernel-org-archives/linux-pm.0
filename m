From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC v2 7/7] ARM: dts: exynos4x12: add suspend OPP for DMC and
 leftbus for Prime
Date: Mon, 19 Dec 2016 15:19:17 +0100
Message-ID: <3433933.B7FFrWlFIV@amdc3058>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <1482113787-28422-8-git-send-email-tjakobi@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:33341 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755289AbcLSOTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 09:19:22 -0500
In-reply-to: <1482113787-28422-8-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com


Hi,

On Monday, December 19, 2016 03:16:27 AM Tobias Jakobi wrote:
> Both DMC and leftbus adjust regulator voltages (MIF and INT
> respectively), which have to be in a safe range to allow the
> BL0 to operate correctly.
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  arch/arm/boot/dts/exynos4412-prime.dtsi | 2 ++

Could you please post patch(es) adding this file?  I'm planning to fix
OPPs for Exynos4412-Prime and don't wont to duplicate efforts.

Also please remember to mention in the cover letter the tree that your
patchset is based on (if it is different than the mainline).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
> index 97d1b9c..18e411f 100644
> --- a/arch/arm/boot/dts/exynos4412-prime.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
> @@ -123,6 +123,7 @@
>  		opp@400000000 {
>  			opp-hz = /bits/ 64 <400000000>;
>  			opp-microvolt = <1100000>;
> +			opp-suspend;
>  		};
>  	};
>  
> @@ -145,6 +146,7 @@
>  		opp@200000000 {
>  			opp-hz = /bits/ 64 <200000000>;
>  			opp-microvolt = <1150000>;
> +			opp-suspend;
>  		};
>  	};

