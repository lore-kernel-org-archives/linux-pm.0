From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 17 Oct 2017 23:36:06 +0200
Message-ID: <20171017213606.janfozvf5gjy3i7j@ninjato>
References: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
 <1507615237-21744-4-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6azw25krnebqfqr7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507615237-21744-4-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sakari.ailus@iki.fi, tfiga@chromium.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--6azw25krnebqfqr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 11:30:37AM +0530, Divagar Mohandass wrote:
> Currently the device is kept in D0, there is an opportunity
> to save power by enabling runtime pm.
>=20
> Device can be daisy chained from PMIC and we can't rely on I2C core
> for auto resume/suspend. Driver will decide when to resume/suspend.
>=20
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>

Applied to for-next, thanks!


--6azw25krnebqfqr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmd8YACgkQFA3kzBSg
Kba6EA//fDzf9U6V0o4KKPYe75rCK8mz/aGDrF8hKs9clMvAivjO2L8CsbprrAfS
N2yiVXo39bLJujPpbFNAV+LXnZR4RR96+B92MU8TKfjhBCdOaAaMy+02fagkJrPM
fKBWht7OpDRTWL4du2iI2dlW1EE6Xtbj4I+eoZXj/tA5xCze3g0I6Pan3PVDxDFf
Sx/JeXuJ+RwlTVlsAczY67bGQSGA4VID3KVG9J7vjSGEe9U7S3lvzM+0i53cQozW
OzOVGq0o+9SGGfX5sBcP+7/ZRY3QrRMfuCmkgZNyLZYK+1v0hSU1R9/3XfLXw5yp
amLl2whhay1rSCsqCBZjhDXWSP44lhMdz9Sr32q9vbLK4vrv41iVEi8ISx3oEm2r
FbA+/SY8XHBVI8sqSg2kZsFYwoni0KSZ2dE3XLrVQuJvxcu4N4K/aXmfM2C7Hrry
45S6WF6aZf21SQDvI5j6RaEBZkshWb4bV9P2f3QXwN9vxg/vjgrCKV+sUhcaM8P4
ykrfzWhVbzy2h4U1U5Bu/gIETaAZzJIWZpRqZoL3oh1Hktz+/3XFIYTvbxb3QDIv
JNyfiswAjmpjJsvJIfNFQEEy/UhhpaC0rdrfiohfthaBfl64w5CDdJZBDglJAi8c
IiFMPe1qaaVMWvaTGaYuA+9BizAhKEGTO+TeGDjunRhEjjVw8SE=
=328b
-----END PGP SIGNATURE-----

--6azw25krnebqfqr7--
