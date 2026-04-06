Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7D38645C
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488316; cv=none; b=CQZW8PNfX//kT1AU2/xPOGKiSnzsTWV3XHEMsfwquiHqu47/p1jVQjInU7gBBPfI1jmqqRrkkqXL0slvEiWsIAofTSr2w5HEdm1BUAKGn/jn9cKzWXNOOi47jn+Dm1Kihob8Z/IRLXvOtmYQofnrcPCn1eLCnHaZW3YMHi7yOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488316; c=relaxed/simple;
	bh=czV9Z6chk57QBksh3vAy5rzeqz0aLh1uyLfwyZZhYDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FupCFZaTdi7jcQDkWT/u4sEuNGd623KlDffEMQ8ULjPC0x0JUFQhLPVlKuQYA60/CMT3/+yQG12oZdKgdEz2on+7clCGHk+a2KbhW6oTzsJ6+LivfA4zxkHwfYp+/QYVemaW6bhlhPkbteNWokr8LEObdvPEe0YZ7FT2YKZuDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1MnZcI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1MnZcI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0F1C4CEF7
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775488315;
	bh=czV9Z6chk57QBksh3vAy5rzeqz0aLh1uyLfwyZZhYDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L1MnZcI2tpbZigvmYWZsbhFLnRpfj5nZzZx5Dv7TxbVGydW+RUns9/C+XiJlP1a1T
	 2AoF/p6c3DPy9XoM2dRnf0dbBcnhKACfvZvnFNv2PoM1fbemv6O/CQeaJdbvFtRX9s
	 FT9jKBuQrYpIp9xgKf0KtfQt97xc2PYzQ0W84EvV5EcF4AY4AwYQw1S1PyGmdVX/8r
	 kFtCuTfhkUrai6hvKmRpRQ2cYp56GDd6xZI6PGVPZupVBp91BAgw9NvZqrCcpgFPEM
	 rdED9Pbet+h389qJZGuHycikmGrLTRRMxBb12hxY9cMH2RQ0cRAmyfA3L+RK5jybyT
	 Gd2zeETUxuLIA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-404254ffe8aso2679942fac.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 08:11:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2U68wSHMIvhe8AjZyDbNhGOO8MeP9SwbfSBMEaEtBFGTZ53EXSMJ/Tg+pdTr10pVHoC4RB9mUzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF98rrNZ/NrWgd0fGMoQNvKGHRETKczZXJ1vwvANsIibf5c3Wp
	57cFoQAbA0T4YIKa1WBD7D/s7MwjDiePeMXeuxujek6XojefvqdRD6W/PdNKVdpLO0BNSjiAvfY
	oYbVrk5oQ1LqCvyQX08by/4AoonQndoE=
X-Received: by 2002:a05:6870:21c4:b0:41c:af81:2e7f with SMTP id
 586e51a60fabf-422f37e1c3amr7661616fac.20.1775488314922; Mon, 06 Apr 2026
 08:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
