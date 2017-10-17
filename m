From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 1/3] dt-bindings: add eeprom "size" property
Date: Tue, 17 Oct 2017 23:35:58 +0200
Message-ID: <20171017213558.rct4fjpplh3cfyyo@ninjato>
References: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
 <1507615237-21744-2-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qwkx27l7hkxso7v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54591 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753003AbdJQVgA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Oct 2017 17:36:00 -0400
Content-Disposition: inline
In-Reply-To: <1507615237-21744-2-git-send-email-divagar.mohandass@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sakari.ailus@iki.fi, tfiga@chromium.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org


--2qwkx27l7hkxso7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 11:30:35AM +0530, Divagar Mohandass wrote:
> This adds eeprom "size" as optional property for i2c eeproms.
> The "size" property allows explicitly specifying the size of the
> EEPROM chip in bytes.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>

Applied to for-next, thanks!


--2qwkx27l7hkxso7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmd7oACgkQFA3kzBSg
KbblFBAAn7F2ZSl9+BZqREdwPEwX2/0SddLIswOeqrlvOTp/EL1rXzMLzRsVXAnp
9lU6rySzRo6s4uZfW+rp1QHIcNQhH8RWM++0FVNSJc7mTdDvi07UWLmNeBG0yHb5
G/mbuBjzEe4SzL2TgqLQIATDfGUOfC699TbkWDQybqNJ4GJq/J7AFdFvgdKWpuFz
uNuElMup6gXBRmMg5JOw5CgMJMjrYqrJwSPjLUwsEDr4xhRNCrV8buQM44rN4G/6
MZOUDFL9LfY7mVDkK5W4tv8v+gqaOfCAuehJxjyymbvsxpDfL21dC6Jih4S6doHk
bfrJcpJA/yY6CTBGDccEBhFFhKxReCVpBc+fx/QdTaktp+UAx4yya7j6ZLYZTGOv
3jFPuSBgReBn0kGP8spd82oPbUCNoXdJDE7KU36jOboNVncTonYvt05nVU8h/E4T
9oE9HIzLAHKM9ISD5dYkN+aY4+IMpRiHvgNn5a8omFjEmTlCJyG7MxQ2anAVoZXl
+3SSCCNR7m6ady6CKr8t1fVR3nHdgTs4+gaWBrejPexwAseEox/0Kq9Aa6ZrDY4H
K5Y93dcEirelwkG3TAUFvo1cvr0SVw4xgbfBxGVHqz1WrkRLWqPSub885qfCAc5G
wfd/eqzlm/nCEsdVh4uZUZG2RaeqKp5AejLUvkB1W1QO7fUR380=
=jmaE
-----END PGP SIGNATURE-----

--2qwkx27l7hkxso7v--
