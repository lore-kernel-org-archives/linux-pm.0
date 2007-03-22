From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 19:18:15 +0100
Message-ID: <1174587495.3588.40.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<200703221010.59040.david-b@pacbell.net>
	<1174583912.3588.25.camel@johannes.berg>
	<200703221113.05518.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268490514=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221113.05518.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org


--===============0268490514==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pu5zviOG9lQt8fK90D7R"


--=-pu5zviOG9lQt8fK90D7R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 11:13 -0700, David Brownell wrote:

> Look at docs for most any SOC processor and you'll see that
> not only does it have a variety of lowpower states, but that
> each of them has various rules about what works there and
> what doesn't.
>=20
> So long as driver suspend() methods have no some way to see
> how far they "must" shut down for a given target sleep state,
> there is only limited utility to defining such states.

Oh ok, yeah, I see.

> That's because the state would only really apply to the cpu
> specific code ... drivers must assume the worst case, precluding
> the primary reasons to use those less-deep system states.

Right. That's a thing we'd have to fix in the interface to drivers to
tell them which state we're entering. But that can also get hairy since
the same device driver might support devices that are built into
different systems and might support different things there by being
hooked up differently....

> I just reposted my clk_must_disable() patches; I think it's time
> to merge them.  They address that issue for one of the most
> common type of rule for system sleep states ... at least, in
> terms of interface.  Platform support will still be an issue,
> but at least the issue won't be "crippled by bad design".

I can't speak for any of that, I haven't ever worked with PM on anything
not looking like a big desktop or at least laptop.

In any case, I didn't intend to fix up all that or even make it
possible, so far all I wanted was to clean up the mess surrounding
pm_ops even as it is currently defined (though it wasn't really
well-documented which probably led to the mess, I had to read the code
to understand it, I had no part in writing it.)

johannes

--=-pu5zviOG9lQt8fK90D7R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAshn/ETPhpq3jKURAqIDAKCrwDDPRpwLggd0hNr9tFOD/BdEiQCglrEA
6thZWzpVLJ4IeZLCOY+NAhY=
=YZTy
-----END PGP SIGNATURE-----

--=-pu5zviOG9lQt8fK90D7R--


--===============0268490514==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0268490514==--
