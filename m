Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719D46B5
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689135; cv=none; b=lzw7F/M7m5DJwuaAs4IsUqRolDqBVBExMRP5By1n7EnH/HVLjxLgDOeTsL3kowEALtDbArOBH4m5NGQ7Cfqh1fTDkuxuoRQPnDLyGwdVyYD3HRCjYMzcI8dVZIogwWbftEPcNx143sMLcjJZq7S5yRIbZgYRV++wJ2FbrIcsNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689135; c=relaxed/simple;
	bh=mEogiDBRS9JezihUGaz7PMQYrpqo9nD1YsyJrfz0rkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekQUDomqszYRddSMWl19YUpS32OYZL/o3NQWzvR2hUoJn5PsrS9qGr2pF0FfXuAS6VLn5uVG8dkXZBHAWVE/k4rPqrgpoTx7T60ypPedFSiwWn8Ie1qJ/yBV/nCfnGP6ACOg26ceaUC3nDK907wF10zuVfdf+FuhARpt0l0etAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGRfdK9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGRfdK9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D300C2BCB3
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 19:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689135;
	bh=mEogiDBRS9JezihUGaz7PMQYrpqo9nD1YsyJrfz0rkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dGRfdK9JEdZUWgYycKhHdcnmvfgCV7JZu/GGc5rE75g83jMYb5c6BSWusQjGT2+KF
	 z8+5SO8HrYmJ05q+NYVXLzUdE68TDX1BZxo0EvveXGv3F/ZU7KSj3cHUj0TBbs/8EQ
	 kEy9aYdGa6RVM/QnfnTS3k2hi2/p2mI2AKhsXnI8yX2f9m1ZdQrMI58a6x0i5rM6/m
	 aujSK1X4JE2zdWankykNa5zVEstsCaykG+hN7Vz3MIihB7/sVz+AS97Gj3q6aIoBo+
	 pQEOIH8dF3eSobMCc00NEwSpGzSsXHGCB+wc/sNH3FLLU8QxZgLqZ/aD6GaELzm86j
	 htVM50M4NERkQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40ea611d1a4so1929464fac.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 12:25:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvVsARdmYLhl9wqKXLyGv44qglBfd4dA/+QsTKLbgAnVD92ug0NW0IwmNgrc7D4LlI9RRnosBL0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLiDYsBQv8ceZEdqVhbFJNOz8C5jTkFtQY3W2RuvknYiiLc8Y
	SDBtlyzRAXxGtC1iLt8SMJx9b1QqWE0YVVH6fKvJg1zst+wiPmeAIM5tdJnGM8O4ZeaAVtgIhwk
	p6uZOcVCDxRErBeOKNvmmGMynPbGmBWs=
X-Received: by 2002:a05:6870:318f:b0:417:6efa:1ef5 with SMTP id
 586e51a60fabf-417b905841cmr8336484fac.1.1773689134393; Mon, 16 Mar 2026
 12:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-2-pierre.gondois@arm.com> <zvk6qqwde535fiimjrtwhkyjnhymliv5acubtho3ge5hgj7y5g@3wolynnix3gz>
 <de26c436-bc6d-49bd-ab88-e055f1665c2f@arm.com>
In-Reply-To: <de26c436-bc6d-49bd-ab88-e055f1665c2f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Mar 2026 20:25:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iHuAwTAtDZqhDiX0H6M2PqrcxVWQkm8qk0dS6-pp-eYw@mail.gmail.com>
X-Gm-Features: AaiRm50lR0gnmEIXQXZo7lRjaCuZoSaKAusgBuOtR65L2_JvaK7g5ymRYl5q-2k
Message-ID: <CAJZ5v0iHuAwTAtDZqhDiX0H6M2PqrcxVWQkm8qk0dS6-pp-eYw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] cpufreq: Remove per-CPU QoS constraint
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 3:46=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
>
> On 3/13/26 09:57, Viresh Kumar wrote:
> > On 25-02-26, 09:49, Pierre Gondois wrote:
> >> policy->max_freq_req represents the maximum allowed frequency as
> >> requested by the policyX/scaling_max_freq sysfs file. This request
> >> applies to all CPUs of the policy. It is not possible to request
> >> a per-CPU maximum frequency.
> >>
> >> Thus, the interaction between the policy boost and scaling_max_freq
> >> settings should be handled by adding a boost specific QoS constraint.
> >> This will be handled in the following patches.
> >>
> >> This patch reverts of:
> >> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> >> a CPU")
> >>
> >> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> >> ---
> >>   drivers/cpufreq/cpufreq.c | 4 ----
> >>   1 file changed, 4 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 4472bb1ec83c7..db414c052658b 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq=
_policy *policy,
> >>
> >>              blocking_notifier_call_chain(&cpufreq_policy_notifier_lis=
t,
> >>                              CPUFREQ_CREATE_POLICY, policy);
> >> -    } else {
> >> -            ret =3D freq_qos_update_request(policy->max_freq_req, pol=
icy->max);
> >> -            if (ret < 0)
> >> -                    goto out_destroy_policy;
> >>      }
> >>
> >>      if (cpufreq_driver->get && has_target()) {
> > Even if this change is required, I don't think this should be applied
> > separately. Just reverting this will get the bug back, which was fixed =
by
> > commit 1608f0230510. Individual patches shouldn't break kernel (and bis=
ect) as
> > much as possible.
> >
> I could not reproduce the original issue.
>
> At the time of the patch and still now, calls to
> freq_qos_update_request() are checked against negative values.
> The only exception is when using the scaling_max_frequency sysfs
> entry, but this is out of the scope.
>
> So I don't see how:
>
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging a CPU=
")
>
> can prevent a CPU to reach the boost frequency.  The only path that
> could fail and that I could reproduce was fixed by:
>
> https://lore.kernel.org/all/852ff11c589e6300730d207baac195b2d9d8b95f.1745=
511526.git.viresh.kumar@linaro.org/
>
> So the current conclusion is that "cpufreq: Fix re-boost issue after
> hotplugging a CPU"
> was not the real fix

OK

I gather then that the $subject patch can be applied without the rest
of the series, can't it?

It would be good to update the changelog with all of the relevant
information though.
