From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 14:18:57 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081416470.3560__4195.79891390658$1260310894$gmane$org@localhost.localdomain>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Dec 2009, Alan Stern wrote:
>
> And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> these routines were not intended to be called with interrupts disabled, 
> but that requirement doesn't seem to be documented.  And it isn't a 
> natural requirement anyway.

'complete()' is supposed to be callable from interrupts, but the waiting 
ones aren't. But 'complete()' is all you should need to call from 
interrupts, so that's fine.

So I think completions should work, if done right. That whole "make the 
parent wait for all the children to complete" is fine in that sense. And 
I'll happily take such an approach if my rwlock thing doesn't work.

		Linus
