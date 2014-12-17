From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] cpuidle, ACPI: remove unused CPUIDLE_FLAG_TIME_INVALID
Date: Wed, 17 Dec 2014 01:28:01 +0100
Message-ID: <1590939.ihOXNTxWbF@vostro.rjw.lan>
References: <1418712728-2193-1-git-send-email-lenb@kernel.org> <2d1595ea66f8eadeb1e337354b311c4f5282e2a1.1418712225.git.len.brown@intel.com> <549012A9.6070408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54075 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750810AbaLQAGR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 19:06:17 -0500
In-Reply-To: <549012A9.6070408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Tuesday, December 16, 2014 12:08:25 PM Daniel Lezcano wrote:
> On 12/16/2014 07:52 AM, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> >
> > CPUIDLE_FLAG_TIME_INVALID is no longer checked
> > by menu or ladder cpuidle governors, so don't
> > bother setting or defining it.
> >
> > It was originally invented to account for the fact that
> > acpi_safe_halt() enables interrupts to invoke HLT.
> > That would allow interrupt service routines to be included
> > in the last_idle duration measurements made in cpuidle_enter_state(),
> > potentially returning a duration much larger than reality.
> >
> > But menu and ladder can gracefully handle erroneously large duration
> > intervals without checking for CPUIDLE_FLAG_TIME_INVALID.
> > Further, if they don't check CPUIDLE_FLAG_TIME_INVALID, they
> > can also benefit from the instances when the duration interval
> > is not erroneously large.
> >
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

OK

Since the material for my next pull request is staged already, I'm going to
queue up this series for 3.19-rc, but I'll most likely push it for -rc2.

Thanks!

> > ---
> >   drivers/acpi/processor_idle.c | 2 --
> >   include/linux/cpuidle.h       | 3 ---
> >   2 files changed, 5 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index 4995365..87b704e 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -985,8 +985,6 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
> >   		state->flags = 0;
> >   		switch (cx->type) {
> >   			case ACPI_STATE_C1:
> > -			if (cx->entry_method != ACPI_CSTATE_FFH)
> > -				state->flags |= CPUIDLE_FLAG_TIME_INVALID;
> >
> >   			state->enter = acpi_idle_enter_c1;
> >   			state->enter_dead = acpi_idle_play_dead;
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index a07e087..ab70f3b 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -53,7 +53,6 @@ struct cpuidle_state {
> >   };
> >
> >   /* Idle State Flags */
> > -#define CPUIDLE_FLAG_TIME_INVALID	(0x01) /* is residency time measurable? */
> >   #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
> >   #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
> >
> > @@ -89,8 +88,6 @@ DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
> >   /**
> >    * cpuidle_get_last_residency - retrieves the last state's residency time
> >    * @dev: the target CPU
> > - *
> > - * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_INVALID is set
> >    */
> >   static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
> >   {
> >
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
