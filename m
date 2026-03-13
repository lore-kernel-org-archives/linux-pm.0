Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1779CD
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402248; cv=none; b=D+kN1sdZhDwL1y3FG0B3tMhbtTXVlsuWNdtgfls5kuzNKu0oSvhD6Owr/GN0CbVMPop8ue1ACC9v7q6sjNWbOYIM44ZuP+gtqtJLxHFnxPh+EtnLW5FC7mJvmKnpyvaoL7wCO6L0dpOXcn0Jgk4O74uje5NTUZxGH2fFROnIgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402248; c=relaxed/simple;
	bh=STMTz/bLIZaJ3tV27/kHJTeZnAbFHa1vsGs1mJHjTus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRxl4r1NLVwyyWaJLU1f2Hj/P4himvWPyV89O2mpD0nCQs2G6I8ibALR0J2zlNO5gzZ6ZMHkcCRKXbRa6O7/VXVnsvE/AsSJkfOKrQNOTDpgA+Ag875h8cx0iUasg+VMsdYLvztBAoDFXt4MUQ5Isz0X7vkf5YL4DqBEBNxMSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGtdymtf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGtdymtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E737C2BCB2
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773402248;
	bh=STMTz/bLIZaJ3tV27/kHJTeZnAbFHa1vsGs1mJHjTus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WGtdymtf2Hq8ufd7IvapjYhsUJioCnIL57XMPCOQt68izeWBYrSkjyKVOa7/URkQe
	 /7TU9syz50kCGqhSm8lMIdNEuTlZTvo1KR6XzuYGxhD4qR6sIVsh7XWgh0TtXPl7OV
	 61KB2qaEd3o/aPxv8Tac4Rv2iBXuzzuFpreKcAJ70+U1/Tx/NKF5Vseziftugd0iaV
	 h2XhgXWOF+UcyEbRhYbgOEcrdkDFarBImYr26aFNhC/YdDrzp3C50X9168bKnfAXP5
	 nj7dvMtI/bOTiK21C1sNLpt4Ip85IjZLaR4Ca+PEHdbwJsFfD2QihIn411g6+Psgq8
	 yDVK12+qqKUdA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45f053b7b90so1381358b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 04:44:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb9nnlvajI+4bCPouIT1tcZr+ectIVgl38lxNgpEQwyQ+80kfgllZtpK5NunVfmDV3diO8s/WfTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziYr/GoGaJSzT4yVTqivnxibG6EJDEx0gIvzkXzWLSV2VwAO9F
	yPT/ybYfrcHcnSuvbPXG5tVVDKp41wN73z+LffWEH9vfe9Btz6QsKb431hCnSuNZ/+xk9SLZYJh
	v/6nVMhMAnQTwbH0NAxnZ5AmkF+pe3EA=
X-Received: by 2002:a05:6808:11cb:b0:464:305e:8fcc with SMTP id
 5614622812f47-4675713631amr1471973b6e.20.1773402247126; Fri, 13 Mar 2026
 04:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-5-pierre.gondois@arm.com> <CAJZ5v0jMsphO=tcHWMeJXE74Xk4HZyCqyMDRU2XZ+HrfxoVZbw@mail.gmail.com>
 <kz2xmjoq6ckf6hykougeimo2fdo5tbjhmffsgk4yfgfwkd43yg@uiixgymot7uw>
In-Reply-To: <kz2xmjoq6ckf6hykougeimo2fdo5tbjhmffsgk4yfgfwkd43yg@uiixgymot7uw>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 12:43:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iiPsuyL=6wqwn_zqTAhVjrazUrQQVHR6d_qPNvP-gM0g@mail.gmail.com>
X-Gm-Features: AaiRm51GJlq5c5FC0aQgstuSi7B1Atmty337qXw0hfTHpLzcwf6QZWdpb4kiYa0
Message-ID: <CAJZ5v0iiPsuyL=6wqwn_zqTAhVjrazUrQQVHR6d_qPNvP-gM0g@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] cpufreq: Update .set_boost() callbacks to rely on boost_freq_req
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pierre Gondois <pierre.gondois@arm.com>, 
	linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 10:38=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 11-03-26, 17:19, Rafael J. Wysocki wrote:
