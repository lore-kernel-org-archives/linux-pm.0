From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] powernv:idle: Define idle init function for power8
Date: Fri, 7 Jul 2017 18:13:02 +0530
Message-ID: <20170707124302.GC8913@in.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-4-git-send-email-ego@linux.vnet.ibm.com>
 <20170707010646.0157d251@roar.ozlabs.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170707010646.0157d251@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Nicholas,

On Fri, Jul 07, 2017 at 01:06:46AM +1000, Nicholas Piggin wrote:
> On Wed,  5 Jul 2017 22:08:14 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > In this patch we define a new function named pnv_power8_idle_init().
> > 
> > We move the following code from pnv_init_idle_states() into this newly
> > defined function.
> >    a) That patches out pnv_fastsleep_workaround_at_entry/exit when
> >       no states with OPAL_PM_SLEEP_ENABLED_ER1 are present.
> >    b) Creating a sysfs control to choose how the workaround has to be
> >    applied when a OPAL_PM_SLEEP_ENABLED_ER1 state is present.
> >    c) Set ppc_md.power_save to power7_idle when OPAL_PM_NAP_ENABLED is
> >    present.
> > 
> > With this, all the power8 specific initializations are in one place.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/platforms/powernv/idle.c | 59 ++++++++++++++++++++++++-----------
> >  1 file changed, 40 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > index a5990d9..c400ff9 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -564,6 +564,44 @@ static void __init pnv_power9_idle_init(void)
> >  		pnv_first_deep_stop_state);
> >  }
> >  
> > +
> > +static void __init pnv_power8_idle_init(void)
> > +{
> > +	int i;
> > +	bool has_nap = false;
> > +	bool has_sleep_er1 = false;
> > +	int dt_idle_states = pnv_idle.nr_states;
> > +
> > +	for (i = 0; i < dt_idle_states; i++) {
> > +		struct pnv_idle_state *state = &pnv_idle.states[i];
> > +
> > +		if (state->flags & OPAL_PM_NAP_ENABLED)
> > +			has_nap = true;
> > +		if (state->flags & OPAL_PM_SLEEP_ENABLED_ER1)
> > +			has_sleep_er1 = true;
> > +	}
> > +
> > +	if (!has_sleep_er1) {
> > +		patch_instruction(
> > +			(unsigned int *)pnv_fastsleep_workaround_at_entry,
> > +			PPC_INST_NOP);
> > +		patch_instruction(
> > +			(unsigned int *)pnv_fastsleep_workaround_at_exit,
> > +			PPC_INST_NOP);
> > +	} else {
> > +		/*
> > +		 * OPAL_PM_SLEEP_ENABLED_ER1 is set. It indicates that
> > +		 * workaround is needed to use fastsleep. Provide sysfs
> > +		 * control to choose how this workaround has to be applied.
> > +		 */
> > +		device_create_file(cpu_subsys.dev_root,
> > +				&dev_attr_fastsleep_workaround_applyonce);
> > +	}
> > +
> > +	if (has_nap)
> > +		ppc_md.power_save = power7_idle;
> > +}
> > +
> >  /*
> >   * Returns 0 if prop1_len == prop2_len. Else returns -1
> >   */
> > @@ -837,6 +875,8 @@ static int __init pnv_probe_idle_states(void)
> >  
> >  	if (cpu_has_feature(CPU_FTR_ARCH_300))
> >  		pnv_power9_idle_init();
> > +	else
> > +		pnv_power8_idle_init();
> >  
> >  	for (i = 0; i < dt_idle_states; i++) {
> >  		if (!pnv_idle.states[i].valid)
> > @@ -858,22 +898,6 @@ static int __init pnv_init_idle_states(void)
> >  	if (pnv_probe_idle_states())
> >  		goto out;
> >  
> > -	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
> > -		patch_instruction(
> > -			(unsigned int *)pnv_fastsleep_workaround_at_entry,
> > -			PPC_INST_NOP);
> > -		patch_instruction(
> > -			(unsigned int *)pnv_fastsleep_workaround_at_exit,
> > -			PPC_INST_NOP);
> 
> So previously this would run on POWER9 and patch out those branches.
> But POWER9 never runs that code, so no problem. Good cleanup.

And that's what I thought, but on checking the assembly code, I found
that pnv_fastsleep_workaround_at_exit is executed on POWER9. Will fix
this!

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

--
Thanks and Regards
gautham.
