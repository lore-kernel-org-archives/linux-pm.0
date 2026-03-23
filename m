Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF931DF980
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271221; cv=none; b=KGIOZA8hnMgf50l89Y+b6Iyzava3VibK75CcDUhGjQgWbnvqAZYSNtAsPTBWoQ/i/q9Wc4WkKTN7xrqSuaXiA6Q6ec/G1VFnP0sAxxhe9nSC0VonzK3MnEUPQSZ91K4F+nzUVZJw/yZQH4zbkxAFkhDAKoow4o+iRlN1kT3f82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271221; c=relaxed/simple;
	bh=I7nCy7Qbwb2je4sJXtx/O3Rh+7iWUUnkNscpPA37Hfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R28jrWw+fF56w/QmBlBy8FIXwqeLSOBDgdzzF6BgipL6G+4rpwEdOK6VAtyhhySw2/xpWdLj8Lp9zeIrA3A4iKGA/3+LQbb1sljRR4ZAdoisch1eClxr51z8pIbiAyFBhsbvHmw8C0uNtJbktpOFeVPryX3VVtJ1oJEG9d8PcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE+2BdIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE+2BdIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8CCC2BC9E
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774271221;
	bh=I7nCy7Qbwb2je4sJXtx/O3Rh+7iWUUnkNscpPA37Hfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dE+2BdIbQHvd3KvToJMweOqsjaCb35Noc6BswoUza5bhihhNx/6xQNNWCKobTY4tP
	 ESBy9W9r+Y0pWLZHYX2Keyb1DQIwFyUcpwdg2z0FnhweopqQCrqg2/s4a6xVKV73XO
	 G9KBuNA/xwMEz0q+a2qUu0wLuw1lyfoPqD07Yq8K+tnkKKSD2a0BA2Zo/b8uZFLeJq
	 bKUVKh3SNXGA+Ol6WgfFm1HrWmdtdYUEgeA1BjiXGn7L/M/wuCoFQ6+FP94mX3Trg5
	 2hoTKkINx/OvdbcaD/LjpeEzkyIyfBI5MHHKFTKlLn8UcTlWrYdXfZS2SBrjjf9B/4
	 l+G8/bshWt7ug==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-466ec4c6852so86173b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 06:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV15eNTobTI6dmhEBlNkty2AtEhS/7JGVrTt/ClC1ti59dHRlj6yQ09GrXHGDBzYwQn6K3cYBu4XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKQTieQIqZB1ErGGhQGR6249bbjhal2K+xXCO4Ux7yhWTGdol
	DaLpjbut36DF57kZ+rGuoU/bjRGIiU9BWi3z0TRmwn6tJAzaIkFQd5qE0Yv4HqtI0P4Hg/dOZK5
	o2/syBHi3aaqtdgoLNTQ8ccFejJNHaKE=
X-Received: by 2002:a05:6870:3513:b0:417:5105:a735 with SMTP id
 586e51a60fabf-41c111b87afmr7254566fac.33.1774271220451; Mon, 23 Mar 2026
 06:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322120528.750178-1-youngjun.park@lge.com>
In-Reply-To: <20260322120528.750178-1-youngjun.park@lge.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Mar 2026 14:06:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jfSO8GDtmXoPqSeAgr4NjBEfio4M_0g6V10wNwj7e4EQ@mail.gmail.com>
X-Gm-Features: AQROBzDDGRKPcNhxp0_W59aur2I4kLJq5TWowB6OuC--PMtjOds6JPaONexx6m4
Message-ID: <CAJZ5v0jfSO8GDtmXoPqSeAgr4NjBEfio4M_0g6V10wNwj7e4EQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Drop spurious WARN_ON from pm_restore_gfp_mask()
To: Youngjun Park <youngjun.park@lge.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 1:05=E2=80=AFPM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> Commit 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask()
> stacking") introduced refcount-based GFP mask management that warns
> when pm_restore_gfp_mask() is called with saved_gfp_count =3D=3D 0.
>
> Some hibernation paths call pm_restore_gfp_mask() defensively where
> the GFP mask may or may not be restricted depending on the execution
> path. For example, the uswsusp interface invokes it in
> SNAPSHOT_CREATE_IMAGE, SNAPSHOT_UNFREEZE, and snapshot_release().
> Before the stacking change this was a silent no-op; it now triggers
> a spurious WARNING.
>
> Remove the WARN_ON() wrapper from the !saved_gfp_count check while
> retaining the check itself, so that defensive calls remain harmless
> without producing false warnings.
>
> Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
> ---
> Split from the earlier pm_restore_gfp_mask_nowarn() series and
> agreed upon with Rafael to take this simpler approach instead:
> https://lore.kernel.org/linux-mm/CAJZ5v0gBHLz7T2qRJRjBfOWY6UXM6L6+Kw8UcsY=
4+OaB7+qQcg@mail.gmail.com/T/#m10ee3346cd8dcd052749105d9a8e2052dbf3bc80
>
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 5f8c9e12eaec..5429e9f19b65 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -40,7 +40,7 @@ void pm_restore_gfp_mask(void)
>  {
>         WARN_ON(!mutex_is_locked(&system_transition_mutex));
>
> -       if (WARN_ON(!saved_gfp_count) || --saved_gfp_count)
> +       if (!saved_gfp_count || --saved_gfp_count)
>                 return;
>
>         gfp_allowed_mask =3D saved_gfp_mask;
>
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> --

Applied as 7.0-rc material, thanks!
