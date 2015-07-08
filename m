From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: bq27x00_battery: Destroy battery_id IDR on module exit
Date: Wed, 8 Jul 2015 18:10:14 +0200
Message-ID: <201507081810.14511@pali>
References: <1436368700-30852-1-git-send-email-jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2696556.BqSSm5ePSW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33441 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225AbbGHQKS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 12:10:18 -0400
In-Reply-To: <1436368700-30852-1-git-send-email-jthumshirn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2696556.BqSSm5ePSW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 July 2015 17:18:20 Johannes Thumshirn wrote:
> Destroy battery_id IDR on module exit, reclaiming the allocated
> memory.
>=20
> This was detected by the following semantic patch (written by Luis
> Rodriguez <mcgrof@suse.com>)
> <SmPL>
> @ defines_module_init @
> declarer name module_init, module_exit;
> declarer name DEFINE_IDR;
> identifier init;
> @@
>=20
> module_init(init);
>=20
> @ defines_module_exit @
> identifier exit;
> @@
>=20
> module_exit(exit);
>=20
> @ declares_idr depends on defines_module_init && defines_module_exit
> @ identifier idr;
> @@
>=20
> DEFINE_IDR(idr);
>=20
> @ on_exit_calls_destroy depends on declares_idr &&
> defines_module_exit @ identifier declares_idr.idr,
> defines_module_exit.exit;
> @@
>=20
> exit(void)
> {
>  ...
>  idr_destroy(&idr);
>  ...
> }
>=20
> @ missing_module_idr_destroy depends on declares_idr &&
> defines_module_exit && !on_exit_calls_destroy @ identifier
> declares_idr.idr, defines_module_exit.exit;
> @@
>=20
> exit(void)
> {
>  ...
>  +idr_destroy(&idr);
> }
> </SmPL>
>=20
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/power/bq27x00_battery.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/bq27x00_battery.c
> b/drivers/power/bq27x00_battery.c index b6b9837..99180d2 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -1106,6 +1106,7 @@ static void __exit bq27x00_battery_exit(void)
>  {
>  	bq27x00_battery_platform_exit();
>  	bq27x00_battery_i2c_exit();
> +	idr_destroy(&battery_id);
>  }
>  module_exit(bq27x00_battery_exit);

Hello, I see that none power supply kernel driver is calling=20
idr_destroy() at module exit time. So if this patch is needed for=20
bq27x00_battery module, then it is needed also for other charger/battery=20
modules...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2696556.BqSSm5ePSW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWdS2YACgkQi/DJPQPkQ1LfSACdHYWWSFFnJkoHABA2nK0RC+cS
NAAAoJ7QfjGwb/H0zAd9QLtyBLuoZUu2
=q5+K
-----END PGP SIGNATURE-----

--nextPart2696556.BqSSm5ePSW--
