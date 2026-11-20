Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192898;
	b=JN9IUvZ0e83wi8ZZjZcQDoZ1NVpMyUHa+u+KlTeIfJ947+52EgyrTZ5YZigDD8Dp08Bd
	 aEbGHlvSvr1PvToRggzEauu/Sd92T96CiM1bNFnfYQfl0f0vLbusna5XIKVR3m6cltymo
	 kRQUAtKR1+AjjseHrVL+KU7iDCIsx5kaFaIIfmlByPESJChQtBwuKIf08W9SI6AdfhWsJ
	 kRGk2iPuV1AAkiLXo8Q64Nes0zrklnsCjCu+kgzjzyPYZMJx/h1Cp1hl1W76cQGBb3TgN
	 b5H4RfC6VpYfX3/CYWMTpxUaG3M9kZmai34n6Y1aExxqFxlaDoq9V5kwLSQgcda3HNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192898;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BU1zg1ONXDx5a3mVAu66HlEYVOudpYSiqol3xpcTdZo=;
	b=5bobmomGeDl9/ukO8Z3X0PUJD8lOnQPCEJsSD5pYjFfneQg8bjR4uZsYx98s1tPKQRic
	 8vBpIFwbmjmLyJPkx9GIT5xeNQJlSRWbJsRnsC7fXjENWY6LfxQvP3pQbKtraDLb7bDRc
	 eKOucMU9EdKOy+7U+sDlX10Zs7bNGO1Ha8yG8TXoUsP6iJooDbE7MOKwhkl2ytfhca6J7
	 KJjqZ7in2ZEW19CfoU6kN/V2el6C1n6GsSrlb4cBVow5EUzPDTULs+upE5XnBdc8ZVC2s
	 8mlL67lSNBImj759dO9kv3rTIt+lt7mtQwVvv9nzsngmqBcDA3yrpXy1+xI6Oj24edw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP5Nsj5d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A893606A61F
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP5Nsj5d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB361F000CF
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795192897;
	bh=BU1zg1ONXDx5a3mVAu66HlEYVOudpYSiqol3xpcTdZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BP5Nsj5dX3BqLnE4PU69kVoaY8OF68r7yYPApHgpijX/Qqp9Bgn/wIIgP7/LCFb21
	 iUWj0dhcvTJovCDH5IliZFigZoH5KbbYClBtiuGBAD95qCxJ8cJeLuoFCfGW2ouiak
	 biIKdiSXxRWo0kpXbJPaoZvtPGAuCPZAqf4igf7QPhoT98N1iqw0xVCtxZ1DFFNqDC
	 ZtOJZN0b7WmjgOKn2HcRDxMN4gD9/1dqMk1t5agyEvScLfPRUpOPYTGFRdB5VrbFwh
	 NSYXyznGPtxCTUZz/GYI5EVzKg4GJwNpi0X8h/ReOG1nfX9ZeicGc6sygXFW98gxNh
	 JS4oK16Z2wYEw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae0a5c1715so21795831fa.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:41:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFWgsUK50NXQuP0pz7ns0pxxsHHE2GNV6kaTjYhdK+3nXiUIBEn9Fb0ghhm8k01/uKPdVnpOjVDdA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9uVVHdpc8pcNJVsb4dLiTB/60/NgopFBrg/sID+11fu5j5TtTW
	lhIL5w/ILhHhtm58VMYj9hddrTzYk1auHehALo2O+AxUVBtK5fMuk091RAhaJXW1kX8X8BAHizz
	OP2AvZ7qxQF9F5Sv8ZQ7absSK8gDTnzw=
X-Received: by 2002:a05:651c:19ab:b0:3a9:7c85:a16d with SMTP id
 38308e7fff4ca-3ae7b7b78b3mr14455201fa.5.1795192895959; Fri, 20 Nov 2026
 08:41:35 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <10852BF0B4974597+20261113010134.1408010-1-tuhaowen@uniontech.com>
In-Reply-To: <10852BF0B4974597+20261113010134.1408010-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:41:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j79Z35=G0j53UYxzY9T_vgpzhrMAWdejTfUZ=tYXLM8g@mail.gmail.com>
X-Gm-Features: Aa3M54oMdW9NFAWI5Xwg3P8Dl0rSValX0ljF28RxR6wfeHuOJynyI1LyNJbsllY
Message-ID: <CAJZ5v0j79Z35=G0j53UYxzY9T_vgpzhrMAWdejTfUZ=tYXLM8g@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore PM notifiers on snapshot open failure
To: tuhaowen <tuhaowen@uniontech.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:01=E2=80=AFAM tuhaowen <tuhaowen@uniontech.com> w=
rote:
>
> Opening /dev/snapshot for writing calls the PM_RESTORE_PREPARE
> notifiers before allocating the basic memory bitmaps. If the allocation
> fails, snapshot_open() returns an error without sending PM_POST_RESTORE.
> The release callback is not called after a failed open, so it cannot undo
> the preparation either.
>
> In particular, the firmware loader enables firmware caching during
> PM_RESTORE_PREPARE and relies on PM_POST_RESTORE to reset the cache state
> and schedule the cached firmware for release. An allocation failure can
> therefore leave firmware caching enabled after the restore attempt has
> already failed.
>
> The robust notifier call only rolls back failures within the notifier
> chain. It does not cover a subsequent failure to allocate the bitmaps.
> Send PM_POST_RESTORE for that failure, after a successful prepare call,
> so that the notifiers can undo their preparation without being called
> twice when the prepare notification itself fails.
>
> Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>

Can you please put your full name into the From: header and the
Signed-off-by: tag?

Failing to do so causes Sashiko to complain unnecessarily:

https://sashiko.dev/#/patchset/10852BF0B4974597%2B20261113010134.1408010-1-=
tuhaowen%40uniontech.com

> ---
>  kernel/power/user.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 6e4f40e49319..e7e8016a4f1a 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -87,6 +87,8 @@ static int snapshot_open(struct inode *inode, struct fi=
le *filp)
>                 error =3D pm_notifier_call_chain_robust(PM_RESTORE_PREPAR=
E, PM_POST_RESTORE);
>                 if (!error) {
>                         error =3D create_basic_memory_bitmaps();
> +                       if (error)
> +                               pm_notifier_call_chain(PM_POST_RESTORE);
>                         data->free_bitmaps =3D !error;
>                 }
>         }
> --
> 2.50.1
>
