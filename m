From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 2/7] cpufreq: Add boost frequency support in core
Date: Tue, 16 Jul 2013 14:06:32 +0200
Message-ID: <20130716140632.70fb2838@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-3-git-send-email-l.majewski@samsung.com>
 <CAKohpomfWKiRjznXeYsg32xAAWPTBQ4Gd0D_pftbA5=zMDiH4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25488 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab3GPMHQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2013 08:07:16 -0400
In-reply-to: <CAKohpomfWKiRjznXeYsg32xAAWPTBQ4Gd0D_pftbA5=zMDiH4Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

On Tue, 16 Jul 2013 15:11:54 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> 
> > +int cpufreq_boost_trigger_state(int state)
> > +{
> > +       unsigned long flags;
> > +       int ret = 0;
> > +
> > +       if (boost_enabled != state) {
> > +               write_lock_irqsave(&cpufreq_driver_lock, flags);
> > +               boost_enabled = state;
> > +
> > +               ret = cpufreq_driver->enable_boost(state);
> > +               if (ret)
> > +                       boost_enabled = 0;
> > +
> > +               write_unlock_irqrestore(&cpufreq_driver_lock,
> > flags); +
> > +               if (ret)
> > +                       pr_err("%s: BOOST cannot enable (%d)\n",
> 
> Who said we are enabling it?

You are right here - also disablement could fail. I will fix it.

> 
> > +                              __func__, ret);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +int cpufreq_boost_supported(void)
> > +{
> > +       if (cpufreq_driver)
> > +               return cpufreq_driver->boost_supported;
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_boost_supported);
> > +
> > +int cpufreq_boost_enabled(void)
> > +{
> > +       return boost_enabled;
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
> > +
> > +void cpufreq_set_boost_enabled(int state)
	  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [*]

> 
> Maybe cpufreq_block_boost? As suggested by Rafael.

What do you mean by cpufreq_block_boost()? This name would reverse the
logic.

Function [*] is used to change boost_enabled static flag (defined at
cpufreq.c file) state according to acpi-cpufreq.c boost support status.


> 
> > +{
> > +       boost_enabled = state;
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_set_boost_enabled);
> > +
> > +/*********************************************************************
> >   *               REGISTER / UNREGISTER CPUFREQ
> > DRIVER                *
> > *********************************************************************/
> >
> > @@ -2001,6 +2094,22 @@ int cpufreq_register_driver(struct
> > cpufreq_driver *driver_data) cpufreq_driver = driver_data;
> >         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >
> > +       if (cpufreq_driver->boost_supported) {
> > +               /*
> > +                * Check if boost driver provides function to
> > enable boost -
> > +                * if not, use cpufreq_boost_enable_sw as default
> > +                */
> > +               if (!cpufreq_driver->enable_boost)
> > +                       cpufreq_driver->enable_boost =
> > &cpufreq_boost_enable_sw;
> 
> & is redundant.

Yes, correct. I will change that.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
