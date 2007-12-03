From: Jarek Poplawski <jarkao2@gmail.com>
Subject: Re: Need lockdep help
Date: Tue, 04 Dec 2007 00:25:50 +0100
Message-ID: <4754907E.9060203__28776.011724449$1196726097$gmane$org@gmail.com>
References: <20071203103630.GB2429@ff.dom.local>
	<Pine.LNX.4.44L0.0712031000480.3630-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712031000480.3630-100000@iolanthe.rowland.org>
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

Alan Stern wrote, On 12/03/2007 04:08 PM:

> On Mon, 3 Dec 2007, Jarek Poplawski wrote:
> 
>>> System sleep start:
>>> 		down_read(notifier-chain rwsem);
>>> 		call the notifier routine
>>> 			down_write(&system_sleep_in_progress_rwsem);
>>> 		up_read(notifier-chain rwsem);
>>>
>>> System sleep end:
>>> 		down_read(notifier-chain rwsem);
>>> 		call the notifier routine
>>> 			up_write(&system_sleep_in_progress_rwsem);
>>> 		up_read(notifier-chain rwsem);
>>>
>>> This creates a lockdep violation; each rwsem in turn is locked while 
>>> the other is being held.  However the only way this could lead to 
>>> deadlock would be if there was already a bug in the system Power 
>>> Management code (overlapping notifications).
>> Actually, IMHO, there is no reason for any lockdep violation:
>>
>> thread #1: has down_read(A); waits for #2 to down_write(B)
>> thread #2: has down_write(B); never waits for #1 to down_read(A)
>>
>> So, deadlock isn't possible here. If lockdep reports something else it
>> should be fixed (and you'd be right to omit lockdep until this is
>> done).
> 
> I think the reasoning goes the way Arjan described.  Suppose in between
> #1 and #2 there is thread #3 trying to do down_write(A) and waiting for
> #1.  Then thread #2 doesn't have to wait for #1 directly, but it would
> have to wait for #3.


As a matter of fact I completely missed Arjan's point because I thought
you described these locks according to lockdep's report, and there is
an information about read or write... Since, you still seem to guess
above about possible scenario, maybe it would be easier to show this
report (and maybe a piece of this code if possible)?

Btw., if it were like you're suggesting, it still shouldn't make any
difference: if thread #3 is only waiting for the lock taken for reading,
then I can't see why thread #2 has to wait for anything. Probably more
dangerous, at least for lockdep, could look taking down_write(A) by
thread #1 in between, but if it all were possible only within one
thread, then still there should be no reason to change good program
only to please lockdep.
 

> In my case the simplest answer appears to be the replace the rwsem
> with something slightly more complicated (a mutex plus a boolean flag 
> -- the loss of concurrency won't matter much since it isn't on a hot 
> path).

I'm not sure I can understand your plan, but I doubt there should be
such problems with taking rwsem for sleeping, so maybe it would be
better to figure out what really scares lockdep, to fix the right place?

Jarek P.
