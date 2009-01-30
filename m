From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Fri, 30 Jan 2009 09:54:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901300951190.2466-100000@iolanthe.rowland.org>
References: <333776.95358.qm@web36801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <333776.95358.qm@web36801.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Qarras <dqarras@yahoo.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Jan 2009, Daniel Qarras wrote:

> > The log doesn't indicate a real cause.  It does show
> > that wakeup was disabled on the EHCI controller, but nevertheless that
> > controller must have been responsible for waking up your system when the
> > mouse was plugged back in.  You can test this by unloading ehci-hcd
> > before suspending.
> 
> Correct, I tested suspend after removing the offending module and
> plugging the mouse does not wake the machine anymore! One thing is
> still different when comparing to Win XP (if I may): hitting mouse
> buttons will activate the internal led while in suspend even after
> removing the module but nothing done with the mouse wakes the
> machine.

This is probably because the mouse itself is enabled for wakeup even
though the host controller isn't.  In theory the mouse should turn its 
LED back off after a few tens of milliseconds; the fact that it doesn't 
means it is not fully compliant with the USB spec.

Alan Stern
