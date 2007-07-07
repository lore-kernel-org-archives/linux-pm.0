From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Sat, 07 Jul 2007 22:14:34 +0200
Message-ID: <E1I7Gfq-0006n0-00@dorka.pomaz.szeredi.hu>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<200707051704.48137.rjw@sisk.pl>
	<20070705150301.GB23647@srcf.ucam.org>
	<200707051727.36715.rjw@sisk.pl>
	<E1I6TJq-000164-00@dorka.pomaz.szeredi.hu>
	<20070707115047.GE2789@elf.ucw.cz>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20070707115047.GE2789@elf.ucw.cz> (message from Pavel Machek on
	Sat, 7 Jul 2007 13:50:47 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pavel@ucw.cz
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > One task doing ptrace() can basically do whatever it wants with the
> > task being traced.  This is not an exact analogy to what fuse does,
> > but close.
> 
> Well, IMO userland tasks should not have power to grab VFS mutexes for
> indefinite ammount of time. ("fused is allowed to deadlock kernel, in
> a way only write to special file helps" is ugly). Unfortunately, I
> don't think there's a way to work around that deadlock within fuse
> design limits... (coda was able to get around it by working on whole
> files granularity, AFAICT), so we'll have to live with that.

That's just file I/O.  You can easily deadlock coda with any other
file operation.  In fact coda is _less_ robust wrt a misbehaving
userspace server than fuse by a big margin.

Miklos
