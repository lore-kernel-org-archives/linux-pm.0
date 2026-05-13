Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D139656D
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668852; cv=none; b=shXqpPvTyHZK8Zu4Icv+JoAl28yXDOArbc7X2IAmOcXR6P4CPBCsMstoX3xGnySjcD8XZ85lDiWaZRkaI6ZxBYRzbkQjceSsHZzRXVrF6phsHvnDtLgMvpj9Rn7nNbPi2XLgcK6o6Qwk/J3tpvUzC8ziWZ3eXcqZhfsnY6X/waM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668852; c=relaxed/simple;
	bh=bpVPa+hq8ckzUNK/Oj1EHMZtsRkORfZqxsqeUDhZBPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMH4dRECf9Owy3bqoPZ8cEF8cqm3udU57frkzdEPYxp2QP+GuggBhJDMqb9g4Zj1HeCPXf0or4+QB4fwXIW8j0xDKhTeyg7RPB3d7u4k0rAgEhmvC/P4NA9r0kB39+/8AUC6wrfce0C2p6QXrZVSwFhDOl9eOZT1ps4XdMl9bzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hziWE+kJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hziWE+kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5C3C2BCB8
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778668851;
	bh=bpVPa+hq8ckzUNK/Oj1EHMZtsRkORfZqxsqeUDhZBPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hziWE+kJ2oqR6pefLSoGgemnKJ1DaBwcFDbkBsv09qNdO8Q+wLtsb+Cu0tknsTZQe
	 45bE9PgHX6uu4QOuuXY3lVm3EZap/0uOVz5aib187fnkteR8Vkdm0Z9GYTdCO0Vsj4
	 Ee3KtWXJQEQkPYcgi/7lvH6XuP9z1wuCyWueTRPHuq7w07TG8qvgIm0UI2XGt+kSfT
	 SVMml5FqBchiRjgObM6Jc78XvDP8J4u2E3TMRi+/BTsCLGMt34XAVQxI3+Ex0SiJTj
	 4RDl/2UFsViu/IkbJ7SaPw8def/f2H17jeSMg5/1TFQKtM0aezpjbRaqQLoEJ599sk
	 MqVQlpxTbtR8g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso61666301fa.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 03:40:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Uu958wT52cI5lQOTDLjBT5cxXWDoglZ0t0rquUJ7lo540ojiBlDk+2CdTPkvArkY666ljuWI/kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVEjJTl3D+LtGO9FnhjY2X2XTiUx/t6e8YYzc8ute6FrHk2c5
	nZSDkS1N9BO+Rs3HrceqLmENmEfiZMFdA5eStgUIGdovfDJpm8mPA59YG9tzLK3Xdg3gpHEz8HI
	C0zqLPCSl+PhjT8P3h4kZiHZknww15nM=
X-Received: by 2002:a05:6512:3b2c:b0:5a3:cee3:a12a with SMTP id
 2adb3069b0e04-5a8ef9645bamr819047e87.1.1778668850049; Wed, 13 May 2026
 03:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513102847.75179-1-henrytseng@qnap.com>
In-Reply-To: <20260513102847.75179-1-henrytseng@qnap.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 May 2026 12:40:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iR1WFCh56SGFRnkae6hNtD7oBn=5BNKGT1uoPz4_=6JQ@mail.gmail.com>
X-Gm-Features: AVHnY4KjdlrTq9xZ1Pl4vUSCiL-KePIme8YwI74nuYz8Yvj1VM2WCT_r80kQpik
Message-ID: <CAJZ5v0iR1WFCh56SGFRnkae6hNtD7oBn=5BNKGT1uoPz4_=6JQ@mail.gmail.com>
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

Do I understand correctly that

https://lore.kernel.org/linux-pm/4523296.ejJDZkT8p0@rafael.j.wysocki/

works for you?
