Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C241B352
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164441; cv=none; b=l4VD649T5E+Qbmg6P/nzAiaU/ewtpxP5MRrNnQAeOGGEKrsEie0w1AkmfPf1JCF+V9yUt6uwtce426P3VwWcLC0YQxgB2aRgaOPXDN7mqCliEQep6Y4Shi7auejjrPNbcD/G9vwrVRNByaYZMBI/czgfah3JNADux73s4Oie44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164441; c=relaxed/simple;
	bh=1zPiUVwsOeKtDXPiVPn8kiW5f00zllQR+VUv5azggXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfLfPNBbwHvjz/gU6oZKJCcgJQa08hfIxF2A3hcVCfDulgwYbopFSxqOzro6eTnLNUWLtsPR5hUQ6k+sQutVb252jMHaOFZu09Im+tKiejxNc90D06IV82rJtsSCJ7Hyi8JQdQelaTzzGNRSskT2L3vgWlWmdQ6a8/CrmPYLynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faOysDKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faOysDKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8CB1F00A3D
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164439;
	bh=DX5ydf/ZthU4S0pAcWaJEr/nv6UdGQv1ZEKCA/p12Fs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=faOysDKPB2JrK2v/giPhIAf9atJJCv1HlGa43nsjP09wpDeIN0AXhED9NcKyzMbh1
	 P6+KPfRkZTx6xEA/7gwvU4rgPITtwRaYeqZlGEh3lKU+JecJx8LnrRj7db2jhrf0Os
	 yh9hmJoXGP3StX5r63CHVxL3mNiii/eCldTyvgi1rjMqUoH1o5WPgPT/Cft6l9VLFE
	 TIG86QN09KCHDlAGbE1WlatVzOIVvh4GW9AqG3x5ic9SsG8V2N79c5XjRitAQaTxcX
	 7Q8l/wyefMG7B4V6Xg9m6+L0usISesxl0JDqd/lSxFIIrP/a+WeSD/PD5M4qyN92JG
	 Axa3o6Yx9Y1Yg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so3158404e87.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:00:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp85pUvhnDgzz5CvmIOkE2cVUvl4jcdAddS8TG1q6afTLOrHuotVcyh7f/2Y3ADq1hp6PliB3QcYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1NLjQHZ633iHi5VJYiIAE2IzBlEs2YqNTDNlwEaMq/zeVBgU
	og0irNQM29kko2G9SOrPp5NCXF1uwzKWuy9TAwuIEijfBHZFp0MdnjaQ2WhYw5vHIKzEM1yNjGk
	DI1ktpL50ZqsmFjLJEJ4LURxbEsyRZoQ=
X-Received: by 2002:a05:6512:308b:b0:5b0:1e16:f3a2 with SMTP id
 2adb3069b0e04-5b2c1b7058cmr1629287e87.57.1785164437416; Mon, 27 Jul 2026
 08:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727093553.98246-1-nihaal@cse.iitm.ac.in> <5zxdn4jnqu22k2s7roo3wxykwsusah7mp4telybmzlc5zgilac@pf5svblpx7nj>
 <5265823c-9b69-417f-80cf-5b06b1106b42@oss.qualcomm.com>
In-Reply-To: <5265823c-9b69-417f-80cf-5b06b1106b42@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 27 Jul 2026 17:00:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ijun5UYQs1r+bTK_x6BgTCUbzvdGCxncW9Wc=K400gkw@mail.gmail.com>
X-Gm-Features: AUfX_mww97u56FKwBrMsueK_m3H6aQzi_oA4gkv6GF_EFZ01Lg1YZuB5_VBZH9Q
Message-ID: <CAJZ5v0ijun5UYQs1r+bTK_x6BgTCUbzvdGCxncW9Wc=K400gkw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 12:39=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 7/27/2026 6:20 PM, Viresh Kumar wrote:
> > On 27-07-26, 15:05, Abdun Nihaal wrote:
> >> The memory allocated for data->powernow_table inside
> >> powernow_k8_cpu_init_acpi() or find_psb_table() is not freed in one of
> >> the error paths in powernowk8_cpu_init(). Fix that by adding a kfree()=
.
> >>
> >> Fixes: 1ff6e97f1d99 ("[CPUFREQ] cpumask: avoid playing with cpus_allow=
ed in powernow-k8.c")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> >> ---
> >> Compile tested only. Issue found using static analysis.
> >>
> >>   drivers/cpufreq/powernow-k8.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-=
k8.c
> >> index fe1f499b4fc0..c9bcc6f0ab7b 100644
> >> --- a/drivers/cpufreq/powernow-k8.c
> >> +++ b/drivers/cpufreq/powernow-k8.c
> >> @@ -1085,6 +1085,7 @@ static int powernowk8_cpu_init(struct cpufreq_po=
licy *pol)
> >>
> >>   err_out_exit_acpi:
> >>      powernow_k8_cpu_exit_acpi(data);
> >> +    kfree(data->powernow_table);
> >>
> >>   err_out:
> >>      kfree(data);
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied as 7.2-rc material, thanks!
