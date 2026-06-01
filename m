Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E513655F6
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315805; cv=none; b=jZXfEq3XGyNoKAZcihydFnTqpsVpSWavvZOGn8rBIcGvWSQi/gQssKyEYpawNU/EqrV8jsMiYvoU0z8u448lqdymqmHQHONHPrRvrmMeIJQuKy8BOdDiJsPqqJzj+/7OQ+XHWZpveOHoXy3LaR1nKvMlbjkjncUPRJanDHfY2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315805; c=relaxed/simple;
	bh=ck9mpQSJUayUVBP+4tRmhXlurMh9FR+aesm2zyTJXQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGqINBjYP6opc3sZ+vHmKPn65mIdsuKF+M/sZrmwOdsDzldrmByih8rNZsp4DXOOSkAIM6sXFh4478/bXN15xB+5R2+bZUSvtglf68nFjQocWYTCIIwQ9iZorAHbRl9e4bkbHe1rqVqRFEoSrLHvmt16XbaOtfBaFT/EF9SsAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc2GLWh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc2GLWh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105351F00893
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780315804;
	bh=V39h9KlL8C5ZAmgSwIYR2drlMNVDfMBRazQaUMZDOGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bc2GLWh1k3jxz9Gi64QU710aADRfON8LR8HWvRfHhCAm9157dyGJ61hkmaWXry+Eu
	 W/6FbuG6b3M+Fgwpasyxspgh7hJFCXgBSm5X8+DK2tx2BCw5N127HJfAG/Qyp9MSBC
	 Ojyg+GwEIJSPEDEmepA37jO/h+MPN5QENgwdb1ZYy6wFu0RUI54WPy2SeqJU5oNyXr
	 9Bw0IszA65Qf3kg40N0DQH7TN+5o/O6rPS64xGaBdlvB2UUAsog+MODL3IF1XYpNc3
	 OJjKlJSEKYNYDk9awKqgtN1hV5t/Eg0mWZ/VXN75fkuyxwds2OKjBtWakC78W644zw
	 ID0Vf7T9Gv9NQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa63daf2a5so1596217e87.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 05:10:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+AJZ6DFGMy9j4syCwlZV3Ono6jDJkjP359OnXdEepfwsKvW4CfsHlr8EwVBqnwvQc12tQjqkUC2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/3QCtKemfREM+vB9zwQgC1UzajRM4oZUfcQNkDo/2L0UCo4I
	QNO+QGvue0B9E3M8ib8QHzzCzGOf0C54wp33598jLcGzJeZFxLUPIcX02qHFPxZaRF09iJPRKpl
	NWg0X6GyGXib1NcQb8YF78BHUXHDEntQ=
X-Received: by 2002:a05:6512:3d09:b0:5aa:6cd6:a7ef with SMTP id
 2adb3069b0e04-5aa6cd6a8e7mr1091989e87.45.1780315802508; Mon, 01 Jun 2026
 05:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601090152.1243983-2-daniel.lezcano@kernel.org>
In-Reply-To: <20260601090152.1243983-2-daniel.lezcano@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 14:09:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHNHpaJug97Xx-5-_JgJ2EM2P_YB86pn9QY8k36_4oXg@mail.gmail.com>
X-Gm-Features: AVHnY4LbyLgwWYfRYLdXPtfDI-mMEcyob74OW82dAm5d9vhspLQmkDORila4tgU
Message-ID: <CAJZ5v0jHNHpaJug97Xx-5-_JgJ2EM2P_YB86pn9QY8k36_4oXg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Fix missing stub for devm_thermal_cooling_device_register
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:02=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@kernel.org> wrote:
>
> Even it is very unlikely the thermal framework is disabled, the newly
> added devm_thermal_cooling_device_register() function has not the stub
> when the thermal framework is optout in the kernel.
>
> Add it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605301554.S9n45bfQ-lkp@i=
ntel.com/
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/thermal.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 81be6e6061b3..083b4f533933 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -344,7 +344,11 @@ static inline struct thermal_cooling_device *
>  thermal_cooling_device_register(const char *type, void *devdata,
>         const struct thermal_cooling_device_ops *ops)
>  { return ERR_PTR(-ENODEV); }
> +
>  static inline struct thermal_cooling_device *
> +devm_thermal_cooling_device_register(struct device *dev, const char *typ=
e, void *devdata,
> +                                    const struct thermal_cooling_device_=
ops *ops)
> +{ return ERR_PTR(-ENODEV); }
>
>  static inline void thermal_cooling_device_unregister(
>         struct thermal_cooling_device *cdev)
> --
> 2.43.0
>
