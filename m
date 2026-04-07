Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307AD3C73EA
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581677; cv=none; b=ZK8AROC1Xjs+l8LDApwZUhmpGeYzqCJ+95v0POkjiB+J3yhv/uy1bTJnCLMP8sFAAl6r9s6tiFP3EHY13RStk1EVp+R3mM74XgW386l/nnNodV/JmK50YdhslZVFfE3DCTo7Yz2EIuca9F4SjCkvhYW8qA9V4IsSz6zODDewl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581677; c=relaxed/simple;
	bh=rGfsBi2DCgduhWIS7yuJTil7m6jzaQM/sno34JzF1pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxuF9JrQ9+peNB/lYSzEYMUJTA5izebMduE+ct2aJnysndAFXG9UCE3YZ9UcsQ6NvgCvtMatLUW2gEcgdKEzmcXgOZf6+d3LocPc664IBCetsoYHkHyQm/nhTP6qv3JK6n8pLanGJH3gTjDS5tTnmy/NZ8jtbmpqsYYX61J6NPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9XFeKtB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9XFeKtB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15FDC2BC9E
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 17:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775581676;
	bh=rGfsBi2DCgduhWIS7yuJTil7m6jzaQM/sno34JzF1pk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K9XFeKtBw3wGQFsi4LHIVD9TMsUGCpDtPX2HgTtKInkKY47oww8n3eHnLZZ88WW12
	 niUrhGFandur30+C/4umc2XmmDw/0Th215R0StWkMSQ9lwWZlF2G3Z32x8AXQ/Q9ll
	 sp+p+1qmGv1q/n3nr/I9nEKGMaaYV06d6hvq+EaIPBvz0RIApItGsLcNP8tq/PNEKt
	 3JL73UQtjdC29WTx9/hIOin+clkmflSyjJND8QxePw9YnyWw+K9NLwzbhLeCR4bXrQ
	 lNzv0pVxcP63TTCeacs5PmaPsvyAdx/rpWcUSpRTiomtJeDy0TpvOMxsqX+ldzR8uT
	 omDcegb4NiI5g==
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4b77adso6122769c88.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 10:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVy0RGUOEsy2Rwio13cVW2m90vB0f3WtuFIENY7CfJcFcxcZogEJWagqCBcrwqMhKuKDOZB98IEtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tdJ4Dt1qlpH24pmqNvySDPkeD5WyeSHJlQ/hdNI1OK3esiQe
	CyyW+CgAqp0lAbtJzqrC+YiBx1k3qlduVS4YG+w9rVzoiLYrdS9MnFbumY1L1fsC8juR1hjoC1G
	Y2T1K41Sgmk8GSDKZv5C8LROTVrShheg=
X-Received: by 2002:a05:7022:260b:b0:128:d375:f1d4 with SMTP id
 a92af1059eb24-12bfb776260mr8396583c88.28.1775581676239; Tue, 07 Apr 2026
 10:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407145458.163727-1-mario.limonciello@amd.com>
In-Reply-To: <20260407145458.163727-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Apr 2026 19:07:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5B1=Qids67NHQV8Zh5jo+Vg_uh1tGorrGStNrTnC7vw@mail.gmail.com>
X-Gm-Features: AQROBzAnGc3Rm4rMhY6iXvI5ghcsoaMmSCcNGoFgmg2vT3gxm4N6mh-NNz1xyBE
Message-ID: <CAJZ5v0g5B1=Qids67NHQV8Zh5jo+Vg_uh1tGorrGStNrTnC7vw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Add POWER_SUPPLY dependency for
 dynamic EPP
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 4:55=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The dynamic EPP feature uses power_supply_reg_notifier() and
> power_supply_unreg_notifier() but doesn't declare a dependency on
> POWER_SUPPLY, causing linker errors when POWER_SUPPLY is not enabled.
>
> Add POWER_SUPPLY to the depends line to fix the build issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604040742.ySEdkuAa-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index a0dbb9808ae9..53e2702e6f1c 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -71,7 +71,7 @@ config X86_AMD_PSTATE_DEFAULT_MODE
>
>  config X86_AMD_PSTATE_DYNAMIC_EPP
>         bool "AMD Processor P-State dynamic EPP support"
> -       depends on X86_AMD_PSTATE
> +       depends on X86_AMD_PSTATE && POWER_SUPPLY
>         default n
>         help
>           Allow the kernel to dynamically change the energy performance
> --

Applied, thanks!
