From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Fri, 18 Mar 2016 01:20:59 +0100
Message-ID: <10670722.U2p4NnYGsS@vostro.rjw.lan>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com> <1704778.QLUl50G1uZ@vostro.rjw.lan> <CA+5PVA4iMHGEhSjDOwR_JB2i+wL2o6v7-aTErfsJ5nqFHp+JMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60098 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S967380AbcCRAS4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 20:18:56 -0400
In-Reply-To: <CA+5PVA4iMHGEhSjDOwR_JB2i+wL2o6v7-aTErfsJ5nqFHp+JMA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Thursday, March 17, 2016 12:44:54 PM Josh Boyer wrote:
> On Thu, Mar 17, 2016 at 10:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, March 17, 2016 09:02:29 AM Josh Boyer wrote:
> >> Hello,
> >
> > Hi,
> >
> >> I have an Intel Atom based NUC that is producing the following
> >> backtraces on boot of Linus' tree as of last evening.  This does not
> >> happen with a tree with top level commit 271ecc5253e2, but does happen
> >> when using the tree mentioned in the subject with top level commit
> >> 63e30271b04c.
> >>
> >> The first backtrace appears to be a warning because the intel_pstate
> >> driver is calling wrmsrl_on_cpu when interrupts are disabled?  Not
> >> sure on that one.
> >>
> >> The second backtrace is a lockdep report.  Both are from the same boot.
> >
> > OK, thanks for the report.
> >
> > Can you please try the patch below?
> >
> > I'm actually unsure if we can do that safely in general for Atom because
> > of the initialization, but that's what Core does anyway.
> >
> > Srinivas, Philippe, why exactly do we need the wrmsrl_on_cpu() in
> > atom_set_pstate()?  core_set_pstate() uses wrmsrl() and seems to be doing fine.
> >
> > ---
> >  drivers/cpufreq/intel_pstate.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -587,7 +587,7 @@ static void atom_set_pstate(struct cpuda
> >
> >         val |= vid;
> >
> > -       wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> > +       wrmsrl(MSR_IA32_PERF_CTL, val);
> >  }
> >
> >  static int silvermont_get_scaling(void)
> >
> 
> I applied this on top of commit 09fd671ccb24 and the backtrace and
> lockdep report both go away.  So yes, this seems to clear up the
> issue.  I tested it on a variety of different CPU types and didn't
> notice anything wrong on them either.

The problems may show up during initialization and cleanup where one CPU
may be running code trying to configure a different one.  In those cases
wrmsrl_on_cpu() needs to be used.

Let me cut a patch taking that into account.

Thanks,
Rafael

