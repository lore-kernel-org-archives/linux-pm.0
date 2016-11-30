From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Wed, 30 Nov 2016 16:17:45 +0530
Message-ID: <20161130104745.GM3288@vireshk-i7>
References: <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-11-16, 09:29, Viresh Kumar wrote:
> +struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name)
>  {
>  	struct opp_table *opp_table;
>  	struct regulator *reg;
> -	int ret;
>  
>  	mutex_lock(&opp_table_lock);
>  
>  	opp_table = _add_opp_table(dev);
>  	if (!opp_table) {
> -		ret = -ENOMEM;
> +		opp_table = ERR_PTR(-ENOMEM);
>  		goto unlock;
>  	}
>  
>  	/* This should be called before OPPs are initialized */
>  	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> -		ret = -EBUSY;
> +		opp_table = ERR_PTR(-EBUSY);

The pointer opp_table shouldn't be overwritten here as it will be used
in the error path. Will resend the patch shortly.

-- 
viresh
