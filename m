From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: stable 3-10-3: strange output of "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 16:52:39 +0530
Message-ID: <CAOh2x=nQL+8DNaSFOnvq9eVMse8-gDvW1gPqFtu+CT52JsG15A@mail.gmail.com>
References: <51F40612.2050403@gmx.de>
	<2111514.pxW5saG1J3@vostro.rjw.lan>
	<18359786.D7glpto546@vostro.rjw.lan>
	<2368277.VjYrsHUseA@vostro.rjw.lan>
	<51F638D9.7050904@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F638D9.7050904@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 29, 2013 at 3:11 PM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> I'm assuming that the module_get() is used in the cpufreq core to ensure that
> until the cpufreq core is managing (atleast one) CPU(s), the cpufreq backend
> driver module (eg: acpi-cpufreq) can't be removed.

I missed this simple stuff in my email.. :(

> But the cpufreq_add_dev() function does a module *put* at the end of
> initializing a fresh CPU.
>
> 1057         kobject_uevent(&policy->kobj, KOBJ_ADD);
> 1058         module_put(cpufreq_driver->owner);
> 1059         pr_debug("initialization complete\n");
> 1060
> 1061         return 0;

That actually looks wrong. And shoud be fixed.

> So, I wonder if it would be a good idea to instead allow that CPU to take a
> module refcount as well. That way, the problem that Toralf reported would go
> away, and at the same time, we can ensure that as long as the cpufreq core is
> managing CPUs, the cpufreq-backend-driver module refcount never drops to zero.
>
> Something like this:
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a4ad733..ecfbc52 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -878,9 +878,14 @@ static int cpufreq_add_dev_interface(unsigned int cpu,
>         }
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> +       /* Bump up the refcount for this CPU */
> +       policy = cpufreq_cpu_get(cpu);
> +
>         ret = cpufreq_add_dev_symlink(cpu, policy);
> -       if (ret)
> +       if (ret) {
> +               cpufreq_cpu_put(policy);
>                 goto err_out_kobj_put;
> +       }

That will do an extra kobject_get() which we don't require.. Only removing what
I mentioned earlier should be good enough, I believe.

Over that, I think below code in __cpufreq_governor() is also wrong.

	/* we keep one module reference alive for
			each CPU governed by this CPU */
	if ((event != CPUFREQ_GOV_START) || ret)
		module_put(policy->governor->owner);
	if ((event == CPUFREQ_GOV_STOP) && !ret)
		module_put(policy->governor->owner);

The second if is sensible as it puts count when governor is stopped.
But the first one decrements the count when we failed for anything
other than START..

But this routine is called for other stuff too:
- INIT/Exit
- LIMITS,

And so, count must be incremented for a passed INIT call and
decremented for a passed EXIT call, otherwise shouldn't be
touched.
