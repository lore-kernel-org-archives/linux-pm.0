Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB400449EB1
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051768; cv=none; b=EoVmzdQu8bMFK/vE4l2z6ofW/z7LO3YK+h3DWzNuTBIu1lSFPAPXNfYodw+luCmsIT5D4ug+lrxplH+vHRncVo7ByB6Ytb+lD62xhuv/7O29KRmG213Lv5CYNtjYJWTbD1CcMN3y/DPIFJvcbmKLYQ78AI3mcihCuGHDq6sLzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051768; c=relaxed/simple;
	bh=v3sEGXTmIUXn5NquOmj378H/4qazuJUJ0JHIHykFzsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9IbxwanhMVH2SoNpO/fTr37EeYXRFPQV1dqVv2eM0yiB6+vsInJSkF+LowpMdYpnrnCBzolUfJf3+GpK/kVqeNt+3yDMjW0lyJ1H+HTxWUzQFHG2RgLtxVCp+rDkw9wi5ynm6D4ANd7Z868jZv/IRbBsoaHZBMWZpJe8hQvlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXdrH1Ah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXdrH1Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9E6C116C6
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775051768;
	bh=v3sEGXTmIUXn5NquOmj378H/4qazuJUJ0JHIHykFzsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AXdrH1Ah9EX4k9bdaxVIwYmE2on2UQ7czRLAdXidaYSFIolHYC2UWn/Ir7aNPjrHP
	 GCx9lgvK+jrtttdRyfJUQKK8FsWaO29uQkieBASFx4c9UUojDdt1vBhaKrvcovcalO
	 O3W4mZ4fKFaj0cNLDx09MwAKo+D8cBd3NBlMiAXd1XlW0RgLrwCx4OFYpcHitOa7Az
	 IDGV1UWbJvMBchPL4wDudyO+NnfOVTlQ2np5fFKByucInkqenf5PE8nTEpitw3i/A6
	 DFUSyEs/y081/dfvQ9y6IXQByR/P2g4XKcr+sbR2YgHDXlGZxVPqRuXDdvn4bD+AVO
	 bL3ftpz3uWE7w==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so2879194fac.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 06:56:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKYywjvtCbze05jhR4CCjKVdC8JDOQ+lQYFtx5VoTpnkOsKqLHzxzYB1R1We/n6wGlHHB7Alyzwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18R01z0RJhxcY/rRRt8hdmSGjOIhflcF+xKSynt5VKgy8mF0g
	cyOblbmIbZqw/inA8Bb5zLpKR5kBoG3KsNs8nA22le5kGR6YFr7BDEwCuQNlXJSUjZg0N0NLFrk
	hX/lTLC/2S7GcMLEVzpuMrtDepy8uw2M=
X-Received: by 2002:a05:6870:970c:b0:3f1:664f:e8db with SMTP id
 586e51a60fabf-422cfeb9060mr2207480fac.23.1775051767674; Wed, 01 Apr 2026
 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
