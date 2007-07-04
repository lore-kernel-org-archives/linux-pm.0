From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 23:36:57 +0200
Message-ID: <200707042336.58466.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<E1I6ATN-0007QS-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6ATN-0007QS-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 21:25, Miklos Szeredi wrote:
> > Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> > wanting to resume devices during a system suspend transition?  This is
> > exactly what happens when those threads aren't frozen.
> 
> OK, let me summarize the situation as I see it now: there are two
> camps, the pro-freezers and the anti-freezers.
> 
> Pro-freezers say:
> 
>   - don't remove the freezer, otherwise we'll have to deal with
>     numerous problems in drivers

And these problems will generally be difficult to reproduce reliably and debug.

> Anti-freezers say:
> 
>   - let's remove the freezer, which causes numerous problems
> 
> Alan summerized the pro-freezer arguments well I think.  What are the
> anti-freezer arguments then?
> 
> After having looked at the freezer and done some experiments with it,
> the most obvious problem looks to be, that it can get stuck on a
> process doing uninterruptible sleep.

That's correct.

> And yes, this can happen if a fuse filesystem daemon is frozen before a
> filesystem user is.  And this is not something that can be fixed in fuse,
> some filesystem calls (rename(2) for example) are simply not restartable.
>
> This doesn't explain the deadlocks, but it could cause failure to
> suspend which would be pretty annoying.

I think the only thing that can deadlock in that context is the sync.  At
least, I don't see anything else.

> Does this affect other things than fuse?

Not that I know of.  It may affect user space drivers, but there's no data on
that.

> Can this be fixed?
> 
> It seems to be a fundamental problem with the freezer: while it does
> make sure that user processes are not calling into drivers during
> suspend, it also disallows perfectly harmless non-driver calls as
> well.

The problem is that when the freezer was designed (I didn't do that, BTW),
there was no FUSE and similar things, so it's not prepared to cope with
such interdependencies between user space tasks.

We had an analogous problem with vfork() and it was solved by using the
PF_FREEZER_SKIP flag.  Perhaps we can do similar thing with FUSE.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
