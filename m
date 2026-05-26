Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631D3E00A3
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794732; cv=none; b=fdkSx26JGW1N2AWpdWZTlke+82lZTm5vC6Z2VuxictMMDNwrO78Eg2LuMCUzFZYaJQZoBDDAilbKdVN9oUGVGPY57x2OpMY4ZFgCvqykgZn1kgYCboXYMjRtnexoEFVwXkORr0T5VqMIs/g1wYFstuQ+Fcus3pgPgNXP1socebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794732; c=relaxed/simple;
	bh=O8ddMNfPCfmUOcGlURjNRHjlWocWu80ho8RtB15Odxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGuKNMT4GCdIdHTXLxY82Y69srk5eO1qCXLxOTBO7J1N2BYyCFw0NUE4ydw4zGNi8Qb1W0FZsB3BjwtQfG+g7riJvmtyOs4OuGTMl4SAAXHYW4svHjBaf1taxwpnQuBdp+QE0D57NoTxD/yR6tcmDpNsGqZkmUvP+SGnq77fLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Xoc3vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Xoc3vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C6B1F000E9
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779794730;
	bh=6VoW69WzwVz3xsGD2O/BMdI9J7BJxNaO5gVD3szcXuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K6Xoc3vXSup79A47YD8POddarHQQ3UHtZX8fTZi32rXS3CHSPQbErUwkBbix1Z3oO
	 GWnAmgUajYq34iDCu2dMgyafGdwroyXfdm83Kbz820fu9q1ydywyEgZBDKHf+EaXhW
	 TsgKyLcwt7tCaR3HLi7sz6gi3A9ncsfzlzBy3Izf3xZHQ6XCRSu7FWbk/MINbEFxEa
	 v6OXyLrhnBxS7B+5Dy/+jXWZTOyX9cfdD+HW5f/tb79B3Mdy/gfEX05w6xBMvKD8Ba
	 srmoCwNMdrkpNDRx2BZTVTb4+AOwB03c2CYX9g1qglEoOzXlcM8GLLu3fl+eeNNbgk
	 OnNYmrBoVWfFw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso11750712e87.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:25:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/KpbomfJ3SL2JPveoEghd//ttjZiUKq703zYtQsbUqv1FedTrIfQg0lYo9iN48YT2D6ytEhRMMZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkq06p+ZXDoPV5i4uVaGDoMT9EFitOF0EwN8CaLgy6wjE5Ccuz
	CPAiVLjXnSAb3N8h08xz+9CoJdP8/M8J2a7kTZWE0Wpk9W0/ZaOXNCtcLNniA1Qr2NG1TK9uDYS
	Do4ZdPC9K8eCP5uTMdbwafIoJt2DP9q4=
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id
 2adb3069b0e04-5aa323a9065mr6215929e87.41.1779794728521; Tue, 26 May 2026
 04:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-1-3998bdf90ee5@collabora.com>
In-Reply-To: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-1-3998bdf90ee5@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:25:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4nsD8NJr_M_W8_rk2DM_0HBE-jnDyJe2zV+qdeK7UOQ@mail.gmail.com>
X-Gm-Features: AVHnY4KsXdh1ZYWed62_n8nqM9ZYWswEWeopoTUVfAykx70kSrcCpUPfgaL7ndI
Message-ID: <CAJZ5v0i4nsD8NJr_M_W8_rk2DM_0HBE-jnDyJe2zV+qdeK7UOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: hibernate: Print speed statistics of copy_data_pages()
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> copy_data_pages() can take a long (multi-second) time to finish, and
> currently the only indication of that is the timestamp difference
> between print messages right before and right after. The timestamp is
> also immediately reset afterwards to the time before image creation,
> making it even harder to spot this delay. And this function runs in a
> critical section with a single CPU online and syscore suspended, so it
> should be kept as quick as possible to keep the system responsive.
>
> Call into swsusp_show_speed() to report the amount of data, time taken,
> and copy speed of copy_data_pages() to make it easier to spot delays and
> verify performance improvements. The current time is obtained through
> sched_clock() instead of ktime_get() since timekeeping is suspended in
> this region.

Why not use local_clock() for this?

> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  kernel/power/snapshot.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index e249e5786fbc..4f452baf31dc 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -13,6 +13,7 @@
>  #include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> +#include <linux/sched/clock.h>
>  #include <linux/suspend.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
> @@ -2109,6 +2110,7 @@ static int swsusp_alloc(struct memory_bitmap *copy_=
bm,
>  asmlinkage __visible int swsusp_save(void)
>  {
>         unsigned int nr_pages, nr_highmem;
> +       ktime_t start, stop;
>
>         pr_info("Creating image:\n");
>
> @@ -2132,7 +2134,10 @@ asmlinkage __visible int swsusp_save(void)
>          * Kill them.
>          */
>         drain_local_pages(NULL);
> +       start =3D ns_to_ktime(sched_clock());
>         nr_copy_pages =3D copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
> +       stop =3D ns_to_ktime(sched_clock());
> +       swsusp_show_speed(start, stop, nr_copy_pages, "Copied");
>
>         /*
>          * End of critical section. From now on, we can write to memory,
>
> --
> 2.53.0
>