> > On Wed, Feb 25, 2026 at 9:50=E2=80=AFAM Pierre Gondois <pierre.gondois@=
arm.com> wrote:
> > >
> > > In the existing .set_boost() callbacks:
> > > - Don't update policy->max as this is done through the qos notifier
> > >   cpufreq_notifier_max() which calls cpufreq_set_policy().
> > > - Remove freq_qos_update_request() calls as the qos request is now
> > >   done in policy_set_boost() and updates the new boost_freq_req
> > >
> > > Note:
> > > cpufreq_frequency_table_cpuinfo() is also called through:
> > > cpufreq_policy_online()
> > > \-cpufreq_table_validate_and_sort()
> > >   \-cpufreq_frequency_table_cpuinfo()
> > > which relies on cpufreq_frequency_table_cpuinfo() to set
> > > policy->min and max initizalization at driver init. This
> > > regression is solved in the next patch.
> > >
> > > Note2:
> > > acpi-cpufreq.c seems to be the only cpufreq driver not
> > > setting cpuinfo.max_freq. Populate it the nominal frequency at
> > > driver init.
> > >
> > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > ---
> > >  drivers/cpufreq/acpi-cpufreq.c |  1 +
> > >  drivers/cpufreq/amd-pstate.c   |  2 --
> > >  drivers/cpufreq/cppc_cpufreq.c | 10 ++--------
> > >  drivers/cpufreq/cpufreq.c      | 16 +++++++---------
> > >  drivers/cpufreq/freq_table.c   |  7 +++----
> > >  5 files changed, 13 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cp=
ufreq.c
> > > index e73a66785d69d..6a6e26e1be14a 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -857,6 +857,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_p=
olicy *policy)
> > >                  * governor from selecting inadequate CPU frequencies=
.
> > >                  */
> > >                 arch_set_max_freq_ratio(true);
> > > +               policy->cpuinfo.max_freq =3D nominal_freq;
> > >         }
> > >
> > >         policy->freq_table =3D freq_table;
> >
> > This looks like a fix for acpi_cpufreq that should be sent separately.
>
> cpufreq_frequency_table_cpuinfo() (called before this) should always end =
up
> setting cpuinfo.max_freq properly and so this never broke earlier.

So is this change needed?

> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstat=
e.c
> > > index c45bc98721d24..310d5938cbdf6 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpu=
freq_policy *policy, bool on)
> > >         else if (policy->cpuinfo.max_freq > nominal_freq)
> > >                 policy->cpuinfo.max_freq =3D nominal_freq;
> > >
> > > -       policy->max =3D policy->cpuinfo.max_freq;
> > > -
> > >         if (cppc_state =3D=3D AMD_PSTATE_PASSIVE) {
> > >                 ret =3D freq_qos_update_request(&cpudata->req[1], pol=
icy->cpuinfo.max_freq);
> > >                 if (ret < 0)
> > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cp=
ufreq.c
> > > index 9eac77c4f2944..4c46c7ea318eb 100644
> > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > @@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufre=
q_policy *policy, int state)
> > >  {
> > >         struct cppc_cpudata *cpu_data =3D policy->driver_data;
> > >         struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> > > -       int ret;
> > >
> > >         if (state)
> > > -               policy->max =3D cppc_perf_to_khz(caps, caps->highest_=
perf);
> > > +               policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, c=
aps->highest_perf);
> > >         else
> > > -               policy->max =3D cppc_perf_to_khz(caps, caps->nominal_=
perf);
> > > -       policy->cpuinfo.max_freq =3D policy->max;
> > > -
> > > -       ret =3D freq_qos_update_request(policy->max_freq_req, policy-=
>max);
> > > -       if (ret < 0)
> > > -               return ret;
> > > +               policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, c=
aps->nominal_perf);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 42de32488f422..20266fb42d18d 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1500,10 +1500,14 @@ static int cpufreq_policy_online(struct cpufr=
eq_policy *policy,
> > >                                 goto out_destroy_policy;
> > >                         }
> > >
> > > +                       /*
> > > +                        * If boost is supported,
> > > +                        * init the constraint with cpuinfo.max_freq.
> > > +                        */
> > >                         ret =3D freq_qos_add_request(&policy->constra=
ints,
> > >                                                    policy->boost_freq=
_req,
> > >                                                    FREQ_QOS_MAX,
> > > -                                                  FREQ_QOS_MAX_DEFAU=
LT_VALUE);
> > > +                                                  policy->cpuinfo.ma=
x_freq);
> > >                         if (ret < 0) {
> > >                                 /*
> > >                                  * So we don't call freq_qos_remove_r=
equest() for an
> >
> > Why do you need to update stuff introduced in the previous patch?
> >
> > Is that because policy->cpuinfo.max_freq is not set consistently
> > before the changes made here?  In which case, wouldn't it be better to
> > make all drivers set cpuinfo.max_freq consistently before making the
> > changes in the second patch and fold the chunk above into the latter?
>
> Since cpuinfo.max_freq is set correctly earlier, I think this can be done
> earlier only.

I'm not sure what you mean.

To clarify my point, the question really is what prevents patch [2/6]
from passing policy->cpuinfo.max_freq to freq_qos_add_request() as the
last argument right away.
