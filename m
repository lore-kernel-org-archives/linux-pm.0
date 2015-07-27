From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
Date: Mon, 27 Jul 2015 14:07:54 +0530
Message-ID: <20150727083754.GD31611@linux>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-07-15, 17:43, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
> index 0414009..483ca1b 100644
> --- a/include/linux/cpufreq-dt.h
> +++ b/include/linux/cpufreq-dt.h
> @@ -17,6 +17,7 @@ struct cpufreq_dt_platform_data {
>  	 * clock.
>  	 */
>  	bool independent_clocks;
> +	bool boost_supported;
>  };

I am planning to kill this structure soon, don't add anything to it.
We should be doing this based on DT.

-- 
viresh
