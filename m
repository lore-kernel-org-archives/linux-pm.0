Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F53352C35
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783833677; cv=none; b=ZUFQbPK+32r2dueIg2TK2c0kdH1VcIClX2Ur3WByz2zQfUP6aipnNVMl6azkq7l2tA/CP3/aUUob/qIGStIW3EQ3vHHBI8Yx+Tat33/K9/4lH7PNrdWFwIkyxWRhDrlHGj3uK36G/HizBfiOa05PXwKwxrwZDSGmYEEFp14eWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783833677; c=relaxed/simple;
	bh=gOChh1ohTaPrZ+Y1GE41WGbMTNjpPj91qb2GtVmX2R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+zRK5D2VRTCRhKjLDkHQrPdhSn7PpLoDqlr0ra8J8KvKtj6+V1yFcgbyMFtBbj5mJVYpLqoH6qdCPM88LiCGHM46jJ/YTNg64pWp/afKymScxr6Pfam0yjBXQrEPJFep0DBtTPaNN+7DwY4wIb6eWgAPgy/OUs31i0PRhL/mwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZYjivwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZYjivwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B291F00AC4
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 05:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783833675;
	bh=gOChh1ohTaPrZ+Y1GE41WGbMTNjpPj91qb2GtVmX2R0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=eZYjivwv6VxAxWDT4CG10n7zgNfpl+yGBRHvlv+VwU8uXLyn1wc+PO5/iRDBxzHEp
	 9KERussY+0ce6BWxHPRqoemDGX6IuPvUd3Ih2HNqrgMdj67+8sUdKVVRgav1JTa+YX
	 EDha5Q+TqABhsIXaAEklbmTLoWflCd0PRwGn7XAgNUGeUV2YmVaiJQfvUrVeqVeohW
	 A20033eiVAXlsMW6vDjhh0/N3CbLB/FZNnmhuIrERosMXXNFm4RzA3qbWS6TNrbrXk
	 lHlxAfOC79bdb47Orlsx77kb6H1ka6RqU0CLyQL/lrSGy1acr7Dg2fnT6PVtc/DRk1
	 bcnnV44Nt5zvA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso2505732e87.1
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 22:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrUI21Qv7uJap4FkM2GE4sKknGe40IFu/ml7TCZhonGd/ZFxxjPAISbMJ+dD9g8qM5TlBjpxzCr2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwrRDuI6yMLgrw6RYG5Y+z5EXpbePnXyXgYwRovtNXhiTBDA1L
	JGJ9i4CiZR6TXxyZLWmMzWEPML6U9d+8fgGKfRU6hNT0dwXIPIIEyzqNjuBrXdRXM7ZUHa7tjTf
	OMZrdO075uWB7PExjPExS7Vaf8bN5QFg=
X-Received: by 2002:a2e:a54a:0:b0:39b:1e0f:5805 with SMTP id
 38308e7fff4ca-39caa80ec19mr9352491fa.24.1783833674238; Sat, 11 Jul 2026
 22:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704171411.1413349-1-iuncuim@gmail.com> <20260704171411.1413349-4-iuncuim@gmail.com>
In-Reply-To: <20260704171411.1413349-4-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 12 Jul 2026 13:21:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v64V9fXrEZD-mB8cLs0hwp6WbpKhhkDzBqLmnZe5DQBtUQ@mail.gmail.com>
X-Gm-Features: AUfX_mw9aYjn22Umh3bpOaSqB39rYIPvYv_r-wBdphks-YmEqPaE5LTT0cIaXBI
Message-ID: <CAGb2v64V9fXrEZD-mB8cLs0hwp6WbpKhhkDzBqLmnZe5DQBtUQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] thermal/drivers/sun8i: get calibration data from
 two nvmem cells
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 1:15=E2=80=AFAM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:
>
> The A523 processor has calibration data in two nvmem cells. To be able to
> add support, the ability to add data from two cells into one array must b=
e
> added.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

Some of the variables could be moved into the of_property_for_each_string()
loop, but it works either way.
