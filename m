From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: sun8i: Add THS node to the H3 .dtsi
Date: Tue, 24 Nov 2015 09:45:31 +0100
Message-ID: <20151124084531.GK32142@lukather>
References: <cover.1448263428.git.atx@atx.name>
 <0fff612e26bf9cda9027a4175e16d25a0c2cc62c.1448263428.git.atx@atx.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1QzJaSEX5hKRjM1z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45693 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbbKXIpd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 03:45:33 -0500
Content-Disposition: inline
In-Reply-To: <0fff612e26bf9cda9027a4175e16d25a0c2cc62c.1448263428.git.atx@atx.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josef Gajdusek <atx@atx.name>
Cc: linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, gpatchesrdh@mveas.com, mturquette@linaro.org, hdegoede@redhat.com, sboyd@codeaurora.org, mturquette@baylibre.com, emilio@elopez.com.ar, linux@arm.linux.org.uk, edubezval@gmail.com, rui.zhang@intel.com, wens@csie.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org


--1QzJaSEX5hKRjM1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2015 at 09:02:52AM +0100, Josef Gajdusek wrote:
> +		ths: ths@01c25000 {
> +			#thermal-sensor-cells =3D <0>;
> +			compatible =3D "allwinner,sun8i-h3-ths";
> +			reg =3D <0x01c25000 0x88>;

The datasheet says the size is 0x400, any particular reason to have a

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1QzJaSEX5hKRjM1z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVCOrAAoJEBx+YmzsjxAgHn8P/RNoAmuUKvT34eXQ5cFmz8cd
LS1DDrfvGkdHC9aOL92B8TSnyetBOS68tI3eLkW2sgagi1qbj0o1snjf73P8nFCc
eTGSYT6J4ewmaPuPfnEOYidGHYpk1rfoUfvyDr6WtbKZvdiZV718LFsF0m+wPJTG
Qi8WiYIkfdwHRfnxiuaCeGJ1dbKF2pXtP3aGc3EkiBP7hFfaoXcl4KFyc0+qUvTw
1aWxBkV8EawfdK4I5C3OnCB/8bPZb8bsmlMhPydca23SnYBT4wYcT+oRrlOpdvmj
FuXqVSBw1agDZ7t2XaxW0rvJdB0HqAUx9yZNJqA+3AlCSQXQ+NfUSZi1mkd7z1R4
X6yIDCI82WdoJcOtrkIgd+emATYZVjvrmNU7CH+O0YFYUKG4TWRJqk+FSmu89C4i
ZXjoLruE4sOmGZDyUM/PAcKnBpTdWnQd2IvHyar5KUsKy6GB5xm+UrWLN4jJUMW6
e/B4dgEYkvUunRorQ5JuXHDur79CJieHQ85cOZ8zf/JZ8b4JJRtXyJORCSmZ7chy
57DADYWMi8+X48cYtKfT80S/Be6KOIcNvmDWsVUobclwy9PElifJj+UBnDOmqK47
qHB+21HHqkD5dvaZS0ragyeN4XZqqz055KjA1SswI6oZ855Zr2I83UXFOkLOQodQ
9EuPNWhW5r4/a0VyjRpi
=f4uw
-----END PGP SIGNATURE-----

--1QzJaSEX5hKRjM1z--
