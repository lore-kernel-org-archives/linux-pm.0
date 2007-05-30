From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Wed, 30 May 2007 15:37:40 +0000
Message-ID: <20070530153740.GA4772__44672.0881191597$1180539557$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
	<200705300024.32455.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705300024.32455.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> +Suspend notifiers
> +	(C) 2007 Rafael J. Wysocki <rjw@sisk.pl>, GPL
> +
> +There are some operations that device drivers may want to carry out in their
> +.suspend() routines, but shouldn't, because they can cause the hibernation or
> +suspend to fail. For example, a driver may want to allocate a substantial amount
> +of memory (like 50 MB) in .suspend(), but that shouldn't be done after the
> +swsusp's memory shrinker has run.
> +
> +Also, there may be some operations, that subsystems want to carry out before a
> +hibernation/suspend or after a restore/resume, requiring the system to be fully
> +functional, so the drivers' .suspend() and .resume() routines are not suitable
> +for this purpose.  For example, device drivers may want to upload firmware to
> +their devices after a restore from a hibernation image, but they cannot do it by
> +calling request_firmware() from their .resume() routines (user land processes
> +are frozen at this point).  The solution may be to load the firmware into
> +memory before processes are frozen and upload it from there in the .resume()
> +routine.  Of course, a hibernation notifier may be used for this purpose.
> +
> +The subsystems that have such needs can register suspend notifiers that will be
> +called upon the following events by the suspend core:
> +
> +PM_PRE_FREEZE		The system is going to hibernate or suspend, tasks will
> +			be frozen immediately

Hmm, looks like bad idea if we are going to remove freezer from
suspend...?

> +PM_POST_THAW		Tasks have just been thawed after a resume or restore
> +			from a hibernation image
> +
> +PM_HIBERNATION_PREPARE	The system is preparing for hibernation.  Tasks have
> +			been frozen, memory is going to be freed and devices
> +			are going to be suspended.

Is not PRE_FREEZE enough? We can allocate memory for drivers there,
too...

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
