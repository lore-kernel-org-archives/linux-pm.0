From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Fri, 11 Dec 2009 19:38:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912111928130.32493-100000__19524.0045701668$1260578508$gmane$org@netrider.rowland.org>
References: <200912112317.31668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912112317.31668.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Dec 2009, Rafael J. Wysocki wrote:

> > > .. and I've told you several times that we should simply not do such 
> > > devices asynchronously. At least not unless there is some _overriding_ 
> > > reason to. And so far, nobody has suggested anything even remotely 
> > > likely for that.
> > 
> > Agreed.  The fact that async non-tree suspend constraints are difficult 
> > with rwsems isn't a drawback if nobody needs to use them.
> 
> Well, see my reply to Linus.  The only thing that bothers me is that if we use
> rwsems, there's no way to handle that even if it turns out that someone
> needs them after all.

This is now a totally moot point, but I want to make it anyway just to
show how perverse life can be.  It turns out that by combining some of
the worst parts of the rwsem approach and the completion approach, it
_is_ possible to have async non-tree suspend constraints with rwsems.  
The key is to imitate the way the completions work.

The resume algorithm doesn't change, but the suspend algorithm does.  
Currently, when suspending a device you first read-lock the parent (to 
prevent it from suspending too soon), then you asynchronously 
write-lock the device and suspend it, and finally read-unlock the 
parent.

Instead, you could first write-lock the device (to prevent the parent
and any other dependents from suspending too soon), then asynchronously
read-lock each of the children and anything else the device needs to
wait for, then suspend the device, and finally write-unlock it.  This
really is analogous to completions:  down_write() is like
init_completion(), up_write() is like complete_all(), and
down_read()+up_read() is like wait_for_completion().  I got the idea
from Linus's comment that completions really are nothing but locks
initialized in the "locked" state.

Of course, you would have to iterate over all the children and deal
with lockdep complaints.  So this obviously is not to be considered as
a serious proposal.

Alan Stern
