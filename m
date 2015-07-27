From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
Date: Mon, 27 Jul 2015 14:05:31 +0530
Message-ID: <20150727083531.GC31611@linux>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436456621-29839-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

$subject is a bit wrong, we aren't fixing any issue here. We are
supporting a new feature and so it should be like:

cpufreq: Mark boost frequencies based on OPP's turbo mode

On 09-07-15, 17:43, Bartlomiej Zolnierkiewicz wrote:
> Turbo modes should be marked with CPUFREQ_BOOST_FREQ flag in
> the frequency table entry.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/cpufreq_opp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
> index 773bcde..f0cf502 100644
> --- a/drivers/cpufreq/cpufreq_opp.c
> +++ b/drivers/cpufreq/cpufreq_opp.c
> @@ -75,6 +75,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>  		}
>  		freq_table[i].driver_data = i;
>  		freq_table[i].frequency = rate / 1000;
> +		if (dev_pm_opp_get_turbo_mode_setting(opp) == true)
> +			freq_table[i].flags |= CPUFREQ_BOOST_FREQ;
>  	}
>  
>  	freq_table[i].driver_data = i;

Rest look fine.

-- 
viresh
