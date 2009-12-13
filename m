From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sun, 13 Dec 2009 14:02:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912131349400.2857-100000__27684.9616472193$1260731001$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0912131221210.1111-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912131221210.1111-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 13 Dec 2009, Alan Stern wrote:

> > Namely that there's no apparent sane way to say "don't wait for children".
> > 
> > PCI bridges that don't suspend at all - or any other device that only 
> > suspends in the 'suspend_late()' thing, for that matter - don't have any 
> > reason what-so-ever to wait for children, since they aren't actually 
> > suspending in the first place. But you make them wait regardless, which 
> > then serializes things unnecessarily (for example, two unrelated USB 
> > controllers).

> In short, allowing devices to suspend before their children would be 
> dangerous and probably would not save a significant amount of time.

There's more to be said.  Even without this "don't wait for children"  
thing, there can be bad interactions causing unnecessary delays.  For
example, suppose A (async) is the parent of B (sync), B comes before C
(sync) in dpm_list, and C is the parent of D (async).  Even if A & B
are unrelated to C & D, they will be forced to wait for them.  It 
doesn't matter that A and D are unrelated and so could suspend 
concurrently.

In essence, every synchonrous device is treated as though it depends on 
all the synchronous devices preceding it in dpm_list.  That's a lot of 
unnecessary constraints.  At the moment we have no choice, because we 
have to assume that some of those constraints actually are necessary -- 
and we don't know which ones.

It's an inescapable fact: If there are unnecessary ordering constraints
then you generally can't be 100% efficient in carrying out parallel
operations.  Compared with all these extra "synchronous" constraints,
the relatively small number of "don't need to wait for children"  
constraints is harmless.  I bet that if we got rid of all unnecessary
constraints except for making parents always wait for their children,
we'd attain more than 95% of the ideal speedup.

Alan Stern
