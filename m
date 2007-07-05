From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 12:14:07 +0200
Message-ID: <E1I6OLf-0000JP-00@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051048.46202.oliver@neukum.org>
	<E1I6NAH-00008t-00@dorka.pomaz.szeredi.hu>
	<200707051202.59375.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051202.59375.oliver@neukum.org> (message from Oliver
	Neukum on Thu, 5 Jul 2007 12:02:58 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oliver@neukum.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > > And teach VFS to block suspension, while waiting on a mutex held by
> > > > another process performing a fuse operation.
> > > > 
> > > > I can already hear the beautiful praise from Al Viro at the sight of
> > > > that ;)
> > > 
> > > There is that.
> > > 
> > > OK, bite the bullet. Tasks involved in fuse are special. Give them a flag
> > > and teach the freezer to put them on ice only after all other task are
> > > frozen. In a way they are kernel, there's no use denying that.
> > 
> > And flag every other process, that the flagged process is
> > communicating with?  How are you proposing to do that?
> > 
> > Quoting Paul:
> > 
> > "1. The freezer cannot be guaranteed deadlock-free without constructing
> >    a dependency graph between tasks (both user and kernel), which is
> >    virtually impossible since the dependencies are not externally
> >    observable."
> 
> A deadlock requires that the circular wait is uninterruptible. Normal IPC
> isn't.
> 
> What are you doing in the userland portions of fuse? Some kind of IPC
> with other tasks?

Anything, writing to a file, writing to shared memory, sending things
over the network.  There's no limit to what a filesystem daemon may
do.  It's a perfectly ordinary unprivileged userspace process.  And
this is a feature not a bug.

> There is a limit to which you can push kernel functionality into
> user space.

Limiting what a userspace filesystem can do would defeat the whole
purpose of the bloody thing.  This is not negotiable ;)

Miklos
