From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
	freeze_processes SMP-safe
Date: Sun, 3 Dec 2006 12:17:46 +0100
Message-ID: <200612031217.47361.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0612021037360.10026-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0612021037360.10026-100000@netrider.rowland.org>
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

On Saturday, 2 December 2006 16:39, Alan Stern wrote:
> On Sat, 2 Dec 2006, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > We send fake signals to them, so they enter get_signal_to_deliver() and they
> > > > call try_to_freeze() from there.
> > > 
> > > Well then, see, you're doing exactly what you said should never happen --
> > > you are freezing a user thread while it might be holding a lock that the
> > > unfreezable usb-storage thread needs.
> > 
> > 
> > I do not think it is okay to call get_signal_to_deliver with *any*
> > lock held... Or do you have example when that is broken?
> 
> Is get_signal_to_deliver() ever called at any time other than when the CPU 
> is about to switch back into user mode?

No, I don't think so.  There's a check in do_signal() that only allows it to
call get_signal_to_deliver() in user mode.

> If not then there shouldn't be any problem.  The routines I was talking
> about earlier hold the USB device locks while running in kernel mode, but
> they release them before returning to user mode.

Then everything is correct, I think.

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
