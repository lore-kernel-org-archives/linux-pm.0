From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 3/8] cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to
 work with common boost solution
Date: Fri, 26 Jul 2013 10:09:40 +0200
Message-ID: <20130726100940.1974559e@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-4-git-send-email-l.majewski@samsung.com>
 <CAKohpo=3+JP0ppru5DSo72yWiN3Qg9xjNJX+6KgCNiEupZEMjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13339 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739Ab3GZIK0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2013 04:10:26 -0400
In-reply-to: <CAKohpo=3+JP0ppru5DSo72yWiN3Qg9xjNJX+6KgCNiEupZEMjA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com

On Fri, 26 Jul 2013 12:58:02 +0530 Viresh Kumar wrote,
> On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c
> > b/drivers/cpufreq/acpi-cpufreq.c
> 
> >  static void __init acpi_cpufreq_boost_init(void)
> >  {
> > +       acpi_cpufreq_driver.boost_supported = false;
	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [*]
> 
> Would be better if we do this in else of below if.

We need to set boost_supported = false at [*] for the case when:
1. msrs_alloc fails 
or 
2. acpi_cpufreq is built as a module and can be inserted and removed
several times. Without [*] we could end up with wrong (not false)
initial state.

> 
> >         if (boot_cpu_has(X86_FEATURE_CPB) ||
> > boot_cpu_has(X86_FEATURE_IDA)) { msrs = msrs_alloc();
> 
> 
> > @@ -1021,12 +995,11 @@ static int __init acpi_cpufreq_init(void)
> >                         *iter = &cpb;
> >         }
> >  #endif
> > +       acpi_cpufreq_boost_init();
	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [**]
> 
> We are calling it before registering cpufreq driver. Will this have
> any complications?

When we call [**] after the cpufreq_register_driver [***] we end up with
sysfs boost attribute not exported at x86.
The boost attribute is exported at [***] only when
acpi_cpufreq.boost_supported = true. However support for boost at x86
is evaluated at acpi_cpufreq_boost_init().


> 
> >         ret = cpufreq_register_driver(&acpi_cpufreq_driver);
> >         if (ret)
> >                 free_acpi_perf_data();
> > -       else
> > -               acpi_cpufreq_boost_init();
> >
> >         return ret;



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
