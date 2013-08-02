From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH] cpufreq: Do not hold driver module references for
 additional policy CPUs
Date: Fri, 2 Aug 2013 12:29:27 +0530
Message-ID: <CAKohpon85sFMz=2e=gdJ43JtVW9StW44CgKmJSuDtOZyq5cb+g@mail.gmail.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan>
	<51FAC46D.1000703@linux.vnet.ibm.com>
	<1757496.qSuJuAun9Z@vostro.rjw.lan>
	<2298639.F0Qv2QqRnZ@vostro.rjw.lan>
	<CAKohponru8Z1fod43dVtAODmYuMTGX70+73b8wk4wuGN=Vuh-w@mail.gmail.com>
	<51FB568B.1040902@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57307 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab3HBG71 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 02:59:27 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so637352oag.14
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2013 23:59:27 -0700 (PDT)
In-Reply-To: <51FB568B.1040902@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 2 August 2013 12:19, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> But lsmod shows 0 for the cpufreq driver right? (Note, your related_cpus
> should have only 1 CPU each, for you to see 0. Else, you'll see a non-zero
> value due to the very bug/inconsistency that Rafael is fixing in this
> patch).

I have hacked the driver this way:

@@ -2114,10 +2114,16 @@ int cpufreq_register_driver(struct
cpufreq_driver *driver_data)
        cpufreq_driver = driver_data;
        write_unlock_irqrestore(&cpufreq_driver_lock, flags);

+       printk(KERN_INFO "%s: Module refcount: %lu\n", __func__,
+                       module_refcount(cpufreq_driver->owner));
+
        ret = subsys_interface_register(&cpufreq_interface);
        if (ret)
                goto err_null_driver;


And this gave me 1..
