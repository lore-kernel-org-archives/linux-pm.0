From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Need lockdep help
Date: Tue, 4 Dec 2007 14:28:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712041424270.13516-100000__44987.3866317377$1196796581$gmane$org@iolanthe.rowland.org>
References: <4755A457.5080405@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4755A457.5080405@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jarek Poplawski <jarkao2@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Kernel development list <linux-kernel@vger.kernel.org>, Jarek Poplawski <jarkao2@o2.pl>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Dec 2007, Jarek Poplawski wrote:

> Alan Stern wrote, On 12/04/2007 04:17 PM:
> ...
> 
> > Furthermore, in this case deadlock isn't really impossible -- it could 
> > occur if there were a bug somewhere else in the kernel.  So lockdep was 
> > correct to warn that deadlock might occur.
> 
> 
> Alan, if the scenario was like you described at the beginning, there was
> no deadlock possible, unless some errors in the notifier.

Or errors in the notifier's caller.

> These #1-#3
> threads were only helpful to guess what lockdep could 'think', but I
> guess notifier doesn't use 2 rivaling threads for a wake, so, lockdep
> probably needed additional information. And you really can't consider
> any hypothetical kernel bugs here because then each lock is vulnerable.

But you have to consider hypothetical kernel bugs.  That's exactly what 
lockdep is for -- to warn you about possible deadlocks that could be 
caused by bugs.

As a simple example, if thread #1 does "lock(A); lock(B)" and thread 
#2 does "lock(B); lock(A)" then there's a possible bug.  Lockdep should 
warn about you, and it does -- even if those two threads can never run 
at the same time.

If lockdep warned about deadlocks only when they actually happened, it 
wouldn't be nearly so useful.

Alan Stern
