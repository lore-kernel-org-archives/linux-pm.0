Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794172090;
	b=vamjiGHPeYR38mcCR/eakNhspEz07eqRLF5PR8a8sMB5nlSk6ehD87mtdAatD3VBpEp+
	 19kh7EjU8e4HdVvHepxSouExuMw2ZjvSasJyei485kSLuIy+sUrZN+1bKLTeHY3k8c3Zq
	 1QsyWXeqIM7Yizetn+F4Y7bsxusjYestEI3e0mBraoPVy+iujCXNxvtwePXD3j/WdovYq
	 yt+2mPqsRifUl6tZR5MeVZ8HdRqoKaMQUTRU8O4p9rVEOtSaQ/ELj+vWV8sPDdKulTc/6
	 lTzCrPBD5oN7GxNZT/zqVmaUvI1mPcTYdYziCzdaK5rDiFlnVDyT3Bd6mk+Gq+iIWAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TKd3XlZghnq1bRXZV5ZgDD+2oyCcUDkC2gv49H+TH8c=;
	b=RQ3cB/EOU4Ao2teGzFYNBKJi/6GhFE0yIDDLu0vB2R1twMMWC2MJl6PQMYY1WQe5AYSL
	 XyS9YTXejrrWEhgBGdwmPGA7xcwHMuERyHT3rbYErt70/PD3BmPyd3n+b8lDns7WXxsAp
	 FE6xtiUgzihPrPuoNHCkMuSv2RzMNhiVCq8uwRSzzY737AAM+YWMEhNgPKsla/chYHfKN
	 R6+zk+keBi8dOGkVgbQXTsiZ8sXY/QxMguewkntImUJEHVnSMztd1brCv8tvLGpJJeoM9
	 39c/oNNZYKJIRryVVnJUgixAWABIrStuwwFNYV16NXCvC3yqbGSMpTB+JYisS3URwIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=sHCr7ys8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F70606A333
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 21:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F70606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=sHCr7ys8
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso344856d50.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 13:08:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794172088; cv=none;
        d=google.com; s=arc-20260327;
        b=mzrs0wuPXlIo4xom5V/PpqM+DjmyNt6sUQCOaxbuuJ8AMk4RivnEXgeLiEiS5Qrk5Y
         C+gpq6D5mVbFOwlFIJ7s68yvNR0gdGYbjRcd/vQZH9tFET/sYP4cQtJsJIeyJdUAPYSP
         N85y8bhMubA2IEBdjf3cPL3fLGZJiHv23Xua/Z8/0QJ4DuoYQ9DP0W9l5Si97up/r/Fq
         qKG+bRtNcLtQJSTbi5e+6Vnx7q5yAQbFuhn0zU9Nj+j6F3IYepxGdOBAXaohvq/sqfhi
         +ZutcjS3pJiHns+eR5yMGb6j+KkcXtaFSIcLAZXjYQcP0F4nfmeL5EIroN4WotNFLuSi
         d1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKd3XlZghnq1bRXZV5ZgDD+2oyCcUDkC2gv49H+TH8c=;
        fh=2BQAfLmi0d3W7TP9e3e0hDXq/KQBsJPED2gfXJO6jFc=;
        b=gNxQ50X0Cmv7cKUQLvb6X8G3EmGo9ohxyGo10dC3aTrcrJDy7RKBIj606nnfUunerv
         nReiCHIQHHC+/H3ycwCi+u5FZbUq8bzyOHwpglT6qzZttbze003Q7LfES+EZ+oM9SLq9
         IbmV0Z7UUmSNYAyM1BaERigNpBGBX4EoyGy78fK6XfVeYO6qdvnUmoxtWJLMMjdOGUrf
         pUB/89d7ukMhV9NXnEzpRGpmWX1PuYatPNAw9vrbosQNyb+HXXbil/tSNDiW1bptXIlQ
         JaqVmfyWfJVza0RJ532SrBzQpMlwCkxrkkKg3uajQDSq2Z/3teLnZnvXYMJ4aDIooQQY
         dkLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794172088; x=1794776888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TKd3XlZghnq1bRXZV5ZgDD+2oyCcUDkC2gv49H+TH8c=;
        b=sHCr7ys8bNxUaNsy+bUcoVeFML1dbnDW2w+esIPjXGCAWDbekntbuCZmOXJdfZDpOE
         j/6JTt8w/B7tGmi0lCs2djCp2qXoxDaRRmam//5cOdpqkHTeIDr2h6qKGDGhT3JMXge6
         seVklIruMWETKxT1xvP+o52n1+TZm/WHjI9Cb0uZZYBUAag61hqA1gbT6Xs1BZbBV9KJ
         Fazm//EF8BTNNaSnIm47n6vXZFxTa1i3vf+uFY8qVgTkN1LzNs53nKiFOv0vj1AEttZC
         VwI8vzuDA1+Qo4Fc3Ynw2gV2cC96Uk3LCFIyZeSodsXc/Mf8y/1x9PvB/mINIzic79Z4
         sLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172088; x=1794776888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKd3XlZghnq1bRXZV5ZgDD+2oyCcUDkC2gv49H+TH8c=;
        b=h4rZGV2gBAqNMrxdYudCD46AqIbK1iP6SG3dvGNYQZ8mFcniTnfOtbnEyJA/BwQaq6
         IXLCOIYwYHC6GyCeHiY4QFfRUt/vl5atA97W1hkow4sbdGLdRCue2GsSLwLrYYe/sV6x
         MbzeE1sHf73VOotXBY6Fx/Kh37ORTEpPiEgipsTOI3Vc8vCbLdi4v6OPnEOxrlWoq6X8
         ocyBym6ksJh8EnJHgA61tqDbjqq0u5yN3ingTe21lxuNeqFQHOSunV1LyFt04UQnQqhI
         dcw9Asd7YpFxaDjt/fjsqZLwO7aRakD73cpXCDjU0zzQxa5K76A57AKSR9sZeWRIQkyp
         GMKw==
