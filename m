Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E8483
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 05:09:01 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d9a0ead0cso552984eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 05:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263340; x=1701868140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCA+ImEIUbeGIm1ABRNcSrpYNvMMQ4NeJ/89Y2RrRM8=;
        b=m04jV2gn4aggCM3Wp/b5yd5oV5vU9Gavm6fGG4hwSXSLKo1gCHk1lRpwVWfqJkIPgZ
         T7x2MNjuwNbOYseiIY7fc08YQnA1oli/LuefQyyR5dEK5S620K+imJFiR/b4QetRh0IK
         EvWq/D55+o29Tn4E+KvtxqkmUxilPdFwmrjx2lXBCtnAWHaCUMYqt36bCeu0XX5c9iD6
         cUEHOoubd5Och40Bau8Ye39qT+YVe/QHldSc/Kmnq2mhoJvduXxb5xT2MsSE13od3Q0+
         4/eD/tTvMlfIRlb2Jzt9mM3SYb94Fj78xxb0zJ7ZlMMHrhzKaeVGk6HM1Zkz0HCexeAp
         Oi/w==
X-Gm-Message-State: AOJu0YzGhYmrJPtG8SxcaJU3ua0i+MoGn3gcQdzjvw7+IUNPeN9AyUwe
	f9k8S8u5BMcoVwK9GI/C7Cx6NY14CJzToDe79Uk=
X-Google-Smtp-Source: AGHT+IH2UtNMXGO5cNt0+amUYlGLaeEwqpR/Pd+ZYEnTxur5pB/H2W+liNBM+a5sGnFfpbg9MFHtx/QW6tNbabHiyxw=
X-Received: by 2002:a4a:c691:0:b0:584:1080:f0a5 with SMTP id
 m17-20020a4ac691000000b005841080f0a5mr17876910ooq.1.1701263340232; Wed, 29
 Nov 2023 05:09:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com>
In-Reply-To: <20231120234015.3273143-1-radusolea@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Nov 2023 14:08:49 +0100
Message-ID: <CAJZ5v0jB9ObOWR5xWme--DZxFdjCYpdf9K6=KpywYxuq6F2c3Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Radu Solea <radusolea@google.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 12:40=E2=80=AFAM Radu Solea <radusolea@google.com> =
wrote:
>
> Some thermal zones are bus connected and slow to resume, thus
> delaying actions which depend on completion of PM_POST_SUSPEND.

What actions in particular?

> Add optional execution path to resume thermal zones on the system
> unbounded workqueue.

Why optional?

This is only useful for people building their own custom kernels.

> Signed-off-by: Radu Solea <radusolea@google.com>
> ---
>  drivers/thermal/Kconfig        | 11 +++++++
>  drivers/thermal/thermal_core.c | 58 ++++++++++++++++++++++++++++++----
>  2 files changed, 62 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c81a00fbca7d..148d6e9734c6 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -91,6 +91,17 @@ config THERMAL_WRITABLE_TRIPS
>           Say 'Y' here if you would like to allow userspace tools to
>           change trip temperatures.
>
> +config THERMAL_ASYNC_RESUME
> +       bool "Thermal async init zones on system resume"
> +       default n
> +       help
> +         Re-initialize thermal zones asynchronously on system resume.
> +         Thermal zone sensors may be attached on slow buses, impacting

"Slow" relative to what?  How can it be determined?

> +         the duration of PM_POST_SUSPEND. If that is a concern enable
> +         this switch.
> +
> +         If in doubt, say N.
> +
>  choice
>         prompt "Default Thermal governor"
>         default THERMAL_DEFAULT_GOV_STEP_WISE

In the first place, I would like to know the exact motivation for this chan=
ge.
