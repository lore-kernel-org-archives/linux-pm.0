From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
 for device PM.
Date: Wed, 27 Apr 2011 00:06:53 +0200
Message-ID: <20110426220653.GA29092__43493.0110037842$1303861497$gmane$org@elf.ucw.cz>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<201104262249.22564.rjw@sisk.pl>
	<20110426211159.GB28033@elf.ucw.cz>
	<201104262336.56347.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104262336.56347.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, MyungJoo Ham <myungjoo.ham@samsung.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > It certainly looks a lot like s2ram to the user.
> > 
> > Now, your PC wakes up periodically in s2ram, too; but it is keyboard
> > controller that wakes up, not CPU, so you do not know.
> 
> I seriously doubt it's a keyboard controller in contemporary machines.

> Yes, there are parts of them that don't actually sleep, but that's not
> under OS control.

Ok, so it is called "embedded controller" these days. But you got the
idea.

> > On Zaurus, you do not know, either; nothing visible happens and
> > userspace is shielded from these details.
> 
> If you wake up device drivers, it _is_ visible.  Maybe not to user
> space, but that's a semantic difference.

Just to clarify; not _all_ device drivers need to be woken up. Just
SPI + charger code is enough... and I guess it would be prefered
because spinning up disk just to toggle charger would be nasty.

> > Should user really have to know if battery charger is implemented on
> > keyboard controller or on main cpu before he selects which interface
> > to use?
> 
> Please don't confuse user space with the user.  You can resume all the
> way to user space without turning the backlight on and the user will not
> notice, right?

The user has to type "echo mem > /sys/power/state" :-). And you better
turn him the backlight on, typing blind is bad.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
