Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20400414429
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242880; cv=none; b=tJZRqD+3AKK4vc0rZCuvdkz+e64R2WLxnfZw5LpY+8CxzK2abXAJW7GCYHLfl410im14SEXBQW/flHitglcIWzHu119m3N3V/3CW0BNzVEWldxwF/KG6BwMpwQ+VwQWeIwUbwml1gJFVDh1oOk76LqgCKgXlRveXM75CDgn2fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242880; c=relaxed/simple;
	bh=6CPiYuuTXPIWdsAfIiOCV03Lg6iemO+IJl3GZDw3XnE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RPFIo9GFzA8unpdcFqCYhIoG+WnIWUrEGLeQz3FvP83+g7pzJz4B35kBXwQekX1ogjQhzTpH/eDL8oh0b0iVrfPj1YiSA4K/ADufuHKaxNw91vdQl1/Kq2onXDfbewYrB8ho2sGMo/nkbGK+QXhsyKEXjYRp9xWdTlbzxnJc9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVhUBfBp; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVhUBfBp"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso763964a91.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791242878; x=1791847678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B/zPhhqSzZgiqvCy2v2R07ljbiJnf/kj+cRVGXz4l2o=;
        b=dVhUBfBpQHFBCdRxCHVQyN/oEX+e9kKMtc6mMLiEovOZjkaA3dP6WT7ELYFfz+rIcG
         LbEUJ5g5hJj50kCLma91uM/oidP9T5hyWPQ8PBX6w8U7Hj2RQfTEh4pJ0l1qHYT/Favj
         J0yz99S5Imjg9n9D1VDfkpzcqV9sMhKRz0QXdE0QS3x2jdtBenxDa2pCYW+NiOKUctUS
         5WyT++KjqO+U8LMOBE6NvTI7EPaE0sCkhhgBl64lbb/KEkc1Pf0Ckh+Apnk2NYj0lC0n
         Ncu82QhKEHa7hMtz7U8Ib3or9buvzo1QZKM12KRV93V7Y2hEqsWWEMKKwQZfLYFEQxYy
         gNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791242878; x=1791847678;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/zPhhqSzZgiqvCy2v2R07ljbiJnf/kj+cRVGXz4l2o=;
        b=Rv2df+iPOIIjdF6C2OWruVZxrv8JG9JT2IXXI4iaxiIzyarBfaLzL5SWyzlcxCwy7f
         pQpaT5CUjLCnj2jzHw52c83A4Zd5ahV6TY/995rhZaj6QANHTvkAbB+3jOh4brQBoEFv
         OhG6GF/WEM2DfmNzFLYN+7wa7Hcuz9dn1bHb2jIKwRX/E+ytDbTapzO3/RG0JJ9qBPNc
         QCAJGh5CQrGj/YWrMgSW7O18szX9UUQ1eSBACWJF3ZY8P3V/HKyWyOl0zDr5w0+0vVbF
         cemDp9Bn0JYBVY9PtaDjFl74sBp+9u79Nmkxbsp68XJKS9IlHyK9BsKZ3G9X4j/8N3b5
         xdFw==
X-Forwarded-Encrypted: i=1; AKwUvByCzqAusNzHc0in6ByB+3STrSbfhYdbuKHlZSPL7fNm2RyvhjCVeKeXGJcql/S4sB4oqEevTB8lVg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIHpUTkWtbtak4bRdv7K4Gk0ChFEZ6QgCGCq/Gd3/pjnMOLPB6m
	emnh9DacYWHAQr4rl9hxVPZJl4QeX3zrUDY2XecorOCOlsPNUd/atsd1RHBnucGAWGl2WA==
X-Gm-Gg: AYBFou1HIFOdVyFJ3x9O2Aj+kobxUonDaJ4Wob5n8V2y2vyOf4U+dA2g+WWVwQ6OKYw
	OqO5t0PKd25xCC4iSk7YaiI/ItEL8ZaNZy2X/9rCDlQ3XI0UbVKCPYJlJ3A3pDtOV72svD5Sczv
	FMpElpxdIkfYdlzUX/b1398KNV5Jz++3fRQVbgxf2jFAjjdIb9l8JEbw1QQLVSwuFtYornOoGZu
	QoCfrlSr7XqP6pLJyq71aBOzbbxVuWpsVg9qE+hyppwLXJqWbKFlspDHUUBUkulwp+HlSv3Grbp
	li2g2aMV91VEXSFt//UBrWtdHU4UL585UsOUTvPBZiWx604s3rG0bcmKWOBh3usDW8BgogCoBMt
	f0O+BphGB52wGW3iC5XCAfxVJKRJghrvO3qFZ8aG4ayNWHuNqiF5nIBe60YAmKaZKbnVYRE/5HO
	O4mabZIeoDFY9dkhi/ihCtyoR+4WH2R0k1o8al3QE61xZXMP+W+a5RvBg4NgDF6EZYXj/eqTbCW
	D874LAf
