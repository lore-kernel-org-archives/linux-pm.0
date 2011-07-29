From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling
 mechanism within UART driver
Date: Fri, 29 Jul 2011 14:37:14 +0300
Message-ID: <20110729113713.GK31013__20979.2362562895$1312057847$gmane$org@legolas.emea.dhcp.ti.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
	<20110729095512.GE31013@legolas.emea.dhcp.ti.com>
	<CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0086720396215370107=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
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
To: Govindraj <govindraj.ti@gmail.com>
Cc: Partha Basak <p-basak2@ti.com>, Tero Kristo <t-kristo@ti.com>, balbi@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============0086720396215370107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Content-Disposition: inline


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 04:54:44PM +0530, Govindraj wrote:
> On Fri, Jul 29, 2011 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
>=20
> Thanks for replying.
>=20
> > On Thu, Jul 28, 2011 at 02:59:55PM +0530, Govindraj.R wrote:
> >> Proposal:
> >> --------
> >> =A0 =A0 =A0 1. For the UART, follow the current approach of locking th=
e console in
> >> =A0 =A0 =A0 =A0 =A0Idle/Suspend path before cutting the clock but usin=
g pm_runtime_putsync.
> >> =A0 =A0 =A0 =A0 =A0That is, continue using the prepare/resume Idle cal=
ls in idle path.
> >
> > I believe you should be using ->prepare() to prevent that any other
> > work on UART won't trigger a console_write() right now. Maybe only
> > queueing the work for after ->complete() or, maybe, just ignoring the
> > work and loosing some prints, dunno.
> >
>=20
> Yes true, for suspend path but for Idle path we don't have any such
> mechanism.

aha... good point ;-)

> I have done clock gating in idle path integrating irq chaining patches.
> hosted in gitorious here[1].
>=20
> Was consolidating whether this approach is OK,
> or
> Are there any other approaches that I should consider?

why don't you also start queueing writes after the first call to
runtime_suspend() and flush them after the first call runtime_resume()??

--=20
balbi

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMptpAAoJEAv8Txj19kN1a1EIAIMHs3SqnpCS+xNzpHLMKZTI
AbajLXZhYv62xoCKjOr/V1gNlsbEn1/P8cyufgOqrzy4nA1NGli1rUMqDbkfhYDy
3oRccBYLovJ3duxgqLhdKzj1FSP9cPE6mbeBlq2U7YplJKJtZRk5l3r/4LoMWwkf
Bdfod4rMXsQwGKZQI1hBsCrlupnVrozi0YIL/Ntj3Mtu9DQDPB+pjMie2URURegO
MK0O+JNO0Mz23NCljteBMOF4rEEAVI5ubYUzHvxm+cPYFuT9EjjtCutkoD3flJut
6HWKUVM+5I1MY3Cx47z2QNaAxESPSFZnfCQ6PD7xN3wxfdM+PCpUVWvwfG8iz9Q=
=DE5E
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--

--===============0086720396215370107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0086720396215370107==--
