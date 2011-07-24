From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: runtime: add might_sleep to PM runtime
	functions
Date: Sun, 24 Jul 2011 23:26:12 +0200
Message-ID: <201107242326.12810.rjw__10140.479313168$1311542730$gmane$org@sisk.pl>
References: <1311396967-16721-1-git-send-email-ccross@android.com>
	<201107240057.00197.rjw@sisk.pl>
	<CAMbhsRTdQLd5GRew9GMx6O287k3O17SKE18jvK2k7oyZpOrZfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMbhsRTdQLd5GRew9GMx6O287k3O17SKE18jvK2k7oyZpOrZfg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, July 24, 2011, Colin Cross wrote:
> On Sat, Jul 23, 2011 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, July 23, 2011, Colin Cross wrote:
> >> The list of functions that can be called in atomic context is
> >> non-intuitive (pm_runtime_put_sync can not, but
> >> pm_runtime_put_sync_suspend can, if pm_runtime_irq_safe has
> >> been called?).
> >
> > However, this behavior is documented.
> >
> > Also, if you have a clean use case for calling rpm_idle() with interrupts
> > off, it can be modified to work in analogy with rpm_suspend() in that respect.
> 
> Yes, Kevin posted that patch in response to a bug that would never
> have existed with this patch.  Even with Kevin's change, this patch
> still detects drivers that are missing pm_runtime_irq_safe().
> 
> >> The code is actively misleading - the entry
> >> points all start with spin_lock_irqsave, suggesting they
> >> are safe to call in atomic context, but may later
> >> enable interrupts.
> >
> > May I say it is this way for a reason?
> 
> I'll reword that
> 
> >> Add might_sleep_if to all the __pm_runtime_* entry points
> >> to enforce correct usage.
> >
> > I'm not sure how this makes things better.
> 
> I spent hours tracking down a bug that was caused by
> pm_runtime_put_sync enabling interrupts when entering idle, which was
> causing the timer interrupt to be serviced before the cpu entered
> idle, and the cpu to idle forever until a non-timer interrupt
> occurred.  The bug would never have been introduced with this patch.
> When I ran with this patch, it immediately caught 3 other cases of
> incorrect usage in atomic context, any of which could cause deadlocks:
> spin_lock_irqsave(driver lock)
> pm_runtime_put_sync
> spin_lock_irqsave(dev lock)
> spin_unlock_irq(dev_lock) - enables interrupts
> driver irq
> spin_lock(driver lock)
> 
> One of the bugs was put_sync instead of put_sync_suspend, which would
> not be a problem after Kevin's patch, but the other two were missing
> pm_runtime_irq_safe.
> 
> Not every developer who calls a pm_runtime function is going to read
> the documentation, and this patch will catch the common incorrect
> usage the first time it is run.
> 
> I'll update this patch on top of Kevin's.
> 
> >> Also add pm_runtime_put_sync_autosuspend to the list of
> >> functions that can be called in atomic context.
> >
> > OK
> >
> > In addition to that rpm_idle() is missing the __releases __acquires
> > annotations.
> 
> Do you want that added to this patch?  It seems like that fits better
> into Kevin's patch, or a third patch.

OK, I'll do a separate patch adding those.

Thanks,
Rafael
