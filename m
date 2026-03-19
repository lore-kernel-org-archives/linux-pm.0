Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E7359703
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950155; cv=none; b=mw5ktEt9ch7y519IogKdO7akpS1nrm6nahpstOOLlwouep1ng0wuEGTT3Q4sbqB54N1SV8luwzpJTv4pbH3sKS85yLQUmYip0KQProvdWuY+YUtCKAjxjm65aHAm6NwtwWZEizjs97LHj/qp+pmXLC0yfkBzY8Dy9xlcYE6p35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950155; c=relaxed/simple;
	bh=MU2PWkwYa9gjkyC4x9WFjSpsoWEcBVGc5WAJ233S1+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fy0AmGn/z7/2dg+1C3a3WaTE3xTjXWs8IG3R6H6omaNOt1L5b9sA9tdyqhBJ7ld3hizRfo1BMAOU64W7vwQItJAw5A1sr25SAK4TZp/sMddv/cBK45dCwty5KA6sWnIWGCksYV3g9P4aPCvAGnGGqfIFfO335vHklS9jr5Vc/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5mNuGPz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5mNuGPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C59AC2BCB1
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773950155;
	bh=MU2PWkwYa9gjkyC4x9WFjSpsoWEcBVGc5WAJ233S1+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d5mNuGPzFTO/HZJ6pqGunNdQBoCAvat+cDGeKNOYOmVLTx8f5g2TV+ff6hF98vUUo
	 zDcyjC5ddaPTwoiHJ7Y5Br1z6G0zH9QF3dqVfh7pV8cF078zrFBL5L0XR6hVvJNDC0
	 645VIMqExMUSekcP03aO8mK5wivjgvp3MpDrBZJ38F5ghPJn2jWSqvSLX4cJ9CpKzB
	 NlnTo9t0+n1fkX841+WJorYRIzBtWVmJpsply2YGjzUpqKgSDdco35rZnGO+4RZB0Q
	 cmj2ICU7JAjRf/kzHNwMZzSWwrM/XgbdL41EmWNABH1mnvTvd6zOr9hTpC5fsXsYvi
	 RWg36X7gtSF2g==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-415b23dd6e5so586055fac.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 12:55:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVG0CFah7VuC9/t+75R0zQq2ufGdwvbvTgIgLFkqcJTbjStorldD9nU1IxtSrG0y25vsejBGtkc8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiMhQgM4+BW//wFOdzkrDTmrw9Er4+1wNru3GRllSxE4gjeW9
	u8p5zeFox9uOhnjDB+eVwVuh2qXIUM8oz0NJhsRP/qxKXgSXMJzjtfbKW4z9gsG61bMfdx4+NyB
	i41P5DzP8Fa7Akf2p6j3rBX7uf/hxNQ0=
X-Received: by 2002:a05:6871:8909:b0:3ec:a08c:9707 with SMTP id
 586e51a60fabf-41c1147f350mr331245fac.42.1773950154297; Thu, 19 Mar 2026
 12:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319142404.3683019-1-youngjun.park@lge.com> <20260319142404.3683019-4-youngjun.park@lge.com>
In-Reply-To: <20260319142404.3683019-4-youngjun.park@lge.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Mar 2026 20:55:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i+KdG1FFTrrpt4fV_DDbY833yDzDs42Me7qmzxfCi73A@mail.gmail.com>
X-Gm-Features: AaiRm52qe5LG4Isvbu9lBVNG-YYTUoDnvsDwaG5GsrQgc9ibs7NjaQkQKJwUaqs
Message-ID: <CAJZ5v0i+KdG1FFTrrpt4fV_DDbY833yDzDs42Me7qmzxfCi73A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM: hibernate: fix spurious GFP mask WARNING in
 uswsusp path
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 3:24=E2=80=AFPM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> Commit 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask()
> stacking") introduced refcount-based GFP mask management that warns
> when pm_restore_gfp_mask() is called with saved_gfp_count =3D=3D 0:
>
>   WARNING: kernel/power/main.c:44 at pm_restore_gfp_mask+0xd7/0xf0
>   CPU: 0 UID: 0 PID: 373 Comm: s2disk
>   Call Trace:
>    snapshot_ioctl+0x964/0xbd0
>    __x64_sys_ioctl+0x724/0x1320
>   ...
>
> The uswsusp path calls pm_restore_gfp_mask() defensively in
> SNAPSHOT_CREATE_IMAGE and SNAPSHOT_UNFREEZE where the GFP mask may
> or may not be restricted depending on context (first call vs retry,
> hibernate vs resume). Before the stacking patch this was a silent
> no-op; now it triggers a WARNING.
>
> Introduce pm_restore_gfp_mask_safe() that skips the call when
> saved_gfp_count is 0. This is preferred over tracking the restrict
> state in snapshot_ioctl, as incorrect tracking risks leaving the
> GFP mask permanently restricted.
>
> Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  include/linux/suspend.h | 1 +
>  kernel/power/main.c     | 7 +++++++
>  kernel/power/user.c     | 4 ++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index b02876f1ae38..7777931d88a5 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -454,6 +454,7 @@ extern void pm_report_hw_sleep_time(u64 t);
>  extern void pm_report_max_hw_sleep(u64 t);
>  void pm_restrict_gfp_mask(void);
>  void pm_restore_gfp_mask(void);
> +void pm_restore_gfp_mask_safe(void);
>
>  #define pm_notifier(fn, pri) {                         \
>         static struct notifier_block fn##_nb =3D                  \
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 5f8c9e12eaec..e610a8c8b7ff 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -36,6 +36,13 @@
>  static unsigned int saved_gfp_count;
>  static gfp_t saved_gfp_mask;
>
> +void pm_restore_gfp_mask_safe(void)
> +{
> +       if (!saved_gfp_count)
> +               return;
> +       pm_restore_gfp_mask();
> +}
> +
>  void pm_restore_gfp_mask(void)
>  {
>         WARN_ON(!mutex_is_locked(&system_transition_mutex));
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 3e41544b99d5..41cff6a89a1c 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -306,7 +306,7 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
>         case SNAPSHOT_UNFREEZE:
>                 if (!data->frozen || data->ready)
>                         break;
> -               pm_restore_gfp_mask();
> +               pm_restore_gfp_mask_safe();
>                 free_basic_memory_bitmaps();
>                 data->free_bitmaps =3D false;
>                 thaw_processes();
> @@ -318,7 +318,7 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
>                         error =3D -EPERM;
>                         break;
>                 }
> -               pm_restore_gfp_mask();
> +               pm_restore_gfp_mask_safe();
>                 error =3D hibernation_snapshot(data->platform_support);
>                 if (!error) {
>                         error =3D put_user(in_suspend, (int __user *)arg)=
;
> --

AFAICS, this patch doesn't depend on the rest of the series, so I can
apply it separately unless there is a problem with that.

However, for the other 2 patches in the series, I'd need some tags
(preferably Reviewed-by) from mm people.

Thanks!
