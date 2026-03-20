Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85086399376
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007315; cv=none; b=pEStxtRxsG9vSbtqo9TvGCTb+uZ6QZWjR04CuZMujabn5ELiy7aFFa8RzvQrNRBGhBPcfTsyeVxWEDz/y8LnNZ+etcNMFPnj52obbg/BHYt08WocgR6aIVUpnAg/J487avyuqX/L6P2XH55tJoFazSeadZsthL4U23ubu/lRDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007315; c=relaxed/simple;
	bh=iZgLe1mru6PFQ6REOTI84wZhvlQ5dixZom1oioQNTDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUYnaP03/RHvyTr+sJYjHGvNK+3DH4fqxn0/4sqPa+gMXdSo2RyRWriLQcWe60CLTla5JfNO7bxzXzX4sNso5qqYW81YC900msaHILK2YlbFUeIzdY3pplNTT13/Q6D2u3Z5aU5u/O1S1FVFP+70aN0yfh3phdB9157s4749st0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkwa3nhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkwa3nhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F3C2BCAF
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774007315;
	bh=iZgLe1mru6PFQ6REOTI84wZhvlQ5dixZom1oioQNTDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dkwa3nhVU4fLGuE79JTQaIogJajcQs7sjZ1uknR6hLzjlk66BkFmcwyhbKAt4JC7n
	 V3NllKvY6q5w+174PjiK9ZzP869ZXcpIrkwFlsHquMTOHSLNHcwx2lBxa7RYwT3Cfc
	 5QbBITJOZU8TdXk71tD3AT4a79OkuJD4O+m7W1510rCdbzot+PMqeWK67obeVdEmYw
	 3eA2OYjPfFtNHfzUnOLndDuoau8yX0ZrVQ/QiDs4m4VBIUgjSs7c3vSXPyPbIgA2Sg
	 CcTHsE+erycYmx+wf/yZ3EdBg8aDW610EQGC3WeR0hYuw5pyPh08ryu9VOYdi2r5Bd
	 Szja4LfwXmXQw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7e5e8c907so854838a34.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 04:48:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHg9p7xBKD6jA1uE1RO/btGvTIFz8IQiKaqUdGRX56ogNfJESsjYLR06hfUAliM93GGnCRmAf7FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqK4dVQK4ZzJYSHtfzvVyDFocJ7cjbU8PGYPgyIuhPbP9GKXta
	PWRqdifcq4JJcSkX+z92gLIq6zQ71qHOLhZAikQw5p2InRaqW/T/86NFvr80zBq8YrMjBhvdZ77
	nuM7Hdy1NW1UfPKCtx72RXVT/3xOMYGM=
X-Received: by 2002:a05:6830:7301:b0:7d7:d66c:a445 with SMTP id
 46e09a7af769-7d7eaffe25dmr1691679a34.31.1774007314282; Fri, 20 Mar 2026
 04:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65ba5c45749267c82e8a87af3dc788b37a0b3f48.1773998611.git.viresh.kumar@linaro.org>
In-Reply-To: <65ba5c45749267c82e8a87af3dc788b37a0b3f48.1773998611.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 12:48:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j7qbPz1eVu1MANwwS0JjPZYtq7oiZAmXAja9NzsgqGPw@mail.gmail.com>
X-Gm-Features: AaiRm53kb54e5YWKGvBBOGd1Spv4wexjnlh4X6UrvtuNs_bvJcdBUm1atczSgXs
Message-ID: <CAJZ5v0j7qbPz1eVu1MANwwS0JjPZYtq7oiZAmXAja9NzsgqGPw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Don't skip cpufreq_frequency_table_cpuinfo()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zihuan Zhang <zhangzihuan@kylinos.cn>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Pierre Gondois <pierre.gondois@arm.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 10:24=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> The commit 6db0f533d320 ("cpufreq: preserve freq_table_sorted across
> suspend/hibernate") unintentionally made a change where
> cpufreq_frequency_table_cpuinfo() isn't getting called anymore for old
> policies getting re-initialized.
>
> This leads to potentially invalid values of policy->max and
> policy->cpuinfo_max_freq.
>
> Fix the issue by reverting the original commit and adding the condition
> for just the sorting function.
>
> Fixes: 6db0f533d320 ("cpufreq: preserve freq_table_sorted across suspend/=
hibernate")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c    | 9 +++------
>  drivers/cpufreq/freq_table.c | 4 ++++
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 277884d91913..1f794524a1d9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1427,12 +1427,9 @@ static int cpufreq_policy_online(struct cpufreq_po=
licy *policy,
>                  * If there is a problem with its frequency table, take i=
t
>                  * offline and drop it.
>                  */
> -               if (policy->freq_table_sorted !=3D CPUFREQ_TABLE_SORTED_A=
SCENDING &&
> -                   policy->freq_table_sorted !=3D CPUFREQ_TABLE_SORTED_D=
ESCENDING) {
> -                       ret =3D cpufreq_table_validate_and_sort(policy);
> -                       if (ret)
> -                               goto out_offline_policy;
> -               }
> +               ret =3D cpufreq_table_validate_and_sort(policy);
> +               if (ret)
> +                       goto out_offline_policy;
>
>                 /* related_cpus should at least include policy->cpus. */
>                 cpumask_copy(policy->related_cpus, policy->cpus);
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 7f251daf03ce..5b364d8da4f9 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -360,6 +360,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_p=
olicy *policy)
>         if (policy_has_boost_freq(policy))
>                 policy->boost_supported =3D true;
>
> +       if (policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_SORTED_ASCENDI=
NG ||
> +           policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_SORTED_DESCEND=
ING)
> +               return 0;
> +
>         return set_freq_table_sorted(policy);
>  }
>
> --

Applied as 7.0-rc material, thanks!
