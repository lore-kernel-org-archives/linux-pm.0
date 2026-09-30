Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0C4F68AB
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776591; cv=pass; b=DVJoDolKFOHLEgzs2UwL3E6MkMF3vPZmxjT+AmJ9bQLuQwI511+pLrSqhsmR8HR6jkeARD//BUazDQh0IWVW2SPkUTGva+w1hJwC7eo11r+GXQe4fujMG9J0oiBbEufeNZjvsgYJ6nEsGtb921e9K719q4QNu8YoQo5uZZFeBq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776591; c=relaxed/simple;
	bh=5SwTqNdqJfRK/IUxZeFy/sI9epuc4z6THWr/paPSz7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvTRf9hmTrKHIbFCoFhygLZngw4IjJYRiG4l4Dqs/kQkKRJPKg1Bqy+uniqdwTN9Q5TJcAAyNPCJuuYCIOnJh7UZuWJJDQqieevNGpGHe8Rwx5ZNCBfDtybMTDqdNRuPvlVeEpUUJWJcRNMW11rj9ybaPM+IqUe/V/JNyU/WMJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=NAu7vgGs; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="NAu7vgGs"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e083d0930so160231066b.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 06:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790776578; cv=none;
        d=google.com; s=arc-20260327;
        b=p7Pjf/5VbKbRGiAEiIfjsMMJ49xMRAyA4ZL3ZFsV5ojwZX3ajRzyiwN+bpZGu3ZXVL
         XW9FF/q4KHRM5LVZmXyfLZgM4rd76J0ZwrvoCileSrDt5xiy4Uq60oaIzLy/NFOyoA2k
         78Pvs76EvDcUFOjY/Dztn9PFk3Up/RNak76cMGLASTcOGBvP4JlL1o/I2sFB9GWXR9I+
         lgwwRnaSP02023kMeFcXeyjqnNMaHCTAZXl6Hzmj64mKqaqNcy0NmJH7BkTQDNkuEswS
         b6EJ2JRBuSXDnIme75Rga4YB97JPANG6VwAcmZW06pbiRBJzWazAgHz9NnZiGqNtSrbF
         6URg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5SwTqNdqJfRK/IUxZeFy/sI9epuc4z6THWr/paPSz7A=;
        fh=6ihTFdXBXgx1IORXjMljEjIryxGuWzbez1DFoio79NU=;
        b=GYGSEPgRLkCwRIlBtQ+BGGOHGqiMCPZLObA83P+LnGBmtwnangB5ci/2P1yeArMb3u
         FZMMK8KYtPfd7jOVYC3YcZ81LhHDCEkv2Tq0GxuwWo9FeK12D45lqrZhNUghbQ8lMTUo
         tUUl2+0T/42MLSNRyhFc50/Kl5Z6T1M2TTX19WxPv62ByAbzOKw2GBs3VvsFJNQXcCQZ
         xK/uo2ZjAA7MysmrzHdcUkw1KUDmMswK/RsXXZ1w3FpHTC8sB8/oi0uCuATWnKEXW7eV
         Li8qmPhnmjAdtCYyaBD3/qxK14sTPXc21fb5+2FyRgaF5eKd1DQgnhHrvkanlSLgbGeZ
         qNsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790776578; x=1791381378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SwTqNdqJfRK/IUxZeFy/sI9epuc4z6THWr/paPSz7A=;
        b=NAu7vgGsXVtRJM3kyMtlMOwhzm55urhiUSDyX8sptKkvZEuu+DxtLMgX9bOD9sV/PB
         hoheU8pY/PcwwObO9x8Xww3BZ9xopjEfolEksoJhIui9UCsAG7apD08uEnAQvFYikcY/
         cq/eenmhC6S/AUZV/GQmjiyaVscpLL+/fxy2q2Sneisl0spSawpIpX4aj2SwS2/4f+Ob
         +L8etTYb3ioJVKe6KdzzxRHtBeGkiHLsPL48wtu+pG70JmkvRCLJ3KQXvPP8VT1siadX
         USmbbSz/GhOnArUa5YyW5JePpFN5XSy797Kfx/kYeAfFnsqaQRMPkJJRmSbkYREG11AI
         usPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790776578; x=1791381378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SwTqNdqJfRK/IUxZeFy/sI9epuc4z6THWr/paPSz7A=;
        b=CabujUnBHYGIsikTLINugerhGsbLLuBQg1hka9CNr07eqLC3kDVIiA0d9fIU2ZxiY5
         ND45AjpPfcBGwfmWxaAcZvCygsB8Of0pwDu0cutDFbsL6xFkvIV7NSESNqqfaTnYu5uN
         gsfkqyP1YeY9DZkg5ZSsF+JnL3wTL4NYe/HF0KgFkFnuVYBp/qFBUkKIMBrg787Oi54Y
         Ysw+p+N9/UiMo1tePl1maBKbZxay2ux8IfpkB0ZZ22X3IOOXkCHAtHoYhbNmIRwUnklE
         kr0D1VT0zxoccczd4UOwGHvttXHQJH6Qnhw/a/wmb9/XAZ/O2QCzWzTDotssUj/v9Qk7
         o7tQ==
