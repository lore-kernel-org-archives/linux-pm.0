From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: mark RK3399 as having separate
 policies per cluster
Date: Wed, 3 Oct 2018 10:11:50 +0530
Message-ID: <20181003044150.i46eaoyco3w47nid@vireshk-i7>
References: <20181001202153.GA240123@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001202153.GA240123@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heiko Stuebner <heiko@sntech.de>, Derek Basehore <dbasehore@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01-10-18, 13:21, Dmitry Torokhov wrote:
> RK3399 has one cluster with 4 small cores, and another one with 2 big
> cores, with cores in different clusters having different OPPs and thus
> different policies. Let's enable this via "have_governor_per_policy"
> platform data.

The policies are always different in such cases, with or without this flag. What
this flag rather enables is for us to have separate set of tunables for the
governor for individual policies.

For example, without this flag there will be a single governor directory:

/sys/devices/system/cpu/cpufreq/schedutil/

and the value of tunables in that directory will be used for all cpufreq
policies.

With this flag you wouldn't have the governor directory there, but rather in:

/sys/devices/system/cpu/cpufreq/policy*/schedutil/

i.e. tunables per policy and that's why the name of the flag is:
have_governor_per_policy.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Not tested, but we had a patch unconditionally enabling
> CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
> based on RK3399 platform. 

Sure, that sounds good. Just that you need to update the commit log a bit.

>  drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index fe14c57de6ca..040ec0f711f9 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
>  	{ .compatible = "rockchip,rk3328", },
>  	{ .compatible = "rockchip,rk3366", },
>  	{ .compatible = "rockchip,rk3368", },
> -	{ .compatible = "rockchip,rk3399", },
> +	{ .compatible = "rockchip,rk3399",
> +	  .data = &(struct cpufreq_dt_platform_data)

data is void *. No need to provide typecast information. This shouldn't throw
any build warnings I believe.

> +		{ .have_governor_per_policy = true, },

-- 
viresh
