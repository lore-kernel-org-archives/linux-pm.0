Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4BC261586
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324248; cv=none; b=UzztsfxEPU+jv/xGTadAeFkdpJgd3yhAZu8cpp3msu7FfThiew8yFVEHE0d5STBJAfJ1dfieS1g/3t1GRjUz0lhKBRTZe3fR6xPx5uG1K4J5+fNfQQ3JypB2WXP5QGMereOmPCoAUTqjdqVusjbCwMhf8IICowdiaZtJ7vj8urM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324248; c=relaxed/simple;
	bh=RT8BkGvOp2IDnZsS+sTiDyQeYaSg8a2MxOzmD5SKElQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkU+duUZ3w4gDZ8foqEu8fRURK0V8DrkDRZx5No1VoNuEMN9+TEgDVRX/eg1nEVonNnwVk6alAyR3o+yjipMxbq0ojIMqTweJtFbZ8NWdSstdSVs603aE+AimpCaGJM0fVrMXRP435p63XY4I6a/F3TJ8OLuSj/Wtv6FbTqGwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCrkr+dJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCrkr+dJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC48AC2BCB0
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773324248;
	bh=RT8BkGvOp2IDnZsS+sTiDyQeYaSg8a2MxOzmD5SKElQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vCrkr+dJ7q/NUoDAoQ8bP1Gp7zwb3suPtjbNMoiWhgtYZdC3h8T90TAcM+aFp4aqv
	 1DlTPsGW4w7E5Kl9tZ7mrXx7/6BKvBWDNjK8ghPCSC2rSh7Z7DT98ktA/NnejbMdYJ
	 X6rVMymJ3cYZ7t5OKcAru0HnyLCs9ziWGsiKFghtc+P3PmcjPKfv4/udUxFGQMxaNp
	 cwDe6wrupF1MomnHaGxuJoG6Y0/AZ/mkma5WT/UJ4XTpinkL2emfF/MPIaK8j5Wi+2
	 ATWxZZFMjuVEwjhIzlqswzl+0s1dmkW0lUlM45BsdTMyaIqBELxQjQiUQ3pBOy72HK
	 3+sK8IpVtfpbw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d738fe814cso880827a34.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 07:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUixatdR9VMXJI5UE4omMimp2O3dG1x21Jn6h+rQL5a+ihb+kHpYFWcby+FOgKVF0q0a6CZEKG6Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxysMOE4F/syJiDJOtH0LPRM3KFoMSSTazh05IAI08AL2vfO1vj
	MrWNmp/BKxeoBoiwXv4g4qAFn5sQnbZGvsZ51NlzVPpEOfyG8uRQrD/F9kFz7jGBkDu4nnu9kZl
	zqUQxvynbkDckzByRhjauu8GqQITYFOo=
X-Received: by 2002:a4a:d805:0:b0:67b:cc71:c4fc with SMTP id
 006d021491bc7-67bcc71c6aemr2404755eaf.23.1773324246938; Thu, 12 Mar 2026
 07:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com> <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
In-Reply-To: <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 15:03:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>
X-Gm-Features: AaiRm52cA4yitJ2OIv6evDDcwc_8iYoqGwObGNR-lTQ8izl1b_bWFh_w5Yuzqq0
Message-ID: <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:27=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 10-03-26, 21:17, Zhongqiu Han wrote:
> > Thanks for the patch. The fix looks correct to me for the reported
> > issue. I do have one question though - should we also consider the
> > interaction with commit abb6627910a1 ("cpufreq: conservative: Fix
> > next frequency selection")?
>
> Thanks for pointing this, I missed this change.
>
> > However, that change was subsequently reverted by commit abb6627910a1
> > ("cpufreq: conservative: Fix next frequency selection"), which noted
> > that using policy->cur directly broke the algorithm when freq_step is
> > small relative to the distances between available frequencies. In that
> > case, the governor may not be able to stay within a narrow range
> > between two consecutive available frequencies and instead jumps through
> > steps faster than intended.
>
> Its the opposite I think. The governor stays within a range and never
> goes to a higher or lower frequency. This is how I think this happens:
> - Lets say frequencies are from 1GHz to 2GHz with a gap of 200 MHz.
> - Lets say the frequency is 1 GHz now and the step size is 100 MHz.
> - conservative governor will try to change the freq to 1.1 GHz and end
>   up selecting 1 GHz only (due to CPUFREQ_RELATION_H, highest freq
>   below 1.1 GHz).
> - With my patch, we will keep resetting to 1 GHz (cur freq) and never
>   change freq.
> - With a recorded requested_freq, we will move to 1.1 GHz (actual 1
>   GHz), but a subsequent call will go for 1.2 GHz.
>
> Here is another idea, once everyone agrees I can send this formally:

So cs_dbs_update() does this:

if (requested_freq > policy->max || requested_freq < policy->min) {
        requested_freq =3D policy->cur;
        dbs_info->requested_freq =3D requested_freq;
}

Why is it not sufficient?

> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpu=
freq_conservative.c
> index e0e847764511..df01d33993d8 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy)
>         dbs_info->requested_freq =3D policy->cur;
>  }
>
> +static void cs_limits(struct cpufreq_policy *policy)
> +{
> +       struct cs_policy_dbs_info *dbs_info =3D to_dbs_info(policy->gover=
nor_data);
> +
> +       /*
> +        * The limits have changed, so may have the current frequency. Re=
set
> +        * requested_freq to avoid any unintended outcomes due to the mis=
match.
> +        */
> +       dbs_info->requested_freq =3D policy->cur;
> +}
> +
>  static struct dbs_governor cs_governor =3D {
>         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
>         .kobj_type =3D { .default_groups =3D cs_groups },
> @@ -322,6 +333,7 @@ static struct dbs_governor cs_governor =3D {
>         .init =3D cs_init,
>         .exit =3D cs_exit,
>         .start =3D cs_start,
> +       .limits =3D cs_limits,
>  };
>
>  #define CPU_FREQ_GOV_CONSERVATIVE      (cs_governor.gov)
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq=
_governor.c
> index 36eb7aee4bcd..acf101878733 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
>
>  void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
> +       struct dbs_governor *gov =3D dbs_governor_of(policy);
>         struct policy_dbs_info *policy_dbs;
>
>         /* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
> @@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_polic=
y *policy)
>         mutex_lock(&policy_dbs->update_mutex);
>         cpufreq_policy_apply_limits(policy);
>         gov_update_sample_delay(policy_dbs, 0);
> +       if (gov->limits)
> +               gov->limits(policy);
>         mutex_unlock(&policy_dbs->update_mutex);
>
>  out:
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq=
_governor.h
> index 168c23fd7fca..1462d59277bd 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -138,6 +138,7 @@ struct dbs_governor {
>         int (*init)(struct dbs_data *dbs_data);
>         void (*exit)(struct dbs_data *dbs_data);
>         void (*start)(struct cpufreq_policy *policy);
> +       void (*limits)(struct cpufreq_policy *policy);
>  };
>
>  static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy=
 *policy)
>
>
> --
> viresh
