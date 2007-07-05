From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 14:39:43 +0200
Message-ID: <E1I6QcZ-0000ex-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<200707042336.58466.rjw@sisk.pl>
	<E1I6Mq2-0008WB-00@dorka.pomaz.szeredi.hu>
	<200707051439.37737.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051439.37737.rjw@sisk.pl>
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

> > > PF_FREEZER_SKIP flag.  Perhaps we can do similar thing with FUSE.
> > 
> > It cannot be just worked around in fuse, as a task might be sleeping
> > on a number of VFS mutexes as well (i_mutex, s_vfs_rename_mutex, etc).
> > It would be a gigantic hack, possible at all.
> 
> Well, obviously FUSE and the freezer don't play well together, but
> that's FUSE who's late in the game (the freezer was here
> before). ;-)

Umm, and CODA which is _very_ similar to fuse was there long before
fuse or the freezer ;)

> If you give me some time, I'll see what can be done.

I give you all the time in the world.  I'd also be willing to help
with drivers for which I have the hardware.

Miklos
