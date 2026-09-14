Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A225385D68
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410304; cv=none; b=ZQWGMyYHN1MlTsCSjVFkWWltcb1XUcsHgVK+X31z3yzTRFey6qIC/KnIrmlhXUxkN1VyoptdV4M+tcrnPwuHb5EB9D6N2C5c9ZUjBEpW0o4xRBv8Ku9g2fsRWZXXIMbFVTDPonin8M4eU2F4GUYmmFHV0R2lx0+LhqXmmo8lpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410304; c=relaxed/simple;
	bh=E7HvEMEH3x9f0jAa3bC0loHO1RMGNOPokzzj9zsJJJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsVlUjM5rqtjeAQNGdyrAMS7WrlKF20QpqOYwMQRiNCvBWqMZaxeOciCb1RgS6KdpUJrAczwhyVMiJrqrAL4G6/EZNe1wL6uD9FK8UQhL7uTRhuSBikkxnu+99Sx60pn3Hxvo5+AvR/dwnoIuubQdVd5RId5eD1k784cRSIq4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2hYOyCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2hYOyCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9921F00893
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410302;
	bh=VkPKODouaWQz277H6RYko4h8DGXFuHfYweq4HcITfeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I2hYOyCBl2pSXtgz11KfgeXNh8uATx3DiNNlT9BP7M06XdgWcl+YmXR0zPABP4ZGq
	 yu8+huIlvDKirnz8D18T1+xlmHL9DU6QGB7PrZ9a/cQBTXVU6QGau0dQ10kwnpzzD7
	 YYuj4ugVcwV5gfVvuLh6COLMdcjJVwSM+9XWl/USSVn/ue5o1LvePIi5hPVC2O1brK
	 uWF4fzxp3//GxluiJNXyY1n5DpMpomuW/JD+C1Dg2B6D1Ji1BzipnXmXpI1bB7hChY
	 EbbAowg7X9euZhTEjqQOOP/Lk7D940i166U0Pel76/zdr5/c+oL+RKHAevA9/JcswM
	 xcmS7mBhQ17Wg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d00bbb1bso4117421fa.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:25:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy636EUUzojO9+CP1Thx6bZA2m4dr6i+oFjS8EZEAMTlpdJBGwCh+Gxnci5bJ35TlX+h1adNTwXtQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nCYjF2E9H4qKs7AL1bE9edO7K8NAnv9MsEJyaYVKM1H51ry8Td
	OaD7McmR8NiMrb+a+MpP1PwmnsTfYmg2mAAkOFFj8sA27UodKONcFEtVzXdm4H63wYO3v2ywQuA
	0DfFyImkVxqME5G32fQ1hQl2g/hzIbFM=
X-Received: by 2002:a05:651c:1986:b0:3a5:af50:bc99 with SMTP id
 38308e7fff4ca-3a5c89b02bcmr10886751fa.13.1789410301161; Mon, 14 Sep 2026
 11:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910111329.2220-1-lirongqing@baidu.com> <20260910111329.2220-3-lirongqing@baidu.com>
In-Reply-To: <20260910111329.2220-3-lirongqing@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 14 Sep 2026 20:23:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPPmrTtLRG23UYJ_ibn7VUceuN2qFXpjCsBYnBzDMzYA@mail.gmail.com>
X-Gm-Features: AcwNN1XrpECCpH-qeMvLzTLEkaV7aS72AoP0mk-c4jR0zH9fPAyVKLDsSnm7T6c
Message-ID: <CAJZ5v0iPPmrTtLRG23UYJ_ibn7VUceuN2qFXpjCsBYnBzDMzYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in get_cur_freq_on_cpu()
To: lirongqing <lirongqing@baidu.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 1:13=E2=80=AFPM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> get_cur_freq_on_cpu() uses perf->state, which is an index into
> perf->states[], to index policy->freq_table[]. However, freq_table[]
> is built by filtering _PSS entries that are not lower in frequency
> than the previous one, so its index space no longer matches
> perf->states[]. The original P-state index for each remaining
> freq_table entry is stored in driver_data.
>
> Once an entry has been skipped, using perf->state as an index into
> freq_table[] can therefore select the frequency of a different
> P-state.
>
> The reported current frequency itself remains correct because it is
> obtained from extract_freq(). The mismatch only affects the cached
> frequency used by get_cur_freq_on_cpu() to detect a firmware frequency
> change behind our back.
>
> If the wrong table entry contains a frequency different from the one
> the CPU is actually running at, the check falsely detects a frequency
> change and sets data->resume. The next ->target() call then performs a
> redundant control-register write even if the requested P-state is
> already the current P-state.
>
> Conversely, if the wrong table entry happens to contain the frequency
> to which firmware has changed the CPU, the frequency change is missed
> and data->resume remains clear. A subsequent ->target() call for the
> P-state that the cpufreq core believes to be current can then
> short-circuit without rewriting the control register, leaving the CPU
> at the firmware-selected frequency until a different P-state is
> requested.
>
> Fix this by taking the cached frequency directly from
> perf->states[perf->state].core_frequency. perf->state and
> perf->states[] use the same P-state index space, and converting
> core_frequency to kHz yields the same value stored in the corresponding
> freq_table entry during initialization.

Sashiko has comments on this patch and it has a point IMV:

https://sashiko.dev/#/patchset/20260910111329.2220-1-lirongqing%40baidu.com

Can you please tell me what you think?

> Fixes: e56a727b023d ("[CPUFREQ] Make acpi-cpufreq more robust against BIO=
S freq changes behind our back.")
> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index a797bb2..3313c74 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -353,6 +353,7 @@ static u32 get_cur_val(const struct cpumask *mask, st=
ruct acpi_cpufreq_data *dat
>
>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  {
> +       struct acpi_processor_performance *perf;
>         struct acpi_cpufreq_data *data;
>         struct cpufreq_policy *policy;
>         unsigned int freq;
> @@ -368,7 +369,9 @@ static unsigned int get_cur_freq_on_cpu(unsigned int =
cpu)
>         if (unlikely(!data || !policy->freq_table))
>                 return 0;
>
> -       cached_freq =3D policy->freq_table[to_perf_data(data)->state].fre=
quency;
> +       perf =3D to_perf_data(data);
> +       cached_freq =3D perf->states[perf->state].core_frequency * 1000;
> +
>         freq =3D extract_freq(policy, get_cur_val(cpumask_of(cpu), data))=
;
>         if (freq !=3D cached_freq) {
>                 /*
> --
> 2.9.4
>
