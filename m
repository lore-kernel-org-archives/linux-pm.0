Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979505;
	b=DikMQVcE2ANXmpn+k2k2JIYZHkV8AL9t7er6/X+OlvpxNGl+L5RkDp3HRPpbhnP25nmn
	 Vr6QKDuVLKxb8PVJHdd5EUBRRG/aBZrmnZUxbzvrVabqCCrv+XGdonItDCWPqvQDnI0Ez
	 jG2LATEuKCgPeIKRO2AR3PrS5HdcQYBlkVcCsiea2J6pFHIsZ/GWAiFJr/VyJT9SJ+gla
	 YGBZJUca3yL7+B8B5oIDFyY7ezTVFpu3DGY3vQtfsItRv7m2ykIMIZfeyFeJCIje2OFFU
	 pR154fMBxvJZXyetlarhXxLWm3uwCtsMvoOcf1WU/sfuG6lxLTyBrXXp6VMIOOv7sCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979505;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4EjTD2S7JpTJpW5A1rQO2R6WbhPm1+ncM2qBDJKLH5s=;
	b=huk9+DE9zOy6N4A7h8XaGWh44GEwceBK96LEDTJnhNF1sOtgNpzU4MUKa28FSuBZNiIi
	 /zAizZXuuN5r6koCjZGEzn702bSdxHiWCW/CFvc8tyAf4l3k2l1AKfHLcBPooMX5eePIM
	 O+F3C1790MFmP4r25PUycFsi4QySQVgr0kIurkl6gaXA/2jn6fXVgEb+1Z5XqCvdJTF6i
	 crrbCpE5m5KbNiwq9MCGgL2pU9pNRLTYfbuHjD074HM2pfHg/8ASRAESdH5VAcprjY85J
	 psaobf83JJmkCqNxx54Euc5NgETb5bY+2MQma2PbDi5LYr1nvcghazTnGc6lTdqvwaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmgKfzlO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B82606A329
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmgKfzlO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79BC1F008A1
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979504;
	bh=4EjTD2S7JpTJpW5A1rQO2R6WbhPm1+ncM2qBDJKLH5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JmgKfzlO0EG03289NlvGXU1cxVX+9NltnkN8JVDRNkTVa1plnDRsIYUB3fhRpgzun
	 ljY1/yv75m4Zik9OE5kkVlgsZbCzu8PLG46N+vgJmOc7YBfSHJ1Z/q/FQZCNbgOwQH
	 169NNCZDObYzUj65qc3EavCbGOgmWL0Bb59O8pYxP1PmDr2eZaX++ZMkpjq1UNReD6
	 5ifUETguUtCRYeYm2LlOZtz3tP+peVG6omJOhmEXVzsx6TNSPapliNK53bTvfoUp01
	 +G4pc4pVdr+LFdQY284ntyEOU0ouansTrUb6RlWMOltLQXZD1qesp9vqAdf3KdvBCc
	 PMY1aoh9wMlng==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be47aa555cso651003e87.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:38:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxJ+i94PUE13jkFElA6FUoBTVnltA6pzilftim4j1eGJkGRai1Jif+gcEjcodmjhkuKzbTNhfVEUw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vPJixGPYFNIQCe9mh3+B2A0Tupky3IxJtW5k6Nu4Dg+JMF2mM
	QmRIjEuQOc/zjMLcbCmnpEcsrV1MX0t1juPv1kIrptwwNXW5ETDNpFYYHQUwxDRTwVybOX9jLKb
	PSU0vQb2KhgZKojI/kNhE9kVe1mgh47g=
X-Received: by 2002:a05:6512:2311:b0:5bf:dcd7:8644 with SMTP id
 2adb3069b0e04-5c003c23c13mr1020094e87.53.1793979503321; Fri, 06 Nov 2026
 07:38:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910111329.2220-1-lirongqing@baidu.com> <20260910111329.2220-2-lirongqing@baidu.com>
In-Reply-To: <20260910111329.2220-2-lirongqing@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 16:38:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-0JWRuJ8sizATqSprL-G89oN4Pab=-+X5yditGTRbRg@mail.gmail.com>
X-Gm-Features: AclHuK_3OxEw6ClYZ2fmNlQgRJpKgB6YIN-WxdKt8wFZDqQ7HtIb9QUGs-lOtKg
Message-ID: <CAJZ5v0j-0JWRuJ8sizATqSprL-G89oN4Pab=-+X5yditGTRbRg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in extract_io()
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
> When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
> that are not lower in frequency than the previous one are skipped.
> For each remaining entry, freq_table[].driver_data stores the
> original ACPI P-state index, so the index space of freq_table no
> longer matches perf->states[].
>
> extract_io() currently walks perf->states[] with index i and uses the
> same i to index policy->freq_table[i]. When duplicate frequencies
> exist, this can associate a P-state status with the frequency of a
> different P-state. It can also access an invalid or sentinel entry in
> freq_table when the number of entries in perf->states[] is greater than
> the number of entries remaining in the frequency table.
>
> extract_io() is used on ACPI_ADR_SPACE_SYSTEM_IO platforms by the
> frequency verification path, which is enabled by the
> acpi_pstate_strict module parameter. With the mismatched lookup,
> check_freqs() can fail to match the frequency of the P-state that
> drv_write() has already programmed. It then sleeps through all 100
> iterations - at least ~1 ms of usleep_range() plus 100 cross-CPU
> calls and I/O port reads, all with policy->rwsem held, and
> .target_index() returns -EAGAIN, leaving perf->state at its previous
> value while the hardware is running at the newly requested P-state.
>
> The cpufreq core consequently keeps policy->cur at the old frequency.
> Since __cpufreq_driver_target() returns early when the requested
> frequency equals policy->cur, the driver is not called again for that
> frequency and the control register is not rewritten. The hardware can
> therefore remain at a frequency that differs from the frequency known
> to the cpufreq core.
>
> Fix this by iterating over policy->freq_table and using
> pos->driver_data as the original ACPI P-state index when accessing
> perf->states[], as extract_msr() already does.
>
> Fixes: fe27cb358835 ("[CPUFREQ][2/8] acpi: reorganize code to make MSR su=
pport addition easier")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 10ea603..a797bb2 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -197,14 +197,13 @@ static unsigned extract_io(struct cpufreq_policy *p=
olicy, u32 value)
>  {
>         struct acpi_cpufreq_data *data =3D policy->driver_data;
>         struct acpi_processor_performance *perf;
> -       int i;
> +       struct cpufreq_frequency_table *pos;
>
>         perf =3D to_perf_data(data);
>
> -       for (i =3D 0; i < perf->state_count; i++) {
> -               if (value =3D=3D perf->states[i].status)
> -                       return policy->freq_table[i].frequency;
> -       }
> +       cpufreq_for_each_entry(pos, policy->freq_table)
> +               if (value =3D=3D perf->states[pos->driver_data].status)
> +                       return pos->frequency;
>         return 0;
>  }
>
> --

Applied as 7.4-rc material, thanks!

There are still comments on the other patch in the series that need address=
ing.
