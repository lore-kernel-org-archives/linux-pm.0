From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 22:53:34 +0200
Message-ID: <200707052253.34817.oliver@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<E1I6YDJ-0001sj-00@dorka.pomaz.szeredi.hu>
	<200707052249.45495.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707052249.45495.oliver@neukum.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: mjg59@srcf.ucam.org, johannes@sipsolutions.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Oliver Neukum:
> Am Donnerstag, 5. Juli 2007 schrieb Miklos Szeredi:
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

Any replying to myself. A deadlock here is not fatal. You can and will
timeout in the freezer and can try again.

	REegards
		Oliver
