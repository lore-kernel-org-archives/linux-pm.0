From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 10:37:22 +0200
Message-ID: <E1I6Mq2-0008WB-00__20561.6866740913$1183624848$gmane$org@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<E1I6ATN-0007QS-00@dorka.pomaz.szeredi.hu>
	<200707042336.58466.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707042336.58466.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > Pro-freezers say:
> > 
> >   - don't remove the freezer, otherwise we'll have to deal with
> >     numerous problems in drivers
> 
> And these problems will generally be difficult to reproduce reliably
> and debug.

I see exactly the opposite.

With the freezer I can have very rarely occuring failures, due to
freeze ordering effects.

And without the freezer I have a 100% reproducable problem, that is
not hard to fix according to Alan Stern.  OK, I don't know what the
next problem would be, but the powermac experience shows, that it's
not nearly as bad as you and Oliver try to make it out.

> > Can this be fixed?
> > 
> > It seems to be a fundamental problem with the freezer: while it does
> > make sure that user processes are not calling into drivers during
> > suspend, it also disallows perfectly harmless non-driver calls as
> > well.
> 
> The problem is that when the freezer was designed (I didn't do that, BTW),
> there was no FUSE and similar things, so it's not prepared to cope with
> such interdependencies between user space tasks.
> 
> We had an analogous problem with vfork() and it was solved by using the
> PF_FREEZER_SKIP flag.  Perhaps we can do similar thing with FUSE.

It cannot be just worked around in fuse, as a task might be sleeping
on a number of VFS mutexes as well (i_mutex, s_vfs_rename_mutex, etc).
It would be a gigantic hack, possible at all.

Miklos
