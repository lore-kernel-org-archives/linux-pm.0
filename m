From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86 / hibernate: Use hlt_play_dead() when resuming from
 hibernation
Date: Wed, 13 Jul 2016 11:56:17 +0200
Message-ID: <20160713095617.GB27870@amd>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
 <12570565.xIMhLmhDgj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35445 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbcGMJ4a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 05:56:30 -0400
Content-Disposition: inline
In-Reply-To: <12570565.xIMhLmhDgj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>

On Sun 2016-07-10 03:49:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On Intel hardware, native_play_dead() uses mwait_play_dead() by
> default and only falls back to the other methods if that fails.
> That also happens during resume from hibernation, when the restore
> (boot) kernel runs disable_nonboot_cpus() to take all of the CPUs
> except for the boot one offline.
> 
> However, that is problematic, because the address passed to
> __monitor() in mwait_play_dead() is likely to be written to in the
> last phase of hibernate image restoration and that causes the "dead"
> CPU to start executing instructions again.  Unfortunately, the page
> containing the address in that CPU's instruction pointer may not be
> valid any more at that point.
> 
> First, that page may have been overwritten with image kernel memory
> contents already, so the instructions the CPU attempts to execute may
> simply be invalid.  Second, the page tables previously used by that
> CPU may have been overwritten by image kernel memory contents, so the
> address in its instruction pointer is impossible to resolve then.
> 
> A report from Varun Koyyalagunta and investigation carried out by
> Chen Yu show that the latter sometimes happens in practice.
> 
> To prevent it from happening, modify native_play_dead() to make
> it use hlt_play_dead() instead of mwait_play_dead() during resume
> from hibernation which avoids the inadvertent "revivals" of "dead"
> CPUs.
> 
> A slightly unpleasant consequence of this change is that if the
> system is hibernated with one or more CPUs offline, it will generally
> draw more power after resume than it did before hibernation, because
> the physical state entered by CPUs via hlt_play_dead() is higher-power
> than the mwait_play_dead() one in the majority of cases.  It is
> possible to work around this, but it is unclear how much of a problem
> that's going to be in practice, so the workaround will be implemented
> later if it turns out to be necessary.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106371
> Reported-by: Varun Koyyalagunta <cpudebug@centtech.com>
> Original-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I notice that it changes even i386, where it should not be
neccessary. But we probably should switch i386 to support similar to
x86-64 one day (and I have patches) so no problem there.

But I wonder if simpler solution is to place the mwait semaphore into
known address? (Nosave region comes to mind?)

Best regards,
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
