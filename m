Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E794377ECF
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021609; cv=none; b=OsiV909zSOHa7noEB/+1dvQFE1fbFzNQhm85zuCGSk6Fz7KXVvUiSOOFppzKt4jlV3/jwXR7qQS4QBp4S7F7YoaFlgK6eCKDmn7nhXWLEu89lbyl2uELo8DOvuKsoDC+npYCOYflXN9GKO70GsVimS1BdN7C6U4aoOlDredoXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021609; c=relaxed/simple;
	bh=m8vQxDVWtiKXGUumN8w4wGGIz1jGRtHOxYQUtL3aKzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMhMb0DuVV2WDvnSgalLU3FLdmjeZswW9j7gByaY+rLdihZZiuFyKtPTQ1lP04nQWFQPgQV6ORnYmVnDKVOQ+34pFi0p3E/OQYMxtk2qmC8C+Rr4mEq5J0NFJyuDGoGlErUKyqelfQN9Q+DLIL7hXZscALlXLi6bDHFZk1c0O64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFZtoq9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFZtoq9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C805C1F00893
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021607;
	bh=oy+wkqTvrdjrZQOe1xdJca6UguwVA7jPuTT15gL03os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mFZtoq9Gtd/CfVbYZt9TtroIzuWCj6CFSw5KPwdJBZ2aBJxkYuifypWmFkUCbxAW1
	 wUiilI0b+2v2ZwCtBIoIjDtaM5VbLlnNylHtcMb3/HIKv8j94lqJ/G3Mk2uMSWDwfj
	 Y6iJXGly744sf/zVrbcdsIHbsI09IWUGGCmS5t0SUxMuzuuA3YCM5zF/dXXYz3zG49
	 0ieHHLMFSbRx2Ew0yHuJMC64SrGBKs2SO0wxbxBuhuM4Yp6vyB9VgP+rPP+1aUHiKX
	 l9toA6EMnYNuKDRB6gAIqXcvtLBBLgZEnEnT50gd77FzdmO4XgGrfS6JSRsnWE/Idu
	 YSnoXOBtpZgHw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3967725a77fso56942341fa.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:13:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/s4IvUilfmgCeB7nS+rDXPrKYE3626W/FUGgmwkTqTT2gHSNprDMk9XfTkFXZGRk9HdrjeBAgJAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbqyiquh0OZDfry3JCZGYGxQ6VfmyNTLIyxjO25jiCP/XSt8w
	Wlb7fR15Yx9Y+VaPUv1m5VVlnVKwwSkqJs6lyoPTvAZC6+bx6+2cOfgiNphPa0Pr5s3ThrFGHJB
	1y6bxEvEqYEEoW/UClqTMMCsAg2c2GeA=
X-Received: by 2002:a05:6512:10ca:b0:5aa:5025:3189 with SMTP id
 2adb3069b0e04-5acf8b8dbdbmr1018134e87.42.1781021606215; Tue, 09 Jun 2026
 09:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608170748.82273-1-dbgh9129@gmail.com>
In-Reply-To: <20260608170748.82273-1-dbgh9129@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jun 2026 18:13:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iR6UuFYoTWnaTRtJtk+6N6JFLtVSD6BYZsrRkO9H1M2Q@mail.gmail.com>
X-Gm-Features: AVVi8Ce5NG7-T71vTa3POMZyoPpX9waqW5gk5pey3bI4ZRYU57atvvgBhQZrcic
Message-ID: <CAJZ5v0iR6UuFYoTWnaTRtJtk+6N6JFLtVSD6BYZsrRkO9H1M2Q@mail.gmail.com>
Subject: Re: [PATCH v1] PM: QoS: Fix misc device registration unwind
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 7:08=E2=80=AFPM Yuho Choi <dbgh9129@gmail.com> wrote=
:
>
> cpu_latency_qos_init() registers cpu_dma_latency first and, when
> CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP is enabled, registers cpu_wakeup_latency
> afterwards. The second registration overwrites the first return value.
>
> As a result, a failure to register cpu_dma_latency can be masked if the
> second registration succeeds. Conversely, if cpu_dma_latency succeeds and
> cpu_wakeup_latency fails, the function returns an error while leaving the
> first misc device registered.
>
> Return immediately on the first registration failure and deregister
> cpu_dma_latency if the second registration fails.
>
> Fixes: a4e6512a79d8 ("PM: QoS: Introduce a CPU system wakeup QoS limit")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  kernel/power/qos.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 398b994b73aa..1944dbeb0d4c 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -519,18 +519,23 @@ static int __init cpu_latency_qos_init(void)
>         int ret;
>
>         ret =3D misc_register(&cpu_latency_qos_miscdev);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 pr_err("%s: %s setup failed\n", __func__,
>                        cpu_latency_qos_miscdev.name);
> +               return ret;
> +       }
>
>  #ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
>         ret =3D misc_register(&cpu_wakeup_latency_qos_miscdev);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 pr_err("%s: %s setup failed\n", __func__,
>                        cpu_wakeup_latency_qos_miscdev.name);
> +               misc_deregister(&cpu_latency_qos_miscdev);
> +               return ret;
> +       }
>  #endif
>
> -       return ret;
> +       return 0;
>  }
>  late_initcall(cpu_latency_qos_init);
>  #endif /* CONFIG_CPU_IDLE */
> --

Applied as 7.2 material, thanks!
