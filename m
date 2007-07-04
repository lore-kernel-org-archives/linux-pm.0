From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 09:02:45 +0200
Message-ID: <E1I5ysv-0005xf-00@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031307.41366.oliver@neukum.org>
	<1183463053.10386.112.camel@localhost.localdomain>
	<200707031355.51028.oliver@neukum.org>
	<18058.56956.595143.15424@cargo.ozlabs.ibm.com>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <18058.56956.595143.15424@cargo.ozlabs.ibm.com> (message from
	Paul Mackerras on Wed, 4 Jul 2007 09:40:44 +1000)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulus@samba.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > That's why we have the problem of freezing the kernel threads or not.
> 
> That problem is a symptom of the deeper conceptual problem, as is the
> problem with FUSE.
> 
> > You want to have all that pain for fuse?
> 
> I'd certainly rather get the drivers right, and maybe have an
> occasional deadlock if I miss something, than have a GUARANTEED
> deadlock every time I suspend with a FUSE filesystem mounted (which is
> pretty much every time, since I use encfs regularly).

That's weird, I never had a suspend problem due to a fuse mount,
though I have them all the time.  And I suspect, that even the sync()
thing that suspend does is not the real cause, because sync() actually
does nothing in fuse filesystems.

So there's something else going on, which obviously has to do with
freezing user processes, but it's not clear what.

Miklos
