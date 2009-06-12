From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 17:23:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906121706180.5018-100000__23977.8199386366$1244841966$gmane$org@iolanthe.rowland.org>
References: <200906122156.14873.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906122156.14873.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:

> On Friday 12 June 2009, Alan Stern wrote:
> > On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:
> > 
> > > So, are you suggesting that the core should only check the "all children
> > > suspended" condition if special flag is set in dev_pm_info?
> > 
> > Or rather, check it only if the special flag _isn't_ set.
> 
> Where the default is unset, I guess?

Yep.

> But then, what about the resuming of the parents before the device is resumed?
> Should the parents be resumed regardless of the flag state?

Yes.  In general you should assume a device's parent (and the device
itself!) needs to be resumed whenever the kernel wants to do something
with the device.  The special flag arises because sometimes it's safe
to suspend the parent without suspending the device _if_ the kernel
isn't using the device.

Imagine an idle disk at the end of a link.  We might want to 
autosuspend the link without spinning down the disk.  When we have to 
communicate with the disk again, we autoresume the link.  (Including 
the case where the communication is a "spin-down" command.)

>  And if so, what's
> the condition for breaking the recurrence?  Surely it's not sufficient to check
> if the parent is active, because its parent need not be active if it has this
> special flag set.

That's a good question.  Let's assume that situations like this will be 
handled by the drivers.

For example, suppose A is the parent of B is the parent of C, and A is
suspended but B isn't and C is.  What happens when somebody wants to
use C?

An autoresume request is generated for C.  Since C's parent is already
resumed, the runtime_resume method in C's driver is called.  The driver
has to do some I/O in order to resume C, so it passes an I/O request up
to B's driver.  The request then gets passed up to A's driver.  This
driver knows that A is suspended, so it starts an autoresume of A and
waits for the autoresume to complete before carrying out the request.

Then the I/O can go through, so C gets resumed and everything works 
out.

I don't know how often this sort of pattern will arise.  It certainly
could be used in usb-storage; there would be no difficulty starting an
autoresume when an I/O request arrives from the SCSI layer below.  In
fact, that is exactly how some early runtime-PM patches for usb-storage
worked.

Alan Stern
