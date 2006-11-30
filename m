From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
	freeze_processes SMP-safe
Date: Thu, 30 Nov 2006 23:57:35 +0100
Message-ID: <200611302357.36038.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0611301723590.2686-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0611301723590.2686-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 30 November 2006 23:34, Alan Stern wrote:
> On Thu, 30 Nov 2006, Rafael J. Wysocki wrote:
> 
> > > > On the other hand, a stopped process might be waiting for a signal that 
> > > > can be sent by an unfreezable process -- and the stopped process might be 
> > > > holding a lock which is needed by some other unfreezable process, so you 
> > > > need to allow it to run long enough to release the lock before freezing 
> > > > it.
> > > 
> > > Theoretically, yes.  But does it happen?  Moreover, even if it does, why can't
> > > we hold the unfreezeable process until the lock is released?
> > > 
> > > > Unless you can somehow rule out this scenario (unfreezable process waiting 
> > > > for resource held by unfrozen but stopped and freezable process), I don't 
> > > > see how this approach can be made to work.
> > 
> > Hm, in fact I think that if it happens, then this is a bug.
> > 
> > Namely, the freezeable task can only acquire the lock when it's running.  Thus
> > it would have to acquire the lock before it's stopped.  Consequently, it could
> > be preempted and subsequently frozen after it has acquired the lock and
> > _before_ it's stopped.
> > 
> > Now from the unfreezeable task's point of view it doesn't matter if the
> > freezeable task acquired the lock and has been frozen before being stopped
> > or if it acquired the lock and was stopped and then has been woken up and
> > frozen, since in both cases the final outcome is the same: the freezeable task
> > is frozen and holds the lock, so the unfreezeable task cannot continue
> > running.
> > 
> > Thus I think the question is if _any_ freezeable task, be it stopped or not,
> > can hold a lock that's needed by an unfreezeable task, and I think the answer
> > is, generally, 'no, it can't', because otherwise it might block the
> > unfreezeable task (if it's frozen while holding the lock).
> 
> Well, certainly the answer is "It shouldn't".  :-)
> 
> I don't know any examples where an unfreezable task waits for a resource 
> which might be held by a frozen task, PROVIDED that tasks don't get frozen 
> at a bad spot.
> 
> Here's what I mean.  usb-storage's kernel thread is unfreezable, because
> it might be needed for reading or writing a memory image to a swap region.  
> If there's an I/O error then usb-storage will try to issue a USB port
> reset, for which it needs to acquire the USB device's lock.
> 
> Now various other tasks may acquire that lock, and they may even stop
> while holding it.  However they should never get frozen while holding the
> lock -- which means they shouldn't get frozen at arbitrary times merely
> because they are stopped.  They are careful to call try_to_freeze() only
> at times when they don't hold any locks.

This means they are kernel threads, so they won't be entering
get_signal_to_deliver(), will they?

If they don't enter get_signal_to_deliver(), they can only be frozen where
they explicitly call try_to_freeze().

Greetings,
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
