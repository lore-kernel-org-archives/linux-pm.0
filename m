From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 22:34:29 +0200
Message-ID: <200707052234.30021.oliver@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707052138.56920.oliver@neukum.org>
	<E1I6XFM-0001ek-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6XFM-0001ek-00@dorka.pomaz.szeredi.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Miklos Szeredi:
> > Am Donnerstag, 5. Juli 2007 schrieb Miklos Szeredi:
> > > > > Actually fuse allows SIGKILL, because it's always fatal, and th=
e
> > > > > syscall may not be restarted.
> > > >=20
> > > > I think you want to stick try_to_freeze() at the same places wher=
e you
> > > > do SIGKILL handling. That should solve the 'syslogd is unfreezeab=
le'
> > > > problem.
> > >=20
> > > I could, but it would not solve the general problem. =C2=A0Namely, =
that the
> > > presence of fuse imposes a certain ordering in which userspace task=
s
> > > have to be frozen. =C2=A0And it is not possible to know this orderi=
ng.
> >=20
> > Actually, why do you need this? There is no absolute need that you
> > finish the request. You must either finish the request or let yoursel=
f
> > be frozen.
> >=20
> > A quick look through fuse reveals principally request_wait_answer()
> > And maybe a few other places. Is there some hidden reason you cannot
> > handle being frozen here?
>=20
> Yes, fuse could handle being frozen there.  However that would only
> solve part of the problem: an operation waiting for a reply could be
> holding a VFS mutex and some other task may be blocked on that mutex.
>=20
> How would you solve freezing those tasks?

OK, you made me reach for literatur on theoretical computer science.

IMHO the range of actions a fuse server is inherently limited.
You must never ever block on a lock one of your clients is holding. In
this case the limitation is not influenced by the freezer.

The freezer introduces a further limitation in that the server can freeze
before the client, which must not be. You can prevent that by freezing
the servers last.

In principle you might have dependencies between servers and you won't
catch that, true. You won't catch servers blocking on IPC, but you are
balancing on the edge of deadlock with fuse anyway.

	Regards
		Oliver
