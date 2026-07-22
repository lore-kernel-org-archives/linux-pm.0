Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105EB3E16B9
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750100; cv=none; b=eMhPnz4gQlgpm54wCfCE++d7TbG5LoI1uKag95gzqy5WX7qxyhZqiV1NtnVsC2AaW7nJTqIfa6mhQEgEnCUo0k/czY5V3zUU1J5IenC7TcICR9z2rG+Rl5K1zd7ZzZAa1tBNTSfhgwY7gRsfy6TcsXJ/A5FLIuZa/Xm4/qQCYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750100; c=relaxed/simple;
	bh=nvXbeJmDIU6VX+uQehb959GxVZ7GiMgRRjwsNvBx/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzLi/+s7AIb6B98pN8ujS4TR9lEsk82BNuuOBf3k4VPfgJ5aQ6XQqCiP5p6j1QbNpASBwtQfoWn1FjiMvYta9ecgCphudL4v7k2NcYm+3+JDDrsjG8re8/d83d4oFYk7Hj9Hywr59ctFV2qgrhD6pdm4QJviRjKS/Be3fmyx42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2nh5lFT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2nh5lFT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caced6038eso88487925ad.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784750098; x=1785354898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tZI2RuaKFEpTRvCs4T5yOqNKGFZdvgovBoWvvY7Lfws=;
        b=o2nh5lFT3WpUSz4MceK6kLgjr1FllQraNqQbxBnFAduXy7mYPv2PAToVU1oy2R0FVM
         kdbf2CvvnN6UgoGG6nt+uthFLRaFUx/5u6sMMW/PLXmM4PapwQgWDbg2BCqflZ1vnjS0
         SGe7DuUUzaJNWGUwcfqd5bveo6EjsDDQOBHi73FeDXwVE6j3hFAKDRka6XRhgN7qkejz
         II2ejnLcqVTZn8mvaQAsm+f/uCcVWQvAVXyDj6hs1Sld8dRJdJGrxBGcFJxHrxzMmiVh
         IOrmQXaa40bavv4V0uzl7lsUElCQINOss3QZFP9CQU8lMqT5Ypwsozr/frJWzlcmjEgc
         UyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750098; x=1785354898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZI2RuaKFEpTRvCs4T5yOqNKGFZdvgovBoWvvY7Lfws=;
        b=mzCB/nzz2eF0GzYMxrfJbe7VKeLd81OkwHwE61P/fj7RCFhwTFH+jXzrt9dUmXNEJO
         scg1b63WZdwamlGQI/V62d6cExSMhAZh2Zi3VjETeukYyvkMmhKdXWvfwDVin/5rwoik
         cFQPyVmNc+DjtfTaAeJbBTq2VpuO3du1LLkuC1+NklkzrWasN/mI6zD4vqL0S4rG/UkY
         yK/MBEGBjq+KARz8wasEw63XEyUfL8E3ugYTGjA1+z5rLIyi6gbIc4EL/0GGo2ThXOvb
         SwxjIHbD2Q+4bumHNZv75DobZCcm2oHUDjAqt9v6UGcF/g81WY3arzlRWYA/hjDIYOL0
         AFcA==
X-Forwarded-Encrypted: i=1; AHgh+RpUaorcwYLbdvyRpHZnkiTOoWCW+YHVtuivx4CuRCKk04oVWdsQoQNA5u6q3CIZKlLBbKTreE+8Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+AS0PbXISwCoM7Ic58wm8xUJY2lj9jJMGrQg0Y04OS31j1hm
	HrhVaXVqkcuOdaWT5D9+YhiM/0gTf50UGFmwvbmelqHYP9SGUSvwKDJQMmEtcbe1X2IRrShR3O1
	G9Ipx/Q==
