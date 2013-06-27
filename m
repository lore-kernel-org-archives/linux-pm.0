From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Thu, 27 Jun 2013 17:55:46 +0200
Message-ID: <20130627175546.677d9f9b@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-3-git-send-email-l.majewski@samsung.com>
 <CAKohpon7GLGvrkFQdWpco5f9P7S8L-2-ETMu2-3dFEDwOgL1RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpon7GLGvrkFQdWpco5f9P7S8L-2-ETMu2-3dFEDwOgL1RQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Jun 2013 16:24:32 +0530, Viresh Kumar wrote:

> > +int cpufreq_boost_trigger_state(int state)
> > +{
> > +       unsigned long flags;
> > +       int ret = 0;
> > +
> > +       if (boost_enabled != state) {
> > +               write_lock_irqsave(&cpufreq_driver_lock, flags);
> > +               boost_enabled = state;
> > +               if (cpufreq_driver->enable_boost)
> > +                       ret = cpufreq_driver->enable_boost(state);
> > +               else
> > +                       ret = cpufreq_boost_trigger_state_sw();

I will use only one call to cpufreq_driver->enable_boost(state) [*] with
either cpufreq_boost_enable_sw() (function with SW boost handling) or
 the one provided by cpufreq driver.

Only when cpufreq driver doesn't provide [*], it will be filled with
"default" cpufreq_boost_enable_sw().

> > +
> > +               if (ret) {
> > +                       boost_enabled = 0;
> > +
> > write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > +                       pr_err("%s: BOOST cannot enable (%d)\n",
> > +                              __func__, ret);
> > +
> > +                       return ret;
> > +               }
> > +               write_unlock_irqrestore(&cpufreq_driver_lock,
> > flags);  


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
