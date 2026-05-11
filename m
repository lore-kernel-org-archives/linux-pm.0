Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CC42982D
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517824; cv=none; b=TiKfdy1ZNe/bc1XJc3WbO6rsMILU+Oc6mK68dHcI2KCIRD/ELwL+58WJ7If4SsO1smAtE41a5NKfcSg+BdCXCbWGavXsvfvDE6yx0ekbPI9CQUp7AEyZiZR9EujaWyB2a+nJ7tz4GNEXkS1fDvU8glyYnqdsIBUsl2fOenLXwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517824; c=relaxed/simple;
	bh=HNw4l5fs4Xn8NKqMIv7U0xRX4INKVPXmLwsXJ0n/rV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1Ixg2Sk1RppWfjCLAMxOXx3LgGCOoU2/lbed6lkT+jjY5CKj85dwynPS13h99mW7J8WhUJv2ghhgIMcR77G43O/vbbH8aQeQUTTcmVs8uPFYLd2IsY0Aky4d7mVQ8fbpXMZ6W548j1CLzT1DNcAfGpiQ6UC+QWWmolIlFxnpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecI+57Q5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecI+57Q5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18EEC2BD00
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517823;
	bh=HNw4l5fs4Xn8NKqMIv7U0xRX4INKVPXmLwsXJ0n/rV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ecI+57Q5hwnIom58Akc9udK8xzzoufZLamIVy+ZCmqc1TkGfIpoS++BKhhHc/n8bV
	 DVqqg4dkXREKCALKcvNf+OUELSP9DQYBbIvk3Cd2UZ/HOno8WZALHfEKmtabPGB86y
	 1yXNM+sVps32zwF9eq5W76H0p9k4xXjMoKVz9EzDhptPCVwN2Gl6AfIAHq0f3Y4wGO
	 eBYJE9DySghktckziYw/pbbBpT0xoQvZ2Ul85SA/UBqX0cdD+Qlkg8yPnT/3hzqiBK
	 ezPn7wjPTotnCuM2lQVowAmuPd7YHuIYRGGnZGvcWFwftVLpcX/wvbLxYCqy1zdt8G
	 NH9lhEns9etAw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a4113ab355so4215997e87.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 09:43:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Uj+lKWklWpSuS5aNuniHIJzDG5xaAf+SnWANW7rSWpPCx3al+5/BWUlZlegWqbDPaR8HdtAwm7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AQj1zp+Ha2ALMxGJkgWs0yFV4LRI6l8wzMCmi0IW/EfxeAG9
	DFdHo3xk5GNIKu/sMPKquAoKd/YciM2Zr1hL+efrsrQBqs1ChcghUvcdR+Uyj03Zrwoc0lbHyZA
	Wn3iZ4n4Oh1JHUmc9nRFfTa0Es6E2yfE=
X-Received: by 2002:a05:6512:3e21:b0:5a4:ab6:81b8 with SMTP id
 2adb3069b0e04-5a8a94caf78mr3905042e87.40.1778517822234; Mon, 11 May 2026
 09:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202605101404.fqz0MXIe-lkp@intel.com> <20260511075647.206642-1-luoxueqin@kylinos.cn>
 <b63b1409-3c01-418b-be27-f7e273b2e73a@arm.com>
