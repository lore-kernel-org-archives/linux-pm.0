From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 6 May 2010 15:40:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005061535540.1708-100000__18673.2333539569$1273175051$gmane$org@iolanthe.rowland.org>
References: <201005062128.31068.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005062128.31068.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 May 2010, Rafael J. Wysocki wrote:

> > Here's a completely new issue.  When using opportunistic suspends on an
> > SMP system, it could happen that the system gets a wakeup event and
> > this routine starts running again before the event's IRQ handler has
> > finished (or has enabled a suspend blocker).  The system would 
> > re-suspend too soon.
> 
> This routine will be run from a freezable workqueue.

But how do you know that processes won't get unfrozen until all the 
pending IRQs have been handled?  Imagine something like this:

	CPU 0			CPU 1
	-----			-----
	Wake up non-boot CPUs
	Resume devices		Invoke the IRQ handler

	[ CPU 0 should wait here for the handler to finish, 
	  but it doesn't ]

	Defrost threads		Handler running...
	Workqueue routine runs
	Start another suspend
				Handler enables a suspend blocker,
				but it's too late

Alan Stern
