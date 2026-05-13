Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9F5A79B
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701641; cv=none; b=jPnj5jdTMXoGUw7ZzWZLDuRmSzmTEXfPkcOi0SFj9RWWdTR+DjnJH73PnbIgz33ci5Z76cYzoznpoBxZhb4k7FAx+iivD3l2NFEBnDTBWzyg+nJtQPxqzx0twLBJmWRQijSfXpQZYBM0bwe9a5r86/31hazzEJW3OHkWpLx/zKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701641; c=relaxed/simple;
	bh=9Ydne36LPPJAEpYXCfOCBgRaZJCvv1oiBRVFjvcSVug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OonJEry6XEmX7RZ69sVkGt5ae2g67FxT9/jS2AtzhMosz9j4SJrqWxRvPugN6eKNF3jzUCkK7EeBQrkgQfjuPs5t1T9BxSnNS/MqRxS/0OtQktpLdQS+Foi5beihZmFU16lIzMFC/wuhMU0JrZX2xpcohiGQ9C47kZeWGHwGVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV7qtEJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV7qtEJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA36C19425
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701641;
	bh=9Ydne36LPPJAEpYXCfOCBgRaZJCvv1oiBRVFjvcSVug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mV7qtEJccXY3yliFfXXhsXLxt0JVG5V55k2dZ+QaYIE4oIYwTnkShx89QWkdWxyQ/
	 gBgKkUfWZ3jMzw/FIFmDIxLdSvTBPPwW0XhOpwbx1/re2UWQyNeHJfr/xWaeWZpt6t
	 K51q1fjQceWcxbWHXwhE15NKr2Oo1VakvYrKv5D6iyTYa2RHG+kEKoXjYKHl00osN6
	 mGRvrpiw1uDpYoIOEjGLzFxmUITGKH5OSwLGigEhlNI+W1I6yYAt5De6EMmqXKACEt
	 Wfqw/2KoWJ1NMPnKXw7nHnOLj5PKLMpgy7COTfWHAVyg0FmcVdbun2xc33vtuElRcn
	 bz1gwSYYxgOrg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a884815606so7136001e87.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Sx3fCkMBmdk1BflIBIo/oKAPbOIyXSsSKuVdbrN6fALy5MVivZGzr6nwmp6dn+wq454NG/gG39g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNuAb3gw0cIRRKn+IpEdE02kMnyARKPBY9dFLra1lq5jGZUkA
	Indpv4btbivOQ3YBhXwOTkxDILE5CI2lHBUhQwSmtUqYP7ygicolvBy4KGBWAxD2D5jsQVRAtCK
	tCzL+Bg7Kp5k9yNs7LehUIOTEafzdagI=
X-Received: by 2002:a05:6512:3090:b0:5a8:9756:f6b8 with SMTP id
 2adb3069b0e04-5a8f445a4cdmr1534217e87.35.1778701639540; Wed, 13 May 2026
 12:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513102847.75179-1-henrytseng@qnap.com>
In-Reply-To: <20260513102847.75179-1-henrytseng@qnap.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 May 2026 21:47:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZBq_wZF87=Ud30FQPBdMK3tUiomQ27q7SfP8eht9rFA@mail.gmail.com>
X-Gm-Features: AVHnY4Ku5RJRIHKesk446e2jQVe88mHUt5ntuadgX7B99FqfI0pDIENrr-ZjTLM
Message-ID: <CAJZ5v0gZBq_wZF87=Ud30FQPBdMK3tUiomQ27q7SfP8eht9rFA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use HYBRID_SCALING_FACTOR_ADL for
 Bartlett Lake
To: Henry Tseng <henrytseng@qnap.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:29=E2=80=AFPM Henry Tseng <henrytseng@qnap.com> =
wrote:
>
> Bartlett Lake P-core only SKUs (e.g. Intel Core 9 273PE)
> do not report X86_FEATURE_HYBRID_CPU and are not in
> intel_hybrid_scaling_factor[].  In hwp_get_cpu_scaling(), the
> non-hybrid fallback then applies core_get_scaling() (100000),
> producing cpuinfo_max_freq values that exceed the documented Max
> Turbo Frequency:
>
>   intel_pstate: CPU0: PERF_CTL turbo =3D 57
>   intel_pstate: CPU0: HWP_CAP guaranteed =3D 30
>   intel_pstate: CPU0: HWP_CAP highest =3D 70
>   intel_pstate: CPU0: HWP-to-frequency scaling factor: 100000
>   intel_pstate: set_policy cpuinfo.max 7000000 policy->max 7000000
>   ...
>   intel_pstate: CPU12: PERF_CTL turbo =3D 57
>   intel_pstate: CPU12: HWP_CAP guaranteed =3D 30
>   intel_pstate: CPU12: HWP_CAP highest =3D 73
>   intel_pstate: CPU12: HWP-to-frequency scaling factor: 100000
>   intel_pstate: set_policy cpuinfo.max 7300000 policy->max 7300000
>   ...
>
> Per the Intel datasheet [1], the Intel Core 9 273PE specifies:
>
>   Performance-cores:                                 12
>   Efficient-cores:                                   0
>   Max Turbo Frequency:                               5.7 GHz
>   Intel Thermal Velocity Boost Frequency:            5.7 GHz
>   Intel Turbo Boost Max Technology 3.0 Frequency:    5.6 GHz
>   Performance-core Max Turbo Frequency:              5.4 GHz
>   Performance-core Base Frequency:                   2.3 GHz
>
> Bartlett Lake P-cores are Raptor Cove cores, per
> commit d466304c4322 ("x86/cpu: Add CPU model number for Bartlett
> Lake CPUs with Raptor Cove cores").  The Alder Lake and Raptor Lake
> P-core entries in intel_hybrid_scaling_factor[] use
> HYBRID_SCALING_FACTOR_ADL (78741).  The same factor applies to
> Bartlett Lake.
>
> Add Bartlett Lake to intel_hybrid_scaling_factor[] with
> HYBRID_SCALING_FACTOR_ADL so HWP performance levels map to the
> correct CPU frequencies matching the datasheet's Max Turbo Frequency.
>
> [1] https://www.intel.com/content/www/us/en/products/sku/245717/intel-cor=
e-9-processor-273pe-36m-cache-up-to-5-70-ghz/specifications.html
>
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 1292da53e5fc..2737e51cff34 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3734,6 +3734,7 @@ static const struct x86_cpu_id intel_hybrid_scaling=
_factor[] =3D {
>         X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
> +       X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
>         X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
>         X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
>         {}
> --

Tentatively applied as 7.1-rc material, thanks!
