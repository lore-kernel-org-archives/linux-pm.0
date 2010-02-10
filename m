From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 10 Feb 2010 20:19:26 +0100
Message-ID: <201002102019.26518.rjw@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201002101134.23851.rjw@sisk.pl>
	<20100210133118.GA31861@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100210133118.GA31861@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 February 2010, Pavel Machek wrote:
> > On Wednesday 10 February 2010, Pavel Machek wrote:
> > > > Hi.
> > > > 
> > > > Pavel Machek wrote:
> > > > >> So you're asking to give this knob "one shot behavior" (i.e. "then
> > > > >> next sleep won't sync")?
> > > > > 
> > > > > Yes.
> > > > > 
> > > > >> But I'm primarily interested in the behavior on embedded systems
> > > > >> (where you control all the processes running -- there's no "user"
> > > > >> involved.
> > > > >> 
> > > > > 
> > > > > Well, then "one shot behaviour" does not hurt you, right?
> > > > > 
> > > > >> If a user starts messing with default settings, any unwanted
> > > > >> behavior is the users problem (besides, this should only be
> > > > >> writable as root).
> > > > >> 
> > > > > 
> > > > > I'd rather not add traps for the user unless absolutely neccessary.
> > > > > Not even for root user. Pavel
> > > > 
> > > > But that's precisely what you're doing. You're advocating making the
> > > > behaviour inconsistent. If what you're suggesting is done, you won't be
> > > > able to simply cat the sysfs entry to know whether sys_syncing is going
> > > > to be done on the next cycle. You'll also have to have knowledge of
> > > > whether a cycle has been done since the last time the value is set. The
> > > > end result will be someone getting trapped and caught out because they
> > > > think '1' in /sys/power/dont_sync (or whatever it's called) means what
> > > > it says.
> > > 
> > > I'm simply advocating that setting from one suspend should not change
> > > other suspends ... because you have multiple different programs
> > > wanting to suspend the system, all independend.
> > 
> > Which is wrong.  There should be one power manager everybody else calls to
> > suspend the system.  Yes, even if the battery is running critical.
> 
> Really? If so then it is misdesigned.
> 
> Before the "don't sync" proposal, it was okay to have multiple
> power managers.
> 
> Actually I have three on zaurus. There's in-kernel suspend on battery
> critical, then there's somehing userspace in desktop environment, and
> then I'm triggering suspends by hand using echo.

To be precise, 1 and 3 are things that override the power manager.

And if you override the power manager, you're supposed to know what you're
doing, aren't you?

> > So really, I don't see anything wrong with a knob that will turn the kernel
> > sync off entirely, because that basically means "my user space is
> > not broken".
> 
> Because, very easily, parts of my users space may be broken.

How exactly would they be broken?

Why do you want to protect the users from themselves for what it's worth?

Why don't we just assume that the user who sets the knob knows what he's doing?

Rafael
