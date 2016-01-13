From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/17] cpufreq: dt: Pass regulator name to the OPP core
 for V1 bindings
Date: Wed, 13 Jan 2016 11:15:35 +0000
Message-ID: <20160113111535.GH6588@sirena.org.uk>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
 <20160112015328.GQ22188@codeaurora.org>
 <20160112071159.GO1084@ubuntu>
 <20160113004335.GD22188@codeaurora.org>
 <20160113054750.GD6050@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C+dxB3FEDSxkOkFg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51041 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbcAMLPt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 06:15:49 -0500
Content-Disposition: inline
In-Reply-To: <20160113054750.GD6050@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com


--C+dxB3FEDSxkOkFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 13, 2016 at 11:17:50AM +0530, Viresh Kumar wrote:

> - A OPP-user driver doesn't need to call any special OPP API and OPP
>   layer can allocate the regulator for it using <device>-name. This
>   will make all drivers (that follow this nomenclature in DT) very
>   simple and straight-forward.

Viresh, as we've been through multiple times supplies should always be
requested with the name of the supply on the physical device.  Please
stop trying to create ABIs around whatever Linux internals you're
currently working with, this is getting repetitive.

--C+dxB3FEDSxkOkFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWljHWAAoJECTWi3JdVIfQ0xgH/RdsaOZsLi+xKPxGiMx6i0Wj
QVxWc2JNVjSBvf0cIQbsDqAonnQY0VsHwG0XdCArnQyAtCjvEoGRktgLjCyk77X+
Wnvuil7T55BzITsc4lnJ/znKujuHZZ6+Kq0XS8ZUa3PIlBZG4eEhKt5h1aAK7sjq
lxDUucEHxXv1zDX3K8TLQDJ/MA1xCqwi7wdz7n3L6frE5SdHnm4DLYYra80YS97o
0j96cW8pjuFNZCEZkX7r4tERY0h5gJZvC8c9Sll1c6mle7EbeuuWauE5H+ybz2Qt
JidHppfZ0H8gkgLCDz4wPjl41KtGO97LjKFOhKEWQA335MgUAakBI/Czn75NoKw=
=bjOU
-----END PGP SIGNATURE-----

--C+dxB3FEDSxkOkFg--
