From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate: Lower p-state when putting down CPU
Date: Thu, 13 Mar 2014 01:07:07 +0100
Message-ID: <16035918.jZXKnQ3yiq@vostro.rjw.lan>
References: <CAKQMxzQhVz0QT6tV0PKFjXXpYpDbtnOBH=miARoeQhrvs2TKFQ@mail.gmail.com> <5320D05F.7050304@gmail.com> <5320D12B.4040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56362 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752474AbaCLX60 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 19:58:26 -0400
In-Reply-To: <5320D12B.4040303@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Patrick Marlier <patrick.marlier@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, March 12, 2014 02:27:07 PM Dirk Brandewie wrote:
> This is a multi-part message in MIME format.
> --------------030804060705000409040008
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> 
> Resend to snare Rafael since intel.com rejects mail with attached shell
> scripts

You might CC the list as well.

> On 03/12/2014 02:23 PM, Dirk Brandewie wrote:
> > Hi Patrick,
> >
> > Adding a couple of people to the CC list so I will restate the issue please
> > correct me if I get it wrong :-)
> >
> > With Patrick's reproduction case below if a core is off-lined while it
> > is requesting a high P state that request continues to be factored into
> > the hardware coordination for selecting the package P state which will
> > set the floor P state at the P state requested by the offline core.
> >
> > I changes intel_pstate's ->exit() procedure to set the P state request
> > for the core being off-lined to the MIN P state. This did not work due to the
> > exit callback being called in the CPU_POST_DEAD phase of the CPU offline
> > process.
> >
> > I hacked a call to the exit() callback into the end of __cpufreq_remove_dev_prepare()
> > and removed the exit() call in __cpufreq_remove_dev_finish() and everything
> > started as expected (at least for this test case).
> >
> > This is most likely *WRONG* given the hell Viresh and Srivatsa when through
> > getting the lightweight tear down stuff working.

I agree with this observation.  The ordering in __cpufreq_remove_dev_finish()
most likely matters and you'd need to audit all drivers implementing ->exit()
even if you thought that it didn't matter.

> > So the question for Rafael, Viresh and Srivatsa what is the way to proceed
> > here given that intel_pstate's exit() callback needs to be called in the
> > CPU_DOWN_PREPARE phase of cpu offline for it to do the work it needs to do
> > to fix the problem Patrick is seeing?
> >
> > I see two possibilities:
> >   1. Move the exit() callback to __cpufreq_remove_dev_prepare().  I don't
> >      have a good understanding of what carnage this would cause in the core
> >      or other scaling drivers.
> >
> >   2. Add another callback to the cpufreq_driver interface that would be call
> >      from __cpufreq_remove_dev_prepare() if the callback was set.

I prefer 2, the reason being that it pretty much is guaranteed not to break
anything.  For the record, I'm not a fan of adding new cpufreq driver callbacks,
but in this particular case it seems we can't really do anything better.

Thanks!

