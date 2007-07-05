From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Thu, 05 Jul 2007 17:32:34 +0200
Message-ID: <E1I6TJq-000164-00__39964.9885636338$1183649617$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<200707051704.48137.rjw@sisk.pl>
	<20070705150301.GB23647@srcf.ucam.org>
	<200707051727.36715.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051727.36715.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > You have processes that don't react to signals, because some
> > > other user land task is misbehaving.  I'd call that ugly at the
> > > very least.
> > 
> > It already happens with, say, NFS. Don't think about it in terms of a 
> > userland task misbehaving - think of it in terms of a resource becoming 
> > unavailable.
> 
> I think there's a difference between a userland task playing the role of a
> resource and a "real" external resource the kernel doesn't control.
> 
> IMO, userland tasks should not have the power to affect each other as though
> they were parts of the kernel.

One task doing ptrace() can basically do whatever it wants with the
task being traced.  This is not an exact analogy to what fuse does,
but close.

And for this reason the security model for allowing access to a fuse
filesystem is similar to that for allowing tracing.

The gory details can be found in Documentation/filesystems/fuse.txt.

Miklos
