Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BFA2C3768
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020438; cv=none; b=qbvDgyfpdB82h8jrJ54ENz8icjrtt6hKURXHgRO/Bsx7zVvvgqF21VP+Fsep2MxHwqOu0h58uIU8YmNNcoXBtmAcmq+J+L0zuH6A8ndCiR/pNJFwNpQuPg60wOtUtXDYt87HbkTvn7jOpb6rjY2kBWaRqJeyd0rqmt4a1HYqyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020438; c=relaxed/simple;
	bh=VOpKgTTDYbWoX52pwzI4i6B9Y41qVJAFQuNXRSBMnFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQzhFK9xuUHepYANdv++tvpQUZB5OP7U/mXUarEH4hcEQ9lyKChL7F9O2X08xXMHFT6vTjFJ+rsdCnn4RSZG2h6Zh6wROS4/W+3HRo/XsouQgmsayWylpOODdsCCG7WxhGwx9XQxNF83xQgzsJIbk6PiTpFa1wrRsbZuPbEgw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFLsS0uF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFLsS0uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9081F000E9
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020424;
	bh=l3qFlMr0i7ZjUkZLLH0duCeU6oc+Pd+K0LkfXRKmHi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FFLsS0uFCFwhcLRWGGvqFVwzXKTL5xed7nx9HbBBefY0vkyQRlcT/bW3bHqdwCPNP
	 OHyWpCLIi41DaCrzHSov6ylwPE+ZBTeBJyEIgE54Olbj0/d9DIftFPyhA5MYpK1mne
	 dBKoKyuhFPgsACbN9c8qBLlE6mp8nA6dD9b3IxHs8AxFYfhFre7GHU/x3T9Rb+mK1O
	 IUuGg0CwoDwGbtMZK2bIsfsfE9093xljQN5YgJgnXIpwrZKmLj3WRufdrQmHueB+4l
	 Aw7QYRH4j3ND068/mCfO/HS/uuGU3vd3XxkJTZhr3vfubPqHiKVPbD2idh+ZJ9kJm7
	 7wJyTOM+k+KZw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0148201fbso1856345e87.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 05:47:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpYl2Umf5EgKRpRH0WVOxSyq9/IAIWCbJejf7TVAajKNwuN7n4WIrF70s2836aVK2hsjttTlHycNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJHGRX3P1+J5sXBXIL/pQYclDKdmCJ0Dfz/l2tr6ddkljrgK/
	tkMHLQA+uAx1Qu1pP4dzx5UOdffq79xDo1+gop3Uyvk7KVSI2zZvPB00nTrTKeA9nToZFXGgVha
	6dUQ0KlUcy9rtlopcIO0/I4EVR6sl6ys=
X-Received: by 2002:a05:6512:3e24:b0:5b2:9358:b868 with SMTP id
 2adb3069b0e04-5b2f4cc90f7mr2010925e87.34.1786020422789; Thu, 06 Aug 2026
 05:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <id2g5cfhmuiy7mkf5vlfkefkh35miye2qdsgnivbkecera4wur@y33swy7czaua>
In-Reply-To: <id2g5cfhmuiy7mkf5vlfkefkh35miye2qdsgnivbkecera4wur@y33swy7czaua>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 14:46:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFQg7Zb+LqnU+hkueSpgv82Kv6--D8E8NQRudp6fuVag@mail.gmail.com>
X-Gm-Features: AUfX_mxtgu_lJKzm2Fjpu1vL_9rkIWJwDtyHyTolNaW8Et1-y6WlPbogpA260CA
Message-ID: <CAJZ5v0gFQg7Zb+LqnU+hkueSpgv82Kv6--D8E8NQRudp6fuVag@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates 7.3
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:41=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e524917774=
82:
>
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-7.3
>
> for you to fetch changes up to 84f05af0975c9f9c8ffee0361d6f7cbb1f289231:
>
>   opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error=
 pointer (2026-08-06 11:54:14 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 7.3
>
> - Fix cleanup ordering around scope-based pointers (Gregor Herburger).
>
> - Use clk_get_optional() for optional clocks (Praveen Talari).
>
> ----------------------------------------------------------------
> Gregor Herburger (1):
>       OPP: Fix cleanup ordering
>
> Praveen Talari (1):
>       opp: Use clk_get_optional() to avoid leaving opp_table->clk as an e=
rror pointer
>
>  drivers/opp/core.c | 67 +++++++++++++++++++++++++++++-------------------=
-------------------
>  1 file changed, 29 insertions(+), 38 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!
