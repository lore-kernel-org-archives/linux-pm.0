From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] intel_idle: Add support for Goldmont core in the Broxton
 Socs
Date: Tue, 17 Nov 2015 17:58:37 +0530
Message-ID: <20151117122837.GA24880@intel-desktop>
References: <20151105164316.GA24063@intel-desktop>
 <2354289.b50G4ZXWXq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61407 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbKQEfK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Nov 2015 23:35:10 -0500
Content-Disposition: inline
In-Reply-To: <2354289.b50G4ZXWXq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org

On Sat, Nov 07, 2015 at 02:08:19AM +0100, Rafael J. Wysocki wrote:
> On Thursday, November 05, 2015 10:13:37 PM Srinidhi Kasagar wrote:
> > Broxton SoC uses similar Haswell like C states. Add a dedicated
> > table for this Soc.
> > 
> > Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> 
> I need an ACK from Len to apply this one.

Len, did you get a time to look at this?

Srinidhi

> 
> Thanks,
> Rafael
> 
> 
> > ---
> >  drivers/idle/intel_idle.c |   76 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> > 
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index 3a3738fe016b..beb950838cda 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -522,6 +522,76 @@ static struct cpuidle_state hsw_cstates[] = {
> >  	{
> >  		.enter = NULL }
> >  };
> > +
> > +static struct cpuidle_state bxt_cstates[] = {
> > +	{
> > +		.name = "C1-BXT",
> > +		.desc = "MWAIT 0x00",
> > +		.flags = MWAIT2flg(0x00),
> > +		.exit_latency = 2,
> > +		.target_residency = 2,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C1E-BXT",
> > +		.desc = "MWAIT 0x01",
> > +		.flags = MWAIT2flg(0x01),
> > +		.exit_latency = 10,
> > +		.target_residency = 20,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C3-BXT",
> > +		.desc = "MWAIT 0x10",
> > +		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
> > +		.exit_latency = 33,
> > +		.target_residency = 100,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C6-BXT",
> > +		.desc = "MWAIT 0x20",
> > +		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> > +		.exit_latency = 133,
> > +		.target_residency = 400,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C7s-BXT",
> > +		.desc = "MWAIT 0x32",
> > +		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
> > +		.exit_latency = 166,
> > +		.target_residency = 500,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C8-BXT",
> > +		.desc = "MWAIT 0x40",
> > +		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
> > +		.exit_latency = 300,
> > +		.target_residency = 900,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C9-BXT",
> > +		.desc = "MWAIT 0x50",
> > +		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
> > +		.exit_latency = 600,
> > +		.target_residency = 1800,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.name = "C10-BXT",
> > +		.desc = "MWAIT 0x60",
> > +		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> > +		.exit_latency = 2600,
> > +		.target_residency = 7700,
> > +		.enter = &intel_idle,
> > +		.enter_freeze = intel_idle_freeze, },
> > +	{
> > +		.enter = NULL }
> > +};
> > +
> >  static struct cpuidle_state bdw_cstates[] = {
> >  	{
> >  		.name = "C1-BDW",
> > @@ -882,6 +952,11 @@ static const struct idle_cpu idle_cpu_avn = {
> >  	.disable_promotion_to_c1e = true,
> >  };
> >  
> > +static const struct idle_cpu idle_cpu_bxt = {
> > +	.state_table = bxt_cstates,
> > +	.disable_promotion_to_c1e = true,
> > +};
> > +
> >  #define ICPU(model, cpu) \
> >  	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
> >  
> > @@ -911,6 +986,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> >  	ICPU(0x47, idle_cpu_bdw),
> >  	ICPU(0x4f, idle_cpu_bdw),
> >  	ICPU(0x56, idle_cpu_bdw),
> > +	ICPU(0x5c, idle_cpu_bxt),
> >  	ICPU(0x4e, idle_cpu_skl),
> >  	ICPU(0x5e, idle_cpu_skl),
> >  	{}
> > 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

-- 
