From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 6/8] cpufreq: sunxi: Use generic platdev driver
Date: Thu, 21 Apr 2016 10:54:02 +0200
Message-ID: <20160421085402.GL13045@lukather>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <e82bf5994897cc979a67c72f09229b8b295bb69a.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1rguoi8KZGYj2k4L"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53778 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751282AbcDUIyP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 04:54:15 -0400
Content-Disposition: inline
In-Reply-To: <e82bf5994897cc979a67c72f09229b8b295bb69a.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Chen-Yu Tsai <wens@csie.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--1rguoi8KZGYj2k4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2016 at 02:13:52PM +0530, Viresh Kumar wrote:
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
>=20
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1rguoi8KZGYj2k4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGJUqAAoJEBx+YmzsjxAgcK8P+wXwPAAH1MouzshzwH7UB03j
TahzoANPQERnSZ89u6tgYOp+MveTp/lSIFM1YejQtwbDCU1VUl4nuPxC/l1UGsAk
7K8x27TCzN+/cdt+So5TFHmPOJVYHVyHvudWV4l1jgIpR9L0wuHr9CxDZlr9PeT7
ElaU0zOWf2hd2j+8fUIOVpGVFtKva4erdhbO/PuUVov6G8gjfdjkldQE7P7xk1de
vn8jfD+H6ZaRJvQNPEUjb0Gsp/NnVMLhNX6ipEl8W4KfVp1WyALmFyZztJVsP0vE
OH+K41Ijo4c/SdEK7+4paJc0rs2uC/mAc3nfnrVM66QPFhP4qU1q14QSYx5OczfS
7jrMN1ERTl7iSeSj4i9B6gt7hCI3Q9DzSdmW7mv0jB+hKCnZVoA0HmzEkTWX00v5
zWoyEPhwkXnPZbI+VKpSDhrklbilisWJ4JQoqLzzXOKBgzK0LKNUmZeUkBKDwjoS
6Dw1VaORhhNn1epyM8f13HUf4Ic1R7quLfNrEELqjN7QLdL1QqBx7usKchVVhk9I
8zj7zq+BQ/5OjIBhuGTik35KPQaPsX9Ywba+TmZWU8kVIB8KM5KG0GcbbDEEBiA3
lQgVJHdJWJyHc+wLL6Nrs7/4WdagiJKQOnCv0QtuYrDXCLXmP5oxIGM+/e5okPI5
gT8wIKbX1lbEElKtjn3s
=B3wC
-----END PGP SIGNATURE-----

--1rguoi8KZGYj2k4L--