In-Reply-To: <b63b1409-3c01-418b-be27-f7e273b2e73a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 18:43:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gaPeZU8a7qY93niVNSNHtFuhBJxyDCv2J60V0zpVV2mg@mail.gmail.com>
X-Gm-Features: AVHnY4LLnIeaTxnTXX1TBG-KMtjXvHkBRBWANCVZ-qGiD7d1hkQOIowgGauCoWE
Message-ID: <CAJZ5v0gaPeZU8a7qY93niVNSNHtFuhBJxyDCv2J60V0zpVV2mg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: cppc: Add update_limits support for Highest
 Performance changes
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Xueqin Luo <luoxueqin@kylinos.cn>, lkp@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	rafael@kernel.org, sumitg@nvidia.com, viresh.kumar@linaro.org, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:17=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> Hello Xueqin,
>
> On 5/11/26 09:56, Xueqin Luo wrote:
> > ACPI CPPC specification requires OSPM to re-evaluate the Highest
> > Performance register when Notify(0x85) is received for a processor
> > device.
> >
> > Implement cppc_cpufreq_update_limits() to refresh the cached
> > highest_perf capability through cppc_get_highest_perf() and update
> > policy->cpuinfo.max_freq accordingly.
> >
> > When autonomous selection mode is enabled, reprogram the runtime
> > MIN_PERF/MAX_PERF envelope against the updated Highest Performance
> > capability through cppc_cpufreq_set_autonomous_perf().
> >
> > --
> > change v2->v3:
> > - Fix build issues reported by kernel test robot
> > - Fold cppc_cpufreq_set_autonomous_perf() refactoring into
> >    this patch to keep it self-contained
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605101404.fqz0MXIe-lkp=
@intel.com/
> > Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> > ---
> >   drivers/cpufreq/cppc_cpufreq.c | 89 +++++++++++++++++++++++++++++----=
-
> >   1 file changed, 76 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpuf=
req.c
> > index 7e7f9dfb7a24..9184d5570de8 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -843,6 +843,80 @@ static int cppc_cpufreq_set_boost(struct cpufreq_p=
olicy *policy, int state)
> >       return 0;
> >   }
> >
> > +/**
> > + * cppc_cpufreq_set_autonomous_perf - Configure performance bounds for
> > + *                                     autonomous mode
> > + * @policy: cpufreq policy structure
> > + *
> > + * When enabling autonomous selection, program MIN_PERF and MAX_PERF f=
rom
> > + * current policy limits so that the platform uses the correct perform=
ance
> > + * bounds immediately.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *pol=
icy)
> > +{
> > +     struct cppc_cpudata *cpu_data =3D policy->driver_data;
> > +     u32 old_min_perf =3D cpu_data->perf_ctrls.min_perf;
> > +     u32 old_max_perf =3D cpu_data->perf_ctrls.max_perf;
> > +     int ret;
> > +
> > +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
> > +
> > +     ret =3D cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
> > +     if (ret) {
> > +             cpu_data->perf_ctrls.min_perf =3D old_min_perf;
> > +             cpu_data->perf_ctrls.max_perf =3D old_max_perf;
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
> > +{
> > +     struct cppc_cpudata *cpu_data =3D policy->driver_data;
> > +     u64 prev_highest_perf;
> > +     u64 highest_perf;
> > +     u64 nominal_perf;
> > +     int ret;
> > +
> > +     guard(cpufreq_policy_write)(policy);
> > +
> > +     prev_highest_perf =3D cpu_data->perf_caps.highest_perf;
> > +
> > +     ret =3D cppc_get_highest_perf(policy->cpu, &highest_perf);
> > +     if (ret)
> > +             return;
> > +
> > +     if (highest_perf =3D=3D prev_highest_perf)
> > +             return;
> > +
> > +     cpu_data->perf_caps.highest_perf =3D highest_perf;
> > +     nominal_perf =3D min_t(u64, highest_perf,
> > +                          cpu_data->perf_caps.nominal_perf);
> > +
>
> I sent a patch to try to remove setting policy->max in drivers
> in cpufreq drivers in general [1]. IMO policy->max should be
> updated through a callback handler, maybe:
>
> refresh_frequency_limits()
> \-cpufreq_set_policy()
>
> [1] https://lore.kernel.org/all/20260511135538.522653-4-pierre.gondois@ar=
m.com/

Yes, that's the right thing to do it.

> > +     policy->max =3D cppc_perf_to_khz(&cpu_data->perf_caps,
> > +                     policy->boost_enabled ?
> > +                     highest_perf : nominal_perf);
> > +
> There might be other things to check:
>
> - Is the new highest_perf higher/equal than nominal_perf ?
> Depending on the answer the boost capabilities/status will have to
> be updated.
>
> - IIUC it will be possible to update the nominal_perf in the next spec,
> so this makes things a bit more complicated aswell.
> https://lore.kernel.org/all/20260430142430.755437-3-sumitg@nvidia.com/

If you are referring to this one:

https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Control.html=
#ospm-nominal-performance-register

it is about something somewhat different IIUC.
