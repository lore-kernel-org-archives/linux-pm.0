From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 12/21] cpufreq: Convert to hotplug state machine
Date: Wed, 7 Sep 2016 16:18:29 +0200
Message-ID: <20160907141829.wpsugjvo3mgy5b5y@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-13-bigeasy@linutronix.de>
 <CAJZ5v0i8o4Bnmvpmn+=8snEzfmBPxqcV9iGVSh62Wf0X86j8BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i8o4Bnmvpmn+=8snEzfmBPxqcV9iGVSh62Wf0X86j8BA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016-09-06 23:27:46 [+0200], Rafael J. Wysocki wrote:
> > +       ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
> > +                                       cpufreq_online,
> > +                                       cpufreq_offline);
> > +       if (ret < 0)
> > +               goto err_if_unreg;
> > +       hp_online = ret;
> 
> hp_online is enum cpuhp_state (and we pass it to
> cpuhp_remove_state_nocalls(() later on), but
> cpuhp_setup_state_nocalls() returns an int (and that should be 0 if it
> is not an error code AFAICS), so is this actually correct?

Not sure what you are pointing out here. Let me try to cover it.
cpuhp_setup_state_nocalls() return <0 for errors. Those are are not
assigned to hp_online. It returns 0 for success on ID was !=
CPUHP_AP_ONLINE_DYN and >= 0 for success if ID was CPUHP_AP_ONLINE_DYN.
In the latter case the dynamic assigned ID is returned which should be
used if you plan to remove the callbacks.
Assigning an unsigned int to enum is okay because enumeration constants
itself should be an int.

> Thanks,
> Rafael

Sebastian
