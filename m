Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F3363C6B
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237456; cv=none; b=fbEJmM0oD2TExa27t4wpdFEo651kyScym46N0GjR6hyqfK3rP5kbw1maQnT4UxnM+m7FEy9nabrTZDcuDHtouyh2psA9aUdcoqgeEQ42sj4js1KCKIQ2c1AAg1wiVXAoul4t0zHUFhXU/q71pAnd3bF3ibySIKaCD3++yc+YJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237456; c=relaxed/simple;
	bh=N80vuuFY4n02RzrBmgmHxAcmlNJjw1++xAz7SL0vA7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfZVlaGE2ApkJOeXrEtxXGQryaU65nr0ncgUSlmcZENUMea304EURNUzroHBghNNoLiQpzCparGroVpqoTWlFLbRNlgt0QWjdi22na4Tgp03V6JxE6rJ5qydsJ/bbDy+ZBeawwoNge8wYDjTgFUC2O18XzTkXsorppxfcXS1l8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQYIn7YH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQYIn7YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E5FC2BCB9
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773237456;
	bh=N80vuuFY4n02RzrBmgmHxAcmlNJjw1++xAz7SL0vA7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MQYIn7YH/Yk3fPlyqu2J0tXMD+mSqPFCJ9IKsBEN+2KeXiItDvSYKH1oKjkRNrNVY
	 ki/AKrytXNb9nVPUfhjWTIkurU3Nl6JEpl047t9TlTqtTSStHHvd/H3kM9/g84MNM/
	 TrZKyb3CVUvLuLiEYJsmVBCnC+/HN925x6zGzrY5TwlhLerCmMxW+UHyLRV5707nza
	 LU/g+OGJCoo4MD0uPKekeDSmPkpEcBL+fBF2q5I/42OjZJuGL/tljwJMamQgd+aoPE
	 zGAEyMk+vVCFWfjoawahpGBuHnn0q2hdw4OeJoeYwWUKvDnSWIJqM6baB12psjT57m
	 Wa3+KEXvSZ0aA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4138136f02eso6390951fac.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 06:57:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7yfaLNZxKfU834z3MWwnjzkJNTc6JQqbGGCFqO4nzyWzMTCNP1TcjM7oeKhnXI54haRTnwS34wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqGVclQfMkbiiWflOuVODCmzTNXxKYjitqqEcBfu5p4ACQc9/
	eeUPTmVXE8Hy8fYQmf7r/rqCBFekGyuvH0uSQSWb1TCnrl+wdC79nYei5gLHMWiYAFH1eOystds
	b5LzDNJzwk396eITKONX3RWwrA8O6NqM=
X-Received: by 2002:a05:6820:2903:b0:67b:c647:c5d4 with SMTP id
 006d021491bc7-67bc898a6e8mr1608337eaf.43.1773237455203; Wed, 11 Mar 2026
 06:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-3-pierre.gondois@arm.com> <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 14:57:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hH7jGoJdFrdh81woh_GVk3WYAeB+OM7nbu0jy0O1j47w@mail.gmail.com>
