From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 10:32:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010271014280.1650-100000__8035.06494635275$1288190062$gmane$org@iolanthe.rowland.org>
References: <20101027122115.GA10722@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101027122115.GA10722@Krystal>
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

[CC: list trimmed drastically, on the assumption that most of the 
people on it aren't very interested in the details of the PM runtime 
memory barriers.]

On Wed, 27 Oct 2010, Mathieu Desnoyers wrote:

> grep -r pm_runtime_get_noresume drivers/    hands out very interesting info.
> 
> e.g.:
> 
> drivers/usb/core/drivers.c: usb_autopm_get_interface_async()
> 
>         pm_runtime_get_noresume(&intf->dev);
>         s = ACCESS_ONCE(intf->dev.power.runtime_status);
>         if (s == RPM_SUSPENDING || s == RPM_SUSPENDED)
>                 status = pm_request_resume(&intf->dev);
> 
> How is this supposed to work ?

It's worth pointing out that this code is going to be removed during
the 2.6.38 development cycle, due to ongoing changes in the runtime PM
core.  It would have been removed already if not for the difficulty of
coordinating cross-subsystem changes.

But it's legitimate to ask how the code _was_ supposed to work...

> If the ACCESS_ONCE can be reordered before the atomic_inc(), then I fear the
> device can be suspended even after the check.

You are correct; the code as written may sometimes fail.  It was a
hack from the beginning; the kind of test it performs should not be
done outside the PM core.  However at the time it was the easiest way 
to do what I wanted.

> My point is that a get/put semantic should imply memory barriers, especially if
> these are exported APIs.

As far as I am aware, apart from the hack above,
pm_runtime_get_noresume is called only in places where either:

	it is purely advisory (e.g., we know that we will use the
	device in the near future so we would prefer to prevent it from
	being suspended, but we don't really care because we're going
	to call pm_runtime_resume_sync before using it anyway);

	or we already know that the usage_count is > 0.

No memory barrier is required for either of these cases.

Alan Stern
