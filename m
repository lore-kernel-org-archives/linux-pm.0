From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 21:47:43 +0200
Message-ID: <E1I5oLf-0004lk-00@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032026.34649.oliver@neukum.org>
	<E1I5no4-0004fU-00@dorka.pomaz.szeredi.hu>
	<200707032132.20731.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707032132.20731.oliver@neukum.org> (message from Oliver
	Neukum on Tue, 3 Jul 2007 21:32:20 +0200)
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > And a further question. The freezer is not atomic. What do you do
> > > if a task not yet frozen calls sys_sync(), but fuse is already frozen?
> > 
> > What do you do if a task not yet frozen writes to a pipe, on the other
> > end of which is a task already frozen?
> 
> The same as you do with a pipe when the reader is not ready.

Yes.  And if the fuse process is not ready, what will sys_sync() do?

(As a side note, sys_sync() actually does nothing in fuse, so these
examples are slightly silly, but the concept applies to any filesystem
operation).

> > It doesn't matter.  The only thing that should matter during suspend
> > (not hibernate) is saving the state of devices to ram, and putting the
> > devices to sleep.
> 
> Well, but you did remove sys_sync() from the freezer, which is
> and must be called in the hibernate path.

Since I don't know why sync() needs to be called from hibernate, I
can't argue about this.  But for _suspend_ it definitely should not be
needed.

> > I'm not sure why this can't be made atomic, but assuming, that it
> > can't, fuse should still not need to be implicated.  If it is, that's
> > an indication about something wrong in the suspend procedure.
> 
> Nope, something's wrong in fuse. You must be able to deal with sync
> until every task is frozen.

Why exactly?  That's like saying the pipe must be able to deal with
writes until every task is frozen.

As I've said, fuse is just special kind of IPC.  The task calling into
fuse can assume nothing about when it's request will be served.  Just
like a task writing into a pipe can assume nothing about when that
write will return.

Miklos
