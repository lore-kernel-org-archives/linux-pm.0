From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Tue, 5 Jun 2007 22:26:29 +0200
Message-ID: <20070605202629.GC4424__33552.0689994611$1181075284$gmane$org@elf.ucw.cz>
References: <20070604110052.GI4363@elf.ucw.cz>
	<Pine.LNX.4.44L0.0706051420351.2606-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0706051420351.2606-100000@iolanthe.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > With the USB subsystem I have followed the approach taken by the PM
> > > core, which is that tasks are frozen.  But one can -- and Linus has on
> > > at least one occasion -- make a good case that tasks should be left
> > > running while only I/O is frozen.  This would require the subsystem to
> > > distinguish between a selective device suspend and a system-wide
> > > suspend-to-RAM, so that selective resume could be enabled on demand in
> > > one case but not the other.
> > > 
> > > It's quite doable in principle -- it's just not the technique I used.
> > 
> > I guess we need to do that. Random user should not be able to prevent
> > machine from sleeping.
> 
> Just to be clear about this, let's agree that we're talking about 
> suspend-to-RAM here, not hibernation.

Yes.

> It boils down to whether we want to freeze user tasks.  As I recall,
> Linus said that he didn't have any big objection to freezing user
> threads; he was much more concerned about freezing kernel threads.  
> Thanks to Raphael's new notifier chains this will no longer be an
> issue, since kernel threads will be able to stop themselves when they
> receive a suspend notification.
...
> The alternative is to have drivers take over the burden.  I don't like
> this at all.  The most obvious disadvantage is that the necessary
> checks would have to be duplicated many many times and spread out over
> lots of drivers.

I like freezer better :-).

> It's also harder to handle these things at the driver level.  Suppose a
> driver gets an I/O request while a suspend is underway.  What should it
> do?  Return an error?  Block until the suspend is over?  Both
> approaches have their difficulties:
> 
> Returning an error would mean that suspend is no longer transparent.  
> Even an error like -EAGAIN.

No, -EAGAIN is not nice.

> Waiting until the suspend is over is likely to be impractical.  At a 
> minimum it would involve adding code to drop a lock or mutex, enter the 
> freezer (or its equivalent), and then restart the I/O operation.  And 
> then, what if the driver was invoked with O_NONBLOCK?

Blocking would be possible option. I agree it is tricky to
implement... it may also be useful for a harddrive:

"I'm riding a horse at 40kph now, so you'll kill the harddrive if you
access it; just freeze everyone until we are at the other end of
meadow".

...hmm, but this seems to be blockdevice specific, and I can't think
of a network or char driver where similar behaviour would be useful.

> I think it is much better overall to stop I/O requests from being
> generated at the source, either by freezing userspace or preventing it
> from making system calls.  It's hard to imagine that anybody would
> miss the small amount of CPU time they'd be giving up by not allowing
> user threads to run during the time that a suspend is underway!

Agreed.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
