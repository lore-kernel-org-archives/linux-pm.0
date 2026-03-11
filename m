Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCF3E1CEE
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245996; cv=none; b=p9i5mdWI0KkXVuv0gFFnts1A7ZHdXaIB4hqPAW5SVYcfzA+/yxEVZm8JR2WolihbIu5Q28ByecdnG59sryf0rSLTKu5XohSgK0bmLCQJKhdv/9BzoEeaN0LOHm8bbUgaQCPYpvAQP+Ep6/pA0tvcSYVy01vVHjv/Hrh18vf8OSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245996; c=relaxed/simple;
	bh=zD7LiPrHT4JIEdBKfbZlWjZKv3fq782YZbS864FS50s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSDL5QhTSIwscj+jUiiDeMT/hPeYMv7+1K8xIV5QIDBea80oNw9P5HFfKcOKWgJgESiN789d2tVRHH1EQfDZheTBrv0A1S9tIEqWFWya8vpolwfnPZ2ryVpH8DOPid7ktzi4MDjNEXRzWk5fcjr3Cmi3DFL6G8eVhZYbxRuNLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7M0wWbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7M0wWbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E0C2BCB1
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773245995;
	bh=zD7LiPrHT4JIEdBKfbZlWjZKv3fq782YZbS864FS50s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s7M0wWbviXuqI4zMVQINtw/5P0raeYG1i95lQW7pmvR/QnpC7NcmTgI0vi+Dhq8eG
	 zBXRWn1+v90AtdLFoNAZY0BpeDoWvwTUENeyXZiO1OWkn0lGh1MUeBtVVxhaKSfk9j
	 MUzDMKeVWryXxU0/Df3whYkicW9r+H2r32GYgosYQ9YWr5OGd7mjTk5aXxloWGhg/A
	 l3HuyzWAwxyC3EY0ohngk3RQglSXbCokTjPZXoH+OmTCZ/Wlsp4POj1baOhbYUeVjp
	 MAs6Njevlvp1lwnJbbI2hbsAanYbosH9UYY1FsOPqh8QKCNNLu8UCA65x7HnOfiVNm
	 TR8Q8yhRkW+CQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4645dde00a7so1057119b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:19:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHvewcAX8X7uRR0laV3AscUSIdK/M8iGOj0ylI1Si+CaBExkiWHIGmbZy0yTch9eU4Dvo48b05xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7IyDFmp9P4B/dYIj6kTmWPPX7ItcfH6Nx5tMgrLC9vTb5XxM/
	SawIoQPWPJv7pKwos5R0LuixIIYktsPTqgpovP46jYKoCoJAslj9Nicg2L6ku8RSLpgrXni3Qs5
	8tktSYIzm83376B96PdmutjqnYYswGOg=
X-Received: by 2002:a05:6808:4f5e:b0:467:6b8:ddbb with SMTP id
 5614622812f47-46743206a0emr96999b6e.17.1773245994859; Wed, 11 Mar 2026
 09:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com> <20260225084930.1692228-5-pierre.gondois@arm.com>
In-Reply-To: <20260225084930.1692228-5-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 17:19:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jMsphO=tcHWMeJXE74Xk4HZyCqyMDRU2XZ+HrfxoVZbw@mail.gmail.com>
X-Gm-Features: AaiRm51pgqx278DixvIydF5vGyJxyWJUe-5O9iEKS9YrBt975WtV0e21PO1XDPg
Message-ID: <CAJZ5v0jMsphO=tcHWMeJXE74Xk4HZyCqyMDRU2XZ+HrfxoVZbw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] cpufreq: Update .set_boost() callbacks to rely on boost_freq_req
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
> In the existing .set_boost() callbacks:
> - Don't update policy->max as this is done through the qos notifier
>   cpufreq_notifier_max() which calls cpufreq_set_policy().
> - Remove freq_qos_update_request() calls as the qos request is now
>   done in policy_set_boost() and updates the new boost_freq_req
>
> Note:
> cpufreq_frequency_table_cpuinfo() is also called through:
> cpufreq_policy_online()
> \-cpufreq_table_validate_and_sort()
>   \-cpufreq_frequency_table_cpuinfo()
> which relies on cpufreq_frequency_table_cpuinfo() to set
> policy->min and max initizalization at driver init. This
> regression is solved in the next patch.
>
> Note2:
> acpi-cpufreq.c seems to be the only cpufreq driver not
> setting cpuinfo.max_freq. Populate it the nominal frequency at
> driver init.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |  1 +
>  drivers/cpufreq/amd-pstate.c   |  2 --
>  drivers/cpufreq/cppc_cpufreq.c | 10 ++--------
>  drivers/cpufreq/cpufreq.c      | 16 +++++++---------
>  drivers/cpufreq/freq_table.c   |  7 +++----
>  5 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index e73a66785d69d..6a6e26e1be14a 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -857,6 +857,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>                  * governor from selecting inadequate CPU frequencies.
>                  */
>                 arch_set_max_freq_ratio(true);
> +               policy->cpuinfo.max_freq =3D nominal_freq;
>         }
>
>         policy->freq_table =3D freq_table;

