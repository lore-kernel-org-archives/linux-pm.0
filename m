From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 08:51:07 +0200
Message-ID: <E1I5cE7-0003E4-00@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707030813.53481.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707030813.53481.oliver@neukum.org> (message from Oliver
	Neukum on Tue, 3 Jul 2007 08:13:53 +0200)
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
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > Suspend to RAM on a machine with / on a fuse filesystem turns out to be 
> > a screaming nightmare - either the suspend fails because syslog (for 
> > instance) can't be frozen, or the machine deadlocks for some other 
> > reason I haven't tracked down. We could "fix" fuse, or alternatively we 
> > could do what we do for suspend to RAM on other platforms (PPC and APM) 
> > and just not use the freezer.
> 
> Only if you want to audit all character devices' read() and write()
> methods for races against suspend().
> / on fuse is a bad idea.

What makes / special?  Why aren't all fuse filesystems affected?
Suspend isn't trying to do I/O on the root fs, is it?

Miklos
