From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] PM / OPP: optimize dev_pm_opp_set_rate() a bit
Date: Mon, 25 Jul 2016 13:12:52 +0800
Message-ID: <20160725131252.0c583a4a@xhacker>
References: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
	<20160722162151.GT3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160722162151.GT3122@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dear Viresh,

On Fri, 22 Jul 2016 09:21:51 -0700 Viresh Kumar  wrote:

> On 22-07-16, 20:42, Jisheng Zhang wrote:
> >  static int _set_opp_voltage(struct device *dev, struct regulator *reg,
> >  			    unsigned long u_volt, unsigned long u_volt_min,
> >  			    unsigned long u_volt_max)
> > @@ -586,9 +565,24 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  		return -EINVAL;
> >  	}
> >  
> > -	clk = _get_opp_clk(dev);
> > -	if (IS_ERR(clk))
> > +	rcu_read_lock();
> > +
> > +	opp_table = _find_opp_table(dev);
> > +	if (IS_ERR(opp_table)) {
> > +		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
> > +		rcu_read_unlock();
> > +		return PTR_ERR(opp_table);
> > +	}
> > +
> > +	clk = opp_table->clk;
> > +	if (IS_ERR(clk)) {
> > +		dev_err(dev, "%s: No clock available for the device\n",
> > +			__func__);
> > +		rcu_read_unlock();
> >  		return PTR_ERR(clk);
> > +	}
> > +
> > +	rcu_read_unlock();  
> 
> It is not _safe_ to use opp_table pointer after the rcu_read_unlock()

Oops, indeed. Thanks very much for pointing it out! Will fix it in v2, so
it seems we can only reduce the call of _find_opp_table to twice.

Thanks,
Jisheng
