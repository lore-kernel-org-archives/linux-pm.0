From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Date: Mon, 14 Jan 2019 22:53:11 +0000
Message-ID: <20190114225311.GJ11073@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
 <20190111123913.GA2804@sirena.org.uk>
 <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0686652998473354990=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu.Beznea@microchip.com
Cc: len.brown@intel.com, alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, pavel@ucw.cz, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0686652998473354990==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
Content-Disposition: inline


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:08:19PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 11.01.2019 14:39, Mark Brown wrote:

> > Like I say I'm working offline so I can't check the links but it sounds
> > like you're saying that the existing suspend mode configuration features
> > are enough for your systems?=20

> Yes, if we rely on the fact that core's regulator device tree bindings for
> suspend-to-mem/suspend-to-standby were filled correctly.

> The function I added here was to double check that core's regulator will =
be
> off in suspend/standby based on what was parsed from DT.

Ah, so it's being used as a consistency check?  OK, that does make sense
to me. =20

--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9EtYACgkQJNaLcl1U
h9AV+Qf+OscuST0WWOE2flYrj4veE7kRdI2nnKYgIWKwk1OvlpNJ4kQy4ZvDXITG
oUMIOLImOSCAMHh+RnSP9ee0inU38wsnbLEnjGBhGf6l/Jybe8ARemNoPO4KJ3tj
Sb4zJjhkrxN66N0KqJM5vh6mqrzz7jA1sfktIxRffRGTEZ4hx3gxVrH3Zwk7xUth
NQIxW9YF8pXZ1j2jnf9NZ3sF8ZRkL9GjN5JdYoS6sRvFcsSF39Of6Nmh3OA6o1rP
g77Jh2rns/BLphp3566eaDBE35QLq+tFELEc0oNWe33x/Dqok8rmC8+nWrOfIYC1
A0pfshgAEcqeDQLac9tYXo6h3sfvfA==
=KGpl
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--


--===============0686652998473354990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0686652998473354990==--