X-Forwarded-Encrypted: i=1; AKwUvByPcYQfa9PbLsRky+hPb0XAWAs7xFwnVbI88oho/lojfQUbYxbmi5VyqoBuNsVGalXF6Ga6R/4HuA==@vger.kernel.org
X-Gm-Message-State: AFuF++lnffpTUi/P2UR9DRxn4/1SgYa1LZ3W5jCcSDV5cxyeQIQLnviT
	OVHrLuSwqHl6ANylSWkXOsbrWBMTGMo8H4MD22v1Uncrcuh2qznAP7dfDqTgAPgksMFGR3yfhPG
	L5CSvzzjB6eXsRP2rr99YO3egb+12UKJPEi8PTyZ8zw==
X-Gm-Gg: AYBFou3ZWTyCKSMsVCWPgN29rtauqd3x8aESvKDLTqN9aLJPj4YIIblAgdADKEKxloo
	7QxqUDhLNZ8YImQaLmsOvnQfg6Dyw+JukR6X7vR1bs9Yc2oh0WVZ9VQXEcEVDw5pzu7ojOvDt1e
	k4MOGRo+z/ibN/ub+4MdNy7Qw/6qmMOodgUaIVnp12laVYN8kTsGx6QWM3dQcmgV0K3chQq0AHH
	EEeuQAuREU7DpSdWmy9aj+lN/zBfOtMIC/Vhp1c1KCDLhc4j5JA7wQ1M41y0PVV3P0w/frc6Gis
	QowZVvv+bEwot0FiuL68MPLfVaIdNjRGP8On4eZaRKf2fIRLoZRA6Rf4A7goG4tqROe/cWggKWZ
	7bZ9HeEEOffNXID2lyGIHzpk=
X-Received: by 2002:a17:907:1c9e:b0:c25:c67d:53cc with SMTP id
 a640c23a62f3a-c2e23cad0fdmr124499966b.8.1790776577897; Wed, 30 Sep 2026
 06:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
 <20260929-b4-rk3576-reboot-mode-v2-1-5a34ca72065a@flipper.net> <20260930-hulking-swan-of-enterprise-94e2ae@quoll>
In-Reply-To: <20260930-hulking-swan-of-enterprise-94e2ae@quoll>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 17:56:06 +0400
X-Gm-Features: AclHuK_LS1pgpfgwaTzGiwreXcQZqQphizrD9-WsvYxGfaJqBGmravJ6aAw_W_w
Message-ID: <CAKTNdwG0NBZUez1Yy=jk3rYrD9W97oRMwvpX1qMXwQsP=_LvNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: soc: rockchip: add boot ROM download
 boot mode
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:46=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Sep 29, 2026 at 02:28:18PM +0400, Alexey Charkov wrote:
> > Rockchip boot ROMs enter USB download mode, commonly known as maskrom,
> > when they find 0xef08a53c in the register they take the boot mode from.
> > Add the magic under the name U-Boot already uses for it, so that boards
> > able to request it can do so symbolically.
> >
> > Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Drop, you cannot test it.
>
> What is the point of such blanket tags which are not even applicable to
> 50% of patches here?

I'd argue for 40% :-D

Anyway, I get your point. I'll drop the tag from the bindings patches,
because Shawn tested a driver implementing the binding and a DTS
implementing the binding, but it's perhaps far fetched to imply that
the test covered the binding change itself.

Best regards,
Alexey
