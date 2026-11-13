Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594077;
	b=bUt+QCSiCjwX4b0vQKVz1upcd3n0PgUf0tRSr2JG8jIGN3jIQk60kCNJWF7twXi4o+ET
	 s0u+PD3E6wa590/q+yvl7Lm3SnBBYK8zEgYO1l98fAyegcj63OLM2nCTeDXL6yj6p49No
	 yprLo2OghunYyJdbKTHx8MD5HpHZZKnaBDYdxtzJaBOi719VPlwxUiNkoDHP4wlrHX54m
	 HVyPvtZrl2/wmN7yijqVbR0q/9TIF5rKH8tTHVG57VpHcS/8+jZV3982G78ZmHGdGhkcD
	 xcIp8FkNjoDa4CHRHB3AUEe0Y4thxN5jVAVfp7wlqRqoXJy7OQ1zXbI+U+DOTCulggQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594077;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g3nU+TBwVWjZ9jQB9EUtuB57kYTq8SS5/0p7qVUrO8U=;
	b=E5FhX4ZGIXngB8z0GwJ6dfAUSkQ8UTA8lM7ZONwF4AsKuH0Y6DG46GxJkvJ0yVGapm7Y
	 v1gMopb7AlCC/f1K0c/ZOygeIY/xv5uJsJdhadHIMe3Q39TZO98OIG+KSpcu5n5bu+wOa
	 S/7Tp409niaNX47CvX2ZqxcjQGBTw4rQd9+wjQDEFHTl8LNkQr3/k3L8uogtKiUYiwSo5
	 pDR9GwU2PVgcL/3ENw4ujXA5trDck15FDZODSWfDfmV4hxWNEj+wZkEzv7fWHcAZuYBXC
	 KtYGEy43kdoH8mtmfONoopSm/ClAJUeOXhANAcaeTzeKFu/9qTugNdIPPReugNSSJIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VShVU6bb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456E606A338
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VShVU6bb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A59A1F000C9
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594077;
	bh=g3nU+TBwVWjZ9jQB9EUtuB57kYTq8SS5/0p7qVUrO8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VShVU6bbkAp6MP2s2zXoShn60DrzD/XIwhAdK+c+4TYDxRaFwrkwe8TmTnt5vsSnu
	 9XIoUmWYpaXYTy/xBjz0cWVlKEksf66/rzJxhAynN2M9YTZF3Z5aG3o6QYukuXZgQY
	 /GIsqCZhjGI27dZnZPAC3q9A+qv3EPe/PfoWJVJ0ckY6qJegwYCHVlJZ7wmpll3QfA
	 eaTIxL+MNWtx4YcSuA9LWxus5lii2iQhb1fxkElra/uYI0kUU1w3ksiptcuBqPBS7b
	 2x7J7F3aHOwF4r/E/S5WHersFdyOH2hdJW8I77MtDPj7kYl9JG88kz/9woEY6j2T5/
	 LAVMHxoqvytpw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso1425998e87.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 10:21:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGcoAoMqppKDTYULNIxEANkOverVUSlEiXL3or2Ny1oeJmpHbAIwj4NVxVmupAnxPWbRNYFC4c2mQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8gvDe0CB5df2tCU1Kea/pTz1PGiazimdNouYuKUJxz+eCpIJVf
	3Dzki2yPaxqdB8xEjN9AvsaJ1TERLYcPoEx6LSduKTxcKPz7Bfsb72T6cAZkfIr3Uyk4zkesm5h
	Qc29TUCGXTOMKcNEUmdex4gbg5seR5zE=
X-Received: by 2002:a05:6512:1388:b0:5c1:5b62:8bb8 with SMTP id
 2adb3069b0e04-5c1709c2f69mr1503098e87.67.1794594075517; Fri, 13 Nov 2026
 10:21:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108145028.2483131-2-thnkslprpt@gmail.com>
In-Reply-To: <20261108145028.2483131-2-thnkslprpt@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 19:21:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g-oDagp2GrZyhLmT-BYJqcm-D4s1eTrXCxB-fj5BNixw@mail.gmail.com>
X-Gm-Features: AclHuK-90duIT9Tx3Ga37dDtHaY-SpMbbAwcRovOmycin_mx6a06vXXNqbCiuog
Message-ID: <CAJZ5v0g-oDagp2GrZyhLmT-BYJqcm-D4s1eTrXCxB-fj5BNixw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is inactive
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	zhanxusheng1024@gmail.com, zhongqiu.han@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 3:50=E2=80=AFPM Avi Weiss <thnkslprpt@gmail.com> wro=
te:
>
> sugov_hold_freq() uses the NOHZ idle-call counter to determine whether
> a CPU has been idle recently. When NOHZ is disabled or fails to
> activate, the counter does not advance, causing schedutil to treat
> the CPU as continuously busy and potentially prevent frequency
> reductions.
>
> Skip the busy-CPU hold when tick_nohz_is_active() is false. This
> also handles systems where NOHZ was enabled but never activated.
>
> Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of bus=
y CPUs prematurely")
> Cc: stable@vger.kernel.org
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

I'd love to see some feedback on this from the people on the CC.

> ---
> v2:
> - use tick_nohz_is_active() instead of tick_nohz_enabled to also
>   handle NOHZ enabled but never activated, as suggested by Zhan Xusheng
>
>  kernel/sched/cpufreq_schedutil.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 14405a614991..50249cc1a594 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>         if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>                 return false;
>
> +       if (!tick_nohz_is_active())
> +               return false;
> +
>         /*
>          * Maintain the frequency if the CPU has not been idle recently, =
as
>          * reduction is likely to be premature.
>
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> --
> 2.43.0
>
