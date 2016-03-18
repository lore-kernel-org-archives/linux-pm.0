From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Fri, 18 Mar 2016 23:23:35 +0100
Message-ID: <CAJZ5v0hh-G1MthLYOn3jzP7S2648utWmTwik6C3YdZ=vpRwkPg@mail.gmail.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
	<10670722.U2p4NnYGsS@vostro.rjw.lan>
	<CA+5PVA78uXrqgm5a9h5ytbrd5sun4mVU5+u9V9GnY1V6rizhzg@mail.gmail.com>
	<6130650.QZM8FIW1Fl@vostro.rjw.lan>
	<CA+5PVA4LEd=QmH4=u9CO9dGHU0kY+Yz1BoZDR+KhY3WJe5cMXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35519 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcCRWXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 18:23:39 -0400
In-Reply-To: <CA+5PVA4LEd=QmH4=u9CO9dGHU0kY+Yz1BoZDR+KhY3WJe5cMXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Fri, Mar 18, 2016 at 6:35 PM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> On Fri, Mar 18, 2016 at 10:36 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, March 18, 2016 08:37:15 AM Josh Boyer wrote:
>>> On Thu, Mar 17, 2016 at 8:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> > On Thursday, March 17, 2016 12:44:54 PM Josh Boyer wrote:
>>> >> On Thu, Mar 17, 2016 at 10:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> >> > On Thursday, March 17, 2016 09:02:29 AM Josh Boyer wrote:
>>> >> >> Hello,
>>> >> >
>>> >> > Hi,
>>> >> >
>>> >> >> I have an Intel Atom based NUC that is producing the following
>>> >> >> backtraces on boot of Linus' tree as of last evening.  This does not
>>> >> >> happen with a tree with top level commit 271ecc5253e2, but does happen
>>> >> >> when using the tree mentioned in the subject with top level commit
>>> >> >> 63e30271b04c.
>>> >> >>
>>> >> >> The first backtrace appears to be a warning because the intel_pstate
>>> >> >> driver is calling wrmsrl_on_cpu when interrupts are disabled?  Not
>>> >> >> sure on that one.
>>> >> >>
>>> >> >> The second backtrace is a lockdep report.  Both are from the same boot.
>>> >> >
>>> >> > OK, thanks for the report.
>>> >> >
>>> >> > Can you please try the patch below?
>>> >> >
>>> >> > I'm actually unsure if we can do that safely in general for Atom because
>>> >> > of the initialization, but that's what Core does anyway.
>>> >> >
>>> >> > Srinivas, Philippe, why exactly do we need the wrmsrl_on_cpu() in
>>> >> > atom_set_pstate()?  core_set_pstate() uses wrmsrl() and seems to be doing fine.
>>> >> >
>>> >> > ---
>>> >> >  drivers/cpufreq/intel_pstate.c |    2 +-
>>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >> >
>>> >> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
>>> >> > ===================================================================
>>> >> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>>> >> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
>>> >> > @@ -587,7 +587,7 @@ static void atom_set_pstate(struct cpuda
>>> >> >
>>> >> >         val |= vid;
>>> >> >
>>> >> > -       wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
>>> >> > +       wrmsrl(MSR_IA32_PERF_CTL, val);
>>> >> >  }
>>> >> >
>>> >> >  static int silvermont_get_scaling(void)
>>> >> >
>>> >>
>>> >> I applied this on top of commit 09fd671ccb24 and the backtrace and
>>> >> lockdep report both go away.  So yes, this seems to clear up the
>>> >> issue.  I tested it on a variety of different CPU types and didn't
>>> >> notice anything wrong on them either.
>>> >
>>> > The problems may show up during initialization and cleanup where one CPU
>>> > may be running code trying to configure a different one.  In those cases
>>> > wrmsrl_on_cpu() needs to be used.
>>> >
>>> > Let me cut a patch taking that into account.
>>>
>>> OK.  Happy to test when you have it ready.
>>
>> Thanks!
>>
>> Please test the patch below.
>>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH] intel_pstate: Do not call wrmsrl_on_cpu() with disabled interrupts
>>
>> After commit a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with
>> utilization update callbacks) wrmsrl_on_cpu() cannot be called in the
>> intel_pstate_adjust_busy_pstate() path as that is executed with
>> disabled interrupts.  However, atom_set_pstate() called from there
>> via intel_pstate_set_pstate() uses wrmsrl_on_cpu() to update the
>> IA32_PERF_CTL MSR which triggers the WARN_ON_ONCE() in
>> smp_call_function_single().
>>
>> The reason why wrmsrl_on_cpu() is used by atom_set_pstate() is
>> because intel_pstate_set_pstate() calling it is also invoked during
>> the initialization and cleanup of the driver and in those cases it is
>> not guaranteed to be run on the CPU that is being updated.  However,
>> in the case when intel_pstate_set_pstate() is called by
>> intel_pstate_adjust_busy_pstate(), wrmsrl() can be used to update
>> the register safely.  Moreover, intel_pstate_set_pstate() already
>> contains code that only is executed if the function is called by
>> intel_pstate_adjust_busy_pstate() and there is a special argument
>> passed to it because of that.
>>
>> To fix the problem at hand, rearrange the code taking the above
>> observations into account.
>>
>> First, replace the ->set() callback in struct pstate_funcs with a
>> ->get_val() one that will return the value to be written to the
>> IA32_PERF_CTL MSR without updating the register.
>>
>> Second, split intel_pstate_set_pstate() into two functions,
>> intel_pstate_update_pstate() to be called by
>> intel_pstate_adjust_busy_pstate() that will contain all of the
>> intel_pstate_set_pstate() code which only needs to be executed in
>> that case and will use wrmsrl() to update the MSR (after obtaining
>> the value to write to it from the ->get_val() callback), and
>> intel_pstate_set_min_pstate() to be invoked during the
>> initialization and cleanup that will set the P-state to the
>> minimum one and will update the MSR using wrmsrl_on_cpu().
>>
>> Finally, move the code shared between intel_pstate_update_pstate()
>> and intel_pstate_set_min_pstate() to a new static inline function
>> intel_pstate_record_pstate() and make them both call it.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utilization update callbacks)
>
> Tested-by: Josh Boyer <jwboyer@fedoraproject.org>
>
> This worked fine on the original problem machine, and the other
> machines I also tested.  No backtrace or lockdeps reported.

Thanks!

Patch applied.
