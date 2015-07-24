From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power/ltc2941-battery-gauge.c: Use the devicetree node
 name as supply name
Date: Fri, 24 Jul 2015 16:54:49 +0200
Message-ID: <20150724145449.GF27569@earth>
References: <1435743653-13967-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34327 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbbGXOyx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 10:54:53 -0400
Content-Disposition: inline
In-Reply-To: <1435743653-13967-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jul 01, 2015 at 11:40:53AM +0200, Mike Looijmans wrote:
> Make it possible to set the name of the supply from the devicetree.
> Like other power supply drivers just use the node name. This makes
> the code smaller as well, as it doesn't need to allocate memory to
> hold the name and allocate a unique ID.

Thanks, queued. It also fixes the missing idr_remove and kfree in
ltc294x_i2c_remove(), btw.

-- Sebastian

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVslG5AAoJENju1/PIO/qaw2QP+wcGv3rMfwHr6Kd+Gbrkq20K
8uhSkfccowi94Oclqw+BfzW1n+daS4vaV6cCyDUMYex5VRDlmk/qigGHxreh8EWM
A7HZSmX6bY4sZUTKZkM/FuB+Ywy9X76ggLKksV66PXMausHbrPYf6iel2RzDkwrO
EKMYqIWcm/qt57b5Eff+TSzm+gowAl3XhnV8a37aN6iLVSIIj0pKcZB0Yb4Xhjcz
HIWBXvEnOsIN1IvhPDq12AgZLMW63ERxwBTqfL7rpfxZXD/dynNMiiZWb9szROoA
muIeUdTKJoefHhgtR16OfdmeL5OtiRXHf6wzBeN8z2J97EwJTkQcxDFVnauo2WvO
POgMdT/RrXbzP3Nrs0oXbZ/R1VbtQ3jnUM7pesfmN9neyjwXhg/+gLtDA95FHoyH
NFRV/IHsXChQ/NJoXaAHe18oUW5Sk1vLK62ZQ3W3cJjGxi0lJav+Ln9PVUbL+H3z
Vb2BkH2lgoU4QrOH2xYfjs+QEDEK4ksn8V2U8UMzyGuQ8sNIjfjZ8P3q3stGSQIE
bUMr91G7F7oIKcPF0UPRkfwe9x4Nz6QkmpxU8IVkdn+T9OVuLDLGgyhwg/5+4AtW
cXX0zgZwX+6pG7dPObrsFMENMPu0gQ70VQJ+YQ/dGDQ0MXqeh27hedy0hud9hV8h
TrCFSrP9jXHCIv0HXUfF
=x8Sj
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
