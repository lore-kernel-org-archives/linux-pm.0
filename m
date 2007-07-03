From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Tue, 3 Jul 2007 16:21:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031609070.7671-100000__11462.5730588616$1183494443$gmane$org@iolanthe.rowland.org>
References: <1183474748.3722.33.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183474748.3722.33.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Johannes Berg wrote:

> > Runtime suspend isn't a problem.  Only STR.
> 
> Ah but for all those character devices people were saying are the
> problem we haven't even solved runtime suspend as far as I can tell from
> the discussion.

The technique used by USB for runtime PM should work fine with other
devices.  They may not have implemented it yet, but I consider the
matter more-or-less solved.


> > As you can see, this is a very difficult problem to solve.
> 
> Indeed. Actually, one could argue that it's impossible to solve the
> problem as long as we try to call out to userspace during suspend and
> need to wait until that's finished, like in the case of sys_sync() and
> fuse filesystems, and probably other cases. Maybe we should make *those*
> calls return a failure so that the suspend isn't transparent inside the
> kernel but is transparent to userspace.

I disagree.  The problem isn't the kernel calling userspace; it's
userspace trying to do I/O at a time when everything is supposed to be
quiescing.  Detecting that and blocking it in drivers is hard and
error-prone; preventing it by freezing userspace is easy and cheap.

The reasons why the PPC people dislike the whole idea aren't clear to
me.  If it were necessary to have some user task running in order to
carry out the STR then their objection would make sense -- obviously
that task couldn't do its job if it were frozen.  But it isn't
necessary, or at least it should not be.

Userspace will be effectively "frozen" while the system as a whole is 
suspended.  So what's wrong with freezing it a little early?  Despite 
Ben's comments, it seems to me that the freezer doesn't hide problems 
-- it prevents them.

Now people may claim that the freezer implementation itself is buggy.  
I wouldn't dispute it.  But the bugs should be fixable; nobody has 
pointed out anything fundamentally wrong with the idea AFAICT.

Alan Stern
