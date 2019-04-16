From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking
 on devfreq initialization failure
Date: Tue, 16 Apr 2019 11:32:26 +0900
Message-ID: <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0@epcas3p3.samsung.com>
        <20190415145505.18397-7-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-7-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

patch6/7/8/9 are for handling of exception handling in probe() function.
Actually, I'm not sure that there are special reason to split out
the patches. I think that you can squash patch6/7/8/9 to only one patch.

Also, even if patch6/7/8/9 handle the exception handling in probe(),
the tegra_devfreq_probe() doesn't support the restoring sequence
when fail happen. I think that if you want to fix the fail case of probe(),
please add the restoring sequence about following function.
- clk_disable_unprepare()
- clk_notifier_unregister()
- dev_pm_opp_remove()


On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The code doesn't check for devfreq initialization failure, fix it.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index f0f0d78f6cbf..aa0478464b35 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -707,6 +707,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  						 &tegra_devfreq_profile,
>  						 "tegra_actmon",
>  						 NULL);
> +	if (IS_ERR(tegra->devfreq)) {
> +		err = PTR_ERR(tegra->devfreq);
> +		return err;
> +	}
>  
>  	return 0;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
