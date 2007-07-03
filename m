From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 14:56:39 +0200
Message-ID: <200707031456.40890.rjw__633.379913824861$1183467047$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183447184.10386.102.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 09:19, Benjamin Herrenschmidt wrote:
> On Tue, 2007-07-03 at 16:08 +1000, Nigel Cunningham wrote:
> > 
> > > So I think Matthew is totally right. In fact, the presence of the
> > > freezer is the main reason why Paulus so far NACKed Johannes attempts at
> > > merging the PPC PM code with the generic code in kernel/power.c
> > > 
> > > We've been doing fine without it so far and intend to continue to do so.
> > 
> > Fuse depends on !PPC?
> 
> No, that's not what I'm saying. I'm saying we've been doing STR without
> the freezer and that's the way to go imho.
> 
> > > As for suspend-to-disk, I refer you to the discussions we had in the
> > > past with Linus, where he explains I think quite clearly how wrong the
> > > current implementation of STR is :-)
> > 
> > I assume you mean STD.
> 
> Oops, yeah, sorry.
> 
> > The problem there is that Linus doesn't care about STD. 
> > If he did, I dare say he'd think through the issues more thoroughly than he 
> > apparently has.
> 
> Heh, that might be the case :-)
>  
> > > Thing is, if you're going to do snapshots, you should probably not sync
> > > after you have "frozen" anyway.
> > 
> > Fully agree. But how do you stop things syncing while you're writing the image 
> > if you don't have a freezer or equivalent? (scheduler based, kexec.. they're 
> > all workarounds for this issue).
> 
> Well, I was saying that in the context of the -current- snapshotting
> mechanism which is based on the freezer, then you should not
> sys_sync(). 
> 
> Some random user or kernel thread doing a sync is not a problem. It will
> stop in the middle of sync and resume on wakeup.
> 
> The problem is currently because STD -itself- attempts to sync after it
> has frozen things.

To be precise, it tries to sync after it has frozen the user land.
 
> I think that should be changed. If you want to sync for whatever reason,
> (mostly save RAM ?) do it before the freeze. That means you may get new
> dirty data in memory that isn't written out by the sync before you
> freeze, but that's allright, that data will be in the suspend image
> anyway. If you fail to wakeup, that's akin to a normal crash, the user
> will only lose the last data written at the time of the suspend and
> journaling fs'es should take care of fs metadata integrity.
> 
> So to summarize, the plan that makes things work with fuse is:
> 
>  - For STR, don't do the freezer thing.

In the long run, I agree.

Still, can you please read this post from Alan Stern:

https://lists.linux-foundation.org/pipermail/linux-pm/2007-June/012847.html

?  I don't think I'm able to repeat the arguments given in there in a
convincing way.

>  - For STD, don't sys_sync() after you froze

Yeah, I think we can move the syncing before the freezing, so to speak.

And it need not be called from within the freezer, BTW.

> There might be -other- issues, but that should get you through some of
> them at least. Of course, you'll be in trouble if you try to do things
> like STD-to-a-file which sits on a fuse FS but there's a limit to
> insanity :-)

Yes. :-)

Ggreetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