X-Gm-Features: AaiRm5126GTIuEeOGs1PRolfvHD0gTGtmajPb31w87RhtkUQ9k9qhjzcx-1Ciuc
Message-ID: <CAJZ5v0hH7jGoJdFrdh81woh_GVk3WYAeB+OM7nbu0jy0O1j47w@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 2:52=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 25, 2026 at 9:49=E2=80=AFAM Pierre Gondois <pierre.gondois@ar=
m.com> wrote:
> >
> > The Power Management Quality of Service (PM QoS) allows to
> > aggregate constraints from multiple entities. It is currently
> > used to manage the min/max frequency of a given policy.
> >
> > Frequency constraints can come for instance from:
> > - Thermal framework: acpi_thermal_cpufreq_init()
> > - Firmware: _PPC objects: acpi_processor_ppc_init()
> > - User: by setting policyX/scaling_[min|max]_freq
> > The minimum of the max frequency constraints is used to compute
> > the resulting maximum allowed frequency.
> >
> > When enabling boost frequencies, the same frequency request object
> > (policy->max_freq_req) as to handle requests from users is used.
> > As a result, when setting:
> > - scaling_max_freq
> > - boost
> > The last sysfs file used overwrites the request from the other
> > sysfs file.
> >
> > To avoid this, create a per-policy boost_freq_req to save the boost
> > constraints instead of overwriting the last scaling_max_freq
> > constraint.
> >
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++++++++++++++++-----
> >  include/linux/cpufreq.h   |  1 +
> >  2 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index db414c052658b..50467b938668a 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1359,17 +1359,21 @@ static void cpufreq_policy_free(struct cpufreq_=
policy *policy)
> >         /* Cancel any pending policy->update work before freeing the po=
licy. */
> >         cancel_work_sync(&policy->update);
> >
> > -       if (policy->max_freq_req) {
> > +       if ((policy->max_freq_req && !policy->boost_supported) ||
> > +           policy->boost_freq_req) {
>
> Are you sure?
>
> >                 /*
> > -                * Remove max_freq_req after sending CPUFREQ_REMOVE_POL=
ICY
> > -                * notification, since CPUFREQ_CREATE_POLICY notificati=
on was
> > -                * sent after adding max_freq_req earlier.
> > +                * Remove max/boost _freq_req after sending CPUFREQ_REM=
OVE_POLICY
> > +                * notification, since CPUFREQ_CREATE_POLICY notificati=
on was sent
> > +                * after adding max/boost _freq_req earlier.
> >                  */
> >                 blocking_notifier_call_chain(&cpufreq_policy_notifier_l=
ist,
> >                                              CPUFREQ_REMOVE_POLICY, pol=
icy);
> > -               freq_qos_remove_request(policy->max_freq_req);
> >         }
> >
> > +       freq_qos_remove_request(policy->boost_freq_req);
> > +       kfree(policy->boost_freq_req);
> > +
> > +       freq_qos_remove_request(policy->max_freq_req);
> >         freq_qos_remove_request(policy->min_freq_req);
> >         kfree(policy->min_freq_req);
> >
> > @@ -1479,6 +1483,29 @@ static int cpufreq_policy_online(struct cpufreq_=
policy *policy,
> >                         goto out_destroy_policy;
> >                 }
> >
> > +               if (policy->boost_supported) {
> > +                       policy->boost_freq_req =3D kzalloc(sizeof(*poli=
cy->boost_freq_req),
> > +                                                        GFP_KERNEL);
>
> Instead of doing this, why don't you add 1 to the policy->min_freq_req
> allocation size when boost is supported?  You'll destroy the policy if
> the allocation fails anyway.
>
> > +                       if (!policy->boost_freq_req) {
> > +                               ret =3D -ENOMEM;
> > +                               goto out_destroy_policy;
> > +                       }
> > +
> > +                       ret =3D freq_qos_add_request(&policy->constrain=
ts,
> > +                                                  policy->boost_freq_r=
eq,
> > +                                                  FREQ_QOS_MAX,
> > +                                                  FREQ_QOS_MAX_DEFAULT=
_VALUE);
> > +                       if (ret < 0) {
> > +                               /*
> > +                                * So we don't call freq_qos_remove_req=
uest() for an
> > +                                * uninitialized request.
> > +                                */
> > +                               kfree(policy->boost_freq_req);
> > +                               policy->boost_freq_req =3D NULL;
> > +                               goto out_destroy_policy;
> > +                       }
> > +               }
>
> Then you can put this block before the policy->min_freq_req addition
> and the corresponding update of cpufreq_policy_free() will be more
> straightforward.
>
> BTW, if I'm not mistaken, there is a bug in the current
> cpufreq_policy_free() because it may attempt to remove a NULL freq QoS
> request for policy->min_freq_req.  I'll send a patch for that later if
> I can confirm it.

Fortunately, freq_qos_remove_request() checks its argument against
NULL, never mind.

Of course, this means that
freq_qos_remove_request(policy->max_freq_req) need not be there under
the if (policy->max_freq_req) in cpufreq_policy_free() which you have
noticed.
