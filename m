Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE24A33
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237179; cv=none; b=N8h8TSBagBmTJIQ1T7FgGr6lf5DLblBM/jVO5jjFRRj/VAKDsxZdw3ZXKVhJQFexrEpuf9LotgQhcYA4ooHChSSZxUapGAM5Ho4sZ5XdW+6GI9fHOht3ITA2wgc0EhbYT0mM8eZRFPAi3RDar1njG7pNkOo847zNoQdNzZGNJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237179; c=relaxed/simple;
	bh=c+B7ev+4XxrvjBtN8IMeUXCjDAWMiqxcu4QngdTrGuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGF0lWMyX4XwMeB/8Z54gQB71KgpHxnAeN2AJfzBmyRLVDr9QfqU+oMQWkedzi1oEUC04MjbxVF37DnywwTSEXx6CL4vh3qI4eGjpUrEw7nOC7TfAFo7uou8Drq6l8VoRgJz1EL2Ou9IncbArl2akLjIR7hhnZSr58fan7cvolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTyhjGzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTyhjGzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C6FC2BCB3
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773237178;
	bh=c+B7ev+4XxrvjBtN8IMeUXCjDAWMiqxcu4QngdTrGuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OTyhjGzCleqUyRgJFv0JrMdtJLeARYrGTODp6EdNI8e5Ht9JfwaBCff246+KYUvi5
	 GWIE1ywacQFoUhG62kOtglBH/p/DCC4v6ngD0PJEPMvCoP6Y+efUdlBZzxvg/lD+4D
	 BZu2WLFNyxPiceiCbh/xLhywdlFZWxE7xxkSlFfssqVOD8VlSIEd4BxCvjR/q1vL57
	 Ut2w5VuaY+MB5i7qTmYsRJrs4RPFDesjl+Fu9xX+fM6X5D85C6TW6yd/VMfnDTPY76
	 sOtEHeNgP453QqtE/Iy7WUJv7DCtKnVw0QOLHeWgCcrF/658rIH54faDnltgWIouWt
	 qt9ZmKjNvQCiw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c383f2fcso10124604a34.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 06:52:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPfGZYs5Pcx+EzHs/F8Zw1RvIjuUusYk599XlU5DQ4LHf5ggLGQoHIhcvUONM+cJyiOG7Zv3NW5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFG8KIkcUMtldjwMHRmZJv5uE6fN1q68ZYJsIPhDuxRsMEUouh
	C34xQa1BMu8W4b/PmTsqH8/zUowm7semzcyzg4UWZqNa9CmT98PYc186j1NS4cI479de4MdFfQC
	n4za/ZtWWD19yN0wMnYwcWu/JmYft/Ek=
X-Received: by 2002:a05:6820:450b:b0:67b:bbc8:9ecd with SMTP id
 006d021491bc7-67bc89d4dddmr1213930eaf.47.1773237177857; Wed, 11 Mar 2026
 06:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com> <20260225084930.1692228-3-pierre.gondois@arm.com>
In-Reply-To: <20260225084930.1692228-3-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 14:52:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
X-Gm-Features: AaiRm52cL3cXGDEPxMUyTt3UurI-BV3mLv1SI5WhPEeUsgg_BjASXLU52ekaIuI
Message-ID: <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cpufreq: Add boost_freq_req QoS request
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

