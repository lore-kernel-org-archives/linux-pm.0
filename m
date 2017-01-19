From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 1/2] power: reset: add linkstation-reset driver
Date: Thu, 19 Jan 2017 05:43:28 +0100
Message-ID: <20170119044327.j3d2rlpn5va3iw37@earth>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
 <CAEQ9gEkoKc0Yv+kLYGWgHZZW92u0tW8E9U0eT7ZhAx79yKxzLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1397219413317979899=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAEQ9gEkoKc0Yv+kLYGWgHZZW92u0tW8E9U0eT7ZhAx79yKxzLQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Shimizu <rogershimizu@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Ryan Tandy <ryan@nardis.ca>, linux-pm@vger.kernel.org, Herbert Valerio Riedel <hvr@gnu.org>, devicetree@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>, linux-arm-kernel@lists.infradead.org, Sylver Bruneau <sylver.bruneau@googlemail.com>
List-Id: linux-pm@vger.kernel.org


--===============1397219413317979899==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idei6pnsp4jbus2l"
Content-Disposition: inline


--idei6pnsp4jbus2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roger,

On Wed, Jan 18, 2017 at 09:08:13PM +0900, Roger Shimizu wrote:
> On Sun, Jan 8, 2017 at 12:04 AM, Roger Shimizu <rogershimizu@gmail.com> w=
rote:
> > Buffalo Linkstation / KuroBox and their variants need magic command
> > sending to UART1 to power-off.
> >
> > Power driver linkstation-reset implements the magic command and I/O
> > routine, which come from files listed below:
> >   - arch/arm/mach-orion5x/kurobox_pro-setup.c
> >   - arch/arm/mach-orion5x/terastation_pro2-setup.c
>=20
> I think there's not much concern regarding to this series.
> Could you kindly help to apply this patch?

Well you dropped the DT binding, but still introduce new DT
properties. Since they are not documented without the binding
I won't merge this. DT binding documentation is not optional.
In other words: NAK on the binding effectively means NAK on
the driver in its current state.

If you want to see this merged rebase it to Rob's generic
serial bindings [0] and help to support him getting everything
into mainline ASAP. Currently the feedback seems to be quite
positive, so I hope to see it merged for 4.11.

[0] https://lwn.net/Articles/711794/ (current proposal from 2 days ago)

-- Sebastian

--idei6pnsp4jbus2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliAQ+0ACgkQ2O7X88g7
+ppoxxAAo/f8qG0ksrebqujmq9OMV9/8MYQInvamFKDIs6NefQiMfH1GeE9q8PXm
EFrW1iYWv3w88fc26iUiHWjJ1YpyJdEam+BdBhFnF15RdLBmLHSoIREKcBQaIHPO
q4nP4uOgUT5oOKG2H9Z+z/oJnWv7Qz6kOg1yyX3Cve2cpsPXkywrGPpDN3VKHv8f
5zLxO2m2eJBXZQj1FChkqqjPuM9NP9Kx8qWlg1w17gLblMaWQxImJkmMUciiRrbz
WjBKfalbbOIjTylRDf+3BvUV1e5L6MakAiMO6+AzRSugIsDbFskuABSWEuPIQGOy
0nWBCSGkGTrxo8UB2s/Zy2+IrCxak8kwbXtSUdOqBQ9pZ0NtlToF+O/Vbw5t7Sqr
cO0xDnw3KEJOKge6yXmqyXVA12TvBMcBLga7TZuXeU7cKXJTBXVdUuGzfR1IoUdg
zul/kFT+BPZCUaMS9B+09sH1SHKS7QHgwW1rqltTH4EZZ+LEncj9nQwsp2tcswc9
kniixhTbf0HYgWyN7Bug3sXjAq9CATYJKnCdTz5t0H93O0Z+Qh6n/guCYxKWR0J7
yKUt4IodgZ6ChL8GYrs9mN/V3gF2G/9wCqCcEdsnnOW/JQU8oZHtzL1TfxxZm41G
YuF8X7nDh1x/oC4g+nH8K7EGr9hLDDbUlpLE7VYBWxladRkY7qw=
=m9Qr
-----END PGP SIGNATURE-----

--idei6pnsp4jbus2l--


--===============1397219413317979899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1397219413317979899==--
