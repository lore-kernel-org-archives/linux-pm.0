From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
	interrupt handlers
Date: Thu, 07 Oct 2010 09:52:18 -0700
Message-ID: <87aamqaqt9.fsf__49381.3999034048$1286470654$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1010071048100.1753-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010071048100.1753-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 7 Oct 2010 11:26:55 -0400 (EDT)")
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 6 Oct 2010, Rafael J. Wysocki wrote:
>
>> Defer the resume.  That's the only thing you can do in any case, whether you're
>> going to busy loop or just use a workqueue.
>
> They are not the same.  With a busy-wait you handle the device as soon
> as possible, before the interrupt routine returns.  With a workqueue
> you have to mask the entire IRQ line, possibly losing interrupt
> requests from other devices, until the workqueue routine can run.
>
>> > On the whole, I don't see any striking reason for the PM core not to 
>> > busy-wait during a concurrent state change.
>> 
>> I do.  That shouldn't happen in a fast path and we're talking about one,
>> aren't we?  Besides, I don't like busy waiting as a rule.
>
> On Wed, 6 Oct 2010, Kevin Hilman wrote:
>
>> Not sure I follow where you're going with this last paragraph.  Of
>> course, calls from ISR context cannot busy wait.
>
> What do you guys think spin_lock() does?  It busy-waits until the lock 
> is free!  If you don't like busy-waiting then you don't like spinlocks, 
> and if you believe ISR's can't busy-wait then you believe they can't 
> acquire spinlocks.  :-)

My confusion is not about the use of spinlocks, it's a question of what
is being busy-waited for, and the thread that is being waited for is
going to complete when interrupts are disabled.

Sorry to be dense, but can you (re)summarize what you're proposing as I
think I'm getting mixed up with all the various options we've been
tossing around.

If it can work, I'm certainly in favor of a busy-wait approach as it 
really ensures that sync requests are handled quickly.

Kevin