> > I am open to other suggestions as well.
> >
> > The two patches I have locally that "fix" the problem are included at the end.
> >
> > Comments, suggestions?
> > --Dirk
> >
> >
> > On 03/12/2014 10:59 AM, Patrick Marlier wrote:
> >> Here is how I proceed to test it (on a 8 HyperThread CPU):
> >>
> >> 1. make sure that the governor is not performance and that your system is idle
> >> 2. run perf.sh (script attached) and check it is running in a low frequency
> >> 3. run stress -c 4 and keep it running in background
> >> 4. run perf.sh and check it is now running full speed.
> >> 5. turn off 4 cores
> >> for i in {4..7} ; do echo 0 | sudo tee /sys/devices/system/cpu/cpu$i/online ; done
> >> 6. stop stress program
> >> 7. wait few seconds
> >> 7. run perf.sh
> >>
> >> perf.sh will show that the requested p-state for all 4 online cores is low but
> >> the effective p-state is high frequency due to offline cores.
> >>
> >> I will test your patch tomorrow and thanks again for your time.
> >>
> >> Keep you posted,
> >> --
> >> Patrick Marlier
> >>
> > commit 293dd3c8d176c3c807471a60dac308d71275251a
> > Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
> > Date:   Tue Mar 11 11:48:28 2014 -0700
> >
> >      intel_pstate: Set core to min P state during core offline
> >
> >      If a core is off-lined and becomes non-idle it will have the last
> >      requested P state for the core which could adversely affect the
> >      package P state.
> >
> >      Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> > ---
> >   drivers/cpufreq/intel_pstate.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index c883ebc..23e3fa1 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -447,7 +447,7 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
> >   	if (limits.no_turbo)
> >   		val |= (u64)1 << 32;
> >
> > -	wrmsrl(MSR_IA32_PERF_CTL, val);
> > +	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> >   }
> >
> >   static struct cpu_defaults core_params = {
> > @@ -776,12 +776,16 @@ static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> >
> >   static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> >   {
> > -	int cpu = policy->cpu;
> > +	int cpu_num = policy->cpu;
> > +	struct cpudata *cpu = all_cpu_data[cpu_num];
> >
> > +	pr_info("intel_pstate CPU %d exiting\n", cpu_num);
> > +	
> > +	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
> > +	del_timer(&all_cpu_data[cpu_num]->timer);
> > +	kfree(all_cpu_data[cpu_num]);
> > +	all_cpu_data[cpu_num] = NULL;
> >
> > -	del_timer(&all_cpu_data[cpu]->timer);
> > -	kfree(all_cpu_data[cpu]);
> > -	all_cpu_data[cpu] = NULL;
> >   	return 0;
> >   }
> >
> > commit 9277ca812181ac246c76e4634e937845ecb5c81f
> > Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
> > Date:   Wed Mar 12 12:19:05 2014 -0700
> >
> >      cpufreq: call scaling driver exit from down prepare
> >
> >      Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> > ---
> >   drivers/cpufreq/cpufreq.c      | 7 ++++---
> >   drivers/cpufreq/intel_pstate.c | 1 +
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index cf485d9..28a3c2a 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1337,7 +1337,8 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
> >   			}
> >   		}
> >   	}
> > -
> > +	if (cpufreq_driver->exit)
> > +		cpufreq_driver->exit(policy);
> >   	return 0;
> >   }
> >
> > @@ -1386,8 +1387,8 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
> >   		 * since this is a core component, and is essential for the
> >   		 * subsequent light-weight ->init() to succeed.
> >   		 */
> > -		if (cpufreq_driver->exit)
> > -			cpufreq_driver->exit(policy);
> > +//		if (cpufreq_driver->exit)
> > +//			cpufreq_driver->exit(policy);
> >
> >   		/* Remove policy from list of active policies */
> >   		write_lock_irqsave(&cpufreq_driver_lock, flags);
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 585e5f2..c883ebc 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -778,6 +778,7 @@ static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> >   {
> >   	int cpu = policy->cpu;
> >
> > +
> >   	del_timer(&all_cpu_data[cpu]->timer);
> >   	kfree(all_cpu_data[cpu]);
> >   	all_cpu_data[cpu] = NULL;
> >
> 
> 
> --------------030804060705000409040008
> Content-Type: application/x-shellscript;
>  name="perf.sh"
> Content-Transfer-Encoding: base64
> Content-Disposition: attachment;
>  filename="perf.sh"
> 
> IyEvYmluL2Jhc2ggCkNQVXM9JChzZXEgMCA3KQoKU1BFRURTVEVQX0VOQUJMRT0kKHN1ZG8g
> cmRtc3IgLWYgMTY6MTYgMHgxQTAgMj4vZGV2L251bGwpClRVUkJPTU9ERV9ESVNBQkxFPSQo
> c3VkbyByZG1zciAtZiAzODozOCAweDFBMCAyPi9kZXYvbnVsbCkKZWNobyAtbiAiU3BlZWRT
> dGVwICIKaWYgWyAiJFNQRUVEU1RFUF9FTkFCTEUiID09ICIxIiBdOyB0aGVuCiAgZWNobyAi
> RW5hYmxlIgplbHNlCiAgZWNobyAiRGlzYWJsZSIKZmkKZWNobyAtbiAiVHVyYm9Nb2RlICIK
> aWYgWyAiJFRVUkJPTU9ERV9ESVNBQkxFIiA9PSAiMCIgXTsgdGhlbgogIGVjaG8gIkVuYWJs
> ZSIKZWxzZQogIGVjaG8gIkRpc2FibGUiCmZpCgplY2hvIC1uICJSZXEgKDB4MTk5KTogIgpm
> b3IgaSBpbiAkQ1BVcwpkbwpWMTk5PSQoc3VkbyByZG1zciAtdSAtZjE2OjggLXAgJGkgMHgx
> OTkgMj4vZGV2L251bGwpCmlmIFtbICIke1YxOTl9eCIgIT0gIngiIF1dIDsgdGhlbgpwcmlu
> dGYgIiU0dSAoMHglMngpICAiICQoKCRWMTk5ICogMTAwKSkgJHtWMTk5fSAKZmkKZG9uZQoK
> IyBOb3RlIHRoYXQgaXQgaXMgbm90IGV4ZWN1dGVkIGFsbCBhdCB0aGUgc2FtZSB0aW1lIHNv
> IHAtc3RhdGUgY2FuIGNoYW5nZSBpbiBiZXR3ZWVuCmVjaG8gIiIKZWNobyAtbiAiQ3VyICgw
> eDE5OCk6ICIKZm9yIGkgaW4gJENQVXMKZG8KVjE5OD0kKHN1ZG8gcmRtc3IgLXUgLXAgJGkg
> LWYxNjo4IDB4MTk4IDI+L2Rldi9udWxsKQppZiBbWyAiJHtWMTk4fXgiICE9ICJ4IiBdXSA7
> IHRoZW4KcHJpbnRmICIlNHUgKDB4JTJ4KSAgIiAkKCgkVjE5OCAqIDEwMCkpICR7VjE5OH0g
> CmZpCmRvbmUKZWNobyAiIgoKCg==
> --------------030804060705000409040008--

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
