From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] ACPI vs device ordering on resume
Date: Fri, 1 Dec 2006 10:33:01 +0100
Message-ID: <20061201093301.GA1842@elf.ucw.cz>
References: <20061114153026.730deb94@freekitty> <200611150203.30965.len.brown@intel.com> <Pine.LNX.4.64.0611150839040.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611150839040.3349@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Len Brown <lenb@kernel.org>, linux-pm@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi!

> > So it looks like we need this sequence:
> > 
> > enable_nonboot_cpus() /* INIT */
> > finish()	/* _WAK */
> > device_resume()
> 
> Can somebody remind me about this immediately after 2.6.19?

Remind. But note that freezer is not yet SMP safe... Rafael is working
on that.
								Pavel

> No way am I going to make that kind of a major ordering change right now, 
> especially as the thing isn't apparently even a real regression (just more 
> fallout from enabling MSI).
> 
> It would be good if people who are affected (and people in general that 
> are interested in power management) would test out the patch.
> 
> In particular, this is an even bigger change than the one suggested by 
> Stephen. It means, for example, that we will have device resume (and 
> process thawing) being called when we're in SMP mode - and that may or may 
> not have issues. So this is a really scary patch to me, no way in hell 
> will I apply it right now.
> 
> But if people try it out, it would be good..
> 
> Btw, this is a clear example of where it might be good to start actively 
> using the "early_resume" thing, and do PCI bus resume there. We might want 
> to do early_resume _before_ calling the bios (I'm not at all convinced 
> that the firmware will do the right thing without the PCI buses set up, 
> for example), and _before_ thawing processes. Then, we might let 
> individual devices do their "device resume" in the normal late resume 
> phase.
> 
> Greg already carries the patch around for that PCI bus early resume thing, 
> I think. 
> 
> We need to test these things.
> 
> 		Linus
> 
> ----
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 873228c..2989609 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -132,12 +132,12 @@ int suspend_enter(suspend_state_t state)
>  
>  static void suspend_finish(suspend_state_t state)
>  {
> -	device_resume();
> -	resume_console();
> -	thaw_processes();
>  	enable_nonboot_cpus();
>  	if (pm_ops && pm_ops->finish)
>  		pm_ops->finish(state);
> +	device_resume();
> +	resume_console();
> +	thaw_processes();
>  	pm_restore_console();
>  }
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
