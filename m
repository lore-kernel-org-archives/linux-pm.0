From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Wed, 14 May 2008 16:56:19 +0200
Message-ID: <20080514145619.GB6615__1461.55202896825$1210777241$gmane$org@ucw.cz>
References: <200804291638.30469.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0804300950460.2432-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0804300950460.2432-100000@iolanthe.rowland.org>
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
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Indeed, it's easy to imagine a situation where somebody suspends their 
> > > laptop and then unplugs a USB mouse, thereby causing a wakeup event.
> > 
> > It's also easy to imagine getting used to unplugging
> > such devices *first* ... :)
> 
> Maybe.  But people aren't likely to unplug the mouse first if
> suspending the laptop is done by clicking on a "Suspend" button.  :-)
> 
> Or consider the case of a flash drive with a mounted filesystem.  You 
> can't safely unplug it before suspending, but you can safely unplug it 
> after suspending (provided you remember to plug it back in before 
> resuming).
> 
> Besides, people will complain that the [insert your choice] operating 
> system doesn't make them remember to unplug USB devices before 
> suspending, so why should Linux?

Besides, its a regression.

So we really should just default to the current behaviour on ACPI
systems: lid and power button wake up the system, other devices don't.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
