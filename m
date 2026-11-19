Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795099902;
	b=V9ZIrMrQAkZgkH0omXuoAMhH863s7hwB/j+Cl5fZCfesyu0UOmHojWZ//cw53tDAmgCT
	 Yys7gBxSRmfhmRQKxoyEytCtCC7yR6Nac3i/0z0b9RLzzYaVTyubWdj3lw8zA72ltKAFD
	 RgnCASyBqWO5CmuD+WBt8LY79hyJjAXOr4+zVe6KPtPcrShQJkrLFhg1e0FRvs2Cn4r1L
	 8AKJKJE5+1zS6ODCEtG97KzIwj3d1ovJTt78sBOxIdeYYO17NDc+nQULGN2BraHajyliL
	 l+XrBL1rOYPd9O52mJkz8Y8cs3eYnVX3q0UIKzOwxOnwt0+x6NXH7uU20CqZCNfY1sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
	b=ROxnEiZK2F+8kPaE/A1mt30fvbVlrKmPobOLvPE/UoQOPv6wxXQxemcFAeG7iE7Nv/DK
	 TGnkRWp4jSwAq1d6hICIsP/gDLuLUcjII8Ct/odD09yJ9cO4OBo7XYC/v4gLIkr/Q/L71
	 K+9U3k6hyQu+86A95O2WSWFY6nsZZAUFEQIzd8U8UwFR3clx269gtl0bFlBgndIv70X8y
	 IQ0hroEUQ91Tqjq12tygk3ZiQIoLWlsKbJ9XAyetkAWkvf595UOENsVvjuGscOd7Aq8my
	 nGVxIV+AwF0BK9Z+mSHM0mUJijh4bspWowopOefHP3jFp7z9yXberOg3KS10qnmbFlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWwy3UQV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A31606A333
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 14:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A31606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWwy3UQV
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3441468eec.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 06:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795099902; cv=none;
        d=google.com; s=arc-20260327;
        b=WbgZXodnW3Cr7oTku3nG3l4k1hok6q3NNcEsbgQEY+/b0ecdd39+UnO1lZw6U3nbAe
         7VhcsgJlmDD8BXD/131tITwV0oCEUroWlBBRDdGK+GUC11QaDPyU0K6E0ZSvrO3F/iUs
         IeoxJ4/6WND+XHwp1ZnD0i+3pWzFj5GwzR2Y1jdIyOymf5l72iNwqyisInKg+nmH9KIK
         +8sXbSVyehA55ihHwdA1XAz2crwQ3yOHP4vU9MZFWbFiRpXAKa7rzxJHwUWajFK5v2Xr
         ltREBJ/78tKMFoT+W3UZYPZ5J1/qEsRxHv2ijW9JEDOJhs7MNBtZdUInZGT/CZlmRrI5
         hLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
        fh=zRrS9AagyTBUwLqhIa//3j1vouovHjwt0jiP3w9/wO0=;
        b=cCX6zaaQgatFXZPlutDT7LHsZe2JSrQ9TRRSW3M4Iv3nNxfj58i1JTtTlbFYyZnbdo
         b/REygSvDtLkYDMy7qUtO9zbFHhCV5XWPSdspdTeFwO8PYsoqyDLJtWWtbhpVghpL/Q9
         Ly4LiR8mIr/cFOk/Ub8grdv36v+njNFylsBWEPumpe6/l+Ro+UwIRBRq19ZkEZ74AVmr
         d9tGxXgsM/PNjXZ88dKy6F1eNno9502gKw0POK9ijqn3N0+cMmXkzUFkeWTUyQqSBJqP
         TwP4XjyFhVsiSfaYgVfGS3VtrUa+fz9L3Qy5Afs9oNv/8B7R2ecpikWFAIzchNLQT5Cr
         KyBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795099902; x=1795704702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
        b=dWwy3UQVVYQLiKDxkA3dgZkZebW32MqoCRtNCPSE9MpO7t7SCUIadQkRZJTN5a8w+V
         3+jB8/+GgdxSwPRLbMBhkMYZd+rZkYs/iaE4Vz9TPjtcDog5e+Pg1NWQZ9MRwGFq0e5w
         LzUZo90zMzoehE3eCLRA1ydOP5xUVZi3O9Y3OY+QKVU2moQ85xP9bsKJk27hvttgM9dT
         fwQe4YuYdrDTdwhpNG1TWYVeXvWAcgtl/oYi1d9P+TUGslnhSuGhgpfPhtggZ4SvwyLs
         osmrQ9/r+uYHVq6YAjvvC0hCJnG0WTpZnwR1CMffZO2NWqJPT7p9zd4sHKLVr+PL9l/g
         jfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795099902; x=1795704702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
        b=RJ4UzXjebHKnYhw7KbGyfkXG21yVHVdFJB/pby5+YKdyKrQ7E4pGJA64plSdHSgNez
         7jAdSxbrryrMv4CwtFnlApZvPUryi/hdDffuxzHLf3QIJw7ygx++qkIEkxqkJWNmdcox
         s2OYPS3ATTFITEGF3Jp6XPGNLxcGqMxM00TwEPwHcYMb/6aZfg0SfPA4fLruLnZ4DWw4
         GiEwg4NOUms56hFmGbKWTSF/RGWuXsFrVRg/uck9s7eMDZemEYoRk1JrfCtBfHO4eBsz
         6RbBMvxKbzuIifj/6d9zU++x4v/90s4QU0kIysRXHhNPzIqZli7DD+xEFywp3L/jMniu
         NJmg==
