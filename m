Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117030;
	b=pq3o7aB9wV7Af/djdVtu/WfBv+D8i05tTKPReZEX6KnWLjE2ALisUmeW+/vSq0j8za1a
	 nu+Fmla7CEGQIEDry2fjsP4sqiEx3qM9wxS6zogJjeZc7wFIURDy8AmVMMTum6z951igY
	 gi4tbtxGqvwXCvpSPRNR8sEXvyF/aW2yKcXmSyjHTy0GmLrGZzsy/8HxxKA8nouRKUGsr
	 9LM4HU8jihfX8NnSjShe+Ng/NDdjMM4LXiPT1/lLmr6KKcyR7LhXVP2tTW2zJ+7y4kdxy
	 8EpsoHBCQ1jUmwAI3o0rspWjxptsZsHqJHG93OjR2elff3eBCZ//Eux9XUNF1K8f6ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117030;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FElAzo4KpvK9gPRiK91dueS67HHcq7pi49y7dNohM6k=;
	b=QGRuc3Sn5eFEEhdcIb+ScioHa/GZl+uFNxPyv5YZOlZW5HO0anvaDVmjG//OGHN4iiEd
	 8wwZl9iInY0o+KXIdCD0sbHiIKcPZypRMopaGGnHsjsUfniNsjBw38CF3eosSEGX5v5kt
	 N4EKo71xqwNQoD2sxOTkz0wH3Q84/6jHMv9eOe7weBdC1JH3ZY+XFIE5tg3LZ64tf3FV5
	 45smLtrX+ArieK7SfQoNcDmbQigjkynF+J8n+a23gx4kCKgx1PRaN6aI1yj0R6OuJG6+w
	 OnyGuT1s6W2n9AgNC/Dmp/K0749drjxvtaWZwqH10v2wfCtAqnSqQ3cdf3kuqlJsQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIkhSw2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF6606A31D
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIkhSw2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876A21F01825
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117029;
	bh=FElAzo4KpvK9gPRiK91dueS67HHcq7pi49y7dNohM6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fIkhSw2g91efxkWWEoRgl6XtY9xFfwrZ2ZeKsEzWrkdt42+TvuPmMJvtH7kk834W5
	 SwQ1TCjF0O130o5fnDRRkDgQ9s1upXVmbfV25Jh5kG7By4dRscwF37IVZQWG/A2IDb
	 4JOleWDkCNaKa/pdcDlKuy823YwHrA3pRZkFi6CebEIApCzGPPSsmmMsPhAvkRMRA0
	 /+1OqD37Sh5Izt9HzMaHPFzKHOQaIGo0xESibHWW5ORB0uEHAYWyRL6M7oagFziAtY
	 jQvGoOABRKimIFGB020MiPcRrP+O01JiMO4mn6oQVQn9AM8N0V3w2I+WOaJUbe3yav
	 ZGyJL/jJLqEdg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so87454e87.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:03:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7UUhe6qLzn5EE2u/jO/LitKIYlYZH/mPlyYjGodATKbjEOd9FmsUjVo1dns7Pj8+Bro/m0UMEZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJXz5jRPiYdBFK/M0pwRpaXRpNm668KRZwyW95/1jH+ChNz80A4
	lLbxkzkywuUIT2J1ZDAO3UqznTPDy2CyE7IAgF1JgWpzDnO1lA1gHCT1k9QmhXfr+y+DI+iwffp
	PcnxTYV68ZqRaSB5pjnuBlUCF/vIwfTo=
X-Received: by 2002:a05:6512:6c3:b0:5bc:e45b:becd with SMTP id
 2adb3069b0e04-5bfb71bbb1fmr4029674e87.14.1793117028030; Tue, 27 Oct 2026
 09:03:48 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027122042.1444-1-crofts@kernel.org>
In-Reply-To: <20261027122042.1444-1-crofts@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 17:03:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hGcvdHKmBQncp2XrKTogXzU7XzJyHbZzSWcsKruTydUg@mail.gmail.com>
X-Gm-Features: AclHuK9_dg389Om2i9Vfy4W7HAdwlfs1Yt1t_lVTjQWUL_gAAK-dR2CsDmMoC-c
Message-ID: <CAJZ5v0hGcvdHKmBQncp2XrKTogXzU7XzJyHbZzSWcsKruTydUg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: clarify pm_runtime_use_autosuspend() undo mechanism
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:21=E2=80=AFPM Joshua Crofts <crofts@kernel.org> w=
rote:
>
> Commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend()=
 on reinit()")
> introduced a pm_runtime_dont_use_autosuspend() call that is executed auto=
matically
> on driver exit without making any changes to the kerneldocs.
>
> Update the kerneldocs to clarify the current mechanism of
> pm_runtime_use_autosuspend() cleanup on exit.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
> Hi, would it be possible for this patch to go in a fix PR before 7.4 is
> released to prevent any confusion about the mechanism of
> pm_runtime_use_autosuspend()? Thanks!
> ---
>  Documentation/power/runtime_pm.rst | 10 +++++-----
>  include/linux/pm_runtime.h         |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index e4407b687f8b..40a5c23d5259 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -425,11 +425,11 @@ but it also allows more flexibility in the handling=
 of devices during the
>  removal of their drivers.
>
>  Drivers in ->remove() callback should undo the runtime PM changes done
> -in ->probe(). Usually this means calling pm_runtime_disable(),
> -pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
> -devm_pm_runtime_enable() during probe, which automatically takes care of
> -calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon =
driver
> -detachment.
> +in ->probe(). Usually this means calling pm_runtime_disable() etc.
> +Alternatively, drivers can use devm_pm_runtime_enable() during probe, wh=
ich
> +automatically takes care of calling pm_runtime_disable() upon driver det=
achment.
> +Any pm_runtime_use_autosuspend() calls in a driver will be automatically=
 undone
> +on driver exit.
>
>  The user space can effectively disallow the driver of the device to powe=
r manage
>  it at run time by changing the value of its /sys/devices/.../power/contr=
ol
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 322e3b17f987..ae68a9dc7fc5 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -855,9 +855,9 @@ static inline void pm_runtime_disable(struct device *=
dev)
>   * requested (or "autosuspend" will be handled as direct runtime-suspend=
 for
>   * it).
>   *
> - * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspen=
d()
> - * at driver exit time unless your driver initially enabled pm_runtime
> - * with devm_pm_runtime_enable() (which handles it for you).
> + * NOTE: This is undone automatically with pm_runtime_dont_use_autosuspe=
nd() on
> + * driver exit regardless of whether a driver uses managed devm_* functi=
ons or
> + * not.
>   */
>  static inline void pm_runtime_use_autosuspend(struct device *dev)
>  {
>
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> --

Applied as 7.4-rc material, thanks!