In-Reply-To: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 17:11:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
X-Gm-Features: AQROBzDTUo8bxZycfPoSaip6sA6CPMiKeDjmFd3HFK-NWfThls0UZCbUP8ABQKM
Message-ID: <CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: call preallocate_image after freeze prepare
To: Matthew Leach <matthew.leach@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:36=E2=80=AFAM Matthew Leach
<matthew.leach@collabora.com> wrote:
>
> Certain drivers release resources (pinned pages, etc.) into system
> memory during the prepare freeze PM op, making them swappable.
> Currently, hibernate_preallocate_memory is called before prepare freeze,
> so those drivers have no opportunity to release resources first. If a
> driver is holding a large amount of unswappable system RAM, this can
> cause hibernate_preallocate_memory to fail.
>
> Move the call to hibernate_preallocate_memory after prepare freeze.
> According to the documentation for the prepare callback, devices should
> be left in a usable state, so storage drivers should still be able to
> service I/O requests. This allows drivers to release unswappable
> resources prior to preallocation, so they can be swapped out through
> hibernate_preallocate_memory's reclaim path. Also remove
> shrink_shmem_memory since hibernate_preallocate_memory will have
> reclaimed enough memory for the hibernation image.
>
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> Changes in v3:
> - Changed error label names to 'Thaw' and 'Complete'.
> - Link to v2: https://patch.msgid.link/20260326-hibernation-fixes-v2-1-f6=
707d82b7b9@collabora.com
>
> Changes in v2:
> - Removed shrink_shmem_memory.
> - Fixed missing call to dpm_prepare in error path.
> - Link to v1: https://lore.kernel.org/r/20260321-hibernation-fixes-v1-1-5=
fe9637b6ff9@collabora.com
> ---
>  kernel/power/hibernate.c | 46 +++++++++---------------------------------=
----
>  1 file changed, 9 insertions(+), 37 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index af8d07bafe02..d2479c69d71a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -392,23 +392,6 @@ static int create_image(int platform_mode)
>         return error;
>  }
>
> -static void shrink_shmem_memory(void)
> -{
> -       struct sysinfo info;
> -       unsigned long nr_shmem_pages, nr_freed_pages;
> -
> -       si_meminfo(&info);
> -       nr_shmem_pages =3D info.sharedram; /* current page count used for=
 shmem */
> -       /*
> -        * The intent is to reclaim all shmem pages. Though shrink_all_me=
mory() can
> -        * only reclaim about half of them, it's enough for creating the =
hibernation
> -        * image.
> -        */
> -       nr_freed_pages =3D shrink_all_memory(nr_shmem_pages);
> -       pr_debug("requested to reclaim %lu shmem pages, actually freed %l=
u pages\n",
> -                       nr_shmem_pages, nr_freed_pages);
> -}
> -
>  /**
>   * hibernation_snapshot - Quiesce devices and create a hibernation image=
.
>   * @platform_mode: If set, use platform driver to prepare for the transi=
tion.
> @@ -425,14 +408,9 @@ int hibernation_snapshot(int platform_mode)
>         if (error)
>                 goto Close;
>
> -       /* Preallocate image memory before shutting down devices. */
> -       error =3D hibernate_preallocate_memory();
> -       if (error)
> -               goto Close;
> -
>         error =3D freeze_kernel_threads();
>         if (error)
> -               goto Cleanup;
> +               goto Close;
>
>         if (hibernation_test(TEST_FREEZER)) {
>
> @@ -445,19 +423,13 @@ int hibernation_snapshot(int platform_mode)
>         }
>
>         error =3D dpm_prepare(PMSG_FREEZE);
> -       if (error) {
> -               dpm_complete(PMSG_RECOVER);
> -               goto Thaw;
> -       }
> +       if (error)
> +               goto Complete;
>
> -       /*
> -        * Device drivers may move lots of data to shmem in dpm_prepare()=
. The shmem
> -        * pages will use lots of system memory, causing hibernation imag=
e creation
> -        * fail due to insufficient free memory.
> -        * This call is to force flush the shmem pages to swap disk and r=
eclaim
> -        * the system memory so that image creation can succeed.
> -        */
> -       shrink_shmem_memory();
> +       /* Preallocate image memory before shutting down devices. */
> +       error =3D hibernate_preallocate_memory();
> +       if (error)
> +               goto Complete;
>
>         console_suspend_all();
>         pm_restrict_gfp_mask();
> @@ -492,10 +464,10 @@ int hibernation_snapshot(int platform_mode)
>         platform_end(platform_mode);
>         return error;
>
> + Complete:
> +       dpm_complete(PMSG_RECOVER);
>   Thaw:
>         thaw_kernel_threads();
> - Cleanup:
> -       swsusp_free();
>         goto Close;
>  }
>
>
> ---

Can you please have a look at

https://sashiko.dev/#/patchset/20260403-hibernation-fixes-v3-1-31bc9fa3ba2d=
%40collabora.com

and let me know what you think?
