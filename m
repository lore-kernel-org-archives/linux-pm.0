From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 13:47:25 +0200
Message-ID: <201008041347.25595.rjw__31439.4141002142$1280922619$gmane$org@sisk.pl>
References: <20100801210548.23f77ff6@infradead.org>
	<AANLkTikyD94wqWZTWA23K=zvN3RpKB6dDRrvFSv9szMg@mail.gmail.com>
	<alpine.DEB.2.00.1008040027140.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008040027140.25170@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 04, 2010, david@lang.hm wrote:
> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
> 
> > 2010/8/3  <david@lang.hm>:
> >> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
> >>
> >>> 2010/8/3  <david@lang.hm>:
> >>>>
> >>>> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
...
> >>>>> The hardware specific idle hook can (and does) decide to go into any
> >>>>> power state from idle that does not disrupt any active devices.
> >>>>
> >>>> This I know is an Andoid specific thing. On other platforms power states
> >>>> very definantly can make user visible changes.

It would be much better if you gave specific examples.  Because, for instance,
I'm not sure what platforms you have in mind.

> >>> How is this Android specific?
> >>
> >> you are stating that this must be suspend because low-power idle must be
> >> transparent to the user.
> >
> > It must be transparent to the rest of the system.
> >
> >>
> >> I am saying that on Linux, low-power idle commonly is not transparent to the
> >> user, so the requirement for it to be transparent (therefor putting the
> >> suspend into a different category) is an Android only requirement.
> >>
> >
> > I'm am not talking about minor latencies. If you have a platform that
> > for instance turns off you screen dma when entering idle, it is broken
> > whether is running Android or not. If it does the same in suspend it
> > is not a problem.
> 
> This isn't sounding quite right to me. I've seen too many discussions 
> about things like idle and USB devices/hubs/drives/etc getting powered 
> down for power savings modes to make me readily accept that everything 
> must be as transparent as you imply. Just the case of drive spin-down 
> shows that it's possible to do things that would be considered 
> destructive, but you have to have a flag and wake-up path to recover 
> within a 'reasonable' amount of time (I guess that this could be 
> 'transparent' if that only implies that things must work eventually, which 
> isn't what I read into the statement)

Well, consider a single character device and suppose there is an application
talking to the driver using read(), write(), ioctl(), whatever.  Now suppose
you want to put the device into a low-power state such that the device can't
do the I/O in that state.  You need to ensure that the app won't be able to
reach the device while in that state and you can (1) arrange things so that
the device is put into the full-power state whenever the app tries to access
it and (2) "freeze" the app so that it won't try to access the device being in
the low-power state.

Generally speaking (1) is what idle (and any other form of runtime PM) does and
(2) is what suspend does with respect to the whole system.

In the suspend case, when you have frozen all applications, you can
sequentially disable all interrupts except for a few selected ("wakeup") ones
in a safe way.   By disabling them, you ensure that the CPU will only be
"revived" by a limited set of events and that allows the system to stay
low-power for extended time intervals.

To achieve the same result in the "idle" case, you'll need to have a mechanism
to disable interrupts (except for the "wakeup" ones) avoiding synchronization
problems (eg. situations in which task A, blocked on a "suspended" device
access, holds a mutex waited for by task B that needs to run so that we can
"suspend" another device).  That, however, is a difficult problem.

Thanks,
Rafael
