Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FB3C73CC
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927912; cv=none; b=qpMYggUh1M5YlcqN9IT92iSpF0BGpsjloGb3pZWH2ilOxD8LMkkLQekbF8HOvGmo2Upm/608iahtHsaY4kDwUorjqI32TDfkzaf1oHXnPzRApfVgArsd/R9Ph0LBwhYUx9AMS9PR7TF61jJXAIubdPK1G4po9qmgBW4XicOiZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927912; c=relaxed/simple;
	bh=CgoHGUDLPWgn+w8sKYQPTmKoljGnnw2Naxq3gvG9oK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHO+meqh2rylMAYgGsG6jyR5IO3+CnqTUP1rND9fVg8BnllQ2G4/0HAlYLBBSdlUQbdVVJLSR7Kln/+IEmFMDODJb4/fjLxjL73+G5MO247TXOXxoxfU3jw3UvGYob/rhqWIgUbFCyUBob2TX9VQWDiUzkgp32W/mpOmhYfBlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idvgfbyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idvgfbyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B9A1F0089A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780927911;
	bh=JJg33xOrhHhg0FKRc1bmj97OCk07VsVoZvBiUc/nFrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=idvgfbytAWy7xIsx+hoXiOjp9Mhpoj26UdZTvi9tfK3gA+EsRTQKsR546CqnQy1gp
	 Q5qjhALFdDMtDTHXuocEpK5kzMbHeD+7FwuX45Cp/i5wXGQgS6BvJPBedjx8Yg9jZ3
	 g6Oj8hMEInT77R/zfMHiZrt3xmh1801vY9QntUm7Y2BmEfV+0rKRsEea38VZ1u8qul
	 aXGJrkjNo18CiUQcfXUpl5hjlsCokJjC5lMcXcILInSL4ITuR6x4IgR/fxgRzndIlA
	 bUaOOewmeaAxahQdHjYCLp648TVHApwu6KpYGG7KFDrn2n8EKO83d3U8R5WnEwXerc
	 YL98ZSdXDYMSw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so4749484e87.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 07:11:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Khd10kdEMqBvSx4voURqcORsFh49zbaoCnk95ZwvD7QaFaj0ZEO9qT3NAsET8iMSavhCC95/q+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YysC2hlkExu2ZrBN5CHP+URarABw7Faxl6Ypo4yAoBB+gb8hVn9
	wNZZ0vtQtMLbpN4Ha6pjQR+FNHn4dRSafzAeca7rxoEIEmS1iY3XYWHjU+1SHL+Ctg8GOhC/n5M
	lW30Y2Y+lJsiw7OYy0SdYk7N96W/a2yA=
X-Received: by 2002:a05:6512:15a4:b0:5aa:66a5:66cd with SMTP id
 2adb3069b0e04-5aa87b78a82mr4819117e87.18.1780927909661; Mon, 08 Jun 2026
 07:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608021526.1023248-1-tzungbi@kernel.org> <20260608021526.1023248-2-tzungbi@kernel.org>
In-Reply-To: <20260608021526.1023248-2-tzungbi@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 16:11:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
X-Gm-Features: AVVi8CdDK_AeEhEGHLtxn8R29DNmlv34N5PLRg_07cIEGG4wsjElUzUaXN-ru2s
Message-ID: <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: core: Rename module parameters prefix to "power"
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, tfiga@chromium.org, 
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 4:16=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> Currently, the module parameters defined in drivers/base/power/main.c
> use the default prefix "main" (derived from the filename).  The prefix
> "main" is too generic and non-descriptive for power management
> parameters.
>
> Redefine MODULE_PARAM_PREFIX to "power." at the beginning of the file
> to group the module parameters under the "power" namespace instead.
> This makes the parameters more descriptive.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> v3:
> - No changes.
>
> v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungbi@kernel.o=
rg
> - New to the series.
>
> v1: Doesn't exist.
>
>  drivers/base/power/main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index ed48c292f575..cd864f3a2799 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -40,6 +40,9 @@
>  #include "../base.h"
>  #include "power.h"
>
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "power."

"power" may be confused with the power supply support, so I'd rather
use "pm" or even "pm_sleep" (in which case the "dpm_" prefix could be
dropped from the new module param name in the next patch).

> +
>  typedef int (*pm_callback_t)(struct device *);
>
>  /*
> --
