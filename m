From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Thu, 05 Jul 2007 23:26:54 +0200
Message-ID: <E1I6Yqk-00022q-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
	(message from Alan Stern on Thu, 5 Jul 2007 17:15:24 -0400 (EDT))
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > I fear, that your efforts to "save" the freezer are in vain.  It is
> > already moderately hackish with that PF_FREEZER_SKIP and the kernel
> > dotted randomly with try_to_freeze() calls, but adding bandaids to try
> > to order freezing userspace processes in the right order would just
> > make it a horrible mess.
> 
> I agree that bandaids won't work.  What's needed is something more 
> radical.  Things like FUSE must be written so that the kernel parts 
> _can_ freeze even while they are waiting for a response from a user 
> thread.

This has already been discussed, with the conclusion, that it can't be
done without hacking VFS internals.

The basic problem is that the freezer tries to get every user process
out of the kernel even when those processes have _nothing_ to do with
drivers and could happily stay in kernel land across a suspend or even
hibernate.

If we could have a good grip on when a request is entering a driver,
it would be easy to take care of this.  I guess network and block
devices are easy.  For others there's no obvious common place where
such barriers could be placed so it's more work, but nothing
conceptually problematic.  Is this about right?

Miklos
