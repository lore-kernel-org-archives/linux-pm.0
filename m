From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 21:25:09 +0200
Message-ID: <E1I6ATN-0007QS-00__8718.44449216059$1183577256$gmane$org@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	(message from Alan Stern on Wed, 4 Jul 2007 11:42:03 -0400 (EDT))
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> wanting to resume devices during a system suspend transition?  This is
> exactly what happens when those threads aren't frozen.

OK, let me summarize the situation as I see it now: there are two
camps, the pro-freezers and the anti-freezers.

Pro-freezers say:

  - don't remove the freezer, otherwise we'll have to deal with
    numerous problems in drivers

Anti-freezers say:

  - let's remove the freezer, which causes numerous problems

Alan summerized the pro-freezer arguments well I think.  What are the
anti-freezer arguments then?

After having looked at the freezer and done some experiments with it,
the most obvious problem looks to be, that it can get stuck on a
process doing uninterruptible sleep.  And yes, this can happen if a
fuse filesystem daemon is frozen before a filesystem user is.  And
this is not something that can be fixed in fuse, some filesystem calls
(rename(2) for example) are simply not restartable.

This doesn't explain the deadlocks, but it could cause failure to
suspend which would be pretty annoying.

Does this affect other things than fuse?

Can this be fixed?

It seems to be a fundamental problem with the freezer: while it does
make sure that user processes are not calling into drivers during
suspend, it also disallows perfectly harmless non-driver calls as
well.

Miklos
