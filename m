From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM/OPP: Set cpu_dev->id in cpumask first
Date: Sun, 03 Jan 2016 02:01:16 +0100
Message-ID: <725923899.qhRhv456J6@vostro.rjw.lan>
References: <20151228031123.GB3598@ubuntu> <1451307977-7427-1-git-send-email-pi-cheng.chen@linaro.org> <20151229035054.GA6351@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42024 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751047AbcACAak (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2016 19:30:40 -0500
In-Reply-To: <20151229035054.GA6351@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tuesday, December 29, 2015 09:20:54 AM Viresh Kumar wrote:
> On 28-12-15, 21:06, Pi-Cheng Chen wrote:
> > Set cpu_dev->id in cpumask first when setting up cpumask for CPUs that
> > share the same OPP table. This might be helpful when handling cpumask
> > without the original CPU bitfield set.
> > 
> > Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> > ---
> > v1->v2:
> > - Set cpu_dev->id in cpumask at the top instead of skip it in the loop
> > ---
> >  drivers/base/power/opp/cpu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> > index 7b445e8..9f0c155 100644
> > --- a/drivers/base/power/opp/cpu.c
> > +++ b/drivers/base/power/opp/cpu.c
> > @@ -214,7 +214,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
> >  /*
> >   * Works only for OPP v2 bindings.
> >   *
> > - * cpumask should be already set to mask of cpu_dev->id.
> >   * Returns -ENOENT if operating-points-v2 bindings aren't supported.
> >   */
> >  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
> > @@ -230,6 +229,8 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
> >  		return -ENOENT;
> >  	}
> >  
> > +	cpumask_set_cpu(cpu_dev->id, cpumask);
> > +
> >  	/* OPPs are shared ? */
> >  	if (!of_property_read_bool(np, "opp-shared"))
> >  		goto put_cpu_node;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, along with the [2-3/3], thanks!

