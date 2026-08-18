Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D387427FBD
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043552; cv=none; b=VQf4NaiFUimYByWLW33flfPDdON/7Mg2G6Ipt31GVaqc6IlTl5ChzLpfb2pKrOElwOJRG7LGZu0Ai7MY206IyBFbiQkKcpxGGuF6opStJWxYwVWsWZGg1QUWk1AGHk+Co9LyMMuXrkK/ahmm7GWaA87bMVPwJmcznP8B4WaD7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043552; c=relaxed/simple;
	bh=Subz9kQAjDVDz99QceolixIbPPedVcJymvxPaJCPSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNffzFqqQdpeewRyRAHpadUscDklihdzW8zo9Fh0BeuekYdJMDb6bXdol6L6Yo9W9UnYplptDF3Iz4cupnqQoyygZszKIwAChP33v0EtwtNd6nsBE4jk6KVOo1xiul7vhX7na6w9fHtXbsL3o23GK7T8lhmvVdQbc3X7ZnnOOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=h+E7jhTS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="h+E7jhTS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f84023916so4155015f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787043549; x=1787648349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+Aet+yk5wErYuGPUVzhzsTqySNhCGJLGb9Ej6EWM+c=;
        b=h+E7jhTSE/BLh5i57aigm4X6YcFKgOnZo+XrtAba1lFMwq+J/OEN+4dzWovKHW/tdy
         ubx1eiGNunD7mf5MSFemQcWorK/Z1Orrkq11sJzAV7xcsJETwE5WmyZK6tz2LTVOdh+g
         liz2uYaSy9eGVw1XQr0RJndJcSmTVXEzYNg9MxQFKb45bizlscH4/9Rx6gCyg5MY2T69
         Teo1LSAWYcdTIJEpcRjqR2VfTqFLQhH87qOFHcZmpdj1loKcTHKBoUsLdHocrPtEH1ul
         iFK60hmsWrmJ46V78wjtQgYgHDctmTllNZP0X3Ui/Hr3yqgZFzGfEV7ZsjDNdou1cG5A
         /Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043549; x=1787648349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+Aet+yk5wErYuGPUVzhzsTqySNhCGJLGb9Ej6EWM+c=;
        b=A+wJ4MNj9ausUQ8I3EA4FDeXQQX/Bidejfh+jSVTuEeevGyjV/QgSFC6msOsWq1LHX
         tOLD3EF3Ij3g/M3+EKjDFKmigQan4jyzt4q97kN6HT7squeisUVL/3uIZh8yGbZjNBd3
         Iab5qWq2khueWn7/biRJC+I+mxcdPUgWbAA/MExYWm9T4cVlSAEpMmuNQbFrcWhP4R29
         K/sZnoVT7co8H5VLaeRaDAoGe/22bL6FT6VHgddsW6MiXG46M6lXItJ7p3NYDXhjNTye
         PduZ0AI013M88KIxNTVcWXP+wXUMWQBfgj5Qt555L6lTR0yIXM7sRCDbF/ga8LD7oxfX
         zXng==
X-Forwarded-Encrypted: i=1; AHgh+RoSekjnS261jKkYpp0oZRtUhpFTMHi1SO8xfDc0c5w2fLMWCt037VazWr0bOSw7WApZBYEZc3xuXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQnjWRMONhMGWlbyDFvgBdyJHiGZFhcKeVI5k+L8y5/JPCQpF
	/0+mf0DlaJ6sjMJO6ieTlD+bTmcBnO1YuEZG3WVypbhe+5yXoSL/a/ZLndKCqMU3t6q3dQ/p651
	UMM1OSFs=
X-Gm-Gg: AR+sD12uZ2etTcDiZcbTJHDXt5ChAr3znx3lkXBoseSZFTwJgdgeGrmhg9g3n0llZy8
	vf8b64HGIeuea/+TQ/OoG+maMg/4IzId44xdIZM51x+BDUzGa199SPzZ6rJy+6Yo9ZLv9aNxglf
	pGzP3unaIBuLncqTOJpfcp2N13CWDom8HjPO3GoGYSMlC43Fqeu1G0OEzflA0xb70hQhfPqBb14
	ZqmsHXS/PwMmlC3o78KsnY1XxdC99iD+eZlaAyLhCrkgzmeDgcTYptnoyWEMcv63citIQFnCnRM
	PSNTNJabQFiIxLQmwHEE2JUr1YSxyLfmELyhBYq+rM+PVsf3PERo/tIv6rpWSOkufePc2mmDDFD
	VND4seQfLckE/DjgkGU/v6Q+UlxvWA61FA5MPWEJdAe8eCSFzNu/teslF2hepE7viMKFBTYMl0l
	rx88gLZqP0NJe+LTiwqzOpa0OFxBBPTw8ORDsNTchyv3ym7mruxNnJy/C/rtFfE9TphK4mSNdbW
	E3v6mr6YctKVok48hhGwg7l+S8Q8qCva9bbclYzdqvG+NoN2QLi
X-Received: by 2002:a05:600c:848e:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-4999fb3f78bmr112284285e9.8.1787043548729;
        Tue, 18 Aug 2026 01:59:08 -0700 (PDT)
Received: from localhost (p200300f65f01710416869d85a644e839.dip0.t-ipconnect.de. [2003:f6:5f01:7104:1686:9d85:a644:e839])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49987b278fbsm215087975e9.2.2026.08.18.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:59:07 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:59:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org, 
	zhangqing@rock-chips.com, royalnet026@gmail.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
Message-ID: <aoQdns-GHS3fg5BJ@monoceros>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-11-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvayaecgmyelikx3"
Content-Disposition: inline
In-Reply-To: <20260817113603.1436067-11-gahing@gahingwoo.com>


--uvayaecgmyelikx3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
MIME-Version: 1.0

Hello,

On Mon, Aug 17, 2026 at 11:36:01PM +1200, Jiaxing Hu wrote:
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99..0096c4ab1 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -6,10 +6,12 @@
> =20
>  #include <drm/drm_mm.h>
>  #include <drm/gpu_scheduler.h>
> +#include <linux/mod_devicetable.h>

Please don't use <linux/mod_devicetable.h> but <linux/device-id/of.h>.

The former is a mixture of many subsystem specifics and thus a
dependency-hog.

Best regards
Uwe

--uvayaecgmyelikx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEHtYACgkQj4D7WH0S
/k4U9gf/aUhrYYFY54POvnsxnelsCZk9pbdIP6pqEh4NpwVQM+NfUIh1SYqcLXIf
NqdrFegte49P8wGlByYbp2BP8P+Vh/KdPn+VPTi15o5ivhF6/lS1s3Smp5hwDS1N
lDMzlLblQBoye2bS2VSkmaaJyzaZEARrJK3GOBpmc8PXGkMOFRFgF+ZgXiyEC91u
E3rOSqRX153lKJWaHX3SH4yO0RUjN22sW6htFUwQZTm4iLRG6IzaP2+BM2cpWnCe
I4RwXW6GaPue9NnC/Bf/659cN68fjK7fUU5JJn80cMtfO47GjXmA3ceX28vIB/rm
WKAMBlhKd47VGV36uZrPNREsoz3v8g==
=ee9u
-----END PGP SIGNATURE-----

--uvayaecgmyelikx3--