X-Forwarded-Encrypted: i=1; AL+hErEmHp9/LPRNL3BwNoMsUCNrBsgn3OAD8Pr4/8AUO5p48kK/YBDqk8qmE6uqVjRlWSsMlcuNuwXwGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lx3D7qrkgZtqxpSXd9jXfPt6CRlVHs1tPP/KI9oU/5VBUz1lh
	xcGc22DkNcxRyjdkiUKapDA2M+SB/UrQLIejva1qbPaUy4wq+jWvoEnVPCjJNZ8P1GxC1cK41tm
	19PLVqzPYoZWcjyqTjQEuw9peOEV5FIs=
X-Gm-Gg: AYBFou0orrapVIBSexpCZ22DTd7unPhMzYCL9ZrhYik7TjKyoInOdIOoPuvLOzKMEdF
	QGfAgRoCCH3SZu/mO9+N7OQiIxJJneZmwXNPq7xoxGIZzz/YPYdBSweMmXuW+iEiAr0l1IfxcJp
	irdufLahObeMcomVPF7LrjFNRudPT95kCvNPWZNjtaXhY2rpxlpkepLdN5uNOc196Bgj6W/ecm9
	lS+kUVvsyzO6btOcRUR+ZbzMSCQh8R8FmIMnoGouwq8a1MR1ox8JdRRGKYOFCbP8x78Nsa/R8/2
	e4OrtEHOHJig/MOuvDQixeXSBvIcBWx8WMrwzNnbHLE7qjgugv+d7IjaRpMEUza50OFv5+SsQbI
	hh6ad9zTa8SYf7XjA7ineDFBKhPxAtI/xeXVB11cvjLglQEOEG5rGO1Rzq5Qiuxv1Ho94zIVaA1
	CxIWST0ho+SRWAfsI=
X-Received: by 2002:a05:690e:bc7:b0:677:df02:fce with SMTP id
 956f58d0204a3-67c3d7cc43cmr1612153d50.5.1794172088171; Sun, 08 Nov 2026
 13:08:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at> <20261106101913.46664-3-christian.koever-draxl@student.uibk.ac.at>
In-Reply-To: <20261106101913.46664-3-christian.koever-draxl@student.uibk.ac.at>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 8 Nov 2026 22:07:57 +0100
X-Gm-Features: AclHuK_oGazsWw9BXqhuCXk0AQ3FrnvIBj2gHr_VP-7Spxdsvm38LfrWlZ3lq_0
Message-ID: <CAFBinCDS_toG+4BySkUoXx73a2JWtp+tD6NHwYHk4mU+p+GF=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] thermal/drivers/amlogic: add S4 support
To: christian.koever-draxl@student.uibk.ac.at
Cc: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:19=E2=80=AFAM
<christian.koever-draxl@student.uibk.ac.at> wrote:
>
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>
> The S4 CPU sensor reads its calibration through the secure monitor and
> otherwise matches the T7 setup, including the separate bus and
> functional clocks, so reuse the T7 data for it. The driver already
> enables every clock the device tree lists.
>
> Without the calibration the driver reported about -144 degrees Celsius
> on an S905W2 board; with it the readings are plausible and CPU
> throttling engages.
>
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de=
>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
