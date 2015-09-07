From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] PM / OPP: add dev_pm_opp_get_suspend_opp() helper
Date: Mon, 7 Sep 2015 11:26:11 +0530
Message-ID: <20150907055611.GB26760@linux>
References: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
 <1441303892-32004-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441303892-32004-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03-09-15, 20:11, Bartlomiej Zolnierkiewicz wrote:
> Add dev_pm_opp_get_suspend_opp() helper to obtain suspend opp.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/base/power/opp.c | 28 ++++++++++++++++++++++++++++
>  include/linux/pm_opp.h   |  6 ++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index eb25449..eaafca7 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -341,6 +341,34 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
>  
>  /**
> + * dev_pm_opp_get_suspend_opp() - Get suspend opp
> + * @dev:	device for which we do this operation
> + *
> + * Return: This function returns pointer to the suspend opp if it is
> + * defined, otherwise it returns NULL.
> + *
> + * Locking: This function takes rcu_read_lock().
> + */
> +struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *suspend_opp;
> +
> +	rcu_read_lock();

This is wrong. Please have a look at other exported APIs that return
an OPP. RCU protected structures must be accessed from within RCU
locks _ONLY_. But your function returns the pointer after dropping
the locks. Which essentially means that the OPP can be freed by core,
by the time you start using it. :)

So, in such cases, its upto the caller to ensure that locks are taken
properly.

You can look at dev_pm_opp_find_freq_exact() as an example.

-- 
viresh
