From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 22:38:24 +0200
Message-ID: <E1I6Y5o-0001qm-00@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707052138.56920.oliver@neukum.org>
	<E1I6XFM-0001ek-00@dorka.pomaz.szeredi.hu>
	<200707052220.00555.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707052220.00555.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > > > > Actually fuse allows SIGKILL, because it's always fatal, and =
the
> > > > > > syscall may not be restarted.
> > > > >=20
> > > > > I think you want to stick try_to_freeze() at the same places wh=
ere you
> > > > > do SIGKILL handling. That should solve the 'syslogd is unfreeze=
able'
> > > > > problem.
> > > >=20
> > > > I could, but it would not solve the general problem. =C2=A0Namely=
, that the
> > > > presence of fuse imposes a certain ordering in which userspace ta=
sks
> > > > have to be frozen. =C2=A0And it is not possible to know this orde=
ring.
> > >=20
> > > Actually, why do you need this? There is no absolute need that you
> > > finish the request. You must either finish the request or let yours=
elf
> > > be frozen.
> > >=20
> > > A quick look through fuse reveals principally request_wait_answer()
> > > And maybe a few other places. Is there some hidden reason you canno=
t
> > > handle being frozen here?
> >=20
> > Yes, fuse could handle being frozen there.  However that would only
> > solve part of the problem: an operation waiting for a reply could be
> > holding a VFS mutex and some other task may be blocked on that mutex.
> >=20
> > How would you solve freezing those tasks?
>=20
> How probable is this situation?

I guess it depends on usage patterns.

I don't remember seeing any such cases, even though I have a permanent
fuse mount, and I suspend regularly.  But the fs is probably totally
idle during suspend in my case.

But some people use fuse as a home or root filesystem and in those
cases it can become quite likely to cause problems.

Miklos
