From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: bit-wise operation bugfix.
Date: Wed, 05 Aug 2015 11:19:08 +0900
Message-ID: <55C1729C.3090408@samsung.com>
References: <1139776636.447211438740931685.JavaMail.weblogic@epmlwas03c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48644 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbHECTK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 22:19:10 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSL02BT97RWEP30@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 05 Aug 2015 11:19:08 +0900 (KST)
In-reply-to: <1139776636.447211438740931685.JavaMail.weblogic@epmlwas03c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 08/05/2015 11:15 AM, MyungJoo Ham wrote:
> 
> Make it u64 before left-shifting 32bits.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index f9901f5..f312485 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -319,7 +319,8 @@ static int exynos_ppmu_v2_get_event(struct devfreq_event_dev *edev,
>  	case PPMU_PMNCNT3:
>  		pmcnt_high = __raw_readl(info->ppmu.base + PPMU_V2_PMCNT3_HIGH);
>  		pmcnt_low = __raw_readl(info->ppmu.base + PPMU_V2_PMCNT3_LOW);
> -		load_count = (u64)((pmcnt_high & 0xff) << 32) + (u64)pmcnt_low;
> +		load_count = ((u64)((pmcnt_high & 0xff)) << 32)
> +			   + (u64)pmcnt_low;
>  		break;
>  	}
>  	edata->load_count = load_count;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
