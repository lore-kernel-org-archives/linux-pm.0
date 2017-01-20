From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Fri, 20 Jan 2017 11:54:28 +0100
Message-ID: <20170120105428.GA1804@mai>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
 <20170117093837.GA2085@mai>
 <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
 <20170119102158.GA1827@mai>
 <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38684 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdATKyf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2017 05:54:35 -0500
Received: by mail-wm0-f53.google.com with SMTP id r144so37471363wme.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2017 02:54:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Shi <alex.shi@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>

On Thu, Jan 19, 2017 at 10:43:23PM +0100, Rafael J. Wysocki wrote:

[ ... ]

> > This function is called from the notifier callback:
> >
> > static int cpuidle_latency_notify(struct notifier_block *b,
> >                 unsigned long l, void *v)
> >  {
> > -       wake_up_all_idle_cpus();
> > +       struct cpuidle_device *dev;
> > +       struct cpuidle_driver *drv;
> > +
> > +       cpuidle_pause_and_lock();
> > +       for_each_possible_cpu(cpu) {
> > +               dev = &per_cpu(cpuidle_dev, cpu);
> > +               drv = = cpuidle_get_cpu_driver(dev);
> > +               cpuidle_set_latency(drv, dev, l)
> > +       }
> > +       cpuidle_resume_and_unlock();
> > +
> >         return NOTIFY_OK;
> >  }
> 
> The above may be problematic if the constraints change relatively
> often.  It is global and it will affect all of the CPUs in the system
> every time and now think about systems with hundreds of them.

Yeah, that could be problematic. The code snippet gives the general idea but it
could be changed by for example by a flag telling the cpus when they enter idle
to update their state_count. Or something like that.

But if you think the patchset is fine, it is ok, we can improve things afterwards.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
