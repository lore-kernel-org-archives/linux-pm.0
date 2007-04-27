From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Sat, 28 Apr 2007 07:32:03 +1000
Message-ID: <1177709523.4737.157.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<20070427145212.GO22250@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3955009652444477537=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427145212.GO22250@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============3955009652444477537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dep3BA2QFGxPUj8hwWqD"


--=-dep3BA2QFGxPUj8hwWqD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, 2007-04-27 at 16:52 +0200, Pavel Machek wrote:
> Hi!
>=20
> > From: Nigel Cunningham <nigel@nigel.suspend2.net>
> >=20
> > As explained by Nigel, Sendmail and some other programs look at the
> > load average and stop delivering when it gets too high.  The CPU
> > intensiveness of suspending to disk pushes the load average up quite
> > high but post-resume we shouldn't really take that into account.  Not
> > updating the load average therefore makes snapshot/shutdown invisible
> > to sendmail and so on.
>=20
> Is it kernel problem? We _had_ high load, and load average goes down
> pretty quickly.

Don't make artificial distinctions between kernelspace and userspace.

The load average doesn't go down that quickly, and the intensiveness of
the work can make the load average _really_ high. Remember that you're
probably not seeing this because you do an atomic copy pretty quickly.
If you're compressing and writing 80% of ram to disk before the atomic
copy, what will your load average be at the end of that?

> > @@ -1253,9 +1254,18 @@ static inline void calc_load(unsigned lo
> >  	if (unlikely(count < 0)) {
> >  		active_tasks =3D count_active_tasks();
> >  		do {
> > -			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> > -			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
> > -			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
> > +			/*
> > +			 * If we let the load average be updated while
> > +			 * snapshot/shutdown, it will be very high
> > +			 * post resume. Processes such as some MTAs
> > +			 * that stop work while the average is high
> > +			 * will be unnecessarily disrupted.
> > +			 */
> > +			if (likely(!freezer_is_on())) {
> > +				CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> > +				CALC_LOAD(avenrun[1], EXP_5, active_tasks);
> > +				CALC_LOAD(avenrun[2], EXP_15, active_tasks);
> > +			}
> >  			count +=3D LOAD_FREQ;
> >  		} while (count < 0);
> >  	}
>=20
> NAK. This slows down regular operation, at it is 30 lines for what
> should have been one (or five).

Count them. It is one line (an if statement) plus seven lines of
comment.

> Just place avenrun[0] =3D avenrun[1] =3D avenrun[2] =3D 0 at strategic pl=
ace
> if you feel strongly about this. Additional points for using Rafael's
> "suspend done" notifier so that you don't have to modify suspend core.

=3D0 might not be right. If you did have a high load average prior to
suspending, not delivering email would be the right thing to do.

Nigel

--=-dep3BA2QFGxPUj8hwWqD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMmvTN0y+n1M3mo0RAvadAJ9hrtwiqQ1cDwycxIiZLPpPodzRBwCg9FZ7
hFuMhie1UxO/X5jHL6OAyBA=
=l8u+
-----END PGP SIGNATURE-----

--=-dep3BA2QFGxPUj8hwWqD--


--===============3955009652444477537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3955009652444477537==--
