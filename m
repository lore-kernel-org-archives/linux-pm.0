From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Date: Wed, 19 Dec 2018 17:31:15 +0100
Message-ID: <20181219163115.fdnl6kivywuxdgmu@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
 <20181218233354.pie5i3lvrrhq5q2c@ninjato>
 <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9083179363208059057=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============9083179363208059057==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qjxzn2xrzruodsqv"
Content-Disposition: inline


--qjxzn2xrzruodsqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 10:39:05AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Dec 19, 2018 at 12:34 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > +   unsigned int is_suspended:1;    /* owned by the I2C core */
> > >
> > > When more stuff is added to this bit field (which always happens at
> > > some point) updates to all members of the bit field will have to use
> > > the same root-adapter-locking, or we will suffer from RMW-races. So
> > > this feels like an invitation for future disaster. Maybe a comment
> > > about that to remind our future selves? Or perhaps the bit field
> > > should be avoided altogether?
> >
> > Changed to bool. Thanks!
>=20
> Does that help, given bool is smaller than the CPUs word size?
> Is it Alpha that cannot do atomic operations on bytes?

Yup, I overestimated bools :( I guess good old

unsigned long locked_flags;
#define <PREFIX>_IS_SUSPENDED	0

set_bit(), clear_bit(), and test_bit() is it then.


--qjxzn2xrzruodsqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwack8ACgkQFA3kzBSg
KbY9JRAAhxm2Kip+tvnMls1hk+/Edk4mmwGCNgQoxQX2AhW3Lw0vyAffaBG7S+eG
UwNg372M5JC8Rva111oTpAVr8MhvAVuJnGFpG0UMJIDWXQGJ2UKcumx7DNHwYjiB
zkDtrdjilgbGSe9SVRco+BbBK6qy/mdNI+GBAnXB9bC+Xbawe+3KTlgGVlFpjS9r
Yb02KmVERIxeBYbzNw23S9Tx3raZVOnGSz2am/n9GGrM/kFtBK1Ge7W+Acq92VoF
9C3AOy0ZoyY8sgz5rR0TRuoVgkXC/8AKsWqS3dVCpR0iZPVG9ZYth5ta7rRojjeJ
C/s1Hgq6oR2zxXLiM/NG7SbdIiVMekYbEDrRx2zsBwg18aynLRuygwnqHkT6WE8A
lfZKa/LEVvP9p5Xw4Lwak0jxtqAJzGIv6ebJRN5tLmcRP9vYRuKk/D5RbWq4U6bZ
fuI6Z589b4nZkWgx52G8RCu3NImmLFxbhJd9RjOm9buE5b3nz4aatviQbno2uJ6s
gC3SMz9p0nG7A0cdEYcXXG2/FrKXl3lQtIU028DFRkkfGARRX5bj6+I7bp/s4Vby
0wsdtXwezh9SQPBiJBbtilD9j6oDZGep3/tLVWacvbn3T819oEfVltn26YHQbuz2
VDmUUE5YtgAdUqjUJ2YM0BOZ+bHAGEzGDY2DJLMSwWs7Clu79FE=
=KkzT
-----END PGP SIGNATURE-----

--qjxzn2xrzruodsqv--


--===============9083179363208059057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9083179363208059057==--
