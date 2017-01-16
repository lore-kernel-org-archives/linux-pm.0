From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 0/2] qcom OTG regulator support
Date: Mon, 16 Jan 2017 22:49:47 +0100
Message-ID: <20170116214947.wpk7mmjrvfzgbgrq@earth>
References: <20161018004251.28733-1-stephen.boyd@linaro.org>
 <CAJOFmgySF7T1N6PDiw2rsQ+n68_k7n_M0TzXZe4S7PxTHmRapA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4898735552741985931=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJOFmgySF7T1N6PDiw2rsQ+n68_k7n_M0TzXZe4S7PxTHmRapA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "Bird, Tim" <tim.bird@sonymobile.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============4898735552741985931==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="guhg7n7l4st7jx74"
Content-Disposition: inline


--guhg7n7l4st7jx74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, Dec 28, 2016 at 02:06:18PM -0800, Stephen Boyd wrote:
> On Mon, Oct 17, 2016 at 5:42 PM, Stephen Boyd <stephen.boyd@linaro.org> w=
rote:
> > This is a resend/resurrection of Tim's patches to add support
> > for the OTG regulator on some of qcom's PMICs[1]. I've made
> > some minor modifications to the driver to make it work, but
> > otherwise it works fine with my USB otg testing. Changes
> > are noted in a maintainer tag.
> >
> > Tim, did you want to me to fix the name? I pulled these from patchwork
> > and it seems you sent it as "Bird, Tim" which may have not been
> > intentional.
> >
>=20
> Can this be picked up for v4.11? Tim hasn't responded so I assume it's
> fine with the name.

Yes, sorry for the delay. I just queued it.

-- Sebastian

--guhg7n7l4st7jx74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9P/gACgkQ2O7X88g7
+prr+Q//VsFkNhS0Q76tOR/Rktjul4S9oK+nh+Q/sDRwu+Bn6YuCW850LDKqncnG
kJBx3JRCBEGCXVVFG5Dom5VZ6SueKMIktIRBdaToyV0vFBgfSrdXTuMfL0v01U4l
DripA14vMlUX4QSjMsnZEVxYXULjVGy0DF+LqjQMExkIbX8+q7ElFwaYEPacNJzF
0M+GmXa1jEGmY7Obx5imxh09RAD4AUUZaf0tZZRsTaQFpASmKLHfKN/Ye5PeqXnP
wGtllkonMv0CP3cGvTHnVUK2R3NQgjwZHhGX8tnfIvq4cTaNJ1Lm0uFWg2DxgcwD
meWIKQjVj5hRr0ix3jMHvNEHofmsNY+mlvt+N0veThuAUengHqY9gTDfh/u/e6h0
F8g8nFx8t/54goDQljdOU88tU1U/kO/38Ea25P/72r/3F0VoBF8eY1XPHlSn0Umu
y7sP3Xf+hAKaRcsLCPiA14QJdtF3nHTOcxIuO80wzuUv4UHWDOjHRSJOFQAFGftj
FJVBvuPxcvXpXLg4iDiR9p0LwEtGNu5ntJzL5wh5dKhfl+NMHi7xVfLIjM2ZkNrx
kUa9MLRnTlzGFzbrLlTnEXt9t6b5yuvlLS3LQesJ2qgRb9GBpyev5qWGYpvIM4cb
tiGK/KlE117nF8OLiKV36FuRlVUWW3zXfOocKXw4pjxw1MHrdds=
=DAaN
-----END PGP SIGNATURE-----

--guhg7n7l4st7jx74--


--===============4898735552741985931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4898735552741985931==--
