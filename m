From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Fri, 21 May 2010 22:47:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005212226180.20028-100000__12286.4106474028$1274496527$gmane$org@netrider.rowland.org>
References: <1274482015-30899-2-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274482015-30899-2-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 May 2010, [UTF-8] Arve Hj=C3=B8nnev=C3=A5g wrote:

> The first goal can be achieved either by using device runtime PM and
> cpuidle to put all hardware into low-power states, transparently from
> the user space point of view, or by suspending the whole system.
> However, system suspend, in its current form, does not guarantee that
> the events of interest will always be responded to, since wakeup
> events (events that wake the CPU from idle and the system from
> suspend) that occur right after initiating suspend will not be
> processed until another possibly unrelated event wakes the system up
> again.

Minor point of clarification here.  I'm not requesting that the patch =

description be rewritten.  But this issue of lost wakeup events is more =

subtle than it appears.

Wakeup events can be lost in at least three different ways:

     1. A hardware signal (such as an IRQ) gets ignored.

     2. The hardware event occurs, but without effect since the
	kernel thread that would handle the event has been frozen.
	The event just ends up sitting in a queue somewhere until
	something else wakes up the system.

     3. The hardware event occurs and the kernel handles it fully,
	but the event propagates to userspace for further handling
	and the user program is already frozen.

1 is a hardware configuration failure (for example, it might happen as
a result of using edge-triggered IRQs instead of level-triggered) and
is outside the scope of this discussion.

2 generally represents a failure of the core PM subsystem, or a failure
of some other part of the kernel to use the PM core correctly.  In
theory we should be able to fix such mistakes.  Right now I'm aware of
at least one possible failure scenario that could be fixed fairly
easily.

3 is the type of failure that suspend blockers were really meant to
handle, particularly the userspace suspend-blocker API.

IMO, we should strive to fix the existing type-2 failure modes.  =

However it is worth pointing out that they are basically separate from =

the suspend-blocker mechanism.

And it might be a good idea to point out somewhere in the patch
descriptions that suspend blockers are really meant to handle type-3
wakeup losses.

Alan Stern
