From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Don't power on at attach for the multi PM
 domain case
Date: Wed, 04 Jul 2018 12:48:01 +0200
Message-ID: <2009003.UOWOtGbzcY@aspire.rjw.lan>
References: <20180629091537.26864-1-ulf.hansson@linaro.org>
 <20180629095146.gljbdw2zbhmj6gwl@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180629095146.gljbdw2zbhmj6gwl@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 29, 2018 11:51:46 AM CEST Viresh Kumar wrote:
> On 29-06-18, 11:15, Ulf Hansson wrote:
> > There are no legacy behavior in drivers to consider while attaching a
> > device to genpd - for the multiple PM domain case.
> > 
> > For that reason, let's instead require the driver to runtime resume the
> > device, via calling pm_runtime_get_sync() for example, when it needs to
> > power on the corresponding PM domain.
> > 
> > This allows us to improve the situation during attach. Instead of always
> > power on the PM domain, which may be unnecessary, let's leave it in its
> > current state. Additionally, to avoid the PM domain to stay powered on,
> > let's schedule a power off work.
> > 
> > Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains...")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index c298de8a8308..9e8484189034 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2235,7 +2235,7 @@ static void genpd_dev_pm_sync(struct device *dev)
> >  }
> >  
> >  static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> > -				 unsigned int index)
> > +				 unsigned int index, bool power_on)
> >  {
> >  	struct of_phandle_args pd_args;
> >  	struct generic_pm_domain *pd;
> > @@ -2271,9 +2271,11 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> >  	dev->pm_domain->detach = genpd_dev_pm_detach;
> >  	dev->pm_domain->sync = genpd_dev_pm_sync;
> >  
> > -	genpd_lock(pd);
> > -	ret = genpd_power_on(pd, 0);
> > -	genpd_unlock(pd);
> > +	if (power_on) {
> > +		genpd_lock(pd);
> > +		ret = genpd_power_on(pd, 0);
> > +		genpd_unlock(pd);
> > +	}
> >  
> >  	if (ret)
> >  		genpd_remove_device(pd, dev);
> > @@ -2307,7 +2309,7 @@ int genpd_dev_pm_attach(struct device *dev)
> >  				       "#power-domain-cells") != 1)
> >  		return 0;
> >  
> > -	return __genpd_dev_pm_attach(dev, dev->of_node, 0);
> > +	return __genpd_dev_pm_attach(dev, dev->of_node, 0, true);
> >  }
> >  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
> >  
> > @@ -2359,14 +2361,14 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> >  	}
> >  
> >  	/* Try to attach the device to the PM domain at the specified index. */
> > -	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index);
> > +	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, false);
> >  	if (ret < 1) {
> >  		device_unregister(genpd_dev);
> >  		return ret ? ERR_PTR(ret) : NULL;
> >  	}
> >  
> > -	pm_runtime_set_active(genpd_dev);
> >  	pm_runtime_enable(genpd_dev);
> > +	genpd_queue_power_off_work(dev_to_genpd(genpd_dev));
> >  
> >  	return genpd_dev;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Patch applied and queued up for 4.18-rc4.

Thanks!
