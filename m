Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BF5505F2
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711207; cv=none; b=GyKu8O12tsLL2JRNjj82bATuzlKH2xnROE9EJ6bZMpfoeowE5n3iA+LeI+4e3gyXSFUE/roceRfQ+NpnYcRO8Ugf4/ORWpqtfSXZU0UhVGrMxJD+QTf1H3WgAHt0nGlti/L/1EzqOPNDrbz7B/WPkb0txboW2y0+nxScTPjIVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711207; c=relaxed/simple;
	bh=zbr+GU0lV+fYqZ0sTiprx6XvkzPIp4t8LPwmB7Qu5uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pU1b+L9XLefCam67ujHBr9wVA4/KG76UOAu7TQaQFan+0K1YDHCo7tOfJyjms0x61nkUWu3hFAkRr7lxSdcz2gsOfFmzl68VOzftpagw6onA/3xtx3jg9NvYrbovVbZDE39+brGws2tuAQ5OlRSQVc+XezTGnn8R87PzDwVA42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gozop4Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gozop4Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917821F0089A
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711206;
	bh=BKbKMVCkvQ3lOBq0ytORD0A1sviCgIZ5GOwLudPtfBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Gozop4Mepjh4ADUhZIb7lShoooSiMAZ0gCL5cs8ASQCtj1TC2BVZ+WQKwO9tWlqLl
	 AL0aLsKpHcg4C5iz8LacDgPQwKlPFxDypn1kLsiN1Y1mdTwwgyouUxEVaOE1ARGt/k
	 KNQye+oDEn7lkiLGU4eecDpR2uv69vjTTjGjo+Md12RE8C7zTQRDKec/i7QD8ANtW9
	 Q8aztkbc8C7cjtfmxAk+OC1o0jMQlkOIOyTUnGAALa5uDiYQ1YCXJch2nhGXZv0uY7
	 vnavPkWuCxJalH21vhVK2K2yCpW1nhX76YCDvlVLZVOr9jH4sr95rJ6cBnRgIiQk2P
	 +xHRwPBD5zrHg==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a77141826cso2332331fa.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 12:46:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwUx+U0vWqvAttM0t/fJkikPPU7zVNEZ1nZXZfkN8homhwVcBkxqz3HHG+Nd8iuNlx9SpW1nzFrYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKm5QA/692nYXv6nflq3odLw5ZYc22HMlIwS7h6DiWTLwRO6GcT
	WA+2fPxEQN4ap/PGL6JVaIdUBe1m5460F10Rxg/YgUG/lRVcTvgICMYvahe53FdQETMSMSJ+h1d
	z1iA2LCMTqx5nqLVWWwaWTBa5mmjmzts=
X-Received: by 2002:a05:6512:3e08:b0:5b8:eb82:4642 with SMTP id
 2adb3069b0e04-5ba3bf174b4mr164370e87.66.1790711204992; Tue, 29 Sep 2026
 12:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923174711.1283986-1-briannorris@chromium.org> <20260923104031.v2.2.Ia1cae8a40a24662df11553c225f4438eab65b7db@changeid>
In-Reply-To: <20260923104031.v2.2.Ia1cae8a40a24662df11553c225f4438eab65b7db@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 29 Sep 2026 21:45:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhhJQt8wPCL=hUA7U9vSEKxF3Mctm1kRzz=y7erhKb2w@mail.gmail.com>
X-Gm-Features: AclHuK9Y5Zd_QKf7aBK1kVhzF4TsvkbXBzwUXDK-YtqmY4v1_OFdJlgXy62rvx8
Message-ID: <CAJZ5v0jhhJQt8wPCL=hUA7U9vSEKxF3Mctm1kRzz=y7erhKb2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] PM: runtime: More kerneldoc formatting
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:47=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> In taking another pass at these docs, I found some more inconsistencies.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>  * New in v2
>
>  drivers/base/power/runtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7e75f6d5df07..dce7b6ff7e9d 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1255,7 +1255,7 @@ static int pm_runtime_get_conditional(struct device=
 *dev, bool ign_usage_count)
>
>  /**
>   * pm_runtime_get_if_active - Bump up runtime PM usage counter if the de=
vice is
> - *                           in active state
> + * in active state.

I wouldn't do this.

Instead, I'd change the one-line description to "Conditionally bump up
runtime PM usage counter" and I'd explain what "conditionally" means
in the body of the comment.

>   * @dev: Target device.
>   *
>   * Increment the runtime PM usage counter of @dev if its runtime PM stat=
us is
> @@ -1635,10 +1635,10 @@ static void pm_runtime_disable_action(void *data)
>  /**
>   * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
>   *

I'd remove the empty line above.

> + * @dev: Device to handle.
> + *
>   * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend()=
 for
>   * you at driver exit time if needed.
> - *
> - * @dev: Device to handle.
>   */
>  int devm_pm_runtime_enable(struct device *dev)
>  {
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