X-Forwarded-Encrypted: i=1; AL+hErEpMtmgIx0u9vNmKwjRDkeBkU1JU4/415ygUuP22KyuZLOdZfQ46JQ2PF/RFP6+JJB0uDR8C2FI7w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8vb3FAJVxWOONMV1HfirCmZcoQ4JROFOdX4cP9tLZfAUP/DTQH
	aGd+f9leOG3SRqHtuqXhU7V66Ev52QfDTDAQsSSVt7jop0M+US6knnrjAg/qYCcUevfudIdgoxa
	joH/r9LmhS9gpwufujM8ZCn5lrLYusvY=
X-Gm-Gg: AZFdTZfh6xQOYqN5lTAvDQzRLIv1rK0YDpWLCgqGM7Cw3o+029qLItuCo3bPiA+lTwM
	hhm5mlLIqA1bidktQL0aErF1AeGK13DcwPkhreG+cZuydSdX+cq1HGWIJwrD7s0+jhgWFgQ1RjW
	euvxk1gPGfcUcLRa3xhwnGsmIzBnVpqYHH5r1PKwmxIYlG7mWSt/lVn7gUmfIhpBLSTAtME7cqs
	hgOrzhdymTdDtIBs05J/9fDcpZ3Pz8V0jzc4cFZijAPPe0ptPXZaC/wd6iwgyA64P7reeK24Qpr
	ZsJVdN7O5T2Zxt3IEQ3Wo68y7NzG7f3Ku8ntL8Yx2PxVOGChcL2QtoaC/fnEXmZ6XF5k903W9DN
	FMgY6Q4saWK3MCjmdL1g1xCIOUlCD5yCkAAbI5gshBmwPmzzfj28jMcFJkgqxoN7vZyhWSPff0N
	UP5xIMZhvGt9QLBAIi7pEt1bzl3/EGxg==
X-Received: by 2002:a05:693c:8803:20b0:384:b001:4350 with SMTP id
 5a478bee46e88-384b00145cdmr1285277eec.24.1795099901356; Thu, 19 Nov 2026
 06:51:41 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795095742.git.geert+renesas@glider.be>
In-Reply-To: <cover.1795095742.git.geert+renesas@glider.be>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 19 Nov 2026 16:51:30 +0200
X-Gm-Features: Aa3M54oSpPPjIjBXKWbeu_LdZEGptwUS0dUMO0QTPqvZvvRh2xuuU1prMieCCXc
Message-ID: <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:5=
2 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=D0=B5:
>
>         Hi all,
>
> This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_EC
> MFD driver and its various subdrivers:
>   - The first patch adds a missing dependency for the MFD driver,
>   - The other patches enable compile-testing for the input, serio, and
>     battery subdrivers.
>
> Note that compile-testing cannot be enabled for the LED and charger
> subdrivers, as they have a hard dependency on the MFD driver.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (4):
>   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA

Though this EC is designed for Tegra based devices, it does not have
any Tegra specific parts. It can be used by any other SoC.

>   input: keyboard: Enable compile-testing for
>     KEYBOARD_ASUS_TRANSFORMER_EC
>   input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
>   power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC
>
>  drivers/input/keyboard/Kconfig | 2 +-
>  drivers/input/serio/Kconfig    | 2 +-
>  drivers/mfd/Kconfig            | 1 +
>  drivers/power/supply/Kconfig   | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