This looks like a fix for acpi_cpufreq that should be sent separately.

> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c45bc98721d24..310d5938cbdf6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq=
_policy *policy, bool on)
>         else if (policy->cpuinfo.max_freq > nominal_freq)
>                 policy->cpuinfo.max_freq =3D nominal_freq;
>
> -       policy->max =3D policy->cpuinfo.max_freq;
> -
>         if (cppc_state =3D=3D AMD_PSTATE_PASSIVE) {
>                 ret =3D freq_qos_update_request(&cpudata->req[1], policy-=
>cpuinfo.max_freq);
>                 if (ret < 0)
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 9eac77c4f2944..4c46c7ea318eb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_po=
licy *policy, int state)
>  {
>         struct cppc_cpudata *cpu_data =3D policy->driver_data;
>         struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> -       int ret;
>
>         if (state)
> -               policy->max =3D cppc_perf_to_khz(caps, caps->highest_perf=
);
> +               policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, caps-=
>highest_perf);
>         else
> -               policy->max =3D cppc_perf_to_khz(caps, caps->nominal_perf=
);
> -       policy->cpuinfo.max_freq =3D policy->max;
> -
> -       ret =3D freq_qos_update_request(policy->max_freq_req, policy->max=
);
> -       if (ret < 0)
> -               return ret;
> +               policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, caps-=
>nominal_perf);
>
>         return 0;
>  }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 42de32488f422..20266fb42d18d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1500,10 +1500,14 @@ static int cpufreq_policy_online(struct cpufreq_p=
olicy *policy,
>                                 goto out_destroy_policy;
>                         }
>
> +                       /*
> +                        * If boost is supported,
> +                        * init the constraint with cpuinfo.max_freq.
> +                        */
>                         ret =3D freq_qos_add_request(&policy->constraints=
,
>                                                    policy->boost_freq_req=
,
>                                                    FREQ_QOS_MAX,
> -                                                  FREQ_QOS_MAX_DEFAULT_V=
ALUE);
> +                                                  policy->cpuinfo.max_fr=
eq);
>                         if (ret < 0) {
>                                 /*
>                                  * So we don't call freq_qos_remove_reque=
st() for an

Why do you need to update stuff introduced in the previous patch?

Is that because policy->cpuinfo.max_freq is not set consistently
before the changes made here?  In which case, wouldn't it be better to
make all drivers set cpuinfo.max_freq consistently before making the
changes in the second patch and fold the chunk above into the latter?

> @@ -2818,16 +2822,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *p=
olicy, int state)
>                 return -ENXIO;
>
>         ret =3D cpufreq_frequency_table_cpuinfo(policy);
> -       if (ret) {
> +       if (ret)
>                 pr_err("%s: Policy frequency update failed\n", __func__);
> -               return ret;
> -       }
>
> -       ret =3D freq_qos_update_request(policy->max_freq_req, policy->max=
);
> -       if (ret < 0)
> -               return ret;
> -
> -       return 0;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);

This also looks like it belongs to the second patch in the series.

> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 7f251daf03ce3..9b37f37c36389 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
licy *policy)
>                         max_freq =3D freq;
>         }
>
> -       policy->min =3D policy->cpuinfo.min_freq =3D min_freq;
> -       policy->max =3D max_freq;
> +       policy->cpuinfo.min_freq =3D min_freq;
>         /*
>          * If the driver has set its own cpuinfo.max_freq above max_freq,=
 leave
>          * it as is.
>          */
>         if (policy->cpuinfo.max_freq < max_freq)
> -               policy->max =3D policy->cpuinfo.max_freq =3D max_freq;
> +               policy->cpuinfo.max_freq =3D max_freq;
>
> -       if (policy->min =3D=3D ~0)
> +       if (min_freq =3D=3D ~0)
>                 return -EINVAL;
>         else
>                 return 0;
> --
