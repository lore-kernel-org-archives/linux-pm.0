From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Tue, 01 Mar 2016 13:17:37 +0100
Message-ID: <16028318.H9OZ9hFYY1@skinner>
References: <4687430.mfM0GbdeDL@skinner> <4735967.8N5ugyHAG2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55644 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbcCAMRk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 07:17:40 -0500
In-Reply-To: <4735967.8N5ugyHAG2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, Thomas Renninger <trenn@suse.com>, x86@kernel.org

On Saturday, February 27, 2016 12:15:47 AM Rafael J. Wysocki wrote:
> On Friday, February 26, 2016 05:38:00 PM Thomas Renninger wrote:
> > The assumption that BIOSes never want to have this register being set to
> > full performance (zero) is wrong.
> > 
> > While wrongly overruling this BIOS setting and set it from performance
> > to normal did not hurt that much, because nobody really knew the effects
> > inside Intel processors.
> > 
> > But with Broadwell-EP processor (E5-2687W v4) the CPU will not enter turbo
> > modes if this value is not set to performance.
> > 
> > So switch logic to tell the user in a friendly way (info) that the CPU is
> > in performance mode and how to switch via userspace if this is not
> > intended.
> > 
> > But otherwise trust that the BIOS has set the correct value here and do
> > not
> > blindly overrule.
> > 
> > How this has been found: SLE11 had this patch, SLE12 it slipped through.
> > It took quite some time to nail down that this patch missing is the reason
> > for not entering turbo modes with this specific processor.
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.com>
> > 
> > --- a/arch/x86/kernel/cpu/intel.c	2016-02-26 17:19:55.731042972 +0100
> > +++ b/arch/x86/kernel/cpu/intel.c	2016-02-26 17:20:48.598020581 +0100
> > @@ -377,8 +377,12 @@ static void init_intel_energy_perf(struc
> > 
> >  	u64 epb;
> >  	
> >  	/*
> > 
> > -	 * Initialize MSR_IA32_ENERGY_PERF_BIAS if not already initialized.
> > -	 * (x86_energy_perf_policy(8) is available to change it at run-time.)
> > +	 * On server platforms energy bias typically is set to
> > +	 * performance on purpose.
> > +	 * On other platforms it may happen that MSR_IA32_ENERGY_PERF_BIAS
> > +	 * did not get initialized properly by BIOS.
> > +	 * Best is to to keep BIOS settings and give the user a hint whether
> > +	 * to change it via cpupower-set(8) userspace tool at runtime.
> > 
> >  	 */
> >  	
> >  	if (!cpu_has(c, X86_FEATURE_EPB))
> >  	
> >  		return;
> > 
> > @@ -387,10 +391,8 @@ static void init_intel_energy_perf(struc
> > 
> >  	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
> >  	
> >  		return;
> > 
> > -	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 
'performance'\n");
> > -	pr_warn_once("ENERGY_PERF_BIAS: View and update with
> > x86_energy_perf_policy(8)\n"); -	epb = (epb & ~0xF) |
> > ENERGY_PERF_BIAS_NORMAL;
> > -	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> > +	pr_info_once("ENERGY_PERF_BIAS is set to 'performance'\n");
> > +	pr_info_once("ENERGY_PERF_BIAS: Update with cpupower-set(8)\n");
> 
> This doesn't need to be cpupower-set IMO.

You mean why switch the message from:
x86_energy_perf_policy to cpupower-set
?

IMO x86_energy_perf_policy should not exist. It has been introduce before
cpupower set -b.
Having an extra tool/binary for this functionality is an unneeded packaging 
overhead for distros.
Also having more and more of such CPU specific tools is not userfriendly.
cpupower supports all power relevant features of your CPU and on all 
architectures (or at least it should). People should know this one better
than "x86_energy_perf_policy" and theoretically intuitively find it, even 
without a message.

So it would be nice to get the message fixed as well.

  Thomas
