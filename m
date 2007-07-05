From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 10:24:22 +0200
Message-ID: <200707051024.23528.oliver__38147.0008324415$1183624033$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
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
> > > > I have discussed the benefits elsewhere. =C2=A0As for the deadloc=
ks -- do=20
> > > > you still observe them if you use the version of the freezer whic=
h=20
> > > > doesn't freeze kernel threads?
> > >=20
> > > In general the only way to guarantee there are no deadlocks is to
> > > construct the graph of dependencies between tasks. =C2=A0Those depe=
ndencies
> > > are not in practice observable from outside the tasks, so it is
> > > virtually impossible to construct the graph.
> >=20
> > In which way can user space tasks depend on each other in a way that
> > allows a them members of that cycle to be in uninterruptible sleep?
>=20
> =C2=A0- process A calls rename() on a fuse fs
> =C2=A0- process B, the fuse server, starts to process the rename reques=
t
> =C2=A0- process B is frozen before it can reply
>=20
> Now process A is unfreezable. =C2=A0We cannot make rename() restartable=
,
> hence it cannot be interruptible.

Then this is a problem specific to fuse. You should teach fuse to block
suspension while such operations are being performed.

	Regards
		Oliver
