Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4530E0F8
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768210; cv=none; b=D1MizndJb+a/vMp6aASE2Q8kGFTPPANtcyRAGHZiGyPSIsF7RHb2Pd6CIwvSS/DByikaQPMFxANK67IEkdjPj95QCsIk5yhg0AzlaXwlMIdavwAg2eX9oyYSKcqPtLwaTAZ6mvaWM6XHSkaVxxfk2BRohyaJM2LWQRgENhNRYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768210; c=relaxed/simple;
	bh=zekRMg+ng6kzfflvhAFBJ364jCZ+hXWwx4Vtxh5YMDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7s6pkvXZM+lqL0BCJHAmWGLB/lDlXwKxbsX9XO0QWFjOeR4u9HpGlUO97Xo9++X5TFeiixE6XbwQ8gpcx/xCT/3jyLL+yB0HpFDIkR3P+wrLbCuozOsinAjsDu4YhX25XkcoI1KBsNMI88mw88JB5LJF4xRvJtBNIO3C2PEVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0gA6ssZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0gA6ssZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F51F00ACA
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768209;
	bh=M2BKTQbdXhDy2x3jUZiflocmL9cQ7+v33o1BTcpcnJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R0gA6ssZwdVZJcrF/oDh6qIdv1L0/LG0pQTXtxbVq+QNqYInizq0OOMDuqKU/2TOu
	 wrMjuSGJC2hcnIN7Aee6ILRAi+wGWbpCq/czicTq9I42FV6F/2lmJ84ATdglfAPmF8
	 2cTayPIUIh3TXTzkbhoHaj2ywCobScPScpAw5EnFPHfwZRrLvhXlyjkdzHlIEbr8iN
	 XXHqUjPUVupQJHbDVO5j3kRoVMCFgR8YLL906n3kfjMiK7d6+GWXuT7tzqSROPcZVC
	 vQY93zKmArBIOWQA3Hd/Ejdq23cXeo9amjP1arHEVmKx6L4eGaNtmnjotYxzQ1cnyH
	 t2SbaG/mOHzpQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso3919265e87.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 07:43:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoA0VvCDv3KORSkA64rHjC0MwRbrERJWyGQL4aLTocJB3g7NrGPbceaPavgcpWJIIVxQHTfxonZuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6jjWa4E1uy7q1HvzMfvro7LhX8Kmbz2haJMavodNvP/mTVem
	in9sl9eY9Pbfe4rtJSaL2aDbBxo7R2hn/8H3bTL6Xx7B/u3Ke/DCMLnYcWOxsxRAGt2yXfnVegX
	V1MYwrMRz+xS4r+a0LwmxT+IoEJ1/LwQ=
X-Received: by 2002:a05:6512:ba0:b0:5b0:11cc:2279 with SMTP id
 2adb3069b0e04-5b2e4f11a1amr1753458e87.1.1785768207827; Mon, 03 Aug 2026
 07:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <cover.1785749175.git.christian.loehle@arm.com> <7bebbf542419fb8d786ba1fcd195c668c22c1e64.1785749175.git.christian.loehle@arm.com>
In-Reply-To: <7bebbf542419fb8d786ba1fcd195c668c22c1e64.1785749175.git.christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 3 Aug 2026 16:43:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hiqqHr13GEdTVk3E7KypNe1JEfwCZxMfPrRueOL5hEHg@mail.gmail.com>
X-Gm-Features: AUfX_mxb_3uZeUEAs0obAD1Y5bqW4B6rnjlVdao8nSP1PnQ8B6zzwAyIaYO2MbI
Message-ID: <CAJZ5v0hiqqHr13GEdTVk3E7KypNe1JEfwCZxMfPrRueOL5hEHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:03=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> ACPI 6.6 changed the Optional Attribute of Desired Performance from
> Read/Write to Write. cppc_get_perf() nevertheless reads the register when
> initializing performance controls, even though cppc-cpufreq overwrites th=
e
> value before using it.

IMV it would be better to say that the change from R/W to W happened
between _CPC rev 3 (in ACPI 6.5) and _CPC rev 4 (in ACPI 6.6).

It would also be better to refer to the _CPC revision in the paragraph belo=
w.

> Use the readability check from cppc_get_desired_perf() and leave
> desired_perf zero instead of reading it on ACPI 6.6 or later. Also exclud=
e
> the register from PCC read-command detection so it cannot trigger an
> otherwise unnecessary read command.
>
> Fixes: 658fa7b1c47a ("ACPI: CPPC: Add cppc_get_perf() API to read perform=
ance controls")
> Cc: stable@vger.kernel.org
> Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6e5381f8de38..210988d57b71 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1843,6 +1843,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
>         u64 desired_perf =3D 0, min =3D 0, max =3D 0, energy_perf =3D 0, =
auto_sel =3D 0;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cppc_pcc_data *pcc_ss_data =3D NULL;
> +       bool read_desired_perf =3D cppc_desired_perf_readable();
>         int ret =3D 0, regs_in_pcc =3D 0;
>
>         if (!cpc_desc) {
> @@ -1862,7 +1863,8 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
>         auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>
>         /* Are any of the regs PCC ?*/
> -       if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
> +       if ((read_desired_perf && CPC_IN_PCC(desired_perf_reg)) ||
> +           CPC_IN_PCC(min_perf_reg) ||
>             CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>             CPC_IN_PCC(auto_sel_reg)) {
>                 if (pcc_ss_id < 0) {
> @@ -1894,7 +1896,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
>         }
>         perf_ctrls->min_perf =3D min;
>
> -       if (CPC_SUPPORTED(desired_perf_reg)) {
> +       if (read_desired_perf && CPC_SUPPORTED(desired_perf_reg)) {
>                 ret =3D cpc_read(cpu, desired_perf_reg, &desired_perf);
>                 if (ret)
>                         goto out_err;
> --
> 2.34.1
>
