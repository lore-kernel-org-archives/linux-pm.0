From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Date: Wed, 9 Jan 2019 16:57:06 +0000
Message-ID: <20190109165706.GG10405@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4827744518063021447=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
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


--===============4827744518063021447==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 10:56:32AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add helper to check if regulator will be disabled in suspend.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

This feels like it's the wrong way round - if this is configurable I'd
expect something to configure the suspend mode and then for that to
arrange to configure the regulator appropriately (along with anything
else that needs doing) rather than to infer the configuration from the
regulator state which feels fragile.  But based on the cover letter
that's kind of like what the initial proposal about target states was so
perhaps this is the way we end up going...  this certainly looks a lot
less impactful that the target state stuff though.

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2J+IACgkQJNaLcl1U
h9DcRQf/f2syn6A2vAA52taqMOX2yicco2vyAygNn47KH3gVlPg1zONPpEQpIgbA
bLBFQrcsF6qDNKhaFtuyoAf6OhTW0Zhx7GMGpiUAeGO1MhG4YH1KYw+bGMG6BxW6
QwaIOK15x1wagCtuI+837xmUUaWDHESLog4uvgpg7lEjZxfeXgsiPc9pCkLlrI2o
2ed96DyT4s/wHdwz61gi5INpScrynAEfzkyHhluYnHVES+6yS52E3NhipLgqbIj8
EhunSZJQFh+QpM3AG5ithO237q3mvPsKV0tUmBjWRZsuL/xrUlqd26J7iDye/52r
CZzk8FIhWeH/0fODpyARFAjqacYa5Q==
=Oh5J
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--


--===============4827744518063021447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4827744518063021447==--
