From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [battery:master 35/35]
 drivers/power/supply/sbs-battery.c:795:15: error: 'struct sbs_info' has no
 member named 'dev'
Date: Thu, 1 Sep 2016 16:09:32 +0200
Message-ID: <20160901140931.feh5cwn74lvoju7q@earth>
References: <201609012149.soN2uERO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxdaonei7gdpghjo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753066AbcIAOJk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 10:09:40 -0400
Content-Disposition: inline
In-Reply-To: <201609012149.soN2uERO%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Phil Reid <preid@electromag.com.au>, kbuild-all@01.org, linux-pm@vger.kernel.org


--sxdaonei7gdpghjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Thu, Sep 01, 2016 at 09:40:53PM +0800, kbuild test robot wrote:
> tree:   git://git.infradead.org/battery-2.6.git master
> head:   6fa4fc2e18d7a9d2a06e6cf7be39fe6b299e210a
> commit: 6fa4fc2e18d7a9d2a06e6cf7be39fe6b299e210a [35/35] power: supply: s=
bs-battery: Use gpio_desc and sleeping calls for battery detect
> config: x86_64-randconfig-x013-201635 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         git checkout 6fa4fc2e18d7a9d2a06e6cf7be39fe6b299e210a
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    drivers/power/supply/sbs-battery.c: In function 'sbs_of_populate_pdata=
':
> >> drivers/power/supply/sbs-battery.c:795:15: error: 'struct sbs_info' ha=
s no member named 'dev'
>      return client->dev.platform_data;
>                   ^~
> >> drivers/power/supply/sbs-battery.c:796:1: warning: control reaches end=
 of non-void function [-Wreturn-type]
>     }
>     ^
>=20
> vim +795 drivers/power/supply/sbs-battery.c
>=20
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14  789  	return pdata;
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14  790  }
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14  791  #else
> 3ddca062f drivers/power/sbs-battery.c        Rhyland Klein       2011-12-=
05  792  static struct sbs_platform_data *sbs_of_populate_pdata(
> 6fa4fc2e1 drivers/power/supply/sbs-battery.c Phil Reid           2016-09-=
01  793  	struct sbs_info *client)
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14  794  {
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14 @795  	return client->dev.platform_data;
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14 @796  }
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14  797  #endif
> 6c75ea1e5 drivers/power/bq20z75.c            Rhyland Klein       2011-09-=
14  798 =20
> 297d716f6 drivers/power/sbs-battery.c        Krzysztof Kozlowski 2015-03-=
12  799  static const struct power_supply_desc sbs_default_desc =3D {
>=20
> :::::: The code at line 795 was first introduced by commit
> :::::: 6c75ea1e582d12120072cae742a0d63ea8ac8c65 bq20z75: Devicetree init =
support
>=20
> :::::: TO: Rhyland Klein <rklein@nvidia.com>
> :::::: CC: Anton Vorontsov <cbouatmailru@gmail.com>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

I fixed this up by modifying your patch, so that it returns
ERR_PTR(-ENOSYS) for sbs_of_populate_pdata in non DT case.

-- Sebastian

--sxdaonei7gdpghjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyDaZAAoJENju1/PIO/qaq84P/0Xk6yRCAZTkSySaWp9EwYkq
OyxwX9FP1MeAKu9ZbOUoL/JObTAq0JbqBW6Fx34JvitXMOxyjPpbmYzOuYlTQXeW
MgJwEq/S9YLjRZw/kl/9p9B+z5j65g8FMF+7WO8zgKgQcLe5B7qtTjGTGHi/Hkg1
+O2MwgdELTiNzKmBnBSYZX7rRYfbL/Q5ZP3KJbnxTUrFUr8pQhL/qP7ilQeFY/tX
adbW5D7U8ktjLaPcK5Mkh4OU9ndWgeQ8zhIn/Gwmnu1vxzkyuzo7XBgQqdCCCrpd
8UocFQ3XhM1KaHg6GgquucdBKwTyRwrX6lvWy/2il1voL+Iiv0iCdivUO+3P955l
g9m//9i7m5oOVV2fvlQ1co2ulos1kdln5TrWX6Xp+pmDm2qoc56RxY82ozMsyPvn
bYQ36khuefoBRJryLw5gHZCHUPIybyglmYEaH8KyZC9lxWUzuyaPpwv4DFkoGG3R
+Pbebl/ZeZMQcFo+pe6vgbhhP+a8WOK3KGwxRGIryQqXcYwkz2tONNklLVqXxSxC
dPT/fqaw5dRKr3taaFQcyG4xmjg75bHGojeFIDTTsMVYkYgoPsx7ChyxK34vFFBd
TwbTjIoCU9sSzhiuXsnv75FmeSX1VYGzHMaBCnhaZqnDDsZHELRYIRRGzHo99/9t
aLalDyoDyDKYXW5Czr30
=AWMJ
-----END PGP SIGNATURE-----

--sxdaonei7gdpghjo--
