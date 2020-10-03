Return-Path: <SRS0=E5yJ=DK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CDC41604
	for <linux-pm@archiver.kernel.org>; Sat,  3 Oct 2020 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E25206DB
	for <linux-pm@archiver.kernel.org>; Sat,  3 Oct 2020 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601760220;
	bh=XOM1iiTCmlGn+kzb56sHfCoEltP/3d+b62BLvBc/MwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3jaOB3qVz5MS2qdmejMsqpKVleAFquEytP0UBgkrWQCpB3FGAQ2owmu0owknmWxo
	 GtS7ETSjN4E70mVIsIz1sDhKOycoBjiM3bx/sy7hBvW2NDZUmADI4wXwZMrc8hP5MV
	 MbvFmuPLX7ohbtzMrFA4U/vIy9PQoPXzwuKRhhnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJCVXj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 3 Oct 2020 17:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgJCVXj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 17:23:39 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F69206C1;
        Sat,  3 Oct 2020 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601760218;
        bh=XOM1iiTCmlGn+kzb56sHfCoEltP/3d+b62BLvBc/MwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v70+ZPsuxCZhL/PJC3oUz2XopDL4VJ1G/R9qucP21vAcIIZoizqMSmTFOEMJelHtv
         pHljq0lChWdkxwy1ft7Psk0TtuA9ng8B4wtY3wd9GmSpdrm2w+pQ1uBmpst1mS1Pun
         EtqnaRsjrhulkNmNwatX+RZ1SlO1jsg78IE55vVs=
Received: by earth.universe (Postfix, from userid 1000)
        id C04563C0C87; Sat,  3 Oct 2020 23:23:36 +0200 (CEST)
Date:   Sat, 3 Oct 2020 23:23:36 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_power: add missing newlines when printing
 parameters by sysfs
Message-ID: <20201003212336.5et7erdf6fihqscu@earth.universe>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fs3y3zgguzqvtvv3"
Content-Disposition: inline
In-Reply-To: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fs3y3zgguzqvtvv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 04, 2020 at 02:09:58PM +0800, Xiongfeng Wang wrote:
> When I cat some module parameters by sysfs, it displays as follows.
> It's better to add a newline for easy reading.
>=20
> root@syzkaller:~# cd /sys/module/test_power/parameters/
> root@syzkaller:/sys/module/test_power/parameters# cat ac_online
> onroot@syzkaller:/sys/module/test_power/parameters# cat battery_present
> trueroot@syzkaller:/sys/module/test_power/parameters# cat battery_health
> goodroot@syzkaller:/sys/module/test_power/parameters# cat battery_status
> dischargingroot@syzkaller:/sys/module/test_power/parameters# cat battery_=
technology
> LIONroot@syzkaller:/sys/module/test_power/parameters# cat usb_online
> onroot@syzkaller:/sys/module/test_power/parameters#
>=20
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/test_power.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 04acd76..4895ee5 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -353,6 +353,7 @@ static int param_set_ac_online(const char *key, const=
 struct kernel_param *kp)
>  static int param_get_ac_online(char *buffer, const struct kernel_param *=
kp)
>  {
>  	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
> +	strcat(buffer, "\n");
>  	return strlen(buffer);
>  }
> =20
> @@ -366,6 +367,7 @@ static int param_set_usb_online(const char *key, cons=
t struct kernel_param *kp)
>  static int param_get_usb_online(char *buffer, const struct kernel_param =
*kp)
>  {
>  	strcpy(buffer, map_get_key(map_ac_online, usb_online, "unknown"));
> +	strcat(buffer, "\n");
>  	return strlen(buffer);
>  }
> =20
> @@ -380,6 +382,7 @@ static int param_set_battery_status(const char *key,
>  static int param_get_battery_status(char *buffer, const struct kernel_pa=
ram *kp)
>  {
>  	strcpy(buffer, map_get_key(map_status, battery_status, "unknown"));
> +	strcat(buffer, "\n");
>  	return strlen(buffer);
>  }
> =20
> @@ -394,6 +397,7 @@ static int param_set_battery_health(const char *key,
>  static int param_get_battery_health(char *buffer, const struct kernel_pa=
ram *kp)
>  {
>  	strcpy(buffer, map_get_key(map_health, battery_health, "unknown"));
> +	strcat(buffer, "\n");
>  	return strlen(buffer);
>  }
> =20
> @@ -409,6 +413,7 @@ static int param_get_battery_present(char *buffer,
>  					const struct kernel_param *kp)
>  {
>  	strcpy(buffer, map_get_key(map_present, battery_present, "unknown"));
> +	strcat(buffer, "\n");
>  	return strlen(buffer);
>  }
> =20
> @@ -426,6 +431,7 @@ static int param_get_battery_technology(char *buffer,
>  {
>  	strcpy(buffer,
>  		map_get_key(map_technology, battery_technology, "unknown"));
> +	strcat(buffer, "\n");
>  	return strlen(buffer);
>  }
> =20
> --=20
> 1.7.12.4
>=20

--fs3y3zgguzqvtvv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9469UACgkQ2O7X88g7
+pojdw//dQ9BtbUc8f2f7SfslHm9n0RPIVKqSlelkWXvUcQm52R0ebOudWndllLU
QFK4OMQZDhF/9Tyo/l5tJKAJKbOUAM4NbP6TlFlapuP0WpVmaH/waQie3R4LYiGD
ORJboknaMKca189SmC8QCGDpsaPHTR0y4BVEYjTnYAPg/RbBdGCseYhrATTOEi2Q
DOu5T7qsyqL1AmlHVpet0eg40aLPBqmI/vmGJ3svzSeja0cvzEC8L8gbbybplwGr
ZtrE+GUUNEiA4SVTcdXVJ0Nwbv2yMWdi3N4gwS+9jW3hcJLvPfnjm90x0DrKN1Og
VrejrCdpaow7WEP2a/Lg4mC2KusdCdx4A4a5xYqNqNiIETehKimX3IlpjWVeQjqY
iLqZc3FC0cXuKWbyOJScYueOYn1v25gzYM3nvTKY0dPgsPM4l+o2FRhJaNHMf0lR
V8X5ogpnPKfUaipgd6s+rupo/b/H+EUKuqjW6I/eFY1M3UI0u86VDPXNvyzTrMSg
Y2EEYVQDGw2KfN+/y56VUTWn0ZJZBv8v5e0A2+HIyVJDZ2iOjhhf1M669ff1XFAT
sRQd6xq+iIpZjaZqDRMe8rmWJU5e3ARRWNtIliFde1YsYXwfBZ/tq/hMlDZuDEP1
EnjAsDzBHQZhZleDeipLTP3v17K28mvU5VcDhTrytzQpqBoM1aY=
=P9et
-----END PGP SIGNATURE-----

--fs3y3zgguzqvtvv3--
