Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760831986C
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786812933; cv=none; b=EaNlD8bcs+LfjL7pZgH4VPOx1jTyOJK0kjqfCudb+AYlIa8YS3QkbD2EW/fYrkTyjMoEyHm1tZ6z9eHvCrp+RY6g0kwcX3ttYFfPUco0Guog0PYYqqg1z0zGWKygA2xuVOZjk702DKqoCjKJ+jUlX0G8qMmg9J4iuD9qqN9Rggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786812933; c=relaxed/simple;
	bh=KNtPpCshur0e2SyD4DCl4I14zNCK2YzXIU4j5vSEk70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuHyHKKQ9t5fBenl5RMiq39kZk1HG0MXNf+z1mYFlt5TwGYBYQ/1u6iGuxB5pwnnUSqbo6z6MteTXBWIGrahAbWytJaTK0blqYSLh9boP/bJQRjAXVdBG+wPMYpppi11g/w4KMelW/Hpd6SKHMV8+9qJfF1oIdV5Eniq8iNHfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAlk5xiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAlk5xiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668BF1F00ACA
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786812931;
	bh=fBAzrsEpjqpy0Yd4RkEQP7ySpkvZOHwXchjdnnhVeg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WAlk5xiZuSZUWx76gGk9NwgH3to9rP85fBhURvpuoUcHmyPDwHlqjWOzi0n1LCfcs
	 UUw+o44AS7hBsOf25LVFl5ms2TRVGWM6z1O+HimqYnwn3fhbm0dg9LbBmxDKpF8uxA
	 swpcFR4L9jYV5GWHOfgpeHvfGZ2Rh19Inf55z+4seXaI+pzr2lbr4c3Bm30pW2tUKY
	 Z9bKcpEI8cNKNpNKCneA7yR/vr9DtZEGJUiTy4ns/pg0NuKFNjU8iwfnx5/ojQr2O3
	 f8xZVgKj3KZwpzJq/0/d56CrKCeSRXoTHf/CgfJQfN4N/m1TbpXQyArLRSyYvCtV3D
	 BvyZZEZKjf1Mg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so1870170e87.0
        for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 09:55:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RphF0+S7yC3dZE5R5zTMynRxpbJwPQNcPPXh1gcRo6c1EiiA7sQo2XtTrMZzVvtamVhzlELQP6GBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTBqan7yDnz4AEWgVYJ3bAgON5wt1ZyaVEg78cdbElHKbD8lk
	HzwKvvkdi3qHVGw0KZ6kGKQnlYYz9cZD3fvA5ZcHiyHGoRwHIWVofgyXs3RQPFAyR5BtDEkqlZQ
	//3/nIsEIerhqzfCVc/weJDNVI8x3kxc=
X-Received: by 2002:a05:6512:3c98:b0:5ae:b2d9:ffd4 with SMTP id
 2adb3069b0e04-5b459139501mr2175348e87.11.1786812929830; Sat, 15 Aug 2026
 09:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811052251.1274451-1-rdunlap@infradead.org>
In-Reply-To: <20260811052251.1274451-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sat, 15 Aug 2026 18:55:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaB8dBGncqwrdMim__Oq8YWBCKp6Ms_js3LtUaMjpfxg@mail.gmail.com>
X-Gm-Features: AcwNN1Uv35pZ1M61-_D8l_mryr8VsSr9O04GYqvIK4WVTnl28whsA51IgM1DuWo
Message-ID: <CAJZ5v0iaB8dBGncqwrdMim__Oq8YWBCKp6Ms_js3LtUaMjpfxg@mail.gmail.com>
Subject: Re: [PATCH] docs: kernel-parameters: add CPU_FREQ, CPU_IDLE build options
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 7:22=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> CPU_FREQ and CPU_IDLE are used in descriptions of some kernel parameters
> so add their descriptions to the build options list.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
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
> --- linux-next-20260810.orig/Documentation/admin-guide/kernel-parameters.=
txt
> +++ linux-next-20260810/Documentation/admin-guide/kernel-parameters.txt
> @@ -8,6 +8,8 @@
>         ARM64   ARM64 architecture is enabled.
>         CLK     Common clock infrastructure is enabled.
>         CMA     Contiguous Memory Area support is enabled.
> +       CPU_FREQ CPU_FREQ is enabled.
> +       CPU_IDLE CPU_IDLE PM is enabled.

What about

+       CPU_FREQ CPU frequency scaling is enabled.
+       CPU_IDLE CPU idle time management is enabled.

>         DRM     Direct Rendering Management support is enabled.
>         DYNAMIC_DEBUG Build in debug messages and enable them at runtime
>         EARLY   Parameter processed too early to be embedded in initrd.
