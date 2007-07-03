From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Tue, 3 Jul 2007 16:02:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031556160.7671-100000@iolanthe.rowland.org>
References: <200707032132.20731.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707032132.20731.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Oliver Neukum wrote:

> Well, but you did remove sys_sync() from the freezer, which is
> and must be called in the hibernate path.

That's not really true.  We _want_ to call sys_sync() in both the 
hibernate and suspend paths (in case the batteries run down), to help 
avoid filesystem problems if something goes wrong with the resume.  But 
it isn't a hard requirement.

> > I'm not sure why this can't be made atomic, but assuming, that it
> > can't, fuse should still not need to be implicated.  If it is, that's
> > an indication about something wrong in the suspend procedure.
> 
> Nope, something's wrong in fuse. You must be able to deal with sync
> until every task is frozen.

That's ridiculous.  FUSE itself runs partially as a user task.  How can
you expect it to carry out a sync or anything else when it is frozen?

I suppose you could "deal" with it by having the kernel portion return
an error if the userspace part is frozen.  If the hibernate/suspend 
code bothered to check the return value, it would immediately abort 
the suspend.

Alan Stern
