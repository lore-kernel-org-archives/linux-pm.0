From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/2] ARM: at91: properly handle LPDDR poweroff
Date: Tue, 17 Jan 2017 00:26:46 +0100
Message-ID: <20170116232646.ivoh5dhr56j4ihgp@earth>
References: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8050814533920366162=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============8050814533920366162==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ucwjv4af2zaf5xif"
Content-Disposition: inline


--ucwjv4af2zaf5xif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Tue, Oct 25, 2016 at 11:37:57AM +0200, Alexandre Belloni wrote:
> This patch set improves LPDDR support on SoCs using the Atmel MPDDR contr=
oller.
>=20
> LPDDR memories can only handle up to 400 uncontrolled power offs in their
> life. The proper power off sequence has to be applied before shutting dow=
n the
> SoC.
>=20
> I'm not too happy with the code duplication but this is a design choice
> that has been made before because both shutdown controllers are really
> different apart from the shutdown itself.
>=20
> I guess it is still better than slowly killing the LPDDR.

Sorry, I totally forgot about this one. I queued it into my for-next
branch using an immutable topic branch, in case you need the patch
against the arm include to also go through arm-soc. Feel free to use
or ignore it:

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/ib-psy-arm-at91-4.11

for you to fetch changes up to 0b0408745e7ff24757cbfd571d69026c0ddb803c:

  power: reset: at91-poweroff: timely shutdown LPDDR memories (2017-01-16 2=
3:21:33 +0100)

----------------------------------------------------------------
immutable branch between ARM at91 and power-supply for v4.11
----------------------------------------------------------------

Alexandre Belloni (2):
      ARM: at91: define LPDDR types
      power: reset: at91-poweroff: timely shutdown LPDDR memories

 drivers/power/reset/Kconfig              |  2 +-
 drivers/power/reset/at91-poweroff.c      | 54 ++++++++++++++++++++++++++++=
+++++++++++++++++++++++++-
 drivers/power/reset/at91-sama5d2_shdwc.c | 49 ++++++++++++++++++++++++++++=
++++++++++++++++++++-
 include/soc/at91/at91sam9_ddrsdr.h       |  3 +++
 4 files changed, 105 insertions(+), 3 deletions(-)

-- Sebastian

--ucwjv4af2zaf5xif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9VrYACgkQ2O7X88g7
+poFvg/8CwqWyFttar2DsS9Es7Pb456Ihat1ES7xy7qBGom3DOzpikm0yzL1TqZr
YGr3xDXj6yILfhU6FOKxp5KSXfMMljaLfZ3SfW2FT+bUh7XmgGPPErwGT1FJw9si
hqQvp0JO79VWnSsbDjXamNrfnXgAidSvg9j+g2Hc62YsjpIIl3pjacL4DGrt8xWj
QZc9mA7NnfCTqerfxvpOmIP7Bb9f4+aLf3C++FkqXAy9QIKvtWOGrLizUJjXOlmn
6wzvl2tt9LWEhTQK17CQC48gdSSNqf4jR6FQC517LvUtpW7OfIcdYg8zJkUeagzw
8N8P2+AmkriBco5MD7yuXlBid3RO+nqsswJSpWgowT/VzR52uqKvlqrZNa5/dmuE
AbVACHWwJFKyFp9l7Mq/RK308AoRrzuQIZBY7r3hOAhNAaHgqfvT0kGoB7uJutOZ
r22zPwNnJVQXyPiOX3jz1IZycA5Yy71jdVsgNomts5Nmy3H5vudGTsYr3sYkyuux
MBJ1enl/J/JcM2QQzerKrXYVyTaICcCZgNkxlu5jLj5X4eaixd+l05uFYFabrIgM
Z0EWEg91E3n2eHkgey9NSX0sBpB1/ec5MP4yHk20OeEcMVTfA7K0jbAOypSm4gFp
89KGOaaz59oHfp52AoqsWMIvWJodqpHQu+E8PzZ6AMfLJgc1LWs=
=i5vG
-----END PGP SIGNATURE-----

--ucwjv4af2zaf5xif--


--===============8050814533920366162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8050814533920366162==--