X-Received: by 2002:a17:90b:5144:b0:3a0:a055:1759 with SMTP id 98e67ed59e1d1-3a6cecaa898mr10080837a91.40.1791242878358;
        Mon, 05 Oct 2026 16:27:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dce36d07sm8230776a91.1.2026.10.05.16.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 16:27:57 -0700 (PDT)
Date: Tue, 06 Oct 2026 07:27:52 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
CC: Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_pmdomain=3A_rockchip=3A_mar?=
 =?US-ASCII?Q?k_PD=5FPIPE_as_active_wakeup_on_RK3568?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260925041751.495818-1-coiaprant@gmail.com>
References: <20260925041751.495818-1-coiaprant@gmail.com>
Message-ID: <382B43FA-B225-41C5-80B6-944D9D2802CF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 25, 2026 12:17:51 PM GMT+08:00, Coia Prant <coiaprant@gmail=2E=
com> wrote:
>The PD_PIPE power domain on RK3568 hosts the XPCS, the PCIe
>controllers and the SATA controllers=2E  All of them can act as
>wakeup sources for the system:
>
>  - the XPCS for MAC WoL, through the SGMII link
>  - the PCIe controllers for PME#
>  - the SATA controllers for hotplug wake
>
>The domain is registered with active_wakeup =3D false, so genpd powers
>it down during system suspend even when a consumer is on the wakeup
>path=2E  That kills the XPCS and the SerDes, which breaks MAC WoL on
>RK3568 SGMII boards, and it also powers down the PCIe and SATA
>controllers while their drivers still expect the link to be alive=2E
>
>Mark PD_PIPE as active_wakeup so that genpd honours the wakeup path
>of its consumers=2E  Consumers that call device_set_wakeup_path() keep
>the domain powered; consumers that do not mark themselves as wakeup
>sources are unaffected and the domain is still powered down when
>nothing needs it=2E
>
>Several other Rockchip SoCs already mark their PCIe and USB power
>domains as active wakeup, for example RK3588's pcie and usb domains
>and RK3576's usb domain=2E  PD_PIPE hosts the same kind of
>wakeup-capable controllers on RK3568, so this follows the same
>pattern=2E
>
>Signed-off-by: Coia Prant <coiaprant@gmail=2Ecom>
>---
> drivers/pmdomain/rockchip/pm-domains=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/pmdomain/rockchip/pm-domains=2Ec b/drivers/pmdomain/=
rockchip/pm-domains=2Ec
>index ba66ae719428=2E=2E16ef0a235f0f 100644
>--- a/drivers/pmdomain/rockchip/pm-domains=2Ec
>+++ b/drivers/pmdomain/rockchip/pm-domains=2Ec
>@@ -1296,7 +1296,7 @@ static const struct rockchip_domain_info rk3568_pm_=
domains[] =3D {
> 	[RK3568_PD_VPU]		=3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false, fals=
e),
> 	[RK3568_PD_RKVDEC]	=3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false, fa=
lse),
> 	[RK3568_PD_RKVENC]	=3D DOMAIN_RK3568("venc", BIT(3), BIT(7),  false, fa=
lse),
>-	[RK3568_PD_PIPE]	=3D DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, fals=
e),
>+	[RK3568_PD_PIPE]	=3D DOMAIN_RK3568("pipe", BIT(8), BIT(11), true, false=
),
> };
>=20
> static const struct rockchip_domain_info rk3576_pm_domains[] =3D {

Hi,

Gentle ping on this patch=2E It was sent on Sep 25, and linux-pm Patchwork=
 shows it
as "Handled Elsewhere", but I can't find it merged in linux-pm,
linux-rockchip, linux-next or mainline, and I haven't received any review
feedback=2E

Thanks,
Coia
