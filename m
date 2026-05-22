Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4D42314D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464223; cv=none; b=JS0vG1+OavaFPfbLu5O+0dwWidSftU5T1VeRC94LINpEF/bT0t5+eTGC46gJnE5Bls/w+4isQ0xSJXUGmUAMgxTlrxXoajtobjPw6qxL8akdHeYttjyX0Umqa52BXVUy7sRCiESlXphidZOzvB66xSU9dszsxJlDGbdx3mjbiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464223; c=relaxed/simple;
	bh=blIuKFRRZ/S9hllh14+ij0KgbBT9ffoG3ne56sPhK4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ba2qCqRIZHxagfsdUXLk+Jp46XZG7KeNih40OxJJw3zoX4xfGwkhovFdNaVbpc94ZNqkR46FVVoItHpZjMqCcwkcoOBH+cGO5STX3n6dWMFgKzv/YTnph+Vx+x5yRAYS5w8rVUnG3Hi/lnpvSlEUdGrIZyG5/iWgY1BEs5bOHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU5A9joZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU5A9joZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626671F000E9
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464221;
	bh=fSEYojMIkK+mhSE0dEiQW354SP1JJUcLILA8KCWkd/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EU5A9joZJsFi8kKGr8QpLspqgCgCb2r/7H5Gf/ZzVEw/W3/MUWy0QZBqh89CGogSR
	 J80MrJBvgayzOgeSg4ojSXNXyZvHLcomL4XoWel1QHbDfbBxTXoD+qdJwDsXKKVDBO
	 qKH+3Po1EdXOajcGFMvzFJanN6sHA9cop8MSNXiRD+zIBchaakobIb+9NpVtqR7Zxi
	 uhBCK/e3kukaQT+x7PvitzEojLauqs99v07fBeYQwiEj/Hs3Gtp1yOgAxUm6ZixWJY
	 cYf3bXKRHz9lyhChPDQtpo1V7GVhcDRg6B6gYgHsStWCosnpvOQQOrYiD+vQZJeoSL
	 dZORhCpfuOV3g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8f9841616so6221267e87.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:37:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UDWzEWSzhrQLnM83J+kxNSzrMQpoMQGD+LNIiY1CzPaceBBEOlRx+t59G0vZq3UIW47u5PVK6SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVE2ewmX8nxCEj5gduwZFdqiRczkfavMoSfohdkphw1+t9xRT
	E8QNpp/vmGkpcfueQrOBC0qVeHVmmLOi6kVOdmSOLmt96naQTwS+DpWrf9GM6s8uXj2bKijY72V
	OUOV8enxtN4w7UTn2JbkNa6IjOv2bJYc=
X-Received: by 2002:a05:6512:6cf:b0:5a4:52d:4abc with SMTP id
 2adb3069b0e04-5aa32369e9dmr1294375e87.8.1779464219911; Fri, 22 May 2026
 08:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520032119.30615-1-fushuai.wang@linux.dev>
In-Reply-To: <20260520032119.30615-1-fushuai.wang@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 17:36:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsSF6Pm6Okpn_PhoQBhuUgixdQ7x5P3LNyMZOaNw91PA@mail.gmail.com>
X-Gm-Features: AVHnY4J90RT3PhOA0pL979XaxWsKq14VNBxXEt8ZkS8nTZHz126tBIYUsWEZnGs
Message-ID: <CAJZ5v0gsSF6Pm6Okpn_PhoQBhuUgixdQ7x5P3LNyMZOaNw91PA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Sync policy->cur when setting
 min pstate during CPU offline
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, currojerez@riseup.net, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wangfushuai@baidu.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 5:22=E2=80=AFAM Fushuai Wang <fushuai.wang@linux.de=
v> wrote:
>
> From: Fushuai Wang <wangfushuai@baidu.com>
>
> When a CPU goes offline with HWP disabled, intel_pstate_set_min_pstate()
> sets the MSR_IA32_PERF_CTL to minimum frequency to prevent SMT siblings
> from being restricted. However, the policy->cur value was not updated,
> leaving it at the previous value.
>
> When the CPU comes back online, governor->limits() checks if target_freq
> equals policy->cur and skips the frequency adjustment if they match. Sinc=
e
> policy->cur still holds the previous value, the governor does not call
> cpufreq_driver->target to update MSR_IA32_PERF_CTL.
>
> Fix this by synchronizing policy->cur with the hardware state when settin=
g
> minimum pstate during CPU offline.
>
> Fixes: bb18008f8086 ("intel_pstate: Set core to min P state during core o=
ffline")
> Cc: stable@vger.kernel.org # 3.15+
> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 1292da53e5fc..11db1c887c80 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2984,10 +2984,12 @@ static int intel_cpufreq_cpu_offline(struct cpufr=
eq_policy *policy)
>          * from getting to lower performance levels, so force the minimum
>          * performance on CPU offline to prevent that from happening.
>          */
> -       if (hwp_active)
> +       if (hwp_active) {
>                 intel_pstate_hwp_offline(cpu);
> -       else
> +       } else {
>                 intel_pstate_set_min_pstate(cpu);
> +               policy->cur =3D cpu->pstate.min_freq;
> +       }
>
>         intel_pstate_exit_perf_limits(policy);
>
> --

Applied as 7.1-rc material, thanks!
