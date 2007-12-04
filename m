From: Jarek Poplawski <jarkao2@gmail.com>
Subject: Re: Need lockdep help
Date: Tue, 04 Dec 2007 21:14:00 +0100
Message-ID: <4755B508.9020806__4218.3663732887$1196799545$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0712041424270.13516-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712041424270.13516-100000@iolanthe.rowland.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Kernel development list <linux-kernel@vger.kernel.org>, Jarek Poplawski <jarkao2@o2.pl>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote, On 12/04/2007 08:28 PM:

> On Tue, 4 Dec 2007, Jarek Poplawski wrote:

...

> But you have to consider hypothetical kernel bugs.  That's exactly what 
> lockdep is for -- to warn you about possible deadlocks that could be 
> caused by bugs.
> 
> As a simple example, if thread #1 does "lock(A); lock(B)" and thread 
> #2 does "lock(B); lock(A)" then there's a possible bug.  Lockdep should 
> warn about you, and it does -- even if those two threads can never run 
> at the same time.
> 
> If lockdep warned about deadlocks only when they actually happened, it 
> wouldn't be nearly so useful.


Sure! I probably missed your point... Lockdep always names reported locks,
so I meant 'hypothetical' only trying to explain lockdep with some other,
unknown or unnamed bugs.

So, depending on the code, above example with A & B could be a real bug
(even if very improbable but logically justified) or a false alarm (eg.
when we know both threads could never work at the same).

Jarek P.
