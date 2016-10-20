From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/4] PM / devfreq: Fix module autoload for platform drivers
Date: Thu, 20 Oct 2016 11:24:10 +0900
Message-ID: <58082ACA.90104@samsung.com>
References: <CGME20161019210649epcas1p4e0c178cb75709bb242da10d9c1fd77d2@epcas1p4.samsung.com>
 <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Javier,

On 2016년 10월 20일 06:06, Javier Martinez Canillas wrote:
> Hello,
> 
> I noticed that module autoload won't be working in some of the defreq
> platform drivers. This patch series contains the fixes for these.
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (4):
>   PM / devfreq: rk3399_dmc: Fix module autoload
>   PM / devfreq: exynos-nocp: Fix module autoload
>   PM / devfreq: rockchip-dfi: Fix module autoload
>   PM / devfreq: exynos-ppmu: Fix module autoload
> 
>  drivers/devfreq/event/exynos-nocp.c  | 1 +
>  drivers/devfreq/event/exynos-ppmu.c  | 1 +
>  drivers/devfreq/event/rockchip-dfi.c | 1 +
>  drivers/devfreq/rk3399_dmc.c         | 1 +
>  4 files changed, 4 insertions(+)
> 

Looks good to me of all patches.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
