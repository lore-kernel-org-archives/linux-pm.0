Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978946D2D7
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813541; cv=none; b=UUb+TQSwYQDRYqijXUkVsZxPtKHqLVAMw7CYNzB3rcpzzoYwJaL0V4IRGXZx0+rMZeW6jVDbotpMQQNQc640cEZr6m8LvmNZmH5b1tF1YmZE7eqKC8RG68W0eSvkLMr9r15RK/OYPrv48pRK1ZHk23qZCl8XdgQqzYRFe2kmpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813541; c=relaxed/simple;
	bh=7U1CdK0hYrsoj1y42u4LxiU9iDmAHKd6NpZs5/3Ck8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ43wl4c7m98EyV0aaQ+no3PMmMg6HkvLa9a9KctzGy0USplUR67JS9TKsjL5Q4WENbjv9dywZ2PA1RcwfUZu2na+z+LfwmpbP6/DnV9RfcEHTi33iTkU0+VJkHHzKSONL09Hsdx2x8qIG2n5LOYuecCqmfLdoCTsSETuPn0NTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLmbqd0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLmbqd0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98D01F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784813539;
	bh=kZL4vCs4/ms6UpJ87qnIgMkSTyik8rwpBkxkcswBaVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JLmbqd0pOSKHB0YMfyxP8aipLsb7q+jB7Jbr3SL0apdv/Wosoul6VyuAQaRn5VSqs
	 Gi0Ktsj9DbjieXf5rxMJN0aVfaIRWiWHUG0Ncf2ZPzRNMFOkjJLanU4w1QnNtZyUIp
	 nTx1/oMNsZlaHnS/rch+Mres82wS5/KvII60CrfKVlmY8Ikxb8PX/wQFaSVuCRnkLR
	 azvHKHVce8ZMZ1AbMUVN3irT1mz1/6gM+jXMvdzgvHrSERDD/Uqb+PfcY6zixH/Naj
	 T04sZlWFCEaew5vsPWnxvzWxJtD5WCXw5RbzdmfOH9h9JulkHDITWbghZhY5bTlve/
	 DC3ZpG7bSkmhg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so738007e87.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:32:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpNOt/Gfj/k4bbQNBh1zeoUc6cZhfNxt0/vbs/SE+5UAqiWC/Xve3IpYi1l/hYmi7SL0HD8S+drPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD42E1cZUd09XdMDU4iJsIZDIEiIWxmtjnLvXEcgrlv86n1JFU
	9AfLAlc+3SmoiKOvKVIGNV0lcl/JDWJlZBYkN2Nh/MPJbnplTtkD2G888czcXm1UJ6kJ2h7ouJi
	cF8HVXL6wTAUMJth8M8tDMKaey4QDhbA=
X-Received: by 2002:a19:5219:0:b0:5b0:e15:772e with SMTP id
 2adb3069b0e04-5b2b2f74f39mr495770e87.51.1784813514124; Thu, 23 Jul 2026
 06:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-copy-data-pages-show-speed-v2-1-6e30f15abcc1@collabora.com>
In-Reply-To: <20260715-copy-data-pages-show-speed-v2-1-6e30f15abcc1@collabora.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:31:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCUTY+qa4BetLUZznUzEfb81aqijn7gg_t=t9jytfVxw@mail.gmail.com>
X-Gm-Features: AUfX_mw3kRNhpVSJ0xuR1XZlwu20fM8kjOF5o5lXjc6qtkJsuTWnLYSpg0_OxsA
Message-ID: <CAJZ5v0gCUTY+qa4BetLUZznUzEfb81aqijn7gg_t=t9jytfVxw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Print speed statistics of copy_data_pages()
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	kernel@collabora.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:51=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> copy_data_pages() can take a long (multi-second) time to finish, and
> currently the only indication of that is the timestamp difference
> between print messages right before and right after. The timestamp is
> also immediately reset afterwards to the time before image creation,
> making it even harder to spot this delay. Furthermore this function runs
> in a critical section with a single CPU online and syscore suspended, so
> it should be kept as quick as possible to keep the system responsive.
>
> Add a call to swsusp_show_speed() to report the amount of data copied,
> time taken, and copy speed of copy_data_pages() to make it easier to
> spot delays and verify performance improvements. The current time is
> obtained through local_clock() instead of ktime_get() since timekeeping
> is suspended in this region.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Patch split from series
> - Use local_clock() instead of sched_clock()
> - Account for total pages copied (nr_pages + nr_highmem) instead of
>   final number of pages in copy (nr_copy_pages)
>
> v1: https://lore.kernel.org/all/20260518-hibernation-decrease-time-in-cop=
y-data-pages-v1-1-3998bdf90ee5@collabora.com/
> ---
>  kernel/power/snapshot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index d933b5b2c05d..42c730fadaed 100644
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
>         pm_deferred_pr_dbg("Creating image\n");
>
> @@ -2130,7 +2132,14 @@ asmlinkage __visible int swsusp_save(void)
>          * Kill them.
>          */
>         drain_local_pages(NULL);
> +       start =3D ns_to_ktime(local_clock());
>         nr_copy_pages =3D copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
> +       stop =3D ns_to_ktime(local_clock());
> +       /*
> +        * Zero pages are overwritten but still copied, so account for th=
em
> +        * in speed calculation.
> +        */
> +       swsusp_show_speed(start, stop, nr_pages + nr_highmem, "Copied");

Sashiko has concerns about this which look valid to me:

https://sashiko.dev/#/patchset/20260715-copy-data-pages-show-speed-v2-1-6e3=
0f15abcc1%40collabora.com

>
>         /*
>          * End of critical section. From now on, we can write to memory,
>
> ---
