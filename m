From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 10:48:45 +0200
Message-ID: <200707051048.46202.oliver__9363.14559444345$1183625431$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051024.23528.oliver@neukum.org>
	<E1I6Mtu-000058-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6Mtu-000058-00@dorka.pomaz.szeredi.hu>
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
> > > > > > I have discussed the benefits elsewhere. =C2=A0As for the dea=
dlocks -- do=20
> > > > > > you still observe them if you use the version of the freezer =
which=20
> > > > > > doesn't freeze kernel threads?
> > > > >=20
> > > > > In general the only way to guarantee there are no deadlocks is =
to
> > > > > construct the graph of dependencies between tasks. =C2=A0Those =
dependencies
> > > > > are not in practice observable from outside the tasks, so it is
> > > > > virtually impossible to construct the graph.
> > > >=20
> > > > In which way can user space tasks depend on each other in a way t=
hat
> > > > allows a them members of that cycle to be in uninterruptible slee=
p?
> > >=20
> > > =C2=A0- process A calls rename() on a fuse fs
> > > =C2=A0- process B, the fuse server, starts to process the rename re=
quest
> > > =C2=A0- process B is frozen before it can reply
> > >=20
> > > Now process A is unfreezable. =C2=A0We cannot make rename() restart=
able,
> > > hence it cannot be interruptible.
> >=20
> > Then this is a problem specific to fuse. You should teach fuse to blo=
ck
> > suspension while such operations are being performed.
>=20
> And teach VFS to block suspension, while waiting on a mutex held by
> another process performing a fuse operation.
>=20
> I can already hear the beautiful praise from Al Viro at the sight of
> that ;)

There is that.

OK, bite the bullet. Tasks involved in fuse are special. Give them a flag
and teach the freezer to put them on ice only after all other task are
frozen. In a way they are kernel, there's no use denying that.

	Regards
		Oliver
