From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [BUG] sleeping function called from invalid context during resume
Date: Sat, 8 Jul 2006 02:30:03 +0200
Message-ID: <20060708003003.GE1700@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF8BD@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF8BD@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >Lacking any other caller-passed indication, it would be much better for
> >acpi to look at irqs_disabled().  That's effectively a task-local,
> >cpu-local argument which was passed down to callees.  It's hacky - it's
> >like the PF_foo flags.  But it's heaps better than having all 
> >the kernel fight over the state of a global.
> 
> I didn't propose that kmalloc callers peek at system_state.
> I proposed that system_state be set properly on resume
> exactly like it is set on boot -- SYSTEM_RUNNING means
> we are up with interrupts enabled.
> 
> Note that this issue is not specific to ACPI, any other code
> that calls kmalloc during resume will hit __might_sleep().
> This is taken care of by system_state in the case of boot
> and the callers don't know anything about it -- resume
> is the same case and should work the same way.

I'd agree with Andrew here -- lets not mess with system_state. It is
broken by design, anyway.

Part of code would prefer SYSTEM_BOOTING during resume (because we are
initializing the devices), but I'm pretty sure some other piece of
code will get confused by that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
