From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: v3.13.5 intel_pstate: cpufreq: __cpufreq_add_dev: ->get() failed
Date: Wed, 12 Mar 2014 00:07:03 +0100
Message-ID: <3509059.VnUUJct98J@vostro.rjw.lan>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com> <531F783B.7010100@gmail.com> <2792846.28xTH7a9zW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2792846.28xTH7a9zW@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, Patrik Lundquist <patrik.lundquist@gmail.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 11, 2014 11:48:30 PM Rafael J. Wysocki wrote:
> On Tuesday, March 11, 2014 01:55:23 PM Dirk Brandewie wrote:
> > On 03/11/2014 01:57 PM, Rafael J. Wysocki wrote:
> > > On Tuesday, March 11, 2014 09:52:42 PM Rafael J. Wysocki wrote:
> > >> On Tuesday, March 11, 2014 01:17:20 PM Dirk Brandewie wrote:
> > >>> On 03/11/2014 01:20 PM, Rafael J. Wysocki wrote:
> > >>>> On Tuesday, March 11, 2014 10:58:59 AM Dirk Brandewie wrote:
> > >>>>> Hi Patrick,
> > >>>>>
> > >>>>> Sorry for the slow response you caught me taking a few days off :-)
> > >>>>>
> > >>>>> On 03/07/2014 07:49 AM, Patrik Lundquist wrote:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> booting 3.13.5 on a dual socket Ivy Bridge-EP resulted in this error:
> > >>>>>>
> > >>>>>> [    0.194139] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2687W v2 @
> > >>>>>> 3.40GHz (fam: 06, model: 3e, stepping: 04)
> > >>>>>> ...
> > >>>>>> [    0.246755] x86: Booting SMP configuration:
> > >>>>>> [    0.250935] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> > >>>>>> [    0.357648] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
> > >>>>>> [    0.553293] x86: Booted up 2 nodes, 16 CPUs
> > >>>>>> [    0.557666] smpboot: Total of 16 processors activated (108850.19 BogoMIPS)
> > >>>>>> ...
> > >>>>>> [    5.210204] Intel P-state driver initializing.
> > >>>>>> [    5.232407] Intel pstate controlling: cpu 0
> > >>>>>> [    5.253628] Intel pstate controlling: cpu 1
> > >>>>>> [    5.274899] cpufreq: __cpufreq_add_dev: ->get() failed
> > >>>>>> [    5.294856] Intel pstate controlling: cpu 2
> > >>>>>> [    5.313553] Intel pstate controlling: cpu 3
> > >>>>>> [    5.332526] Intel pstate controlling: cpu 4
> > >>>>>> [    5.352347] Intel pstate controlling: cpu 5
> > >>>>>> [    5.372112] Intel pstate controlling: cpu 6
> > >>>>>> [    5.391097] Intel pstate controlling: cpu 7
> > >>>>>> [    5.410272] Intel pstate controlling: cpu 8
> > >>>>>> [    5.429092] Intel pstate controlling: cpu 9
> > >>>>>> [    5.447714] Intel pstate controlling: cpu 10
> > >>>>>> [    5.465872] Intel pstate controlling: cpu 11
> > >>>>>> [    5.482942] Intel pstate controlling: cpu 12
> > >>>>>> [    5.498414] Intel pstate controlling: cpu 13
> > >>>>>> [    5.513586] Intel pstate controlling: cpu 14
> > >>>>>> [    5.529200] Intel pstate controlling: cpu 15
> > >>>>>>
> > >>>>>> CPU 1 is alive and well but missing the cpufreq driver. The system is
> > >>>>>> running fine otherwise.
> > >>>>>
> > >>>>> This is a regression introduced by commit
> > >>>>> da60ce9f2fa cpufreq: call cpufreq_driver->get() after calling ->init()
> > >>>>
> > >>>> So the problem is that ->get() may return 0 in intel_pstate and that causes
> > >>>> the core's _add function to abort?  That would mean sample->freq equal to 0,
> > >>>> which shouldn't happen after intel_pstate_sample() called by intel_pstate_init_cpu().
> > >>>>
> > >>>> Or am I missing anything?
> > >>>>
> > >>>
> > >>> The problem is that the core has been running less than 1% of the time based on
> > >>> the absolute values of aperf/mperf and the second sample has not been taken to
> > >>> get a more precise delta.
> > >>>
> > >>> I thought about running sample twice during init but didn't want to propose it
> > >>> until I made sure I was not going to break anything else.
> > >>
> > >> Well, ->setpolicy drivers are a special case anyway, so we can simply skip the
> > >> current frequency updates in __cpufreq_add_dev() and cpufreq_update_policy()
> > >> for them.
> > >
> > > In other words, we can do something like in the patch below I suppose?
> > >
> > > Rafael
> > >
> > >
> > > ---
> > >   drivers/cpufreq/cpufreq.c |    4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > > @@ -1137,7 +1137,7 @@ static int __cpufreq_add_dev(struct devi
> > >   		per_cpu(cpufreq_cpu_data, j) = policy;
> > >   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > >
> > > -	if (cpufreq_driver->get) {
> > > +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> > >   		policy->cur = cpufreq_driver->get(policy->cpu);
> > >   		if (!policy->cur) {
> > >   			pr_err("%s: ->get() failed\n", __func__);
> > > @@ -2150,7 +2150,7 @@ int cpufreq_update_policy(unsigned int c
> > >   	 * BIOS might change freq behind our back
> > >   	 * -> ask driver for current freq and notify governors about a change
> > >   	 */
> > > -	if (cpufreq_driver->get) {
> > > +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> > >   		new_policy.cur = cpufreq_driver->get(cpu);
> > >   		if (WARN_ON(!new_policy.cur)) {
> > >   			ret = -EIO;
> > >
> > or use has_target()
> 
> Yes.
> 
> Modified patch is appended.  Patrik, can you please check if it helps?

Well, actually, I think that checking ->setpolicy is more appropriate, because
both places modified by the patch above are before calling cpufreq_set_policy()
and that quite explicitly handles ->setpolicy drivers in a special way.

It may be equivalent, but that's not obvious from the way the code is written.

So Patrik, please test this one (resending, so that it gets to linux-pm): 

---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1137,7 +1137,7 @@ static int __cpufreq_add_dev(struct devi
 		per_cpu(cpufreq_cpu_data, j) = policy;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (cpufreq_driver->get) {
+	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
 		policy->cur = cpufreq_driver->get(policy->cpu);
 		if (!policy->cur) {
 			pr_err("%s: ->get() failed\n", __func__);
@@ -2150,7 +2150,7 @@ int cpufreq_update_policy(unsigned int c
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
 	 */
-	if (cpufreq_driver->get) {
+	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
 		new_policy.cur = cpufreq_driver->get(cpu);
 		if (WARN_ON(!new_policy.cur)) {
 			ret = -EIO;

