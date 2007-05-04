From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 22:58:46 +0200
Message-ID: <20070504205846.GB24123@elf.ucw.cz>
References: <200705032221.59285.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> You all misunderstood the point I was trying to make.
> 

> > acpi_enter_sleep_state(ACPI_STATE_S4), are just different pieces of one
> > (complicated) 'platform' power off method.  It doesn't make sense to use the
> > (other) hibernation_ops without the ->enter() method.
> 
> Let's look at the big picture.
> 
> Entering hibernation basically involves these steps:
> 
> 	1. Freeze tasks
> 
> 	2. Quiesce devices and drivers
> 
> 	3. Create snapshot
> 
> 	4. Reactivate devices and drivers
> 
> 	5. Save snapshot to disk
> 
> 	6. Prepare devices for wakeup
> 
> 	7. Power down (ACPI S4 on systems which support it)
> 
> Leaving hibernation involves a similar sequence which I won't discuss.
> 
> Notice that steps 1-5 above are _completely_ independent of all issues 
> concerning wakeup devices and S4 vs. S5 vs. whatever.  They have to
> be

No, they are not. You probably should tell ACPI at step 2 that you are
suspending, and you definitely need to tell ACPI that you have resumed
(so it can re-scan AC adapters, for example).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
