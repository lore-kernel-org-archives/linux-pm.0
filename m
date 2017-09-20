From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Call notifier without holding opp_table->lock
Date: Wed, 20 Sep 2017 10:00:00 -0700
Message-ID: <20170920170000.GA457@codeaurora.org>
References: <59C2414E.6020803@samsung.com>
 <45c7e892a69c4936993c65c9987981dbe4433148.1505920911.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45c7e892a69c4936993c65c9987981dbe4433148.1505920911.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, cw00.choi@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, myungjoo.ham@samsung.com, inki.dae@samsung.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/20, Viresh Kumar wrote:
> The notifier callbacks may want to call some OPP helper routines which
> may try to take the same opp_table->lock again and cause a deadlock. One
> such usecase was reported by Chanwoo Choi, where calling
> dev_pm_opp_disable() leads us to the devfreq's OPP notifier handler,
> which further calls dev_pm_opp_find_freq_floor() and it deadlocks.
> 
> We don't really need the opp_table->lock to be held across the notifier
> call though, all we want to make sure is that the 'opp' doesn't get
> freed while being used from within the notifier chain. We can do it with
> help of dev_pm_opp_get/put() as well. Lets do it.

s/Lets/Let's/

> 
> Reported-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 4360b4efcd4c..668fd940d362 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -1627,6 +1627,9 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
>  
>  	opp->available = availability_req;
>  
> +	dev_pm_opp_get(opp);
> +	mutex_unlock(&opp_table->lock);

Does this prevent the OPP from changing while the lock is
released? That would be the only difference from before. It's
possible that nobody cares about this situation though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
