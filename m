Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081DD471428
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814517; cv=none; b=ddMB+LABHShbBJHQOp6yrBGD0RLJNmaBZ0EBI4QfhRim1U3iCbylJNjsMRgu9YlufZEpM9ZXiGjZkObo82ZLE48SyK9fX1F053VSxO2Yw6NVnh87fXJjd+6bqWgY0SpJeA4o50+eks0f2lzm/6zR1KanfPazwockeiqWYayq/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814517; c=relaxed/simple;
	bh=VwQdFLfRqdGM5nUxBzCF1AGxYUnnTWEYeBtyXHCcubA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFHc8DFTpXRHUCjfAgdWsZLO3SQY7hAxmzZhJarrl9b1NvM5bv2rmC1+XcioByCDdsCUx+JEqaI6bPz/k7jlcEC9HTjxSfG//2CX+MdEG5RX2eVbl4/cUrRoquygK9uX8lHvl6U27zCxRUdrH/flS9J9W7PiUw+bB/HL+flS2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D241F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:48:34 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so808619e87.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:48:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqimsnVkZz7U5IHYnGFsT3ofnGv7YmCzw/9MQHMIGOFo6XR/9GOA+zRT/z0CkSn2rVaizCE2WqvpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyejHeYX47JEp1wBq1cNW2g97lGi+tVmsU5naVlmAbDJi3qYEQq
	+ALU3mGYycs6OInJ7BUIRe3a9LFLYW8v5QW1j7ECMNcK93WGp9rEKYIbvy94dWlGg7Zx8/L9TAP
	8IWU5hcEt9hP/vr9y5ygDu7ZUdqyJ47w=
X-Received: by 2002:a05:6512:1591:b0:5b2:8c97:b50d with SMTP id
 2adb3069b0e04-5b2b2e52d40mr630470e87.4.1784814501178; Thu, 23 Jul 2026
 06:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720030821.2780257-1-tzungbi@kernel.org>
In-Reply-To: <20260720030821.2780257-1-tzungbi@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:48:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtdDt+bMm8As_FRHXhQn2fDzhc8jhpKm1=1iGTaVAHww@mail.gmail.com>
X-Gm-Features: AUfX_mz7JjnAkI5LuEmMgkAJQMkER1jPgy31srddET01j7xHZTzj3KWIy3A2kZc
Message-ID: <CAJZ5v0gtdDt+bMm8As_FRHXhQn2fDzhc8jhpKm1=1iGTaVAHww@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 0/2] PM: dpm_watchdog: Improve DPM watchdog configurability
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, tfiga@chromium.org, 
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:08=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> This series improves the configurability of the DPM watchdog.
>
> Currently, the DPM watchdog is always enabled if compiled in.  Also, the
> module parameters defined in drivers/base/power/main.c use the generic
> and non-descriptive "main" prefix.
>
> This series addresses these limitations.
>
> Patch 1 renames the module parameter prefix for
> drivers/base/power/main.c from "main" to "pm".
>
> Patch 2 introduces the "dpm_watchdog_enabled" module parameter to allow
> enabling/disabling the watchdog at boot time and runtime.  It also adds
> CONFIG_DPM_WATCHDOG_ENABLED to set the default value of the module
> parameter at compile time.
>
> The primary motivation for this configurability revolves around Android
> GKI (Generic Kernel Image).  We want to enable CONFIG_DPM_WATCHDOG in
> the GKI so the feature is available.  However, because the GKI is shared
> across many different devices, we don't want to inadvertently affect
> devices that are unaware of this feature.  This provides a way to
> compile it in, but keep it disabled by default for those devices via the
> kernel command line or module parameters.
>
> To maintain backward compatibility, CONFIG_DPM_WATCHDOG_ENABLED relies
> on `default y`.  Previously, the DPM watchdog was always active if
> CONFIG_DPM_WATCHDOG was set.  Defaulting this new option to 'y' ensures
> that the behavior remains unchanged for existing users and defconfigs
> when they upgrade.
> ---
> Since there was no further feedback on v5, I'm sending out v6.
> Any feedback would be appreciated.
> ---
> v6:
> - Change the prefix "pm_sleep" -> "pm".
>
> v5: https://lore.kernel.org/all/20260701045640.3130090-1-tzungbi@kernel.o=
rg
> - Rebase to v7.2-rc1.
> - Fix Signed-off-by lines.
>
> v4: https://lore.kernel.org/all/20260611021219.2093476-1-tzungbi@kernel.o=
rg
> - Address review comments.
> - Patch 3 in v3 has applied separately.
>
> v3: https://lore.kernel.org/all/20260608021526.1023248-1-tzungbi@kernel.o=
rg
> - Address review comments on patch 2.
>
> v2: https://lore.kernel.org/all/20260604090756.2884671-1-tzungbi@kernel.o=
rg
> - Form a new series.
>
> v1: Doesn't exist.
>
> Tzung-Bi Shih (2):
>   PM: sleep: Rename module parameters prefix to "pm"
>   PM: dpm_watchdog: Allow disabling DPM watchdog by default
>
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  drivers/base/power/main.c                       | 14 ++++++++++++++
>  kernel/power/Kconfig                            | 10 ++++++++++
>  3 files changed, 31 insertions(+)
>
> --

Applied as 7.3 material, thanks!
