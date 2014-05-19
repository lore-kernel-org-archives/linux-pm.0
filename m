From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
Date: Tue, 20 May 2014 00:07:29 +0100
Message-ID: <20140519230729.GD30457@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-3-git-send-email-broonie@kernel.org>
 <CAKohpo=4c=eDOMxxFi37mLA7LViJ-P_Rb42Yt5ARa_qgiGU8eg@mail.gmail.com>
 <2437793.vfcRUkFCet@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33612 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaESXH4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 19:07:56 -0400
Content-Disposition: inline
In-Reply-To: <2437793.vfcRUkFCet@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:

> I've queued this one up for 3.16, thanks!

This will fail to build without patch 1 - it uses the stubs added there.

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTeo6uAAoJELSic+t+oim99GMP+QEWbqmya1/JJn26voO9c0Ix
8XLwefNIE7kqhMIESDJFiUP4WvIbTh/GfxXHYuZML4n18lpAnAnJPChbSTAuVVUC
v+gzSmRumTCOcTiMtMNKwtS2PKlg6g5eTvmWO9tFNijHEy85CxOrXnM5lPI1LE/q
ceq5LISStcWPuJUt28bgpSrea5XIiMuK4H476HBe5AjXr7L4r26WNzGESIAzjaQ5
G+D6vEqghj16h027UbdTzWaz+eNnkNDynDbVZPIvB8X8hWhDs8YsIsNbXJwTfjgh
2CVnhsZ6BcoV6AtPZfiSWxT/r99UfxoVa1vUB1xJ6o40BghyYyTLoVQAbQxtRPbg
N6huVzOcwWPvTGc44LtZXH3kE4tQkW1eEzvSPSHAWl3M881KZzo5k0Z7+em3bgi7
+ndBaTpYEHzzUxSu1XwNiB5BTXDeZabVBhmWIqVKEsfF8zhKIM53s1XkCkoKolpQ
9JwK0Txt06hBaUD8RzEsSedh8bDlwp176vx1L2Kf47BKUNGff7DEKFQ2rRl271el
GfmpxrSrYoEom5ifWzMuAyOLnVNl/C61CRQXveZoWSRW9mD2CDWmMXVh6rZL5bL4
kKV1HowZKSnJTlTIYtnJTOE/Wy9uCiZEcpBBQaVSGP5HGHUwAVuvfJALXheVlUmo
5ADTfpFoHPQFSfoxO1F2
=vWQz
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
