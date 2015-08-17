From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Mon, 17 Aug 2015 15:27:26 +0200
Message-ID: <20150817132726.GA11047@amd>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com>
 <20150817101115.GA27204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35916 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbHQN12 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 09:27:28 -0400
Content-Disposition: inline
In-Reply-To: <20150817101115.GA27204@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2015-08-17 12:11:15, Ingo Molnar wrote:
> 
> * Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)

Access denied :-(

> > that, after resuming from S3, CPU is working at a low speed.
> > After investigation, it is found that, BIOS has modified the value
> > of THERM_CONTROL register during S3, changes it from 0 to 0x10,
> > while the latter means CPU can only get 25% of the Duty Cycle,
> > and this caused the problem.

What HW is this on?

> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -97,6 +97,7 @@ static void __save_processor_state(struct saved_context *ctxt)
> >  	mtrr_save_fixed_ranges(NULL);
> >  
> >  	rdmsrl(MSR_EFER, ctxt->efer);
> > +	rdmsrl(MSR_IA32_THERM_CONTROL, ctxt->clock_modulation);
> 
> So what your changelog fails to mention:
> 
>  - You only add this code to the 64-bit kernel. Are 32-bit kernels not affected?
> 
>  - the MSR read is done unconditionally. Is MSR_IA32_THERM_CONTROL available
>    architecturally and readable (and has sensible values) on all 64-bit capable
>    x86 CPUs that run this code path?

- So BIOS expects to control MSR_IA32_THERM_CONTROL . Now you suspend
  in hot enironment but resume in cool one. BIOS sets up
  MSR_IA32_THERM_CONTROL the right way, but you override it.

  As BIOS expects to control MSR_IA32_THERM_CONTROL and machine is
  kept cool, BIOS will not write new value to it, and machine will
  keep running slowly.

Doing this unconditionally is asking for trouble. Blacklist entry with
affected BIOS info might be acceptable, but...
									Pavel  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
