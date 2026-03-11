Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD236D4FD
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245491; cv=none; b=U/dUluAKKj6AMefJxk/xGDxaYEQrEf9DiBcBDqj8R09KQg62s5qb2AZuU9IjQoy2608NVuxveQKJlX7Ebrchy8jjtketr60c1bhywfj99qlMmLA8RO4sXHVSDw9DWq4sb09DjNfvJu9wwPseu44gm6XBWM/b6n1u01K9YVUCawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245491; c=relaxed/simple;
	bh=FJKqJr1iVgTcZsgm4AEI2vVnIjFHH3byHQioVS0H8yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sB+v3GdY3nq1P1F7sd5prw4R+jEcoittux7bFVzpx3mRRp17SPM6/1Sz1qbslMQBOJgyelOTmTvHG3/KtUnnvuSxLrVEI5A+rS7gbmL4e5JZIB/GsVjwoII65IpvzIMXLx7fVheX6WdAqoqvK7wIsYQ0Xq7yzchaO9mqhwvpTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t12ByOtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t12ByOtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6487C19421
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773245490;
	bh=FJKqJr1iVgTcZsgm4AEI2vVnIjFHH3byHQioVS0H8yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t12ByOtIqGq42MKFvySimJpIrxVDuhLdTa1/ZmxG3hSdO+OSm+Iw1FKlYxSbT4CKz
	 PERpDZjxuZjX9ysbEoGsvfk87B2GmniTxRmiX5Z3Q2Erd2O/m86Hab78/oOPwlA2KO
	 EysSpt2G4jnXDYF5QlZ2eVrhywWfA9zLbJ6iy8drDjdV+pMIPOeFyJXe1sldwceJSk
	 3voBr1NaFRIQB8+AIGlkDFELgyRyqQFcLyscTuntHB1BrGV2xSqvNeaQjTOty/fovl
	 DP/qUOh+TfHgNZm3xYluEbn56HWE2sEMgwGpxQPBlCTFckBSUXEYHuHsqS4+Ost+S4
	 tHmgi2XGh3+kw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662efd1bdd4so69861eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:11:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYaK3mwGW0W5SDd/Z6nN8yfKihDplmQGApLrdOS9zvoH6aCnpAvwOK0OLx7kKaW7K7pfE6YrsC+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZqn4XRnHqSiOtJlRVht7A2ogXJxzrUACM906pqOfeprb/Igp
	r26T3+kaAoZLT9L3UfTOAPbqO/DX6xXzTv8E4iMsa1otRc3JCCbnr8WBFOijhtmWQYFQ6ZYwlzh
	ZrpNnNs3RiRh3piEUnF0YPXv+9emTPzg=
X-Received: by 2002:a05:6820:490d:b0:661:1bee:284a with SMTP id
 006d021491bc7-67bd0760ef1mr54560eaf.28.1773245489716; Wed, 11 Mar 2026
 09:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com> <20260225084930.1692228-4-pierre.gondois@arm.com>
In-Reply-To: <20260225084930.1692228-4-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 17:11:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iL_geDUgb4zUzr9eB-PPsQiLPYO37T6ocLJx9DM=3TyQ@mail.gmail.com>
X-Gm-Features: AaiRm51vVNh5iwMQVYiZCNmbq0k--0R2gPIEbeLLMxSAdbCFT0gmCypasIOMBoA
Message-ID: <CAJZ5v0iL_geDUgb4zUzr9eB-PPsQiLPYO37T6ocLJx9DM=3TyQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] cpufreq: Centralize boost freq QoS requests
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
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

I don't quite see a reason for splitting this patch off the previous
one.  Can you combine them into one, please?

> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50467b938668a..42de32488f422 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *=
policy, bool enable)
>         policy->boost_enabled =3D enable;
>
>         ret =3D cpufreq_driver->set_boost(policy, enable);
> -       if (ret)
> +       if (ret) {
>                 policy->boost_enabled =3D !policy->boost_enabled;
> +               return ret;
> +       }
>
> -       return ret;
> +       ret =3D freq_qos_update_request(policy->boost_freq_req, policy->c=
puinfo.max_freq);
> +       if (ret < 0) {
> +               policy->boost_enabled =3D !policy->boost_enabled;
> +               cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,
> --
> 2.43.0
>
