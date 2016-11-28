From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 01/22] cpufreq/acpi-cpufreq: Convert to hotplug state
 machine
Date: Mon, 28 Nov 2016 10:49:08 +0100
Message-ID: <20161128094908.o6f4itwnj4gssv46@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-2-bigeasy@linutronix.de>
 <20161128051520.GA9104@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45276 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932223AbcK1JtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 04:49:14 -0500
Content-Disposition: inline
In-Reply-To: <20161128051520.GA9104@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 2016-11-28 10:45:20 [+0530], Viresh Kumar wrote:
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 297e9128fe9f..2c29cbaca7b5 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -922,37 +909,47 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
> >  	.attr		= acpi_cpufreq_attr,
> >  };
> >  
> > +static enum cpuhp_state acpi_cpufreq_online;
> > +
> >  static void __init acpi_cpufreq_boost_init(void)
> >  {
> > -	if (boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)) {
> > -		msrs = msrs_alloc();
> > +	int ret;
> >  
> > -		if (!msrs)
> > -			return;
> > +	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
> > +		return;
> >  
> > -		acpi_cpufreq_driver.set_boost = set_boost;
> > -		acpi_cpufreq_driver.boost_enabled = boost_state(0);
> > +	msrs = msrs_alloc();
> >  
> > -		cpu_notifier_register_begin();
> > +	if (!msrs)
> > +		return;
> >  
> > -		/* Force all MSRs to the same value */
> > -		boost_set_msrs(acpi_cpufreq_driver.boost_enabled,
> > -			       cpu_online_mask);
> 
> Why isn't this required anymore ?

Later there is cpuhp_setup_state() which invokes the online callback
(cpufreq_boost_online) which is doing this.

> > +	acpi_cpufreq_driver.set_boost = set_boost;
> > +	acpi_cpufreq_driver.boost_enabled = boost_state(0);
> >  
> > -		__register_cpu_notifier(&boost_nb);
> > -
> > -		cpu_notifier_register_done();
> > +	/*
> > +	 * This calls the online callback on all online cpu and forces all
> > +	 * MSRs to the same value.
> > +	 */
> > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cpufreq/acpi:online",
> > +				cpufreq_boost_online, cpufreq_boost_down_prep);
> > +	if (ret < 0) {
> > +		pr_err("acpi_cpufreq: failed to register hotplug callbacks\n");
> > +		msrs_free(msrs);
> 
> If 'msrs = NULL' is required to be done in the _exit() routine, then it should
> be done here as well. Right?

It is not required in the exit path, it is just needed here. It is gone
in the following patch anyway but I will post a fixed version.

> > +		return;
> >  	}
> > +	acpi_cpufreq_online = ret;
> >  }
> >  
> >  static void acpi_cpufreq_boost_exit(void)
> >  {
> > -	if (msrs) {
> > -		unregister_cpu_notifier(&boost_nb);
> > +	if (!msrs)
> > +		return;
> >  
> > -		msrs_free(msrs);
> > -		msrs = NULL;
> > -	}
> > +	if (acpi_cpufreq_online >= 0)
> > +		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
> > +
> > +	msrs_free(msrs);
> > +	msrs = NULL;
> >  }
> >  
> >  static int __init acpi_cpufreq_init(void)
> > -- 
> > 2.10.2

Sebastian
