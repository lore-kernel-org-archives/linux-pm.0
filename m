From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: exynos-ppmu: Staticize event list
Date: Thu, 08 Jun 2017 10:22:20 +0900
Message-ID: <5938A6CC.8030206@samsung.com>
References: <CGME20170607181258epcas2p4191204d7b3853ef0482d84df7a06589d@epcas2p4.samsung.com>
        <20170607181228.32102-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20170607181228.32102-1-krzk@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 2017년 06월 08일 03:12, Krzysztof Kozlowski wrote:
> The ppmu_events array is accessed only in this compilation unit so it
> can be made static.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 9b7350935b73..c68f3b5a10b5 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -44,7 +44,7 @@ struct exynos_ppmu {
>  	{ "ppmu-event2-"#name, PPMU_PMNCNT2 },	\
>  	{ "ppmu-event3-"#name, PPMU_PMNCNT3 }
>  
> -struct __exynos_ppmu_events {
> +static struct __exynos_ppmu_events {
>  	char *name;
>  	int id;
>  } ppmu_events[] = {
> 

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
