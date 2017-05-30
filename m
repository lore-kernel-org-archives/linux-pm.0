From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regmap: Add OneWire (W1) bus support
Date: Tue, 30 May 2017 12:50:40 +0100
Message-ID: <20170530115040.awy7y5rv7ouub6k6@sirena.org.uk>
References: <20170528071120.6604-1-minimumlaw@rambler.ru>
 <20170528071120.6604-2-minimumlaw@rambler.ru>
 <20170529131346.gsauzllpplc2e7vy@sirena.org.uk>
 <f4efbd7b-6b65-1344-dc36-8695d1d451e8@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nds5slbqgqkx5d5t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f4efbd7b-6b65-1344-dc36-8695d1d451e8@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--nds5slbqgqkx5d5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 07:37:58PM +0300, Alex A. Mihaylov wrote:
> 29.05.17 16:13, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > I asked you to move the error handling into the else case in these :(

> Why do you want to see exactly the construction of if/else?

I want to see some error handling in the lock so it doesn't look like
it's missing, especially since this is the unusual pattern of "mark it
as OK in an if statement then carry on running".  The code pattern is
too unusual and there's too much code and blank space between the ret =3D
0 meaning it takes too much effort to slow down and check that there's
not a bug.

> I already wrote that for me this will worsen the quality and understanding
> of the code. And another point - in fact it is not an error handler. This=
 is
> a completely normal and permissible situation. There is no "disconnect"

It's an error.  It may be an expected and recoverable error but as far
as this write is concerned it's an error.

> I can see this pattern in other kernel place, like:
> drivers/usb/musb/da8xx.c line 374

This one for example looks like normal code - it's jumping to error in
the error handling cases, the success case is a normal direct return
with the error cases in the if checks and there's multiple conditions
that could trigger an error.  You need to get out of the locked region
so you have limited options but only have one conditional, moving the
assignment inside the else seems like the clearest.

--nds5slbqgqkx5d5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlktXJAACgkQJNaLcl1U
h9DNVgf8Cm0qwrTg1lrdAfqP0nk+L5qD9G1BZ1EyPoR5Ern/yShnX80NrBIkluxC
hoUFdTNvvCEUXutJfRVi4eNXk6ML7crTsa5E2n+yTpfQc2XyComjslbqrkbMOUWc
8guZNJeiBqtNw992aSP/rNxuiuBDtjGnSwWxq/khSjQqXkX7Eilz2DvsxDm3YfaJ
3I3mEAbNuOfvi9hQ72FdkqKoboa5SQsU38I3L/hX6EINhzD8dQFU2l6smmY2TW8Y
1KACdX8tJqcVETUmp/Unc+H+63P0zfFYtDu6zVu38+OIse/k6pIYY0HCFENx6PYU
vwATsWPTmRHFFrkT1ULNUgs3V/1P6Q==
=zk03
-----END PGP SIGNATURE-----

--nds5slbqgqkx5d5t--
