From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/3] drivers: power: twl4030_charger: fix link
 problems when building as module
Date: Tue, 22 Sep 2015 23:29:38 +0200
Message-ID: <20150922212900.GB15646@earth>
References: <1442953171-19718-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52672 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934130AbbIVV3t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 17:29:49 -0400
Content-Disposition: inline
In-Reply-To: <1442953171-19718-1-git-send-email-marek@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, linux-kernel@vger.kernel.org, neilb@suse.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Tue, Sep 22, 2015 at 10:19:29PM +0200, Marek Belisko wrote:
> If either twl4030_charger or twl4030_madc is configured as MODULE,
> we get build (link) errors.
>=20
> To solve, the direct call of twl4030_get_madc_conversion() is replaced
> by a call to iio_read_channel_processed().
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
> changes from V1: added missing iio_channel_release + document and add new=
 DT bindings

That was fast :) Patchset looks fine to me except for one last
thing: Let's make the iio-channel optional, so that old DT blobs
are still supported. Also the IS_REACHABLE(CONFIG_TWL4030_MADC)
check can be removed, it should no longer be needed with
iio_read_channel_processed().

-- Sebastian

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAcgZAAoJENju1/PIO/qaJn4QAJQVkPeQMwlPmqqcjCuC+pC7
r0KH63HVGJGbNlaqNCHn0rSSv0F0UbKjJKZ1tyM4bYrFTPJChSEnNS7mc30m5stO
8AQ4JZZNQd5YP4/RRgQf85dHBH16CN0hlL3v2VPnAKbs9+7w6mkC/kXvqSXoPftE
XNn0FT5byFQhCxE3i1EBcggijhmUqAyfycJQsakzjOX2QORFblhvP7Jih/7n6OdR
9PicTYvHbAdBP4FR4Gg54NpbdLooeOlKhKuF90IuaqMr89K1tn1oHaK8Z2Lab0pq
ice+7U4d7M73lalsNS6qLw6N8TG6RnNfdtgNLqzQYuxsWPvzE7M3bz/g2VrtQK/F
1H6q2ff7+3iZm3wokFRTAk1e7/1HeBA0jWqjcRLJ7Kl0w08Msv/Cs5ZiiwBHFGpg
esDqTASWhHptMoVHjV9C3WBGe/805h0DhpiijnQCA280qaACh10xf2mUwdW/MRaD
U1rn47+ySYP7d3JaAnLnB3hL01cE7Fc2wbQwHGvukseHCsIQI4b+VrZArPFNXI15
ZD3Jpdi+W5BuCoadYlTpcKLnSas6A4Y/JXuUAZvxf8MWdq/xLXMOh1ue7sUFATWA
nww3WNG/Qh47lzkRs8dUr+6FL+/hUVI02uSV40c/CtQtF8CgoMtMD7Rv7WGVXQ1p
dwFJbWLfH3zYM+w7PAqY
=jM4l
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
