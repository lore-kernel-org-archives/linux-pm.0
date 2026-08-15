Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75F31A572
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817840; cv=none; b=tJaN1HHr99avFwDYyA4gaD+9LYh/sMwjqos9McOXtUb8wzIGFhQK3tpQf+bGXwFaorzyuczj1dM7o0RpSjUipK8mzhxxvlW2dXyLNzPv95fy5k/aDXPBbA+JzrAysqUKVuSErQOU373Neak0Ne1552ab4VTvTctok9nxMZDfvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817840; c=relaxed/simple;
	bh=EASq+7j5j6AregZcikON2o6wwxF3NfOMw8VlSb/4c/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3y1jx8mK5qi42fs0oD9bFNMimoANe/CldoaMRX0UTslMZHrdKQ+lZ8nS9ll4AON0FLb1lOlsUfH9+HetvTKkAmFX2/tkDXRgmZ8EVbH1vsiGH+EzF3cKn4MxFeldJQOFRyEIl9C2hY59qiuXfKVAOLDToLScOowK2hUohhbKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUA8CT9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUA8CT9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BE21F00AC4
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786817837;
	bh=c9Pty9ijROwt3oCuT2lj7EyTW27AkQAoOJWN5aHoho8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cUA8CT9hTt4M9GggltZ5QAozkLi2a5JRU2uSHmYoUhV/wKBVAXw9V7Bak6Kjqx6of
	 Lfqav6ajwaZ/9VVqC5+pkz6jivz/AMddc9zWpv4XGc8Ytdx2xWuvrFZ0yGWjJ6veBB
	 Tl6Q90QSmyArWU9u8zeeFzClrfuow50jK3HYBYNmvMn40tUrRCvKyY6iDldxw/iHM9
	 tsa9eOup71G8kf6trqi/vlySpyQN7rdr6hmR009JZKjFZMxfgXhNujgvTwGt9H3Mpt
	 GTrQjeuTngurRQRDgPQMqNczbJ192Uvn3DqnjItDXmPp0oA6nbOA7seCBVZf6chXh2
	 cIhwsfCqoJfGw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso2371914e87.2
        for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 11:17:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpb2zS+NdrmsRDAirTHYfdEBFZX1z9J6fydJfh9b/r9kCH82Csm9TdZnHBkhoc3nZt/qMeny33i9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oWWwADuOZNxWOZArKGoHrBA+R2xPoO89YXSrKPx+anDNA1VX
	2Qek0E2f9AyWbiL+oR29ZeLKUtpdip1sX4YuGS+GdE9ZBKfOxG6DU3Ye0DgPY8kF6BF92xyzmHz
	GguUTA1w5nQKdcvhiiqugFFgFE3cdpQQ=
X-Received: by 2002:a05:6512:65ca:b0:5b2:a396:1793 with SMTP id
 2adb3069b0e04-5b459142a07mr1617741e87.37.1786817836246; Sat, 15 Aug 2026
 11:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815172934.3604009-1-rdunlap@infradead.org>
In-Reply-To: <20260815172934.3604009-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sat, 15 Aug 2026 20:16:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0idudBM656kan3aistPySHpOsJU_v5YTg3snD+VQL0a-w@mail.gmail.com>
X-Gm-Features: AcwNN1UdG38bXSm7YR9vmVXSG7_6KHiB_cqUOefPFOkxVzU5_T7tuZgUdcOJpvE
Message-ID: <CAJZ5v0idudBM656kan3aistPySHpOsJU_v5YTg3snD+VQL0a-w@mail.gmail.com>
Subject: Re: [PATCH v2] docs: kernel-parameters: add CPU_FREQ, CPU_IDLE build options
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 7:29=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> CPU_FREQ and CPU_IDLE are used in descriptions of some kernel parameters
> so add their descriptions to the build options list.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> v2: wordsmithing by Rafael (thanks)
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: linux-pm@vger.kernel.org
>
>  Documentation/admin-guide/kernel-parameters.txt |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-next-20260814.orig/Documentation/admin-guide/kernel-parameters.=
txt
> +++ linux-next-20260814/Documentation/admin-guide/kernel-parameters.txt
> @@ -8,6 +8,8 @@
>         ARM64   ARM64 architecture is enabled.
>         CLK     Common clock infrastructure is enabled.
>         CMA     Contiguous Memory Area support is enabled.
> +       CPU_FREQ CPU frequency scaling is enabled.
> +       CPU_IDLE CPU idle time management is enabled.
>         DRM     Direct Rendering Management support is enabled.
>         DYNAMIC_DEBUG Build in debug messages and enable them at runtime
>         EARLY   Parameter processed too early to be embedded in initrd.
