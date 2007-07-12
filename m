From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Fri, 13 Jul 2007 01:13:09 +0200
Message-ID: <E1I97qP-0005JF-00@dorka.pomaz.szeredi.hu>
References: <200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070705091801.GB3084@elf.ucw.cz>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
	<20070705115400.GF3984@ucw.cz>
	<E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
	<20070707121729.GC3111@elf.ucw.cz>
	<E1I7H6v-0006pf-00@dorka.pomaz.szeredi.hu>
	<20070707233315.GB3820@elf.ucw.cz>
	<E1I7vx0-0002Fn-00@dorka.pomaz.szeredi.hu>
	<20070712153112.GB5139@ucw.cz>
	<E1I96eW-00059M-00@dorka.pomaz.szeredi.hu>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <E1I96eW-00059M-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 12 Jul 2007 23:56:48 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > Ok, I'll just blame fuse here. 'You have to write to /sys
> > files for SIGKILL to work' is not funny.
> 
> SIGKILL won't work on a stopped task.  Neither on a traced task.
> Neither on a zombie (how many newbies are thoroughly confused about
> that ;)
> 
> And it won't work on a task that is hanging on an NFS mount, when the
> network broke.
> 
> Oh, and it won't work on a deadlocked fuse filesystem.  How many of
> these have you met?  How many of the others?

And maybe someday, when I'm feeling _really_ bored, I may start
hacking the VFS to make it possible for tasks to be killed while
waiting on a mutex.  Can a task doing a page fault be interrupted?  I
don't see why not.

But, it's _not_ going to happen now, to fix the problems with suspend.
Hacking fuse (however broken it may be) or the VFS is not the right
way to fix those problems.  It may be easier than fixing the drivers,
though I doubt it.  But even if it's the easier way it's not the
_right_ way.

We want the various subsystems in the kernel to be less dependent on
each other not more.  And the freezer is just adding unnecessary
dependence on totally unrelated code.  And that does not only impact
fuse, but a lot of other code in the kernel, in the form of
try_to_freeze() calls all over the place.

Is that so hard to understand?

You can bash fuse all you want, I really don't mind.  But please stop
trying to prove, that this situation is best handled in fuse.  It just
won't happen, not because I'm lazy to do the work but because I don't
have the guts to do something so obviously wrong.

Miklos
