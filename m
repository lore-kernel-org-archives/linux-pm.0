Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360B2EC0BF
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007533; cv=none; b=AQ+QsghMA8VQRu1hE97MLZtohTm3HTqvE3HUn3GAws1iOPllRNs3+x95iUQCSXMniHCwBDbW3pMWdFHsv+8F71f1+YlQT+uZ3Bu/Gy6tTkJN+eHkadA/Rdd8V/qmJBt+dwO95zqpzIgPBRriAGDAX9p0ONmKJt0df/hTCaxS/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007533; c=relaxed/simple;
	bh=/xicRzkzhZvSTA+EO8GiVBeStEymapU+Q07JFhtKQro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSFQlCnWd/7Y+p8e82s3O2I2TJCWLADAPENRioAmuFhCKBSc64MxbW/P7b2KtM4c5YoJHiMEgzGppdy7cbdanLurmPB306ULr6JWNnBiA8Dh44ZKxG6PtGAjM4AUxgOEEfKhRNk6HZnShU/6uDjX9R8pzN5J9CcUqLWQtmSYqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsVne9gR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsVne9gR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD3CC2BCAF
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774007532;
	bh=/xicRzkzhZvSTA+EO8GiVBeStEymapU+Q07JFhtKQro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dsVne9gRvxvvYVQ1UG3jqllMyjJ57OlI7xhnLCo9+kQAyUpJ0cvoz9lr1XpVrrU66
	 wDDqiYmd0m9Qw+vonqLlMByfWibxWLUh5urtOS7Y6/C+VhHkIVS89TqNIdCouU9LUg
	 HfqPdj56mUTa7HVyKBTsCvXLSRp9U+ImEfk3B8FuOSeYeVecvVK1VxR2EUqipUWXnb
	 gYruWDl2XGWsKBR6l9igctfi2Ah8ejro+765cnmgzFa2qKL3Hx3bprsY/XRYybn/6X
	 klXyRuryA9v/EEWwc8s4MvHmdSN+KoD0AqMfBBaB/rlwALXuAcfVs3/BbyxJf7ZgAO
	 tRLiGqJ+gbeTg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46704fbf62dso1304000b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 04:52:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8Oz43ReNid6y6Rj2SGBES4661IgZjVmuhiQph2rbtW0Caiglq
	OkZ1rkvB0Vzx2l5ZE0aa3QBTwxxjW8Yxthvov3fQfjvVFaEkpwYGtrfdo/+IcFbEsb881Y9vuHT
	kVZ20GKApv4WnRmuBRC9vBHbY/sqD4Zk=
X-Received: by 2002:a05:6808:4f06:b0:467:2a6e:ada8 with SMTP id
 5614622812f47-467e5dec2eemr1513185b6e.25.1774007531651; Fri, 20 Mar 2026
 04:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d846a141a98ac0482f20560fcd7525c0f0ec2f30.1773999467.git.viresh.kumar@linaro.org>
 <4c75f644-2c06-48b1-a72b-1b84be7ba4ab@oss.qualcomm.com>
In-Reply-To: <4c75f644-2c06-48b1-a72b-1b84be7ba4ab@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 12:51:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2+gcCDTRhXPLW7Vgjqdp30w4cvjz3CqG12=u_2X08eQ@mail.gmail.com>
X-Gm-Features: AaiRm52lpI2d3mWronBoEzk2FRQixo_nSmwY3z-BdTMC2iTzv3XkBdCavAYTgck
Message-ID: <CAJZ5v0h2+gcCDTRhXPLW7Vgjqdp30w4cvjz3CqG12=u_2X08eQ@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: conservative: Reset requested_freq on limits change
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:02=E2=80=AFAM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 3/20/2026 5:38 PM, Viresh Kumar wrote:
> > A recently reported issue highlighted that the cached requested_freq
> > is not guaranteed to stay in sync with policy->cur. If the platform
> > changes the actual CPU frequency after the governor sets one (e.g.
> > due to platform-specific frequency scaling) and a re-sync occurs
> > later, policy->cur may diverge from requested_freq.
> >
> > This can lead to incorrect behavior in the conservative governor.
> > For example, the governor may assume the CPU is already running at
> > the maximum frequency and skip further increases even though there
> > is still headroom.
> >
> > Avoid this by resetting the cached requested_freq to policy->cur on
> > detecting a change in policy limits.
> >
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied as 7.0-rc material, thanks!


> > Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1=
@huawei.com/
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > [v2]
> > - Completely different design to solve the problem.
> >
> >   drivers/cpufreq/cpufreq_conservative.c | 12 ++++++++++++
> >   drivers/cpufreq/cpufreq_governor.c     |  3 +++
> >   drivers/cpufreq/cpufreq_governor.h     |  1 +
> >   3 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index e0e847764511..df01d33993d8 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy=
)
> >       dbs_info->requested_freq =3D policy->cur;
> >   }
> >
> > +static void cs_limits(struct cpufreq_policy *policy)
> > +{
> > +     struct cs_policy_dbs_info *dbs_info =3D to_dbs_info(policy->gover=
nor_data);
> > +
> > +     /*
> > +      * The limits have changed, so may have the current frequency. Re=
set
> > +      * requested_freq to avoid any unintended outcomes due to the mis=
match.
> > +      */
> > +     dbs_info->requested_freq =3D policy->cur;
> > +}
> > +
> >   static struct dbs_governor cs_governor =3D {
> >       .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> >       .kobj_type =3D { .default_groups =3D cs_groups },
> > @@ -322,6 +333,7 @@ static struct dbs_governor cs_governor =3D {
> >       .init =3D cs_init,
> >       .exit =3D cs_exit,
> >       .start =3D cs_start,
> > +     .limits =3D cs_limits,
> >   };
> >
> >   #define CPU_FREQ_GOV_CONSERVATIVE   (cs_governor.gov)
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index 36eb7aee4bcd..acf101878733 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
> >
> >   void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
> >   {
> > +     struct dbs_governor *gov =3D dbs_governor_of(policy);
> >       struct policy_dbs_info *policy_dbs;
> >
> >       /* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
> > @@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_pol=
icy *policy)
> >       mutex_lock(&policy_dbs->update_mutex);
> >       cpufreq_policy_apply_limits(policy);
> >       gov_update_sample_delay(policy_dbs, 0);
> > +     if (gov->limits)
> > +             gov->limits(policy);
> >       mutex_unlock(&policy_dbs->update_mutex);
> >
> >   out:
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 168c23fd7fca..1462d59277bd 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -138,6 +138,7 @@ struct dbs_governor {
> >       int (*init)(struct dbs_data *dbs_data);
> >       void (*exit)(struct dbs_data *dbs_data);
> >       void (*start)(struct cpufreq_policy *policy);
> > +     void (*limits)(struct cpufreq_policy *policy);
> >   };
> >
> >   static inline struct dbs_governor *dbs_governor_of(struct cpufreq_pol=
icy *policy)
>
>
> --
> Thx and BRs,
> Zhongqiu Han
>
