Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1858477E2B
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224602; cv=none; b=rylCIv9P4xLnpva9EhOEOiwflkfMWsQAaV/mZx2wNiON2p3z9RZsycDr7AvOId8U0qWhkNyOra9HUu3xtvKR9Wiu9D/SjHPOKZOLXIH4sOZZ3Tirf/xvUTflquQnIXnHmeXOF01P6KqueL6Pxx5eNMl0cL0ip1ycAQw0W0+SSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224602; c=relaxed/simple;
	bh=mg9sfrdjj9Rxh2K/4kD1npVTFhhd/pgaXjnGwsMfUKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASpQZrnZKhcIqyTYZPkbHNzfXStlN3bNZhDKdYPYIof3OgNxDaONgYd+ZW20Rdjwk2ohtzAouqAO768vr4dPToHv8Lb0B3sWqSYH1T3DcyfKOgpQRj3mWHxYTkoxlp6HTh8ADAArJVNwopx4+wZJVgKgq19KYFejDFSv2BwcIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv9wUJBS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv9wUJBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD897C2BCB3
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772224602;
	bh=mg9sfrdjj9Rxh2K/4kD1npVTFhhd/pgaXjnGwsMfUKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sv9wUJBSLNM/iugNZfMmvn+QqKUYCLlHWqFVIp/SsbR8KDw53ukPHiP2dU1QRI/Q8
	 uAPMPlKyAvZlEIRDOwk8pWDVQ5OSslwiOKEXxQ7K8+uvZRf4TK7OE8vvkKDjT5v7Gb
	 DMhV3cQMGuFkjZyoOG7zcy/ByiZnJeQigW3dcItLwRRK+QoF/AjU0eM0L5FqirUhYc
	 JBHTqKI2U036ynmRbzdqYpkU07pat515hWNpqOdJiYmChR8jEAjDPSPsY3kWwdFqGW
	 qaBtIKnvZPZ0cWahQmsHpCwKqHah04dVo4lNKeEfxcWJUnTZZL85ZP+1P80jpzTK8J
	 GHfJBWpiiex3w==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662f91bba0fso2826434eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:36:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRV9AEBv20gHrt6P7jKE01xrquzk/H3tKEi2zquDUzwJuUGrBp8nmFWBOpJ4OhMlQiMZ95taje5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyamEVxrjp4oD78S8/wWCGJ5l0Tar7skd8y9wiVgL5V2R0+ScgI
	ClT4GdpqAFZ+ApV3V1ImI5FRbHMDRj4AFWRfyouNY8A01bHFiCDPWEm6zsxax9e6YzYvbQtxwa/
	oO7hwfeOly1mFGvAFSilWzxMVPddpW3Q=
X-Received: by 2002:a4a:edc9:0:b0:672:397d:5da2 with SMTP id
 006d021491bc7-679fb55a57bmr2115102eaf.25.1772224601395; Fri, 27 Feb 2026
 12:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206142658.72583-1-sumitg@nvidia.com> <48b52f98-119e-4693-806b-78d47f7a43bb@nvidia.com>
In-Reply-To: <48b52f98-119e-4693-806b-78d47f7a43bb@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Feb 2026 21:36:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iOsqoZx0EZ3AqEk_8mrGxSj6wj-m8phRJ0cT71NTuBWA@mail.gmail.com>
X-Gm-Features: AaiRm53Rvoc1jPRsW_C3wm3K2uu7f-OR6f-nyVhpAFv0qIGeTAbPKLPHLqUbNQc
Message-ID: <CAJZ5v0iOsqoZx0EZ3AqEk_8mrGxSj6wj-m8phRJ0cT71NTuBWA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Enhanced autonomous selection and improvements
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, ionela.voinescu@arm.com, lenb@kernel.org, 
	robert.moore@intel.com, corbet@lwn.net, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, zhanjie9@hisilicon.com, yumpusamongus@gmail.com, 
	dedekind1@gmail.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, nhartman@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 2:59=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
>
> > This patch series improves the CPPC cpufreq driver with new ACPI APIs
> > and enhancements for Autonomous Selection (auto_select).
> >
> > CPPC auto_select enables hardware-driven CPU performance scaling using
> > Energy Performance Preference (EPP) hints. Currently, there's limited
> > runtime control and visibility into CPPC performance registers.
> >
> > The series adds cppc_get_perf() API to read performance controls, updat=
es
> > MIN_PERF/MAX_PERF in target callbacks using existing scaling_min/max_fr=
eq
> > interface similar to intel_cpufreq HWP handling, and exposes perf_limit=
ed
> > register via sysfs to detect throttling events.
> >
> > The patches are grouped as below:
> > - Patch 1: Add cppc_get_perf() API (independent).
> > - Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
> > - Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent).
> > - Patch 4: Update cached perf_ctrls on sysfs write (independent).
> > - Patch 5: Update MIN_PERF/MAX_PERF in target callbacks (depends on 4).
> > - Patch 6-7: APIs, sysfs and doc for perf_limited (independent).
>
> Gentle ping.
>
> If there are no further comments, could this be considered for merging.

Applied as 7.1 material, thanks!

That said, wouldn't it be prudent to check cpc_read() return values everywh=
ere?

They are handled quite inconsistently and this series doesn't improve that.
