From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] cpufreq: governor: Always schedule work on the CPU
 running update
Date: Tue, 22 Mar 2016 05:51:45 +0100
Message-ID: <1458622305.29862.9.camel@gmail.com>
References: <3454445.v5QdUCRORG@vostro.rjw.lan>
	 <20160322025112.GQ27778@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160322025112.GQ27778@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-03-22 at 08:21 +0530, Viresh Kumar wrote:
> On 22-03-16, 01:17, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Modify dbs_irq_work() to always schedule the process-context work
> > on the current CPU which also ran the dbs_update_util_handler()
> > that the irq_work being handled came from.
> > 
> > This causes the entire frequency update handling (involving the
> > "ondemand" or "conservative" governors) to be carried out by the
> > CPU whose frequency is to be updated and reduces the overall amount
> > of inter-CPU noise related to cpufreq.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> > @@ -245,7 +245,7 @@ static void dbs_irq_work(struct irq_work
> >  	struct policy_dbs_info *policy_dbs;
> >  
> >  	policy_dbs = container_of(irq_work,
> > structwq_unbound_cpumask policy_dbs_info, irq_work);
> > -	schedule_work(&policy_dbs->work);
> > +	schedule_work_on(smp_processor_id(), &policy_dbs->work);
> >  }
> >  
> >  static void dbs_update_util_handler(struct update_util_data *data,
> > u64 time,
> 
> queue_work() used to queue the work on local cpu by default, has that
> changed now ?

By default it still will, but the user now has the option to deflect
work items with an unspecified target.  These will land on a CPU
included in wq_unbound_cpumask iff the current CPU is excluded
therefrom.

	-Mike
