From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Thu, 23 Sep 2010 17:05:03 -0700
Message-ID: <8762xwnh00.fsf__46425.5131468692$1285286758$gmane$org@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

Looking for advice for a little runtime PM dilemma...

After some inactivity, a driver decides to supend iteslf using
pm_runtime_put_sync().

The device is now suspended, it's ->runtime_suspend() method has
disabled its clock, so its registers cannot be accessed anymore.

Now, as interrupts are still enabled, an interrupt for this device might
still arrive.  For example, if this device is a wakeup source, its
->runtime_suspend() method may not have masked its interrupt.

So, the IRQ fires, and the drivers ISR is called.  The driver wants to
access the device registers, but since it has been runtime suspended,
it's registers are not available.

The first reflex would be to simply do a pm_runtime_get_sync() in the
ISR, however this is not safe if the ISR is an IRQs-disabled handler (as
is the case for me, where the problematic handler is chained handler
used for demuxing GPIO IRQs.)

So, what is the "right" thing to do here?

A quick hack would be to for the drivers ISR to do a
pm_runtime_get_noresume() and directly call the its ->runtime_resume()
method, then do its normal stuff, followed by a pm_runtime_put() at the
end of the ISR.

Is this an acceptable hack given that it's only needed for the
increasingly rare cases of ISRs with interrupts disabled?

Or should we think of making a version of _get_sync() that is safe for
IRQs disabled contexts like this where we know the device is already
RPM_SUSPENDED?

Any advice appreciated...

Kevin
