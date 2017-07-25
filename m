From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v1 3/6] power: supply: bq27xxx: Enable data memory update
 for certain chips
Date: Tue, 25 Jul 2017 13:17:01 +0200
Message-ID: <20170725111701.3hqgnzqfuaocfu2w@earth>
References: <20170709021700.14354-1-liam@networkimprov.net>
 <201707091107.44653@pali>
 <CAKvHMgQ0D6DRz8Ckk4st+5uYZybXfAQtGq=wZ3Bgz4RuaNZV_g@mail.gmail.com>
 <201707091712.34705@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqxhgjvvyc4cxedu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32817 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdGYLRJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 07:17:09 -0400
Content-Disposition: inline
In-Reply-To: <201707091712.34705@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--mqxhgjvvyc4cxedu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 09, 2017 at 05:12:34PM +0200, Pali Roh=E1r wrote:
> On Sunday 09 July 2017 16:13:59 Liam Breck wrote:
> > On Sun, Jul 9, 2017 at 2:07 AM, Pali Roh=E1r <pali.rohar@gmail.com>
> > wrote:
> > > On Sunday 09 July 2017 04:16:57 Liam Breck wrote:
> > >> From: Liam Breck <kernel@networkimprov.net>
> > >>=20
> > >> Support data memory update on BQ27500, 545, 425, 421, 441, 621.
> > >> With exception of BQ27425, these are only enabled #ifdef DEBUG,
> > >> as they are not tested.
> > >>=20
> > >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> > >> ---
> > >>=20
> > >>  drivers/power/supply/bq27xxx_battery.c | 164
> > >=20
> > > Why under #ifdef DEBUG? Seems that this is misusing DEBUG which is
> > > used for other things.
> >=20
> > This is a temporary measure, as those definitions are not tested on
> > their chips. Nothing new happens in debug mode unless
> > monitored-battery is set in driver's DT config, and it's either a
> > ram-only chip or the dt_updates_nvm config option is set.
> >=20
> > If DEBUG isn't ok in this case, alternative suggestions?
> >=20
> > Thanks for your input!
>=20
> DEBUG can be enabled by other kernel option and should provide just more=
=20
> debugging functionality. But you are adding non-debug functionality=20
> under #ifdef DEBUG, which basically is "new experimental untested=20
> feature".
>=20
> Better way for "experimental feature" would be introduction of other=20
> kconfig switch or probably runtime module option...

As far as I understand it, there is a risk to brick hardware
when internal data is modified. So if these chips are untested,
let's just leave them out.

Testing should be done by a developer anyways and then he can
just add the required values.

-- Sebastian

--mqxhgjvvyc4cxedu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3KKoACgkQ2O7X88g7
+pq3Ew/+JQfdZn8eHx7TSTP+jbvNvBYsDC9CzDlf3NEjhze+E45wI55UxsW5VJEY
tyIfzFdcd7/xWfdYF5V5vjT1EyBbZ7jV4T+pkaEMKKijR9H2AGQu6OLwt05svbt8
Q9Pxm2nYzsZWp959VQ3dUz6Qf8eaqlW62SYbhpPZG8CLWC0j4TusBTZZBmujAuZN
GkY/LfMwFOl6mfEpOfLhABwZZeyUP3H+I1I4gY5yIfqGs4dej1YdurZ/3aOzRZOi
M9kco8Ree7KRItaAAlW+XZqaOd2iAwt8DcFoWvbAXvt4gRH6un4cPHApVB9ARTfg
f/R8Fo498V4LXv4J0dcTycvrTnrQcjHnTdtz5Xe2q2D+z6onu9f3FnHtxrvFXNz8
gLTuKYkbn9+lWTfvL5xlBWcwDAYWjpkfkzdzVgtn5p+hkzRS1OlWlEXxL4jr9i2n
r/dTLQLxA+rOEZkJVJCDCcifJhfQHZgc4pmfFagG1a/1ZDkn9e+Q7zusExLHgSG4
7EzzmW1WaWvNo4sp0rdUzXHJSsknIXFd8KzaFD5LAuKYQ4vZ4Yq36/kwmAEK0aPG
x3vX5/+qCm8j0JV2Jk6Raoc9Jt7AbdF5p9kMsddvjk8eedW0Em6oMbhadngdEmKi
+JL0JY0xPwRO1y4VKur8oPTHDR49h16Jn4V1LWV5GrxaLlXlMHQ=
=1A6w
-----END PGP SIGNATURE-----

--mqxhgjvvyc4cxedu--
