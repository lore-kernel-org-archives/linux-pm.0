From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: set BYT MSR with wrmsrl_on_cpu()
Date: Mon, 11 May 2015 11:39:02 -0700
Message-ID: <20150511113902.4e8d59a7@kcaccard-desk.amr.corp.intel.com>
References: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com>
	<2313402.8O0OJYkUeN@vostro.rjw.lan>
	<20150507232232.GA4313@jbkonno-beef.jf.intel.com>
	<14176313.LWr7lMH80W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34460 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933262AbbEKSjc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 May 2015 14:39:32 -0400
In-Reply-To: <14176313.LWr7lMH80W@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joe Konno <joe.konno@linux.intel.com>, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org

On Fri, 08 May 2015 15:59:14 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Thursday, May 07, 2015 04:22:32 PM Joe Konno wrote:
> > On Thu, May 07, 2015 at 10:58:11PM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, May 07, 2015 09:59:39 AM Joe Konno wrote:
> > > > From: Joe Konno <joe.konno@intel.com>
> > > > 
> > > > In instances where the default cpufreq governor is Performance, reading
> > > 
> > > I'm not really sure what this is about.  You're talking about cpufreq governors
> > > and this is an intel_pstate patch.  What gives?
> > 
> > I'll reshuffle the paragraph to bring detail to the fix first, and the
> > "when/why" second.
> > 
> > In debug I have only seen the bug during boot when cpufreq calls
> > intel_pstate's init for each logical core-- often from one, sometimes
> > two logical cores.
> > 
> > The bug may occur after init as well, but not enough data to conclude
> > one way or the other. I personally have not seen it happen after init in
> > my local testing.
> > 
> > > 
> > > > from MSR 0x199 on an applicable multi-core Atom system saw boot-to-boot
> > > > variability in the P-State value set to each logical core.  Sometimes
> > > > only one logical core would be set properly, other times two or three.
> > > > There was an assumption in the code that only a thread on the intended
> > > > logical core would be calling the wrmsrl() function. That was disproven
> > > > during debug, as cpufreq, at init, was not always calling from the same
> > > > as the logical core it targeted. Thus, use wrmsrl_on_cpu() instead, as
> > > > done in the core_set_pstate() function.
> > > > 
> > > > For: LCK-1822
> > > 
> > > This tag is meaningless upstream.
> > 
> > Mimicked another subsystem's practice. I have no problem removing it.
> > 
> > > 
> > > > Fixes: 007bea098b86 ("intel_pstate: Add setting voltage value for
> > > >        baytrail P states.")
> > > 
> > > So, you're fixing a function introduced by the above commit, right?
> > 
> > Correct. That commit introduced the byt_set_pstate() function with the
> > wrmsrl() call.
> > 
> > > 
> > > > Signed-off-by: Joe Konno <joe.konno@intel.com>
> > > > ---
> > > >  drivers/cpufreq/intel_pstate.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > > index 6414661ac1c4..c45d274a75c8 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -535,7 +535,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
> > > >  
> > > >  	val |= vid;
> > > >  
> > > > -	wrmsrl(MSR_IA32_PERF_CTL, val);
> > > > +	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> > > 
> > > So the bug is that this may run on a CPU which is not cpudata->cpu in which
> > > case the write will not happen where it should.  Is that correct?
> > 
> > Yes-- I believe my first inline comment spoke to this.
> 
> So here's the changelog I'd use with this patch:
> 
> "Commit 007bea098b86 (intel_pstate: Add setting voltage value for baytrail
>  P states.) introduced byt_set_pstate() with the assumption that it would
>  always be run by the CPU whose MSR is to be written by it.  It turns out,
>  however, that is not always the case in practice, so modify byt_set_pstate()
>  to enforce the MSR write done by it to always happen on the right CPU."
> 
> I don't think you need to say anything more in it.  Mentioning governors in
> particular is unnecessary and confusing.
> 
> Kristen, what do you think?
> 
> 

Looks good to me with the modified changelog.

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>
