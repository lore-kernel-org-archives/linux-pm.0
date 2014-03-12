From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: v3.13.5 intel_pstate: cpufreq: __cpufreq_add_dev: ->get() failed
Date: Wed, 12 Mar 2014 14:27:29 +0100
Message-ID: <6940820.ZTt8rJoQDh@vostro.rjw.lan>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com> <3509059.VnUUJct98J@vostro.rjw.lan> <CAA7pwKOgtx8dBSzdu2iBS_f1Xck0MkmHYjQOvsS-8W+HxFkYmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAA7pwKOgtx8dBSzdu2iBS_f1Xck0MkmHYjQOvsS-8W+HxFkYmg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Patrik Lundquist <patrik.lundquist@gmail.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 12, 2014 12:42:26 PM Patrik Lundquist wrote:
> On 12 March 2014 00:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > So Patrik, please test this one (resending, so that it gets to linux-pm):
> 
> Will do. Might take a couple of days.
> 
> cpufreq_quick_get() caught my eye when applying the patch. "This is
> the last known freq, without actually getting it from the driver."
> doesn't make sense since it is calling the driver. And shouldn't it
> get the frequency from the policy when possible?
> 
> 
> @@ -1484,7 +1484,7 @@ unsigned int cpufreq_quick_get(unsigned int cpu)
>         struct cpufreq_policy *policy;
>         unsigned int ret_freq = 0;
> 
> -       if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
> +       if (cpufreq_driver && !cpufreq_driver->setpolicy && cpufreq_driver->get)
>                 return cpufreq_driver->get(cpu);

No, that one is intentional, because ->setpolicy drivers are supposed to
implement a fast mechanism to obtain the frequency via ->get().

It also isn't related to the problem at hand.  The kerneldoc is outdated, though.

> 
>         policy = cpufreq_cpu_get(cpu);
> 
> 
> 
> > ---
> >  drivers/cpufreq/cpufreq.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -1137,7 +1137,7 @@ static int __cpufreq_add_dev(struct devi
> >                 per_cpu(cpufreq_cpu_data, j) = policy;
> >         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >
> > -       if (cpufreq_driver->get) {
> > +       if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> >                 policy->cur = cpufreq_driver->get(policy->cpu);
> >                 if (!policy->cur) {
> >                         pr_err("%s: ->get() failed\n", __func__);
> > @@ -2150,7 +2150,7 @@ int cpufreq_update_policy(unsigned int c
> >          * BIOS might change freq behind our back
> >          * -> ask driver for current freq and notify governors about a change
> >          */
> > -       if (cpufreq_driver->get) {
> > +       if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> >                 new_policy.cur = cpufreq_driver->get(cpu);
> >                 if (WARN_ON(!new_policy.cur)) {
> >                         ret = -EIO;
> >

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
