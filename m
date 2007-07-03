From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 17:19:44 +1000
Message-ID: <1183447184.10386.102.camel__5264.22291663966$1183447483$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031454.42078.nigel@nigel.suspend2.net>
	<1183441706.10386.73.camel@localhost.localdomain>
	<200707031608.06348.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031608.06348.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-03 at 16:08 +1000, Nigel Cunningham wrote:
> 
> > So I think Matthew is totally right. In fact, the presence of the
> > freezer is the main reason why Paulus so far NACKed Johannes attempts at
> > merging the PPC PM code with the generic code in kernel/power.c
> > 
> > We've been doing fine without it so far and intend to continue to do so.
> 
> Fuse depends on !PPC?

No, that's not what I'm saying. I'm saying we've been doing STR without
the freezer and that's the way to go imho.

> > As for suspend-to-disk, I refer you to the discussions we had in the
> > past with Linus, where he explains I think quite clearly how wrong the
> > current implementation of STR is :-)
> 
> I assume you mean STD.

Oops, yeah, sorry.

> The problem there is that Linus doesn't care about STD. 
> If he did, I dare say he'd think through the issues more thoroughly than he 
> apparently has.

Heh, that might be the case :-)
 
> > Thing is, if you're going to do snapshots, you should probably not sync
> > after you have "frozen" anyway.
> 
> Fully agree. But how do you stop things syncing while you're writing the image 
> if you don't have a freezer or equivalent? (scheduler based, kexec.. they're 
> all workarounds for this issue).

Well, I was saying that in the context of the -current- snapshotting
mechanism which is based on the freezer, then you should not
sys_sync(). 

Some random user or kernel thread doing a sync is not a problem. It will
stop in the middle of sync and resume on wakeup.

The problem is currently because STD -itself- attempts to sync after it
has frozen things.

I think that should be changed. If you want to sync for whatever reason,
(mostly save RAM ?) do it before the freeze. That means you may get new
dirty data in memory that isn't written out by the sync before you
freeze, but that's allright, that data will be in the suspend image
anyway. If you fail to wakeup, that's akin to a normal crash, the user
will only lose the last data written at the time of the suspend and
journaling fs'es should take care of fs metadata integrity.

So to summarize, the plan that makes things work with fuse is:

 - For STR, don't do the freezer thing.

 - For STD, don't sys_sync() after you froze

There might be -other- issues, but that should get you through some of
them at least. Of course, you'll be in trouble if you try to do things
like STD-to-a-file which sits on a fuse FS but there's a limit to
insanity :-)

Cheers,
Ben.
