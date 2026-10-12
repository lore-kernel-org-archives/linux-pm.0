Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48541E6A3
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803675; cv=none; b=dNtnDqNOsBce3+Iv1ot8S76hfXgYy6OGqhnLOQCcRXiPaJ2F5Qd5FC2jb0iU9Tu9x3uYG545xTStn3U1XQvxkFlrnm0b+nwnMCRoGpNBDLtpaENp4uABUAtDDFP7abhqVN1/+F+slJ7chqbxCz6q8AIjZ2sNkbtMSIvQAsr46Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803675; c=relaxed/simple;
	bh=uB+EhctYOJjiUgeuo7dNIo2M8JJ9CsWEY4PYvk5q0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5+V9IcvB0vzESgqWRhVuwJXV3Lv6jJnJ0PifAgSDEbeUyZBiWzm4wkEs7oJ5t1aUG3uxgGVYSG0r4sgXypVvLaTwmVy1yWiZBrWKLARvJmCdGzY9d3ll5N1NzNJEq6RTox5dJtfplLNSu5oeU4Yyl1bQw3DfbMjgwZoh30PFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dqNrKEdR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dqNrKEdR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a061a13884so15122585e9.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791803671; x=1792408471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uB+EhctYOJjiUgeuo7dNIo2M8JJ9CsWEY4PYvk5q0t8=;
        b=dqNrKEdRUdmDGiNhKUfxenXLEgvFCYpUGCa2ZM4GnitxQhE4uhVNcxC9MthlDygC7t
         OLJ7oA26HAHMFPqcOv9mdmuCeBizaWjdzOpwpu4UeY28qDnh/U06ugFDKmf58a/ofxlw
         U5u96B4te/8x1FXxtjcNulMXOPfOjw/+b+8vQKlJEtBFUMsdP8MVCsaEhRizPl4Hrta7
         VS2voX2iLpwLSSH4rlaPiVAGPdNm3FX83XFsV2umN8EAR4CiH4BOz2ZHyDFllHIq+Ywb
         ZK32SbkWYjJM/8kNlQiw9iL7oddoskYUWlEGxarTfQKpfzUM/6+VuejnwMcSk1ih45al
         bTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803671; x=1792408471;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uB+EhctYOJjiUgeuo7dNIo2M8JJ9CsWEY4PYvk5q0t8=;
        b=e84n+Mq+jY5fOXnkbD1e6GlZQO9QsHQuE5EBRFksZw0DN0qPzcWkgBw4vBS6oZTQvb
         M6ZumkGpFZHAymmpBv9djyhDO1Sn3Pr4uqGqF1J4lNAuAZeGtpKae1wrPjaqnaCjhMQt
         h2SR0KpdiTZelcplWIe8R2OBd3J3jr2yCHM33MxJkIvqkdw5Qn1BRwe9SgGF4KllvO1y
         Ndz6hrSg5ZPYS+3FwI1NnCR6T2Ihyo1EdNsfCtJxGhedCbIkqoITZFnBm4S4cdOH5QpD
         hxNqO5FHJa8e+hclXPz9lxiEsDfBnGUoYk/FH3BSffxUE5R5UQDO9FEawKTbRXKHI+cz
         TiyA==
X-Forwarded-Encrypted: i=1; AKwUvByJNJzF5zUF1C4zZhqy/BqYLNEdaDgGBjN54vXilVMoDpkF93qiHQTXv/MhcHzenLIWPzUbOKk0qA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIyjxoN4vHJn541gTXbzI4v3lzRxlo+OQ1mPl0+TVr6kmZlwNyu
	OOwCC5LkJEsjV83/TdyjrpAp39hov1hWDD1PrvSPUiB5jOtp67/+8l/l/7XaI119T4E=
X-Gm-Gg: AYBFou2exTj/0LmPNl4R5mRj+vhGw7SizJsa8pkBJBlOrqSLNbJYvAu3q5g31ID9fgN
	SgitWOJYuocodgeIxd0ukU1glh/5Th6OCrhuWDWE0TnFKdRuwJg5d8bk+yP9kO0ea0yiU8TXokZ
	1kMQh3z2RgxGQf1MQVtWcm/EI5k8736i/n1brmKSZcHugn2Nb/mTYCzVpe+CdplO8hu6n5hNF3J
	RQHnz4bVelRJMNs7Fam0vSE/yekwzMRvq7eNuam+IqY2U3VXMB7HeNFaTdsCxeyRebofAogFF00
	B+AjiHNVXgu55e2OkJgsl+t+Uw7xydeT+8mAnh3hovsfxhflD8j9fHaQ5t+ujhRdn5J6fDtMMwf
	VwO9onLdBzMtUprCVhfrfK1/ABD/YFRyUI+dUrEiCxXeZF+yQ3+JlSHroj/+tyk8IdFdcjOSa2i
	H1aLEtyq0+6taPqyyD2HRxQcYnVFeJWg37TDfa2lb7ulbVRoXI3smB1LhXk23JdiSoQWRYYN595
	Ycge/NZGf5wlAAmMeuCk5HfgQ/wuV75bOVfVRk0109UJ/KuXvewayryADK1bg==
X-Received: by 2002:a05:600c:630f:b0:4a1:9f59:ee7 with SMTP id 5b1f17b1804b1-4a19f5911f4mr44897885e9.0.1791803671322;
        Mon, 12 Oct 2026 04:14:31 -0700 (PDT)
Received: from localhost (p200300f65f19a904ade4f69ba751c34c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ade4:f69b:a751:c34c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48ddaefa06esm2597263f8f.20.2026.10.12.04.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:14:29 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:14:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Serv Pol <servpol@tuta.io>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add GL.iNet GL-E750 MCU battery driver
Message-ID: <aszArhrDM7DzITUp@monoceros>
References: <20261005-gl-e750-mcu-v1-0-499d2e31f786@tuta.io>
 <20261005-gl-e750-mcu-v1-2-499d2e31f786@tuta.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7yjuxhsuiamtrxl"
Content-Disposition: inline
In-Reply-To: <20261005-gl-e750-mcu-v1-2-499d2e31f786@tuta.io>


--d7yjuxhsuiamtrxl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] power: supply: Add GL.iNet GL-E750 MCU battery driver
MIME-Version: 1.0

On Mon, Oct 05, 2026 at 10:25:25PM +0000, Serv Pol wrote:
> +#include <linux/mod_devicetable.h>
> [..]
> +#include <linux/serdev.h>

Please rely on <linux/serdev.h> to provide of_device_id and drop
<linux/mod_devicetable.h>.

Best regards
Uwe

--d7yjuxhsuiamtrxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMwRIACgkQj4D7WH0S
/k7sWQgAroYgP1mHB9Yp1jn4yG6DjNDy+RIzTG6nPXmFnTPvqkw2LaXBq6h9vWY9
azRLvxYkTfN8+Rsilq6ANoSpKDiryCW4vZ0Dj7lgpZ5awdeNf+o5KoCpmn4nmznv
ibLeJtz7TDfldnA7FR1+vOiyiUqZjstujOOpbBTHLBAd6ZkpbCtgkfhm3YsOfRjR
DmGb+EBRH1xG1QAXFiL8cux9URnOsrEVw5unUq2KuwzvZbkAN8ItzO/6NQ7XhRJ+
IzqRvPvgst6TiXxowIdVkbwF9JT3+rrB9Xa9UvjTXMOQZJEt2xuNCml3dMkpHLvE
QfnxsUx3sShO2HYDb0w2Td2augUolg==
=S0V3
-----END PGP SIGNATURE-----

--d7yjuxhsuiamtrxl--
