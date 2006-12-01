From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
	freeze_processes SMP-safe
Date: Fri, 1 Dec 2006 22:19:43 +0100
Message-ID: <200612012219.44076.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0612011615150.2629-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0612011615150.2629-100000@iolanthe.rowland.org>
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
To: suspend-devel@lists.sourceforge.net
Cc: pm list <linux-pm@lists.osdl.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 1 December 2006 22:17, Alan Stern wrote:
> On Fri, 1 Dec 2006, Rafael J. Wysocki wrote:
> 
> > On Friday, 1 December 2006 15:56, Alan Stern wrote:
> > > On Thu, 30 Nov 2006, Rafael J. Wysocki wrote:
> > > 
> > > > > Here's what I mean.  usb-storage's kernel thread is unfreezable, because
> > > > > it might be needed for reading or writing a memory image to a swap region.  
> > > > > If there's an I/O error then usb-storage will try to issue a USB port
> > > > > reset, for which it needs to acquire the USB device's lock.
> > > > > 
> > > > > Now various other tasks may acquire that lock, and they may even stop
> > > > > while holding it.  However they should never get frozen while holding the
> > > > > lock -- which means they shouldn't get frozen at arbitrary times merely
> > > > > because they are stopped.  They are careful to call try_to_freeze() only
> > > > > at times when they don't hold any locks.
> > > > 
> > > > This means they are kernel threads, so they won't be entering
> > > > get_signal_to_deliver(), will they?
> > > 
> > > Some of them are kernel threads and some of them are user threads.  Only 
> > > the kernel threads call try_to_freeze().
> > > 
> > > > If they don't enter get_signal_to_deliver(), they can only be frozen where
> > > > they explicitly call try_to_freeze().
> > > 
> > > What about the user threads?
> > 
> > We send fake signals to them, so they enter get_signal_to_deliver() and they
> > call try_to_freeze() from there.
> 
> Well then, see, you're doing exactly what you said should never happen --
> you are freezing a user thread while it might be holding a lock that the
> unfreezable usb-storage thread needs.

Well, the current code does exactly the same - it freezes userland tasks
by sending them fake signals (and there's no way to check if such a process
holds any locks at that time).  Moreover, it's been doing that from day one
and my patch doesn't change that.

If you have an unfreezeable process that depends on locks that may be held
by userland tasks, then _this_ is a bug, IMHO.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
