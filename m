From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 12/21] cpufreq: Convert to hotplug state machine
Date: Wed, 07 Sep 2016 17:58:46 +0200
Message-ID: <9891841.xb8KPMjjUJ@vostro.rjw.lan>
References: <20160906170457.32393-1-bigeasy@linutronix.de> <CAJZ5v0i8o4Bnmvpmn+=8snEzfmBPxqcV9iGVSh62Wf0X86j8BA@mail.gmail.com> <20160907141829.wpsugjvo3mgy5b5y@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160907141829.wpsugjvo3mgy5b5y@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 07, 2016 04:18:29 PM Sebastian Andrzej Siewior wrote:
> On 2016-09-06 23:27:46 [+0200], Rafael J. Wysocki wrote:
> > > +       ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
> > > +                                       cpufreq_online,
> > > +                                       cpufreq_offline);
> > > +       if (ret < 0)
> > > +               goto err_if_unreg;
> > > +       hp_online = ret;
> > 
> > hp_online is enum cpuhp_state (and we pass it to
> > cpuhp_remove_state_nocalls(() later on), but
> > cpuhp_setup_state_nocalls() returns an int (and that should be 0 if it
> > is not an error code AFAICS), so is this actually correct?
> 
> Not sure what you are pointing out here. Let me try to cover it.
> cpuhp_setup_state_nocalls() return <0 for errors. Those are are not
> assigned to hp_online. It returns 0 for success on ID was !=
> CPUHP_AP_ONLINE_DYN and >= 0 for success if ID was CPUHP_AP_ONLINE_DYN.
> In the latter case the dynamic assigned ID is returned which should be
> used if you plan to remove the callbacks.

OK, that last part wasn't clear to me.  The kerneldoc comment for
__cpuhp_setup_state() doesn't mention the possible non-zero return values
on success, which is a bit confusing IMHO.

> Assigning an unsigned int to enum is okay because enumeration constants
> itself should be an int.

But the unsigned int still may be out of range for the given enum, so I
wouldn't call it particularly clean. :-)

Anyway, please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patch.

Thanks,
Rafael
