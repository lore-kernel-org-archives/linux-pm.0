From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 10 Feb 2010 12:58:54 -0800
Message-ID: <76FA3B279DD9DA48896E2B4049449572051378CE@USA7061MS02.na.xerox.net>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<4B67A663.6080008@crca.org.au>
	<20100210081354.GA20950@atrey.karlin.mff.cuni.cz>
	<201002101134.23851.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <201002101134.23851.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org



>   -----Original Message-----
>   From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>   Sent: Wednesday, February 10, 2010 5:34 AM
>   To: linux-pm@lists.linux-foundation.org
>   Cc: Pavel Machek; Nigel Cunningham; Leisner, Martin
>   Subject: Re: [linux-pm] syncing the disks when entering sleep
>   
>   On Wednesday 10 February 2010, Pavel Machek wrote:
>   > > Hi.
>   > >
>   > > Pavel Machek wrote:
>   > > >> So you're asking to give this knob "one shot behavior" (i.e.
>   "then
>   > > >> next sleep won't sync")?
>   > > >
>   > > > Yes.
>   > > >
>   > > >> But I'm primarily interested in the behavior on embedded systems
>   > > >> (where you control all the processes running -- there's no "user"
>   > > >> involved.
>   > > >>
>   > > >
>   > > > Well, then "one shot behaviour" does not hurt you, right?
>   > > >
>   > > >> If a user starts messing with default settings, any unwanted
>   > > >> behavior is the users problem (besides, this should only be
>   > > >> writable as root).
>   > > >>
>   > > >
>   > > > I'd rather not add traps for the user unless absolutely
>   neccessary.
>   > > > Not even for root user. Pavel
>   > >
>   > > But that's precisely what you're doing. You're advocating making the
>   > > behaviour inconsistent. If what you're suggesting is done, you won't
>   be
>   > > able to simply cat the sysfs entry to know whether sys_syncing is
>   going
>   > > to be done on the next cycle. You'll also have to have knowledge of
>   > > whether a cycle has been done since the last time the value is set.
>   The
>   > > end result will be someone getting trapped and caught out because
>   they
>   > > think '1' in /sys/power/dont_sync (or whatever it's called) means
>   what
>   > > it says.
>   >
>   > I'm simply advocating that setting from one suspend should not change
>   > other suspends ... because you have multiple different programs
>   > wanting to suspend the system, all independend.
>   
>   Which is wrong.  There should be one power manager everybody else calls
>   to
>   suspend the system.  Yes, even if the battery is running critical.
>   
>   And I guess on the embedded systems in question the situation is exactly
>   like
>   that.
>   
>   > See the example about system running low on battery earlier in the
>   thread.
>   
>   Which is irrelevant here.
>   
>   Actually, doing the sync() in the kernel is a hack that we decided not
>   to
>   remove just because the users space didin't do the right thing on some
>   systems.
>   If the user space always synced disks before suspending, we wouldn't
>   have to
>   do that in the kernel.
>   
>   Same goes for the kernel VT switch, BTW.
>   
>   So really, I don't see anything wrong with a knob that will turn the
>   kernel
>   sync off entirely, because that basically means "my user space is not
>   broken".
>   
>   Rafael

This is interesting.   When I saw the sync's I said to myself "WTF?"
It definitely should be a knob because it implements policy behavior -- 
which is often detrimental to power saving efforts.

marty
