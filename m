From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 22:19:59 +0200
Message-ID: <200707052220.00555.rjw__33563.2932525643$1183666416$gmane$org@sisk.pl>
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

On Thursday, 5 July 2007 21:44, Miklos Szeredi wrote:
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

How probable is this situation?

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
