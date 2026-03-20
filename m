Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A123B2FDC
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030836; cv=none; b=GRHQXJdqctIinw+W+2CxYpNA0iMrPXCJkaJr9wDHmtpI+l/STcUxYR12DxIVFFacuNaTAD58RJWCuf9YzwGu/Ri+MPKYsP2pNAxpTUO71DBq5ST6AA+GK9U04vYGm+Xn5lIwGT1lOEpDKClKd3WhSwVV2cA3A5o5cnHRk0BEmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030836; c=relaxed/simple;
	bh=/2FmF1+s9+JnUik8tx08R8i2DCSkv7HYbO/lzTxtn9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx8DioC6mHf3uMOCzy1rbfL8vx/WVvdLjHxDMtxeYf5S0iz1SpylfVh9NBJzpOx9RU/7HBV3jDoDr4XT82ETpMNhFuBDn6PwjG2weVEM9BtpVgYr4DAR8svgsjChGyrlJU2psy6WYY1jKegLNqyJfQaLi03+uQw+Pwr5QE4ZYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVMqG1mC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVMqG1mC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60841C4CEF7
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030836;
	bh=/2FmF1+s9+JnUik8tx08R8i2DCSkv7HYbO/lzTxtn9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qVMqG1mCerSIzYCTuYFicWV18EMmjuYGgjXj1gFLkmqNKhYmfOpzbDvL8pk4lKZEo
	 t+sgjiQUYKtMSaFZ9JDu4IITHwDFHMGbKYwlSyNR8qurIyTp/nGn+kN03BKKq1jKtY
	 Ow0Dnsf+ZxbAZIovTbiewSShLyruuRfdF49MqnA1vFjkYHF4xBbTak1UlUMgQZlgHL
	 nZ6kKk1DkqCbNAMcZhzQuq+L6PONmDUntUiqS0PN4cZnk7C2+Oirj+nYlPhIxwqXvD
	 CXwU/Fiqjk+Fw43KTnMzUK1y/W7myHVvCs016y4us934SnGaaY66ExLNlHOmhICOCT
	 Kz6jZa5lMCsQg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4670676ba03so802213b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:20:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpZKze7IGjAYLJVh4BhXAtdz4/vpGo4dhlOI3+FfoHl6THKfTNrNfKX4/N1WKHxnM+BbZL9WoFQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOl+reXi1O/NsM/xtTl4Ots9eXHrIGGZQZ5zRuxVftevnx/07
	Fs8oG29KOyVorRlP4uu3nhZC4zQUXyKaKrcxWhmYGAIHjfdf3JOQS8nQitp7Jv6jBcKcMBw+L0a
	q4NemT5LuvgdFwOry1saMoEY8aoiEr2g=
X-Received: by 2002:a05:6808:1645:b0:462:dc57:f8ba with SMTP id
 5614622812f47-467e5f095d0mr2208888b6e.27.1774030835503; Fri, 20 Mar 2026
 11:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320170313.163386-1-youngjun.park@lge.com> <20260320170313.163386-4-youngjun.park@lge.com>
In-Reply-To: <20260320170313.163386-4-youngjun.park@lge.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 19:20:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>
X-Gm-Features: AaiRm51AjAgtOUbYQswu1KWiSaj81rVMqfYBli5jqjANmDWpKKnCsKuexQlpqPY
Message-ID: <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PM: hibernate: fix spurious GFP mask WARNING in
 uswsusp path
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Again, this patch does not appear to depend on the rest of the series,
in which case there's no need to send the other patches along with it.

Please send the next version separately unless there is a dependency
on the other two patches, but in that case that dependency should be
explained in the changelog.

On Fri, Mar 20, 2026 at 6:03=E2=80=AFPM Youngjun Park <youngjun.park@lge.co=
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
> SNAPSHOT_CREATE_IMAGE, SNAPSHOT_UNFREEZE, and snapshot_release(),
> where the GFP mask may or may not be restricted depending on the
> execution path.
>
> Before the stacking change this was a silent no-op; it now triggers
> a WARNING when saved_gfp_count is 0.
>
> Introduce pm_restore_gfp_mask_safe(), which skips the call if

It would be better to call this pm_restore_gfp_mask_nowarn() IMV.

> saved_gfp_count is 0. This avoids the warning without requiring
> state tracking in snapshot_ioctl, which could otherwise leave the
> GFP mask permanently restricted if mismanaged.
>
> Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  include/linux/suspend.h |  1 +
>  kernel/power/main.c     | 18 ++++++++++++++++++
>  kernel/power/user.c     |  6 +++---
>  3 files changed, 22 insertions(+), 3 deletions(-)
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
> index 5f8c9e12eaec..90e9bd56a433 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -36,6 +36,24 @@
>  static unsigned int saved_gfp_count;
>  static gfp_t saved_gfp_mask;
>
> +/**
> + * pm_restore_gfp_mask_safe - Conditionally restore the GFP mask
> + *
> + * Call pm_restore_gfp_mask() only if a GFP restriction is active.
> + *
> + * After GFP mask stacking was introduced, calling
> + * pm_restore_gfp_mask() without a matching restriction triggers a
> + * warning. Some hibernation paths invoke restore defensively, so this
> + * helper avoids spurious warnings when no restriction is in place.
> + */
> +void pm_restore_gfp_mask_safe(void)
> +{
> +       WARN_ON(!mutex_is_locked(&system_transition_mutex));

Could this be changed to lockdep_assert_held()?

> +       if (!saved_gfp_count)
> +               return;

Please add an empty line here.

> +       pm_restore_gfp_mask();
> +}
> +
>  void pm_restore_gfp_mask(void)
>  {
>         WARN_ON(!mutex_is_locked(&system_transition_mutex));
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index aab9aece1009..88de4b76a9dc 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -119,7 +119,7 @@ static int snapshot_release(struct inode *inode, stru=
ct file *filp)
>         free_all_swap_pages(data->swap);
>         unpin_hibernation_swap_type(data->swap);
>         if (data->frozen) {
> -               pm_restore_gfp_mask();
> +               pm_restore_gfp_mask_safe();
>                 free_basic_memory_bitmaps();
>                 thaw_processes();
>         } else if (data->free_bitmaps) {
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
