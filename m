From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Fri, 7 Dec 2007 14:33:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712071414210.27132-100000@netrider.rowland.org>
References: <20071207180112.8C68B1E3692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071207180112.8C68B1E3692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Dec 2007, David Brownell wrote:

> > What about ordering constraints?  A lot of them aren't explicit.  We 
> > just depend on the fact that devices get suspended in reverse order of 
> > registration.  You can't do that in parallel.
> 
> Those constraints should *become* explicit ... not stay implicit!

Why do I get the feeling we've gone through this before?  :-)

> FWIW the appended patch removes that rude "order of registration"

"Rude"?  What's rude about it?  It seems most logical to me: Since the
devices obviously worked in the intermediate stages of registration,
when the early-to-register devices were available and the
late-to-register devices weren't, duplicating those same intermediate
stages (with the same sets of devices available) should also work
during suspend.

> policy, so that the suspend/resume list matches the device tree.

In what respect doesn't it match the device tree now?

As far as I know, the only way in which the list wouldn't match the
tree is when the tree gets reorganized by device_move(), which doesn't
change the list at all.  (This is quite possibly a bug.)  Your patch 
doesn't affect that.

> It's behaved OK on PCs and, in light duty, a few development boards;
> I've carried it around most of this year.

I predict it will cause failure of the USB-Persist mechanism when a 
non-high-speed device is plugged into a dual high/full-speed port.  
This is because when an EHCI root hub is resumed after a loss of power, 
the driver looks for ports that had been owned by the companion 
controllers and tries to hand them over again -- but if the companion 
controllers haven't been resumed yet the handover won't work.

However to be fair, about the best one can say for the current way this 
situation is handled is that it works more or less by coincidence (EHCI 
controllers are required by the spec to have higher function numbers 
than their companion controllers on a PCI board, and PCI devices are 
enumerated in increasing order by function number).  I have to agree 
that this ordering dependency really should be made explicit.

> I'd expect this to eventually turn up some cases where Linux is
> right now doing a bad job of exposing devices with multiple such
> ordering constraint ... power management via I2C seems likely to
> turn up a few of them.  We'd need some automatic way to detect
> and report such problems so that they could be fixed.

If you really want to sniff out dependencies, you should add each new
device to the list at a _random_ position, subject only to the
constraint that it must not precede its parent!

Alan Stern
