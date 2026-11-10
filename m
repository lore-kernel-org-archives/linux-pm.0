Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322695;
	b=ZGP+jZVzyfcVeUBCIgHEdcuKfbx3F3ytMW3nwwpKIeUx6tP9enxLPp8ram34GgjPtocg
	 Bha2gli5WdkMI6XmNY59Rep/bkU5z9yCztDXokgDNzOU4+/LL/AhOznpuqm6uYKJBlkni
	 6LC1NUDcuJYVY00ynHfbIf9jm5n08S6UB7AmRuSsvllN8s4fKI68xUZadzMOs5BWpwMqi
	 pbaUucPdbS7Im8crfrFXsCCngKsStpYeafxHKRmpkNrcNLVvCmOzO0Z5fsqtlq5oCJG3I
	 roqkXWD9qYfgYZZ4W5LoNwenLYnB/+9Ej7+Mffti6ErhW5UyXn1B9nJ4nydv35Qk1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322695;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WnkJ8LXf/bgZJNIPyQGBBjaA78zgoKgnkLMT97HZ4hM=;
	b=KzDvoIr4fu7XbtdJc28i+bK8wis/2BNivTCB7I3HMfLimyJV2GqUBflL4YADQAGZJLL+
	 AZSzjgR+LciwBan+6fH30nytWwLfsBH3CEuda50jzZYteILn2fKLLmVeIBxzpKkTMCVnD
	 qv60bnNIoEWcFMGb/nQ2ZKjZFRSa5pXcyKB0ZA/Ash2EHfKAfs2FF8zm6RegA0S9zj4V2
	 oSxw16D9T6OjJibz+vsKhz9hqxQV6Yn/qtsawvoUQO5oM36qIVVVapI3QChJslIWwNajA
	 AW0uxuONoDBTt3KkaE0rta1aUpLekRv+iYnuBDphGSb2lJBWWvlEBixtFBZgn9DgWEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvPtbBbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA1606A32A
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvPtbBbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA4A1F008A7
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322694;
	bh=WnkJ8LXf/bgZJNIPyQGBBjaA78zgoKgnkLMT97HZ4hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EvPtbBbpY0MjDrJNm/qEfHVLVqDPeNiRukmRUFa4wWsRoo6sCSQw+dMYY0H3/TdIo
	 5rGBDNsi9o8CXMflRBCr3XSY0eF6h4mL4dZFLwCe5xGnvbOpH/4YndZsn5IZLaOa/v
	 iSkQ6Pr18uxngCNjGJnx8fe5XPUSAgFwzndWaN99yG0r66WVa89QAHjROZqlQzesFL
	 r9DBjPRvtBZwST8/tzlm/7BHBGo04X2tKXGG+JlIRHGIigH/76hZVR4S8c5eLr/mn8
	 cb7I1uW2JG21uHuTSx4xq5fmw1kzmKwZfpeEni0vRhWxHbjyov7ZyTXy3mat1NnXKT
	 ymgwxGi3mFHHA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab3dd966e1so17302641fa.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 06:58:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEYqRvyFVLbi1KC6Zwcg7kKvfAEZ6n2Jy/3kdCYB4RNhGVY6RCBbGXayqCP4JgpeZNk0A+lpbbuPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+aEusJESXqZ+bjgvKeXihYajqFxSpfU0RWlMRF8sYRngZhyXA/
	AoXgScduYZSCKla0rRjYITFk9QkUe8Y2dnUiQ18NgRc2PNUADrXBNchHNspGvgEqiFzo0FJzVbt
	wtLb2eT5ujtxkZ5wTJzgBpPqqVrgK5dw=
X-Received: by 2002:a2e:a9a5:0:b0:3ab:4f5e:3edc with SMTP id
 38308e7fff4ca-3ae09632513mr5987871fa.15.1794322692389; Tue, 10 Nov 2026
 06:58:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110101246.3665797-1-sumitg@nvidia.com> <09209b48-a469-4bd9-8d43-845f709353ca@arm.com>
In-Reply-To: <09209b48-a469-4bd9-8d43-845f709353ca@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 15:58:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgUnFO5FsDU64bE9ArzTQaGcU=2ocRJ2QpsJb_octG8w@mail.gmail.com>
X-Gm-Features: AclHuK8X5hMi8jD3gHPYYnsPSCyrp4PzOzFf8JJiGs5yNkckX-k7Tw8xtv2KRhU
Message-ID: <CAJZ5v0jgUnFO5FsDU64bE9ArzTQaGcU=2ocRJ2QpsJb_octG8w@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
To: Christian Loehle <christian.loehle@arm.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	jbenc@redhat.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:58=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/10/26 10:12, Sumit Gupta wrote:
> > As per ACPI 6.x s8.4.6.1.4 (CPPC Enable Register):
> >   "If supported by the platform, OSPM writes a one to this register
> >    to enable CPPC on this processor. If not implemented, OSPM assumes
> >    the platform always has CPPC enabled."
> >
> > The driver never writes this register. CPPC therefore stays disabled
> > on platforms such as NVIDIA GB10 that wait for OSPM to enable it.
> >
> > Call cppc_set_enable() in cppc_cpufreq_cpu_init(). Fail init if
> > enabling CPPC fails. If init fails after CPPC is enabled, disable it
> > again. The register is optional, so -EOPNOTSUPP is not an error.
> >
> > This relies on commit ab482f1bac6b ("ACPI: CPPC: Refactor register
> > value get and set ABIs") from v6.16. Before it, cppc_set_enable()
> > returned -EFAULT instead of -EOPNOTSUPP when the Enable register is
> > not implemented. On an older kernel this change would make init fail
> > on every platform without the register, so the stable range starts
> > at v6.16.
> >
> > Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CP=
PC")
> > Cc: stable@vger.kernel.org # v6.16+
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Applied as 7.4-rc material, thanks!

> > ---
> > v1 -> v2:
> > - Fail init if enabling CPPC fails and disable CPPC again if init
> >   fails after enabling it (Christian).
> > - Move enable after the policy->shared_type check, so cppc_set_perf()
> >   is the only failure after it.
> > - Mention NVIDIA GB10 in the commit message (Christian).
> >
> > v1: https://lore.kernel.org/lkml/20261105123244.3132560-1-sumitg@nvidia=
.com/
> >
> >  drivers/cpufreq/cppc_cpufreq.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpuf=
req.c
> > index 957fa7775260..b2af24ae5008 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -714,7 +714,17 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
> >               pr_debug("Unsupported CPU co-ord type: %d\n",
> >                        policy->shared_type);
> >               ret =3D -EFAULT;
> > -             goto out;
> > +             goto out_put;
> > +     }
> > +
> > +     /*
> > +      * Enable CPPC. The Enable register is optional - some platforms
> > +      * may not support it.
> > +      */
> > +     ret =3D cppc_set_enable(cpu, true);
> > +     if (ret && ret !=3D -EOPNOTSUPP) {
> > +             pr_err("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret=
);
> > +             goto out_put;
> >       }
> >
> >       policy->fast_switch_possible =3D cppc_allow_fast_switch(policy->c=
pus);
> > @@ -742,6 +752,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
> >       return 0;
> >
> >  out:
> > +     cppc_set_enable(cpu, false);
> > +out_put:
> >       cppc_cpufreq_put_cpu_data(policy);
> >       return ret;
> >  }
>
