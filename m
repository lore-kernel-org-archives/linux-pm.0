Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DF495AE7
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996167; cv=none; b=HEw5yxWk9pqR+NvdOe/7ObIrDsxuSwMkdSacGnwW3J7txe8jlnDBbZ+oRnw1Eg/MceFvc5vTTqD2zra4RWuM1YbFRfFiO8pE570ip2a3jCxQR/PtSvxqawcRWYkPpdzt+rgnL7bmrNIpDxaHuRFDrBVeOsqob+G9vuckbJwNSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996167; c=relaxed/simple;
	bh=YDs7MIlX8JsGIUo3tbwX046GT9jZ2L7QPkHJbAmrkgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4IXgaaCucyDDgUbdazoKiI7zPOC+dTg068cTKRIA09ay6R8pF80ylmwfKn9WnTEWhjKqYR9E41TVshw+1ZLnqntRHDg7JMVAKk65WWo76RNcW3TLpbeoKFtP6SiWxxoqDdL0ecklb4mLojyakY6py82hlVJZsZraLW0QvUmS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzMGr6GA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzMGr6GA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C001F000FF
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996166;
	bh=q/C+TkovrfS7xh0NX0AU1j6790V/SQ+1uydnthmXsm4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=QzMGr6GAr2rUGswl3cxf536nnRbMwyHgvVG6g2aKIicA0h9TD1UXobSJE3/MC1X4R
	 Uk0r6WVokXmoqsW/PplRTS/M6gGwttVdtMCvNcAwlopLNM3AvZdJ3Rs5xl/AY1enbl
	 hGZyncdrztkEFEd3z5upbOG/36V+9y+SYc06tBvXWV6emOg3WFHBKqvZ9FFOpZZl4N
	 QxWxHebn56T3LwZ9z71FetDU/MGpyon3UanWrfm9y+aWsgknxvOLgwT29IPgfZ8z0k
	 Ui89wvxHHBHg8qb2wvsUAbtNSCwMTByTwgKcvsSfscXtx5YRqxHG7AzBpvc3B3dblG
	 0LOm8cq7+/hsQ==
Received: by mail-lr2-f28.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so23579781fa.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwfOrE3O1ICB5jOglKD5ShEHK4z1FcCZV40iqBGaBr4pGuPsLD2U5joU1icLLquQEPhyKye76lpDA==@vger.kernel.org
X-Gm-Message-State: AFuF++kEfvgjx0eUJG22SALWHEFHhZnB9K3YgUHkKcN8PHtPBfCYWC3I
	EYm4bsrSNwbYS+yx5O+eeO00egOVZIx4O3I2Cm4R4NkwDugnHJTHkzsfYH1FY+6Vd6+zdtRj//b
	v2iIp2P1zxOMFAPLHEIQiGH2MObJur/M=
X-Received: by 2002:a05:651c:509:b0:3a3:7682:49a0 with SMTP id
 38308e7fff4ca-3a5fc0a87b3mr23796891fa.21.1789996164981; Mon, 21 Sep 2026
 06:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789983244.git.ukleinek@debian.org>
In-Reply-To: <cover.1789983244.git.ukleinek@debian.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 21 Sep 2026 21:09:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v655yJYigaqNFeUxXiz+yXMG0SgBPjb0k=AyuMqq66tGYQ@mail.gmail.com>
X-Gm-Features: AcwNN1VfEIiQSwKSNJjpSkRCEsb6EEJxj7KXX0abnLdITfYeVbNwAdMJfk3TyV4
Message-ID: <CAGb2v655yJYigaqNFeUxXiz+yXMG0SgBPjb0k=AyuMqq66tGYQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Drive-by changes to axp20x drivers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc: Linus Walleij <linusw@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:42=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@deb=
ian.org> wrote:
>
> Hello,
>
> while trying to help a Debian user debugging why USB doesn't work in the
> installer on a bananapi, I discovered these patch opportunities. They
> are only build tested.
>
> The first patch touches a different subsystem than the other three, but
> given that maintainership overlaps and the first two patches are
> identical in spirit, I still created a single series only. The two
> subsets are orthogonal, so can be picked up individually by their
> respective subsystem maintainers (and please do so assuming you're happy
> with the patches).
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (4):
>   pinctrl: axp209: Drop check for disabled devices
>   power: supply: axp20x*: Drop check for disabled devices
>   power: supply: axp20x_usb: Introduce a helper variable for &pdev->dev
>   power: supply: axp20x_usb: Improve probe error reporting

Whole series is

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
