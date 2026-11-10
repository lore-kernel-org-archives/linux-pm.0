Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341629;
	b=hI1MN9upcDsPoAkN6XeENyD8VP3ysnqdRfIGSuBeZ34iaDb0cOT7SRf0dugry7Cf2TfY
	 jbk3mBQnTg11l4XVoA3bYfdThItO22cioZiI0EFYcy7gJtAnUIWNTyHqKtItKK1HhI3Hb
	 s5ymgwqYL5GYC++RTarbD2AIMS7Xz1WhYNyCGtJv5hMxFBzgPJET7zOl6rm3nhVfRnbr0
	 1s8A/QVMxvqaBzPA7qDH7pUhlmUNzxzjExZY4EcurTU1GJ5YmOP+AHU4lKEoo8rYRllfS
	 q+dtPeoMGT4kEYDkwEeArYt6id/zqzgE45IGHn6ax+DLFT0JcRs3hVx/8JtHG99kTAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341629;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aKfx/NE84qHCttWloNJhMf81vJASf9iP8Q1rv6pkwHg=;
	b=t4oT/hFuBOTqhVX9yM1qGiUFeKsSDbhZGh2FQEHmsQdalT3TDsQanj7ySysuF8f5YG5l
	 QAlbtZoxTwDNU2SPcJAmljJ3qQKTO4goLnKVL4LKbq1/FB2jX2fETbPM9EvHFVanNwtps
	 uBuR5xph63Gi7LOtrsNXU5mnjFppIrNwUgqxt1DwmaZ71Ke5b9F7pPiluWNRX1wSUjnvH
	 mlZC4VZpNPrCdJos+Cc8KyizUr4cgoqx9FH2f51LRjhQoQt165bcdexGFy+QtCSjyIUuJ
	 zj32e9mEe9+mIdbWdIwSNEHNBs07fTVyBbJld/UEFqRqu0mX507yZ8O4emFJQqS990Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxRMZ+qI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65E606A31C
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxRMZ+qI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1221F008A6
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 20:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341628;
	bh=aKfx/NE84qHCttWloNJhMf81vJASf9iP8Q1rv6pkwHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IxRMZ+qIdULUaqhxaYCFebt3OHeoF01CSIjhZrVmB5c9pQhF0VHgTv1ai8yb8OKHV
	 K5pxXi4gnlJeIGVEcoan1JnvF72XGClpr6eU2mYdBoW/TaeMLgBsIECLu5szmbXUOM
	 E3uvN0nTF44pZv67aFSM/KYX8rBpiEK950EhuOad1cg+aFWBZnQAGa6nibMKHgcq1P
	 K2qKN1h+DrwggXpPY4lgCG5jgp6QNHLJBvULy0bJMrWeMKLsDFOWlSjBXQ3jzlwJEj
	 9x8Tcs/IYMctbGgHw8BMA9hGI6GtpKqMpYn+1F25LYxu6zCql0pjk70UDYhbfFhiOb
	 fEelk32qYY0ZQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14e307f29so2580149e87.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:13:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGsoUEKpcQG2aNT6fX9Tla90t98NcNw9Y/jvr+fIPRHswNGEjqiBWK8iEeaWQ2o9yIY5XKJ+xoZqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pHw5nOj8mtqUijNYtJ4KC0+Ct3qE4ThabUDKZZOZkBOtvH8eA
	GUD5+YvnfhyNAwLlxgupfg0YIydmF9lbyD5fHGBxEt9T2wQE5FkWomt7Iwz2kBTGwObUvyCrqLl
	roKQ3SLPKyWgY27csi7bGjqZB5NQHxyE=
X-Received: by 2002:a05:6512:304c:b0:5c1:597d:aa93 with SMTP id
 2adb3069b0e04-5c15d5cc5efmr65814e87.24.1794341627024; Tue, 10 Nov 2026
 12:13:47 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083633.1699270-1-christian.loehle@arm.com> <20261030083633.1699270-3-christian.loehle@arm.com>
In-Reply-To: <20261030083633.1699270-3-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 21:13:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2wqNDxe-R9fSQW4uF5XE1uW+8UP1u2UjnDDEWRO3LpQ@mail.gmail.com>
X-Gm-Features: AclHuK9UnPvQW1QMfGoXRDr-59ymytGmkJorhdLTB4yqTC_2fvJfuC9eRqkhPnY
Message-ID: <CAJZ5v0g2wqNDxe-R9fSQW4uF5XE1uW+8UP1u2UjnDDEWRO3LpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: Respect latency constraints when accounting
 below misses
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 9:36=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Only count a below miss when an enabled deeper state meets the latency
> constraint. Save the applicable limit before entry so QoS changes during
> idle do not affect accounting. Continue checking disable flags on exit.
>
> Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics=
")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/cpuidle.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index faa29f58738e..e9195ea8cfb6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -219,6 +219,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>                                  int index)
>  {
>         int entered_state;
> +       s64 latency_req;
>
>         struct cpuidle_state *target_state =3D &drv->states[index];
>         bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TIMER_ST=
OP);
> @@ -244,6 +245,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>         if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>                 leave_mm();
>
> +       latency_req =3D cpuidle_governor_latency_req(dev->cpu);
> +

What if this is different from what the governor has used?  The limits
may change at any time.

>         /* Take note of the planned idle state. */
>         sched_idle_set_state(target_state);
>
> @@ -327,7 +330,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>                         }
>                 } else if (diff > delay) {
>                         for (i =3D entered_state + 1; i < drv->state_coun=
t; i++) {
> -                               if (dev->states_usage[i].disable)
> +                               if (dev->states_usage[i].disable ||
> +                                   drv->states[i].exit_latency_ns > late=
ncy_req)
>                                         continue;
>
>                                 /*
> --
> 2.34.1
>
