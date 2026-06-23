Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC641C72
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216921; cv=none; b=N0gA3I4u34IHeENNxT5saORbQH/V23tIkMO91Jx2jkawx+ZU6SERWDP/N8jZHbPUmrJrVw5A/gs/aSgqRdS1xRyTovBrYKtfFc3PyuxUrJaByPHXtcg0Qv1CiizxnSLVKbu2ZWHvUPluhkOC1hB6SZSOgBqmuT0/q7wza2IIP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216921; c=relaxed/simple;
	bh=Uk26RXzBLNoTAplGfMkUzxPcsC0Rno0ee22agIFv5gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgmXGTQb42m4M8vlWBqv2DRX/bPFcJ0/Xt2FjTXU75InJh5Chs8CjbyvF4OdIx3krWOZIt6WycDdkBxEWqQeXSMRSQQy9Nx59LSl7jAORFhfcgGHqunP4f4wQoF1zPpqgQCA3nylIjEWfTle0gsBjdUV5Bq9MooSgAaGA5vpatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFG+N69X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFG+N69X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594921F00AC4
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782216920;
	bh=TgeZMJkDjHNNDgHc0S0nhakdXcOlfDPM3hTKcJ8WcGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XFG+N69Xim7ACRkhEA9KIlNcTUee6fqOZppueASBO1vBqb0TDr4xypiz/W2kN02xf
	 Oa5jpXk95UhWixg1s/bXbimEjUGxSAcEIFWc7Ttgqtt3UqsooKdNHnbMDsfGaxWXIH
	 VWQl9yTjC5syYCae0oa/8nvJM+6uX8NdTka1NCRGmLhYUxI28V7nRQQ3JvycK+ZLTt
	 4gvb0Bqrps6cBdkTh+OzCoYqsbNFau9lX1/fdiUHdDDRu2VKqDibyxo6qHptffm9ng
	 nrrXjT0Ovm3IkVd51XVi07ECq9xJGE4q0m4hb+4jzghdI4E78kR6Ku7bDrIYfLhrpk
	 2sSGfF/TsySmg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ad68b30252so1326837e87.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 05:15:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+rxtlcytpkOPcma2PO+jkUnbsVWUpaEr/cFeq9mKI2Y0OXw9waAnTWQp5VUPFU5Fc6DyDuMvDcxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xHSWRN60p7gpcG9vrqE9+X20owPTrKIM/poAD220sCco4xu9
	dFzGhCgFCB84srMbBa83PAa4wDV21Jznkndn17i79NV1cEH6A2UIi8B6NXp7Lsa1iee7RI+Sr5Y
	6cBonkCSp7rdxU8q+twvP5RtqZ15+jcE=
X-Received: by 2002:a05:6512:804c:b0:5aa:678f:5646 with SMTP id
 2adb3069b0e04-5ad576db30fmr3841497e87.8.1782216918732; Tue, 23 Jun 2026
 05:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com> <20260618224527.1506419-5-jmattson@google.com>
In-Reply-To: <20260618224527.1506419-5-jmattson@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 14:15:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hETJWf7Y=d-trMhsSsAZMiP4CFFeNc+RKMrbG_iuwXfg@mail.gmail.com>
X-Gm-Features: AVVi8CeCUBGVAU-IEA9xlKDeDjPpEf5sUU8Bd-zbTZHIX5j3jFJ_MrBhwNi6eVc
Message-ID: <CAJZ5v0hETJWf7Y=d-trMhsSsAZMiP4CFFeNc+RKMrbG_iuwXfg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] cpufreq: ACPI: Use amd_update_hwcr() for
 MSR_K7_HWCR updates
To: Jim Mattson <jmattson@google.com>
Cc: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:45=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> For consistency and maintainability, update boost_set_msr() to use
> the centralized amd_update_hwcr() helper when modifying MSR_K7_HWCR.
>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Assisted-by: Gemini:gemini-3.5-pro
> Signed-off-by: Jim Mattson <jmattson@google.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/cpufreq/acpi-cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 48d678812fd6..b3e058dd6b4b 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -103,9 +103,7 @@ static int boost_set_msr(bool enable)
>                 break;
>         case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
> -               msr_addr =3D MSR_K7_HWCR;
> -               msr_mask =3D MSR_K7_HWCR_CPB_DIS;
> -               break;
> +               return amd_update_hwcr(MSR_K7_HWCR_CPB_DIS_BIT, !enable);
>         default:
>                 return -EINVAL;
>         }
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>
