From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 7/8] PM / OPP: Allow platform specific custom opp_set_rate() callbacks
Date: Wed, 12 Oct 2016 00:26:32 +0200
Message-ID: <4594322.zH4gqY9UBX@vostro.rjw.lan>
References: <cover.1475581665.git.viresh.kumar@linaro.org> <f774c37de292f89053f22e9a2ac0f51c73c8dd89.1475581665.git.viresh.kumar@linaro.org> <20161005012929.GF4664@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161005012929.GF4664@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 05, 2016 06:59:29 AM Viresh Kumar wrote:
> On 04-10-16, 17:26, Viresh Kumar wrote:
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > +int dev_pm_opp_register_set_rate_helper(struct device *dev,
> > +	int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data))
> > +{
> > +	return -ENOTSUPP;
> > +}
> 
> + this to fix up a warning:
> 
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index ef882ed24b0e..483f33e70895 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -180,7 +180,7 @@ static inline int dev_pm_opp_set_supported_hw(struct device *dev,
>  
>  static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
>  
> -int dev_pm_opp_register_set_rate_helper(struct device *dev,
> +static inline int dev_pm_opp_register_set_rate_helper(struct device *dev,
>         int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data))
>  {
>         return -ENOTSUPP;
> 
> 

Can you resend the full patch, please?

Thanks,
Rafael
