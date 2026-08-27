Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2C367B72
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827249; cv=none; b=rd8E89q9QvE5jADySJGykadx+vT0uIG9EXGurl0TzmqK2kWKxycgHjK20WbTDF5DUmoqi6SZ9mM/Z7G1HF3NtCPT1Oh8CWTT2MGGhp6yVxaXsxSOrJwEz0JkCMAxKwh8zVNu6spMkIKiYRutRLOWsTr7mPTTKpMDLS6WDkEv6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827249; c=relaxed/simple;
	bh=qHPCKGJ5o2tW+ZfnmNwZX4C95z8aSkgBAksEB0VrNkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLpNcqkXW0jn2w8ebsSAHQBqYks5NjGcGsEOO/WK06UYv9fHQUVvkBAoIsdjJEIWp5Cw3gai6Wonjr1EfBy47dO7Vb29gZqcugJKKazVx/feVMY1J0t33SA/S9yiExEmzT+Oczdf3ZmIgWfhhy7/BkAKHuwX12hK3qm0e7ENczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsvqKtdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsvqKtdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600171F000E9
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787827248;
	bh=9doIWBCQoxCqx/1P47ArUtpVwldGAPkQhgto/funho8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AsvqKtddY7qZDpRoWiPI9OJ6VnRT2VPGZs+G20oTp8OB6+0tESkGI08Kp9tWTe+Rw
	 KhtPMDbkOwApIfPE5CJ1QKlir1UYArj5PtRs+OKbPiHbBNxCWEpi/UywXxfKj4f/mv
	 EE3vT6NP65961pmp5M/zDcniEYSl7gBYTSnMjRgl8+qQ/FOI8jlr4Pa2YrhyHOX3ZL
	 vnWbjYnLA2cg/3BrKhGsaVfGYz+EIqYBtDtREKAhkSQpmiA0I/PkBI+xLb5wGR1QPR
	 Trf/nIr8qe0VHkktvWJC/X2zNzlBm5LmYMGwXkn4Z6UAAWwOBAlikeh9MtX6aZetYH
	 jywKN25vQ//wg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b5e18f0439so257138e87.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 03:40:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoNhNxy6GcRpRzrjAQ7BCN+vX7PMdNYDOr7eutkeSA3XROvT6kul/1DtAhAkxeeiBtEYanY3jQohw==@vger.kernel.org
X-Gm-Message-State: AFuF++lP5/5KCnZ+/gsUv/OhK6HUMYDPU1au/Typ/n8omz6h3W/QNZZT
	1k294E6tzjdY5GOyrDmapqJYCvpDNWCJYZXlAB2gk6y8lHyg4Pci+20DfLFh7T3p9jiDQCI8fw2
	OPVr4ERC8P7vu/Uks/MvTWHs+gR6vR1M=
X-Received: by 2002:a05:6512:b0a:b0:5b4:ac27:6bb8 with SMTP id
 2adb3069b0e04-5b4ac276cc0mr3937680e87.12.1787827246768; Thu, 27 Aug 2026
 03:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827090505.3703860-1-luoxueqin@kylinos.cn>
In-Reply-To: <20260827090505.3703860-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 27 Aug 2026 12:39:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcsx6nsCBWfDjP7OEez2jM3-hNj8kSSm=xH5nS_fNSug@mail.gmail.com>
X-Gm-Features: AcwNN1Vek8nxWavwBJ9nh-QHuAf7fGOEShayoPRzS6wWOf-UH3Dz_NBpbGflO50
Message-ID: <CAJZ5v0gcsx6nsCBWfDjP7OEez2jM3-hNj8kSSm=xH5nS_fNSug@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: teo: Do not return a disabled idle state
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:05=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> =
wrote:
>
> If idle state 0 is disabled and none of the enabled idle states satisfies
> the PM QoS latency constraint, constraint_idx in teo_select() stays at it=
s
> initial value of 0, because the loop that updates it starts at state 1,
> and so the candidate state index is capped at state 0, which is disabled,
> and that state is returned to the caller.
>
> The cpuidle core does not validate the returned state index against the
> per-state disable flags, so the CPU ends up entering the disabled state 0=
.
>
> Address this by falling back to the shallowest enabled idle state, found
> by the same loop that computes the candidate, whenever the state selected
> by the latency constraint check turns out to be disabled.
>
> Note that if none of the enabled idle states meets the latency constraint=
,
> choosing the shallowest enabled one is the least intrusive option, and it
> is also consistent with the behavior of the menu governor.
>
> Fixes: c410a9a142f1 ("cpuidle: teo: Change the main idle state selection =
logic")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/cpuidle/governors/teo.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index ac43b9b013b3..b4b14c86b2a9 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -433,6 +433,14 @@ static int teo_select(struct cpuidle_driver *drv, st=
ruct cpuidle_device *dev,

I would instead add the following conditional here:

if (idx0 < constraint_idx)
        constraint_idx =3D idx0;

>         if (idx > constraint_idx)
>                 idx =3D constraint_idx;
>
> +       /*
> +        * If the state selected above is disabled, which is only possibl=
e if
> +        * it is state 0 (all of the enabled states violate the latency
> +        * constraint in that case), fall back to the shallowest enabled =
one.
> +        */
> +       if (dev->states_usage[idx].disable)
> +               idx =3D idx0;
> +
>         /*
>          * If the tick has not been stopped and either the candidate stat=
e is
>          * state 0 or its target residency is low enough, there is basica=
lly
> --
> 2.43.0
>
