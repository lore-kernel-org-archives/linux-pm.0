From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Thu, 28 Oct 2010 11:22:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010281117530.1601-100000__20675.4156425179$1288279547$gmane$org@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1010271014280.1650-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010271014280.1650-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 27 Oct 2010, Alan Stern wrote:

> On Wed, 27 Oct 2010, Mathieu Desnoyers wrote:
> 
> > grep -r pm_runtime_get_noresume drivers/    hands out very interesting info.
> > 
> > e.g.:
> > 
> > drivers/usb/core/drivers.c: usb_autopm_get_interface_async()
> > 
> >         pm_runtime_get_noresume(&intf->dev);
> >         s = ACCESS_ONCE(intf->dev.power.runtime_status);
> >         if (s == RPM_SUSPENDING || s == RPM_SUSPENDED)
> >                 status = pm_request_resume(&intf->dev);
> > 
> > How is this supposed to work ?

> > If the ACCESS_ONCE can be reordered before the atomic_inc(), then I fear the
> > device can be suspended even after the check.
> 
> You are correct; the code as written may sometimes fail.  It was a
> hack from the beginning; the kind of test it performs should not be
> done outside the PM core.  However at the time it was the easiest way 
> to do what I wanted.

I forgot to mention one other thing...  The fact that this code will
sometimes behave unexpectedly isn't a bug.  That function is documented
as requiring additional locking when a driver uses it.  The need for
extra locking is unavoidable because I/O requests can arrive at any
time, even while a runtime suspend is in progress.

Therefore the fact that usb_autopm_get_interface_async() can race with 
a runtime suspend doesn't matter.  The driver making the call should 
have sufficient locking to know that the runtime suspend should fail 
because the driver is busy.

Alan Stern