X-Gm-Gg: AR+sD12eW+7fSihB9EPPVf4O01s8h2ufJVL/x2dAdAjAn94Cw0l84eID5Jn31IUzx6Y
	/+DbkqJTy/y+Sy926zTRwOtGsNUDylxYFmMcUnw7oPwrWDErvljTPsVpjbHR8BOqRTLr3vHqabt
	J3piFaP9RBB6sagaOrtpLJiZYjBWAEbhKfo1Br9TgXQLQaQ5IOwp6owE4C/TdgmF87SryxZSn5S
	/7nSdTNDZrLJAE8EyHWdVlcrmVYne4i5a771Ag6oRrhDOaOBv14Q8R+N8LCU/E6U6oTLe4iMUcE
	K5mvtp9smqe+Hie6TmDvEsjgS0NIntZlXNkgsiu2Im7+sy1LnyjCrDRzdf7/1GzQ/RdwcUXDePL
	GJ7vSuDsIxd6J9CteM6a4xn1LrcKrTj5EwWFYzvM7m0uov6/J/D+uQu9ggrEDRCfReVNwssGdMS
	Wo1LX0KVggKnpiiWrVHUbBUBenYTUjjEL6ATc=
X-Received: by 2002:a17:903:1590:b0:2ca:de3:15d7 with SMTP id d9443c01a7336-2cf8dd6e392mr53379335ad.16.1784750097523;
        Wed, 22 Jul 2026 12:54:57 -0700 (PDT)
Received: from google.com (51.86.127.34.bc.googleusercontent.com. [34.127.86.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd76cfsm20274425ad.20.2026.07.22.12.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:54:56 -0700 (PDT)
Date: Wed, 22 Jul 2026 19:54:53 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, sre@kernel.org,
	fparent@baylibre.com, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: cros_usbpd: Limit port counts to
 EC_USB_PD_MAX_PORTS
Message-ID: <amEgDZews_De0mH8@google.com>
References: <20260722195059.1420738-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C5XRS+V9CVgowzAx"
Content-Disposition: inline
In-Reply-To: <20260722195059.1420738-1-jthies@google.com>


--C5XRS+V9CVgowzAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 07:50:59PM +0000, Jameson Thies wrote:
> Currently the cros_usbpd-charger driver probe iterates based on raw
> charger port count returned by the embedded controller. The only check
> is against the number of USB PD ports which the embedded controller
> also defines. A malicious embedded controller could return an inaccurate
> port count (up to 255) resulting in an out of bounds write and
> subsequent memory corruption.
>=20
> Update helper functions in cros_usbpd-charger to limit port counts to
> EC_USB_PD_MAX_PORTS.
>=20
> Fixes: 3af15cfacd1e ("power: supply: cros: add support for dedicated port=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/power/supply/cros_usbpd-charger.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 308e1d4e6dd8..82185ee33fd4 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -125,6 +125,11 @@ static int cros_usbpd_charger_get_num_ports(struct c=
harger_data *charger)
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (resp.port_count > EC_USB_PD_MAX_PORTS) {
> +		dev_warn(charger->dev, "Charge port count out of bounds\n");
> +		return EC_USB_PD_MAX_PORTS;
> +	}
> +
>  	return resp.port_count;
>  }
> =20
> @@ -138,6 +143,11 @@ static int cros_usbpd_charger_get_usbpd_num_ports(st=
ruct charger_data *charger)
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (resp.num_ports > EC_USB_PD_MAX_PORTS) {
> +		dev_warn(charger->dev, "USB PD port count out of bounds\n");
> +		return EC_USB_PD_MAX_PORTS;
> +	}
> +
>  	return resp.num_ports;
>  }
> =20
>=20
> base-commit: 17376e7311cdec252b61cb1ecec43be61907781b
> --=20
> 2.55.0.229.g6434b31f56-goog
>=20

--C5XRS+V9CVgowzAx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCamEgDQAKCRBzbaomhzOw
wn8cAP9o/UaHtmuO3OGVfyb7gYiej2q0tbRzJ9TCk0NYnVh8lQD+PUX/OYdODfgX
TK8sGHCZq6dp8IoqaZE7JHsKoOZKlgo=
=yVpF
-----END PGP SIGNATURE-----

--C5XRS+V9CVgowzAx--
