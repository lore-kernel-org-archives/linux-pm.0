Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709463E1D0E
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961148; cv=none; b=HMtsS/tJNIW2laYmX592jYnRpOW45gQswb6VVJTzy1LVe12657dDxHBpq3Dt3My8GgKyro4LgeoulLJHPSVYGrMeGsp5TWEKIKeyZrnsUG7DNNtRZYxIt5WLnhSxz4/hm/W11xC1AYLSA1hTfjjQApDTP4B38ulxPTcUZT8o4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961148; c=relaxed/simple;
	bh=63xAkHfhONGpFnJuCZYgYjWIcctaOjWDhbc90DUQ1ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQ8yowi0mh29nBF2qiqd9vgvocaNyPmJHHENo3D6dzWG/ZOK0qH86QQTU9wROfCw8gcuLOLBC+pTdM5C7+RzukOxakW7IYERHUprSn1fiuTLI1jC38BIkeNDXjB5VFIIALHGI3040ycjjbXtN5/nn9PMPE6eVCW0yGF0qmfPgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP6hcOWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP6hcOWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D320C2BC9E
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774961148;
	bh=63xAkHfhONGpFnJuCZYgYjWIcctaOjWDhbc90DUQ1ts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NP6hcOWQrvmYyRaNcd5iPE4Ay0UY71j7NfhAR4LL8HQQOts3PsxNlvyA4zncHp0zY
	 HuTorn2+fF7egy2bPxK3fZ8m2tFz0C7dUc3dRHS1cv7gGo+pIttdcSM80EsxlWTYGU
	 jAf5EQ6wMfqGZjGg17HWS61bWsgEDVpXa2Q6oKvMCDFEFuLw/3ilA84QxMAfwGdU1n
	 KbbyslYN2xYVakMKdeakDW9CZNCaFMVT3BV+hf6xG5Eqn3dq+UG54F7Cpi2AsTNcDJ
	 IIJ77QOlhPthI1XMa/7Aq2KYmqBcA8ipUA7m/VfhSkTGHEu+BBWfFcvzKBA/YA3+O5
	 R+cTzbnUK0QMg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40f387a688dso4433413fac.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 05:45:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgMsNXORJmgKz7sNMPZPUAbULj0+gG/lRpdtArxFuQIJfNhdN0KT/QMkFUkHvmALJtllv+r6IlRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUdtsiVKpYIr8Lw7Mkw7rC/6KjaADv1IXF+LGMajuLimj1vzG
	RvMb3tWNvBiy32tVrStH7EN2RkPLjAerfyOt9SratDqon5l/z4artM0P0j60UKpkhQcojgDRGuJ
	ryzWsWmjn7A6P61/sh1MewG0ctcTCAq0=
X-Received: by 2002:a05:6870:2042:b0:417:56da:593c with SMTP id
 586e51a60fabf-41cec38bcdcmr9271615fac.45.1774961147332; Tue, 31 Mar 2026
 05:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com>
In-Reply-To: <20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 14:45:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjaMFezGQx+pF-TuLBQ-8wNYzd8ZBu+6XCV0=YgEx0Ew@mail.gmail.com>
X-Gm-Features: AQROBzDDopFWGVRgx8adIRknC1Taf7UgKV39Bmuz3W-ercJieJiaTYCiTzTShA8
Message-ID: <CAJZ5v0hjaMFezGQx+pF-TuLBQ-8wNYzd8ZBu+6XCV0=YgEx0Ew@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: call preallocate_image after freeze prepare
To: Matthew Leach <matthew.leach@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:37=E2=80=AFPM Matthew Leach
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
> index af8d07bafe02..39b0a8ea4024 100644
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
> @@ -441,23 +419,17 @@ int hibernation_snapshot(int platform_mode)
>                  * successful freezer test.
>                  */
>                 freezer_test_done =3D true;
> -               goto Thaw;
> +               goto ThawKThreads;

Do not change the name of this label.

>         }
>
>         error =3D dpm_prepare(PMSG_FREEZE);
> -       if (error) {
> -               dpm_complete(PMSG_RECOVER);
> +       if (error)
>                 goto Thaw;

But add a new label called "Complete" for this jump.

> -       }
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
> +               goto Thaw;
>
>         console_suspend_all();
>         pm_restrict_gfp_mask();
> @@ -493,9 +465,9 @@ int hibernation_snapshot(int platform_mode)
>         return error;
>
>   Thaw:

swsusp_free() needs to be called here AFAICS or you'll see memory
allocation failures subsequently in some cases.

> +       dpm_complete(PMSG_RECOVER);
> + ThawKThreads:
>         thaw_kernel_threads();
> - Cleanup:
> -       swsusp_free();
>         goto Close;
>  }
>
>
> ---
