From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 10:41:22 +0200
Message-ID: <E1I6Mtu-000058-00__39457.1254415952$1183624965$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<200707051024.23528.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051024.23528.oliver@neukum.org> (message from Oliver
	Neukum on Thu, 5 Jul 2007 10:24:22 +0200)
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

> > > > > I have discussed the benefits elsewhere. =C2=A0As for the deadl=
ocks -- do=20
> > > > > you still observe them if you use the version of the freezer wh=
ich=20
> > > > > doesn't freeze kernel threads?
> > > >=20
> > > > In general the only way to guarantee there are no deadlocks is to
> > > > construct the graph of dependencies between tasks. =C2=A0Those de=
pendencies
> > > > are not in practice observable from outside the tasks, so it is
> > > > virtually impossible to construct the graph.
> > >=20
> > > In which way can user space tasks depend on each other in a way tha=
t
> > > allows a them members of that cycle to be in uninterruptible sleep?
> >=20
> > =C2=A0- process A calls rename() on a fuse fs
> > =C2=A0- process B, the fuse server, starts to process the rename requ=
est
> > =C2=A0- process B is frozen before it can reply
> >=20
> > Now process A is unfreezable. =C2=A0We cannot make rename() restartab=
le,
> > hence it cannot be interruptible.
>=20
> Then this is a problem specific to fuse. You should teach fuse to block
> suspension while such operations are being performed.

And teach VFS to block suspension, while waiting on a mutex held by
another process performing a fuse operation.

I can already hear the beautiful praise from Al Viro at the sight of
that ;)

Miklos
