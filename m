From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 17:17:04 +0200
Message-ID: <200707041717.05149.rjw__41178.3923664645$1183562035$gmane$org@sisk.pl>
References: <20070703211227.GA28758@srcf.ucam.org>
	<E1I666o-0006wu-00@dorka.pomaz.szeredi.hu>
	<200707041703.21808.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041703.21808.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 17:03, Oliver Neukum wrote:
> Am Mittwoch, 4. Juli 2007 schrieb Miklos Szeredi:
> > > > And we won't know if drivers are OK until we remove the freezer,
> > > > catch-22.
> > >=20
> > > I disagree. =C2=A0We can learn that by auditing the drivers.
> >=20
> > In theory, yes. =C2=A0But it scales far worse than letting everyone
> > experiment/report/fix problems as they crop up.
>=20
> You will open many but small races. This would be very painfull
> to debug.

Agreed.

They will not trigger 100% of the time, but sporadically and generally at
random.

At least the freezer problems are reproducible. ;-)

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