On Wed, Feb 25, 2026 at 9:49=E2=80=AFAM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> The Power Management Quality of Service (PM QoS) allows to
> aggregate constraints from multiple entities. It is currently
> used to manage the min/max frequency of a given policy.
>
> Frequency constraints can come for instance from:
> - Thermal framework: acpi_thermal_cpufreq_init()
> - Firmware: _PPC objects: acpi_processor_ppc_init()
> - User: by setting policyX/scaling_[min|max]_freq
> The minimum of the max frequency constraints is used to compute
> the resulting maximum allowed frequency.
>
> When enabling boost frequencies, the same frequency request object
> (policy->max_freq_req) as to handle requests from users is used.
> As a result, when setting:
> - scaling_max_freq
> - boost
> The last sysfs file used overwrites the request from the other
> sysfs file.
>
> To avoid this, create a per-policy boost_freq_req to save the boost
> constraints instead of overwriting the last scaling_max_freq
> constraint.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++++++++++++++++-----
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index db414c052658b..50467b938668a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1359,17 +1359,21 @@ static void cpufreq_policy_free(struct cpufreq_po=
licy *policy)
>         /* Cancel any pending policy->update work before freeing the poli=
cy. */
>         cancel_work_sync(&policy->update);
>
> -       if (policy->max_freq_req) {
> +       if ((policy->max_freq_req && !policy->boost_supported) ||
> +           policy->boost_freq_req) {

Are you sure?

>                 /*
> -                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLIC=
Y
> -                * notification, since CPUFREQ_CREATE_POLICY notification=
 was
> -                * sent after adding max_freq_req earlier.
> +                * Remove max/boost _freq_req after sending CPUFREQ_REMOV=
E_POLICY
> +                * notification, since CPUFREQ_CREATE_POLICY notification=
 was sent
> +                * after adding max/boost _freq_req earlier.
>                  */
>                 blocking_notifier_call_chain(&cpufreq_policy_notifier_lis=
t,
>                                              CPUFREQ_REMOVE_POLICY, polic=
y);
> -               freq_qos_remove_request(policy->max_freq_req);
>         }
>
> +       freq_qos_remove_request(policy->boost_freq_req);
> +       kfree(policy->boost_freq_req);
> +
> +       freq_qos_remove_request(policy->max_freq_req);
>         freq_qos_remove_request(policy->min_freq_req);
>         kfree(policy->min_freq_req);
>
> @@ -1479,6 +1483,29 @@ static int cpufreq_policy_online(struct cpufreq_po=
licy *policy,
>                         goto out_destroy_policy;
>                 }
>
> +               if (policy->boost_supported) {
> +                       policy->boost_freq_req =3D kzalloc(sizeof(*policy=
->boost_freq_req),
> +                                                        GFP_KERNEL);

Instead of doing this, why don't you add 1 to the policy->min_freq_req
allocation size when boost is supported?  You'll destroy the policy if
the allocation fails anyway.

> +                       if (!policy->boost_freq_req) {
> +                               ret =3D -ENOMEM;
> +                               goto out_destroy_policy;
> +                       }
> +
> +                       ret =3D freq_qos_add_request(&policy->constraints=
,
> +                                                  policy->boost_freq_req=
,
> +                                                  FREQ_QOS_MAX,
> +                                                  FREQ_QOS_MAX_DEFAULT_V=
ALUE);
> +                       if (ret < 0) {
> +                               /*
> +                                * So we don't call freq_qos_remove_reque=
st() for an
> +                                * uninitialized request.
> +                                */
> +                               kfree(policy->boost_freq_req);
> +                               policy->boost_freq_req =3D NULL;
> +                               goto out_destroy_policy;
> +                       }
> +               }

Then you can put this block before the policy->min_freq_req addition
and the corresponding update of cpufreq_policy_free() will be more
straightforward.

BTW, if I'm not mistaken, there is a bug in the current
cpufreq_policy_free() because it may attempt to remove a NULL freq QoS
request for policy->min_freq_req.  I'll send a patch for that later if
I can confirm it.

> +
>                 blocking_notifier_call_chain(&cpufreq_policy_notifier_lis=
t,
>                                 CPUFREQ_CREATE_POLICY, policy);
>         }
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 0465d1e6f72ac..c292a6a19e4f5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>         struct freq_constraints constraints;
>         struct freq_qos_request *min_freq_req;
>         struct freq_qos_request *max_freq_req;
> +       struct freq_qos_request *boost_freq_req;
>
>         struct cpufreq_frequency_table  *freq_table;
>         enum cpufreq_table_sorting freq_table_sorted;
> --
