Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9123C4F2
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246264; cv=none; b=fXJtwSVKm2ou2vsKAe+LI54Z8+xnGB99UPsjEC1NXWbhSgqNjeFM1A6+OKwwtufVmJbvZ5GOM5w2CksxbQxrbOvQLar52lEHllCyJ1y03/Ymzo0fL5SLgilQztUItLUmZ4HisfwiGk0ii62hNsGkarnbYvQ2PYmlSWrPB2x0/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246264; c=relaxed/simple;
	bh=oi0x0oVi67bSBbWJGllxDkZy9+HUZ2a9Bv8ByoGs5FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axc5oKBnSg5lOCI+41rtxaPnGYZQCvJFnBTVSKocCBUZsaeOFEqsePbefRHv+sHgjDP9Yg63CE3TA4of1yb6vr0aM18GFcNyI7GC71g3hnUG5q8ZIBRyFsH5ngyMhBL6QgsbRwZKagutmqGV8xgheXC0b0Vbal9gNDabFQrBLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tObbUprB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tObbUprB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D87EC2BCB1
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773246264;
	bh=oi0x0oVi67bSBbWJGllxDkZy9+HUZ2a9Bv8ByoGs5FQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tObbUprB0fItV3ndfpkVR/H6zcyn3UOBvmOaT2oYKEXvq5nVs6JFz2gb9l/xjwDge
	 bMle7Ra+oJRFU8Iq1kcZbCC6M2g6unwDP0vXZf9v/Agroctinru6K/omJz2QL6RxVJ
	 RMBiJu+W9Kdgeav+4s5W5Qu5uCKfrQgDoF+yZB3U3VJB7RYSI4Y5is15pkJKsw07kA
	 qPSbBwomkbe4CYsc/axsdVoBbNjT1Of8W+CWRPD+JMZE430prjQrDqGETR4SFWVg3l
	 LPAF66yi/Qcw+iTp/hJ77MM9cQr3kiWiibL92X+yoKtMmg6VnAOmywz1akPVerKAav
	 q2LYlMN6BTVsw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d738fe814cso86195a34.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:24:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbFAGBN2S0lD+52Ou1wI4Nk4GuQ85A1/2fKjBBnFVtkwohU02AWcNvC0x+xsxKDBgMRO9Bn512fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJw3F85opQjO20JoibIJ9Qx13na1jgR+XKsIN/BKNQ/5gNxaqi
	G4PxjNFjVi8LjmzI5BLwzu+oouPd2hjNCMawJ3rN/GTxUYFfF+Qe+PYcLYfayTN83IomFWps+au
	y5eGI6Lv31QE+RkDZqglPMRRHeYvTMTU=
X-Received: by 2002:a05:6820:f031:b0:66e:1928:ca46 with SMTP id
 006d021491bc7-67bc887c11dmr1951944eaf.8.1773246263065; Wed, 11 Mar 2026
 09:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com> <20260225084930.1692228-7-pierre.gondois@arm.com>
In-Reply-To: <20260225084930.1692228-7-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 17:24:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gzVGUWW+qgqSPY2FxJq6F4KLicx=jYriuVrOiekq59XQ@mail.gmail.com>
X-Gm-Features: AaiRm532cwAcO7aM02xdN_e_15cAfdYrGdZIJsFVUc-tPuQ_IVfUbLhLDQRledM
Message-ID: <CAJZ5v0gzVGUWW+qgqSPY2FxJq6F4KLicx=jYriuVrOiekq59XQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 6/6] cpufreq/freq_table: Allow decreasing cpuinfo.max_freq
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:50=E2=80=AFAM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> Drivers not using freq. tables update cpuinfo.max_freq in their
> .set_boost() callback. E.g. amd-pstate, cppc_cpufreq.
> Drivers relying on freq. tables and supporting boost frequencies
> rely on cpufreq_frequency_table_cpuinfo(). cpuinfo.max_freq is
> only updated if the new maximal value is higher than the previous
> one.
>
> Using the scmi-cpufreq driver which relies on freq. tables, enabling
> boost will permanently increases the cpuinfo.max_freq value.
> This patch allows to lower cpuinfo.max_freq.
>
> Note:
> commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
> if max boost is known")
> favored having cpuinfo.max_freq reporting the maximal boosted
> frequency of a CPU instead of the maximal reachable frequency
> due to regressions in the frequency reported by cpuinfo.max
> and scaling_cur_freq.
> As stated above, this is not what most of the other cpufreq driver
> do. I assume that the following patch:
> commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to
> cover boost frequencies")
> was correct, but might not have tagged the boosted frequency with
> the CPUFREQ_BOOST_FREQ flag in the freq. table.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/freq_table.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 9b37f37c36389..bd08cbe9e9ba3 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_pol=
icy *policy)
>         }
>
>         policy->cpuinfo.min_freq =3D min_freq;
> -       /*
> -        * If the driver has set its own cpuinfo.max_freq above max_freq,=
 leave
> -        * it as is.
> -        */
> -       if (policy->cpuinfo.max_freq < max_freq)
> -               policy->cpuinfo.max_freq =3D max_freq;
> +       policy->cpuinfo.max_freq =3D max_freq;
>
>         if (min_freq =3D=3D ~0)
>                 return -EINVAL;
> --

How exactly does this change depend on the previous patches?
