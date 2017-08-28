From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: ti: Fix 'of_node_put' being called twice in error handling path
Date: Mon, 28 Aug 2017 23:21:07 +0200
Message-ID: <13108044.7jpZQWdzkb@aspire.rjw.lan>
References: <20170819202246.18415-1-christophe.jaillet@wanadoo.fr> <20170820132106.GA21417@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64425 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751284AbdH1V3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2017 17:29:46 -0400
In-Reply-To: <20170820132106.GA21417@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sunday, August 20, 2017 3:21:06 PM CEST Viresh Kumar wrote:
> On 19-08-17, 22:22, Christophe JAILLET wrote:
> > If 'dev_pm_opp_set_supported_hw()' fails, 'opp_data->opp_node' refcount
> > will be decremented 2 times.
> > One, just a few lines above, and another one in the error handling path.
> > 
> > Fix it by simply moving the 'of_node_put' call of the normal path.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/cpufreq/ti-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index a7b5658c0460..b29cd3398463 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -245,8 +245,6 @@ static int ti_cpufreq_init(void)
> >  	if (ret)
> >  		goto fail_put_node;
> >  
> > -	of_node_put(opp_data->opp_node);
> > -
> >  	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
> >  							  version, VERSION_COUNT));
> >  	if (ret) {
> > @@ -255,6 +253,8 @@ static int ti_cpufreq_init(void)
> >  		goto fail_put_node;
> >  	}
> >  
> > +	of_node_put(opp_data->opp_node);
> > +
> >  register_cpufreq_dt:
> >  	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
