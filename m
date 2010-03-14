From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM API issue
Date: Sun, 14 Mar 2010 20:41:10 +0100
Message-ID: <201003142041.10618.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003141500230.1752-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003141500230.1752-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 14 March 2010, Alan Stern wrote:
> Rafael:

Hi,

> I ran across this issue recently.  The best way I can see to fix it is
> to modify the runtime PM API slightly.
> 
> Drivers that handle high throughput may not want to incur the overhead
> of testing for idleness after every I/O operation; they may prefer to
> poll at regular intervals.  Currently this is awkward and inefficient
> to do.
> 
> First, recognize that idleness testing will often be needed in the 
> runtime_suspend method, not just in the runtime_idle method.  This is 
> for two reasons:
> 
>     (1) Suppose the driver determines the device isn't idle, so it 
> 	wants to schedule another poll in the future.  There is no
> 	pm_schedule_idle() routine, so it has to use 
> 	pm_schedule_suspend().  When the delay expires, the job of 
> 	determining whether the device is idle then has to fall on the 
> 	runtime_suspend method.
> 
>     (2) More importantly, an interrupt-driven driver will most likely
> 	want to avoid races by doing both the idleness test and the 
> 	actual suspend under a single spinlock_irq().  This can't be 
> 	done if the test is in a different method from the suspend.
> 
> Now here's the point.  Suppose the runtime_suspend method determines
> that the device isn't idle.  It needs to schedule another poll in the
> future.  But it can't!  pm_schedule_suspend() will fail if it is called
> while the runtime status is SUSPENDING.  Instead the suspend call has
> to be allowed to fail; then the PM core will call the runtime_idle
> method, which has to repeat the idleness test and call
> pm_schedule_suspend().  As I said before, this is inefficient.
> 
> It's also a little awkward, since it requires the driver to maintain
> some extra device status information -- otherwise the runtime_idle
> method doesn't know whether it's being called because a suspend attempt
> failed or for some more benign reason.
> 
> The best solution seems to be to allow pm_schedule_suspend() to succeed
> if the status is SUSPENDING.  In turn, __pm_runtime_suspend() should
> avoid calling pm_runtime_cancel_pending() if the suspend fails with
> -EAGAIN, and it should call pm_runtime_deactivate_timer() if the
> suspend succeeds.
> 
> What do you think?

I don't see any obvious drawbacks at this point.

Patch welcome. :-)

Rafael
