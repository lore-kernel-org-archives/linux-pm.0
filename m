From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [Update][PATCH] cpufreq: Do not hold driver module references
 for additional policy CPUs
Date: Fri, 02 Aug 2013 12:39:19 +0530
Message-ID: <51FB5B1F.7030602@linux.vnet.ibm.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan> <51FAC46D.1000703@linux.vnet.ibm.com>	<1757496.qSuJuAun9Z@vostro.rjw.lan> <2298639.F0Qv2QqRnZ@vostro.rjw.lan> <CAKohponru8Z1fod43dVtAODmYuMTGX70+73b8wk4wuGN=Vuh-w@mail.gmail.com> <51FB568B.1040902@linux.vnet.ibm.com> <CAKohpon85sFMz=2e=gdJ43JtVW9StW44CgKmJSuDtOZyq5cb+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:54973 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab3HBHNB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 03:13:01 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 12:32:44 +0530
In-Reply-To: <CAKohpon85sFMz=2e=gdJ43JtVW9StW44CgKmJSuDtOZyq5cb+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 08/02/2013 12:29 PM, Viresh Kumar wrote:
> On 2 August 2013 12:19, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> But lsmod shows 0 for the cpufreq driver right? (Note, your related_cpus
>> should have only 1 CPU each, for you to see 0. Else, you'll see a non-zero
>> value due to the very bug/inconsistency that Rafael is fixing in this
>> patch).
> 
> I have hacked the driver this way:
> 
> @@ -2114,10 +2114,16 @@ int cpufreq_register_driver(struct
> cpufreq_driver *driver_data)
>         cpufreq_driver = driver_data;
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> +       printk(KERN_INFO "%s: Module refcount: %lu\n", __func__,
> +                       module_refcount(cpufreq_driver->owner));
> +
>         ret = subsys_interface_register(&cpufreq_interface);
>         if (ret)
>                 goto err_null_driver;
> 
> 
> And this gave me 1..
> 

Well, on my system, lsmod shows:

acpi_cpufreq           13643  0 

The last column is the refcount, as printed by:
kernel/module.c: print_unload_info()

 913         seq_printf(m, " %lu ", module_refcount(mod));


I guess you are printing it at an odd time, when the module
is still running its init function. Perhaps the core kernel
module infrastructure increments the refcount around that
region temporarily?

Regards,
Srivatsa S. Bhat

