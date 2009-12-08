From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: spinlock in completion_done() (was: Re: Async resume
	patch (was: Re: [GIT PULL] PM updates for 2.6.33))
Date: Tue, 8 Dec 2009 22:48:14 +0100
Message-ID: <200912082248.14138.rjw__17720.3492414721$1260309056$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 December 2009, Alan Stern wrote:
> On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> 
> > BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
> > and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
> > here?
> 
> And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> these routines were not intended to be called with interrupts disabled, 
> but that requirement doesn't seem to be documented.  And it isn't a 
> natural requirement anyway.

OK, let's ask Ingo about that.

Ingo, is there any particular reason why completion_done() and
try_wait_for_completion() don't use spin_lock_irqsave() and
spin_unlock_irqrestore()?

Rafael
