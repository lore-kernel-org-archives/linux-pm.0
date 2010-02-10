From: Pavel Machek <pavel@ucw.cz>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 10 Feb 2010 09:13:54 +0100
Message-ID: <20100210081354.GA20950@atrey.karlin.mff.cuni.cz>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001272146.43660.rjw@sisk.pl> <20100131085210.GH2238@elf.ucw.cz>
	<201001311333.37620.rjw@sisk.pl>
	<20100201104922.GC5809@atrey.karlin.mff.cuni.cz>
	<76FA3B279DD9DA48896E2B404944957204F88D87@USA7061MS02.na.xerox.net>
	<20100201210921.GB13638@elf.ucw.cz> <4B67A663.6080008@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B67A663.6080008@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

> Hi.
> 
> Pavel Machek wrote:
> >> So you're asking to give this knob "one shot behavior" (i.e. "then
> >> next sleep won't sync")?
> > 
> > Yes.
> > 
> >> But I'm primarily interested in the behavior on embedded systems
> >> (where you control all the processes running -- there's no "user"
> >> involved.
> >> 
> > 
> > Well, then "one shot behaviour" does not hurt you, right?
> > 
> >> If a user starts messing with default settings, any unwanted
> >> behavior is the users problem (besides, this should only be
> >> writable as root).
> >> 
> > 
> > I'd rather not add traps for the user unless absolutely neccessary.
> > Not even for root user. Pavel
> 
> But that's precisely what you're doing. You're advocating making the
> behaviour inconsistent. If what you're suggesting is done, you won't be
> able to simply cat the sysfs entry to know whether sys_syncing is going
> to be done on the next cycle. You'll also have to have knowledge of
> whether a cycle has been done since the last time the value is set. The
> end result will be someone getting trapped and caught out because they
> think '1' in /sys/power/dont_sync (or whatever it's called) means what
> it says.

I'm simply advocating that setting from one suspend should not change
other suspends ... because you have multiple different programs
wanting to suspend the system, all independend. See the example about
system running low on battery earlier in the thread. 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
