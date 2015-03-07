From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] bq2415x_charger: Fix coding style issues and add new
 charger in the list of supported chargers
Date: Sat, 7 Mar 2015 19:38:14 +0100
Message-ID: <20150307183813.GA5233@earth>
References: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54321 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbbCGSia (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 7 Mar 2015 13:38:30 -0500
Content-Disposition: inline
In-Reply-To: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 05, 2015 at 01:23:55PM +0200, Anda-Maria Nicolae wrote:
> Hello,
>=20
> First patch from patchset fixes coding style issues: removes unnecessary =
else after return.
> This way, the coding style complies with checkpatch.pl.
>=20
> Second patch from patchset updates bq2415x driver to support bq24157s cha=
rger.

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/0e1392d9df3dca4c1774a0c61fd=
85fce81cb88cd

-- Sebastian

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+0WSAAoJENju1/PIO/qaRdEP/RfGD5YN3yl8uCRAdDb80t+/
mzfGjjyzNK98W14INaIoZmlNlau993iGJxA3SSGKw4OEasyT9QL/BlqN0e16QLtg
DBgFFwZE+M04T7TKp2v/IvyzfqYglNXdeMvFLNUhWOosCTvkTIaudDaFO81+D3pn
bnHaO3+Ce5q1W1VUh8bqFl1LhiL7tIXTiy0+2YP+j80yQWIJ5igs7aph0qFwOyen
asCR5HivoV9zHQ8eo8k173g16lFrzn4k1ki0MycoVo+WAOuBaNzpaOLESEcckxk0
FE8StQqXt0TNZGm0bxherc4F9Sc+GrSj4yKNPg9Lumm7l80zLInotZfsJe4ev+K9
yPLdTrNVB8VGiwkWGOGjO0YK2AeNgspL1GC3s/+T+xFxEZhywLzT6uile75tP+JW
CPXXpNaQx0DotpQ+apauNuasZLrMFzOTnh+C4RY2u7wm31mqnhpxpJz2M6ZMLKRI
yWcg1e6UChv499gn5rPmhs7fr7C6WyCuts7rlRtoeoxue5OE8aJbI99CybM5c4YO
dzRbXGu3uN7dRTjS2XWTJBXWBXMuE5TV4cr3rdFAJhUUp0wN3MlsEwWfkMJEQBJB
qH1bM7Fbg/FHKI0NYFs+dk65B58TwxrTbVoEkqs66Vl/X3ucd1LEcCW+urzg3hy+
qtYRX4za39LAS/5BE7uw
=v9Rc
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
