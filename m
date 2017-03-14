From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/14] cpufreq: intel_pstate: Skip unnecessary PID resets on init
Date: Tue, 14 Mar 2017 17:40:54 +0100
Message-ID: <12755010.JhP3xaBCR7@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan> <000001d29cdd$00458ff0$00d0afd0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59135 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751158AbdCNQqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 12:46:25 -0400
In-Reply-To: <000001d29cdd$00458ff0$00d0afd0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Linux PM' <linux-pm@vger.kernel.org>

On Tuesday, March 14, 2017 09:06:52 AM Doug Smythies wrote:
> On 2017.03.12 10:19 Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > PID controller parameters only need to be initialized if the
> > get_target_pstate_use_performance() P-state selection routine
> > is going to be used.  It is not necessary to initialize them
> > otherwise, so don't do that.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > drivers/cpufreq/intel_pstate.c |    4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -1974,12 +1974,12 @@ static int intel_pstate_init_cpu(unsigne
> > 			intel_pstate_disable_ee(cpunum);
> > 
> >  		intel_pstate_hwp_enable(cpu);
> > +	} else if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance) {
> > +		intel_pstate_pid_reset(cpu);
> >  	}
> > 
> >  	intel_pstate_get_cpu_pstates(cpu);
> > 
> > -	intel_pstate_pid_reset(cpu);
> > -
> >  	pr_debug("controlling: cpu %d\n", cpunum);
> > 
> > 	return 0;
> 
> Hi Rafael,
> 
> The patch has a long line and scripts/checkpatch.pl complains.
> 
> $ scripts/checkpatch.pl rjw_7_14.txt
> WARNING: line over 80 characters

I just ignore these.  I disagree with checkpatch.pl about this particular item. :-)

> #27: FILE: drivers/cpufreq/intel_pstate.c:1977:
> +       } else if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance) {
> 
> total: 0 errors, 1 warnings, 14 lines checked
> 
> Myself, I don't care, and only found this by accident. I am just passing along
> the information.

OK

Thanks,
Rafael
