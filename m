From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
 interrupt handlers
Date: Mon, 11 Oct 2010 13:00:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111254430.2339-100000__26972.2221456052$1286816503$gmane$org@netrider.rowland.org>
References: <201010091309.18552.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010091309.18552.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 9 Oct 2010, Rafael J. Wysocki wrote:

> I wonder if we can do the "fast suspend" and "fast resume" under the
> power.lock spinlock.  That would allow us to avoid some complications
> related to RPM_RESUMING and RPM_SUSPENDING.  Namely,
> if the device is flagged as "power.irq_safe", it will always suspend and
> resume "atomically" under its power.lock spinlock.  Then, the status will
> always be either RPM_ACTIVE or RPM_SUSPENDED (or RPM_ERROR,
> which is uninteresting).

We could do this.  It has some disadvantages but they aren't terrible.

>  Also, if "fast suspend" doesn't change the device
> parent's power.child_count, we won't need to worry about parents any more.

I don't know about that.  If the parent's child_count doesn't change 
then the parent can never suspend.  Of course, if there is no parent or 
the parent is disabled for runtime PM then this doesn't matter.

> I'm still not sure what to do with _idle() in that case.

Clearly we should not hold the spinlock while running the runtime_idle
callback.  That would make it impossible for the callback to ask for a
suspend.

Alan Stern
