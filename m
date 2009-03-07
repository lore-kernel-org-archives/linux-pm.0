From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Sat, 7 Mar 2009 11:51:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0903071143340.5732-100000__8187.34661811522$1236444906$gmane$org@netrider.rowland.org>
References: <200903071120.53901.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903071120.53901.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Arve@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Mar 2009, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce two helper functions allowing us to prevent device drivers
> from getting any interrupts (without disabling interrupts on the CPU)
> during suspend (or hibernation) and to make them start to receive
> interrupts again during the subsequent resume, respectively.  These
> functions make it possible to keep timer interrupts enabled while the
> "late" suspend and "early" resume callbacks provided by device
> drivers are being executed.
> 
> Use these functions to rework the handling of interrupts during
> suspend (hibernation) and resume.  Namely, interrupts will only be
> disabled on the CPU right before suspending sysdevs, while device
> drivers will be prevented from receiving interrupts, with the help of
> the new helper function, before their "late" suspend callbacks run
> (and analogously during resume).
> 
> In addition, since the device interrups are now disabled before the
> CPU has turned all interrupts off and the CPU will ACK the interrupts
> setting the IRQ_PENDING bit for them, check in sysdev_suspend() if
> any wake-up interrupts are pending and abort suspend if that's the
> case.

One thing about this isn't clear: the distinction between "wake-up" 
interrupts and other interrupts.

In an ideal world, the only pending interrupts during sysdev_suspend
would be wake-up interrupts, because drivers would have prevented their
devices from generating any other kind of IRQ and would have done all
the necessary synchronization as part of their suspend (_not_
suspend_late) methods.  Thus there would be no need to distinguish
between wake-up and non-wake-up interrupts.

So perhaps you're worried about drivers that aren't sufficiently
clever.  Or is something deeper going on?

Alan Stern