In-Reply-To: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 15:55:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXHFDKZejtPH2T3Yo1FrJe9+5bNgnP1nMmdMLBKJ8oXg@mail.gmail.com>
X-Gm-Features: AQROBzD4sO0R3wVxbBXW0gXfxo02wy_mujNeuwbyrBAr6ZUyoZVxg6EOBGMuFnw
Message-ID: <CAJZ5v0hXHFDKZejtPH2T3Yo1FrJe9+5bNgnP1nMmdMLBKJ8oXg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Allocate QoS freq_req objects with policy
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pierre Gondois <pierre.gondois@arm.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 7:04=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> A recent change exposed a bug in the error path: if
> freq_qos_add_request(boost_freq_req) fails, min_freq_req may remain a
> valid pointer even though it was never successfully added. During policy
> teardown, this leads to an unconditional call to
> freq_qos_remove_request(), triggering a WARN.
>
> The current design allocates all three freq_req objects together, making
> the lifetime rules unclear and error handling fragile.
>
> Simplify this by allocating the QoS freq_req objects at policy
> allocation time. The policy itself is dynamically allocated, and two of
> the three requests are always needed anyway. This ensures consistent
> lifetime management and eliminates the inconsistent state in failure
> paths.
>
> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Fixes: 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 53 +++++++++++----------------------------
>  include/linux/cpufreq.h   |  6 ++---
>  2 files changed, 17 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c0aa970c7a67..f4a949f1e48f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -614,7 +614,7 @@ static int policy_set_boost(struct cpufreq_policy *po=
licy, bool enable)
>                 return ret;
>         }
>
> -       ret =3D freq_qos_update_request(policy->boost_freq_req, policy->c=
puinfo.max_freq);
> +       ret =3D freq_qos_update_request(&policy->boost_freq_req, policy->=
cpuinfo.max_freq);
>         if (ret < 0) {
>                 policy->boost_enabled =3D !policy->boost_enabled;
>                 cpufreq_driver->set_boost(policy, policy->boost_enabled);
> @@ -769,7 +769,7 @@ static ssize_t store_##file_name                     =
               \
>         if (ret)                                                        \
>                 return ret;                                             \
>                                                                         \
> -       ret =3D freq_qos_update_request(policy->object##_freq_req, val);\
> +       ret =3D freq_qos_update_request(&policy->object##_freq_req, val);=
 \
>         return ret >=3D 0 ? count : ret;                                 =
 \
>  }
>
> @@ -1374,7 +1374,7 @@ static void cpufreq_policy_free(struct cpufreq_poli=
cy *policy)
>         /* Cancel any pending policy->update work before freeing the poli=
cy. */
>         cancel_work_sync(&policy->update);
>
> -       if (policy->max_freq_req) {
> +       if (freq_qos_request_active(&policy->max_freq_req)) {
>                 /*
>                  * Remove max_freq_req after sending CPUFREQ_REMOVE_POLIC=
Y
>                  * notification, since CPUFREQ_CREATE_POLICY notification=
 was
> @@ -1382,12 +1382,13 @@ static void cpufreq_policy_free(struct cpufreq_po=
licy *policy)
>                  */
>                 blocking_notifier_call_chain(&cpufreq_policy_notifier_lis=
t,
>                                              CPUFREQ_REMOVE_POLICY, polic=
y);
> -               freq_qos_remove_request(policy->max_freq_req);
> +               freq_qos_remove_request(&policy->max_freq_req);
>         }
>
> -       freq_qos_remove_request(policy->min_freq_req);
> -       freq_qos_remove_request(policy->boost_freq_req);
> -       kfree(policy->min_freq_req);
> +       if (freq_qos_request_active(&policy->min_freq_req))
> +               freq_qos_remove_request(&policy->min_freq_req);
> +       if (freq_qos_request_active(&policy->boost_freq_req))
> +               freq_qos_remove_request(&policy->boost_freq_req);
>
>         cpufreq_policy_put_kobj(policy);
>         free_cpumask_var(policy->real_cpus);
> @@ -1452,57 +1453,31 @@ static int cpufreq_policy_online(struct cpufreq_p=
olicy *policy,
>         cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>
>         if (new_policy) {
> -               unsigned int count;
> -
>                 for_each_cpu(j, policy->related_cpus) {
>                         per_cpu(cpufreq_cpu_data, j) =3D policy;
>                         add_cpu_dev_symlink(policy, j, get_cpu_device(j))=
;
>                 }
>
> -               count =3D policy->boost_supported ? 3 : 2;
> -               policy->min_freq_req =3D kzalloc(count * sizeof(*policy->=
min_freq_req),
> -                                              GFP_KERNEL);
> -               if (!policy->min_freq_req) {
> -                       ret =3D -ENOMEM;
> -                       goto out_destroy_policy;
> -               }
> -
>                 if (policy->boost_supported) {
> -                       policy->boost_freq_req =3D policy->min_freq_req +=
 2;
> -
>                         ret =3D freq_qos_add_request(&policy->constraints=
,
> -                                                  policy->boost_freq_req=
,
> +                                                  &policy->boost_freq_re=
q,
>                                                    FREQ_QOS_MAX,
>                                                    policy->cpuinfo.max_fr=
eq);
> -                       if (ret < 0) {
> -                               policy->boost_freq_req =3D NULL;
> +                       if (ret < 0)
>                                 goto out_destroy_policy;
> -                       }
>                 }
>
>                 ret =3D freq_qos_add_request(&policy->constraints,
> -                                          policy->min_freq_req, FREQ_QOS=
_MIN,
> +                                          &policy->min_freq_req, FREQ_QO=
S_MIN,
>                                            FREQ_QOS_MIN_DEFAULT_VALUE);
> -               if (ret < 0) {
> -                       kfree(policy->min_freq_req);
> -                       policy->min_freq_req =3D NULL;
> +               if (ret < 0)
>                         goto out_destroy_policy;
> -               }
> -
> -               /*
> -                * This must be initialized right here to avoid calling
> -                * freq_qos_remove_request() on uninitialized request in =
case
> -                * of errors.
> -                */
> -               policy->max_freq_req =3D policy->min_freq_req + 1;
>
>                 ret =3D freq_qos_add_request(&policy->constraints,
> -                                          policy->max_freq_req, FREQ_QOS=
_MAX,
> +                                          &policy->max_freq_req, FREQ_QO=
S_MAX,
>                                            FREQ_QOS_MAX_DEFAULT_VALUE);
> -               if (ret < 0) {
> -                       policy->max_freq_req =3D NULL;
> +               if (ret < 0)
>                         goto out_destroy_policy;
> -               }
>
>                 blocking_notifier_call_chain(&cpufreq_policy_notifier_lis=
t,
>                                 CPUFREQ_CREATE_POLICY, policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index b6f6c7d06912..9b10eb486ece 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -79,9 +79,9 @@ struct cpufreq_policy {
>                                          * called, but you're in IRQ cont=
ext */
>
>         struct freq_constraints constraints;
> -       struct freq_qos_request *min_freq_req;
> -       struct freq_qos_request *max_freq_req;
> -       struct freq_qos_request *boost_freq_req;
> +       struct freq_qos_request min_freq_req;
> +       struct freq_qos_request max_freq_req;
> +       struct freq_qos_request boost_freq_req;
>
>         struct cpufreq_frequency_table  *freq_table;
>         enum cpufreq_table_sorting freq_table_sorted;
> --

Applied as 7.1 material, thanks!
