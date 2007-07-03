From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 21:13:00 +0200
Message-ID: <E1I5no4-0004fU-00@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031508.45595.rjw@sisk.pl> <200707031709.29968.rjw@sisk.pl>
	<200707032026.34649.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707032026.34649.oliver@neukum.org> (message from Oliver
	Neukum on Tue, 3 Jul 2007 20:26:34 +0200)
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

> And a further question. The freezer is not atomic. What do you do
> if a task not yet frozen calls sys_sync(), but fuse is already frozen?

What do you do if a task not yet frozen writes to a pipe, on the other
end of which is a task already frozen?

It doesn't matter.  The only thing that should matter during suspend
(not hibernate) is saving the state of devices to ram, and putting the
devices to sleep.

I'm not sure why this can't be made atomic, but assuming, that it
can't, fuse should still not need to be implicated.  If it is, that's
an indication about something wrong in the suspend procedure.

Miklos
