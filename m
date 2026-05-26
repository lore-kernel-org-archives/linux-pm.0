Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E67388E5A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794088; cv=none; b=Ne0FbXcxz0AeEw7qYPQDzyA1V/pv4ENd2BiOh4lbK60O4VXIGKuUbLM0QdjZT/eYcLcBgITUGkF+sPpSPHmm9aIDFzOtg1UX1V9PwCCV9zL9jyEUZ7dQ+N5WDWwhhUTqB8o0z3j0/tHpd4eY4OPT8INBg/d4kyqgmNxzLRIdT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794088; c=relaxed/simple;
	bh=q9w7+K4dw3tUgZV9s0a7MpYsMEq6WClBHHgbFLPKpEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBhuYamj7GvuZz0ocHU0zeQXfR3f96khag5VqxZA2wz1pYMwk0JfjsJE9C6KKoz1B6xi2VmbBOr/f6BZ8PPTB7IFQUvVI8XazJORi32d9/YgSsZWmVgDEZ1Ldwxt820flR9KoIRScosOrf20Iahu5D28TTQJfpToX7/a7Ede3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+35ZIbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+35ZIbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE431F00A3A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779794087;
	bh=Jl4A5BploI0aLzf+f1VH2H1uwnUGnoJyUMtMQYNxCVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m+35ZIbPw68o69pVdadGClRCk00jjm8HZHM0GRdr31xkz8BxbPJzPxfZElOVwzsVV
	 pYGanaKB81RFK8R5Fmuu+qIyDmQ6hmsYOffk3g8rHBh4b3RMAggfFqpVrXYFwJQIa+
	 UgZdDknxScOHgMky8i2s2cpujxI470xfMxcAWkMYVO4RS+ExmrWTRPPXTGvHD15qk0
	 Fcbw19L6yLJyBM/xSaszI5L+a+tjP11nG0/vYPQpDuW3vgDAxVDplXR9l07J7/GrQo
	 VHClYlfNVfJ1ExJaywLQ4JIg8YL5Fq64O+bdAhPpkuty5CnOgzUd4xhGkjjjrehsbg
	 tAGOjlo4vGfTw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a746f9c092so14548261e87.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9cpQ1E1zB/naY6fd2U8aS8d+G8+nbfkBWuAKo7Wb6qeCmNXXgMGG4KvaNCwzPZkP78tSKBCZdkRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGxauAj+OYx0n0mgrAawRfn5g4T+XYaBlcQwn5jqJi3XiVGVC
	c+xThGPEIg7XA6tNWyilbscHvElk/6Zqmehf3LwJpEpnSng/WTIzjpbySdJOfWIJ2f6Mmf79e+n
	nboHX1+fkg0HMVKjmD42hpoqukSdKyv0=
X-Received: by 2002:a05:6512:704:b0:5a7:4912:1a50 with SMTP id
 2adb3069b0e04-5aa2ba8c2a7mr4167836e87.20.1779794085637; Tue, 26 May 2026
 04:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519055920.13180-1-jszhang@kernel.org>
In-Reply-To: <20260519055920.13180-1-jszhang@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:14:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOfVmjwpTFw3UKALiGrPQRbD9pBvnuga+TKt4Hm2OuCg@mail.gmail.com>
X-Gm-Features: AVHnY4I3p3JtLqx6qWtPGsdALHvbUCPKp6zNoy1khUWLvVCRZ3XGvVcV8QjRQtw
Message-ID: <CAJZ5v0jOfVmjwpTFw3UKALiGrPQRbD9pBvnuga+TKt4Hm2OuCg@mail.gmail.com>
Subject: Re: [PATCH] PM: Use LIST_HEAD() to initialize on stack list head
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:18=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> Use LIST_HEAD to initialize on stack list head. No intentional
> functional impact.
>
> Change generated with below coccinelle script:
>
> @@
> identifier name;
> @@
> - struct list_head name;
> + LIST_HEAD(name);
> ... when !=3D name
> - INIT_LIST_HEAD(&name);
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I'd rather see two separate patches for these changes as they affect
unrelated code.

Thanks!

> ---
>  drivers/base/power/clock_ops.c | 4 +---
>  drivers/base/power/main.c      | 3 +--
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index 59bb37e8244c..1f708e10e711 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -422,13 +422,11 @@ void pm_clk_destroy(struct device *dev)
>  {
>         struct pm_subsys_data *psd =3D dev_to_psd(dev);
>         struct pm_clock_entry *ce, *c;
> -       struct list_head list;
> +       LIST_HEAD(list);
>
>         if (!psd)
>                 return;
>
> -       INIT_LIST_HEAD(&list);
> -
>         pm_clk_list_lock(psd);
>
>         list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e1b550664bab..d0c7b1d4101e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1257,11 +1257,10 @@ static void device_complete(struct device *dev, p=
m_message_t state)
>   */
>  void dpm_complete(pm_message_t state)
>  {
> -       struct list_head list;
> +       LIST_HEAD(list);
>
>         trace_suspend_resume(TPS("dpm_complete"), state.event, true);
>
> -       INIT_LIST_HEAD(&list);
>         mutex_lock(&dpm_list_mtx);
>         while (!list_empty(&dpm_prepared_list)) {
>                 struct device *dev =3D to_device(dpm_prepared_list.prev);
> --
