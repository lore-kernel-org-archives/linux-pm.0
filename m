From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 23:07:03 +0200
Message-ID: <E1I6YXX-0001yE-00__34817.4179591753$1183669903$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707052234.30021.oliver@neukum.org>
	<E1I6YDJ-0001sj-00@dorka.pomaz.szeredi.hu>
	<200707052249.45495.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707052249.45495.oliver@neukum.org> (message from Oliver
	Neukum on Thu, 5 Jul 2007 22:49:44 +0200)
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

> > > > Yes, fuse could handle being frozen there. =C2=A0However that wou=
ld only
> > > > solve part of the problem: an operation waiting for a reply could=
 be
> > > > holding a VFS mutex and some other task may be blocked on that mu=
tex.
> > > >=20
> > > > How would you solve freezing those tasks?
> > >=20
> > > OK, you made me reach for literatur on theoretical computer science.
> > >=20
> > > IMHO the range of actions a fuse server is inherently limited.
> > > You must never ever block on a lock one of your clients is holding.=
 In
> > > this case the limitation is not influenced by the freezer.
> >=20
> > Obviously. =C2=A0But I wasn't about the server trying to acquire a lo=
ck
> > held by a client. =C2=A0I was talking about a client trying to acquir=
e a
> > lock held by _another_ client.
> >=20
> > If this coincides with the server (or some other task which the serve=
r
> > is depending on) being frozen before the clients, the freezer has a
> > problem.
>=20
> True, but that case can only happen if servers are frozen before client=
s.
> You don't need a full dependency graph. A simple set sequence of two
> classes of tasks will do.

Umm, let's take sshfs, it has a separate "reply processing thread",
that reads replies from the sftp server and then wakes up the relevant
request thread.  The reply processing thread has no direct contact
with the fuse kernel module.  How is freezer supposed to know that
that task in fact also belongs to the server and needs to be kept from
freezing?

Given, it's in the same thread group, but using that is a rather weak
heuristic, as it could easily be a separate process, and likely in
some filesystems it is.

I fear, that your efforts to "save" the freezer are in vain.  It is
already moderately hackish with that PF_FREEZER_SKIP and the kernel
dotted randomly with try_to_freeze() calls, but adding bandaids to try
to order freezing userspace processes in the right order would just
make it a horrible mess.

Miklos
