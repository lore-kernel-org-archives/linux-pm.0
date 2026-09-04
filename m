Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22743BCD16
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537047; cv=none; b=J4Hu4CFBRBxoYCbzWBjKSO7XlJfaMyO+iRl2vSq49Qknwl2z+svusReA8H/ZIv0+L1QVaS2/kk3QiyGjFOSBsKxdociN6RIRXSm8Vkqc8eUlO0boIz17wlDSIBNnmAa/tPKea5bo55t88PiGrucxn1jOoxw5nNBS+SmDSyVwyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537047; c=relaxed/simple;
	bh=J+D67EODDrpGteCFiX+P6aHNJ72fFHw19CVT3mWXN+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHb8EShjPWA+kGg9pGxvQA79LhDfmOZt9n/tJMwpZCKqbl1kpA3twNUAKB5agfqD5xxaOqJ91xk/CpUK7SxVmGzLGi2IiFGdwlKNot2zhHWDo+POherjTSoU9h4n+l+h4mDCn/c/xw3MpBeT2Q8LZIfSwYk1FDwfldLEwrKe1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxYS3lCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxYS3lCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CD1F00A3F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537042;
	bh=rB7QG4udtei/n0n7iUfg2mxj3C+yQdTojJ/0cfG7vvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hxYS3lCkORd/tFWX3tQ+ceikAdRR/koxwxk+sGOiokvUCfeQ+2EvyhS3y0VTTosdG
	 og7Vy1sD9k91+HWCcpXMpEvwfnYRv2zGwTGQzVXTSdZ8kiVTcVS/l6SDfFivPuuC5k
	 /y16Vvwkie8O21DxCAaFNVJ0MeA1tnJjJKkuvDY/b6Y/umArfj//IGmVu9ojjkJ9E7
	 9UvUtE3BezeOc074aS2xb+84wqV74QBZrhwVSyxigCcAN9dqaD4y58871dOAgMcBsH
	 7DKVHMxgh7SQ9uQkbG2bcCEUaHYNF0W8nIHIeINKU0BCdk2bpnPwkTAqR6XF8SnGSx
	 UYkIeC76RFflg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a0faa764beso8810521fa.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:50:42 -0700 (PDT)
X-Gm-Message-State: AFuF++n5E119iAAJEjBgcAnqogzFRqTVMr6hHW3yYBDknbO2JcjPpdj/
	4nI0z8nLD3UwnPCv5LS0kSui2HfLHqJ2rC6CnsRfJh5kvcXTrhEn0B4LEjYORa5qckFNZPNlIWq
	6Chb9xh13TnasgUGO6GTFNGBMkzfL9zI=
X-Received: by 2002:a05:651c:a0a:b0:3a3:74b7:fc04 with SMTP id
 38308e7fff4ca-3a374b827c4mr5887081fa.16.1788537040786; Fri, 04 Sep 2026
 08:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901143635.4106960-1-zhongqiu.han@oss.qualcomm.com> <apemScUaVXUn8sR6@vireshk-B250M-D3H>
In-Reply-To: <apemScUaVXUn8sR6@vireshk-B250M-D3H>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 17:49:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdhLSaRrrOTmpKcop47i_8G1UMFZOMEhmdDMvaivkTug@mail.gmail.com>
X-Gm-Features: AcwNN1W43c3-LCeX8-sU8YYrIcSYgGW0bLlt4lAdD6IX6Hroiae8pOhzv3eOA9M
Message-ID: <CAJZ5v0jdhLSaRrrOTmpKcop47i_8G1UMFZOMEhmdDMvaivkTug@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: zero-initialize policy cpumask before sysfs publication
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 6:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 01-09-26, 22:36, Zhongqiu Han wrote:
> > cpufreq_policy_alloc() allocates policy->cpus with alloc_cpumask_var(),
> > i.e. without __GFP_ZERO, unlike the sibling related_cpus and real_cpus
> > masks. With CONFIG_CPUMASK_OFFSTACK=3Dy the mask is a separate
> > kmalloc_node() allocation, so its bitmap holds whatever the slab alloca=
tor
> > left behind:
> >
> >   cpufreq_online()
> >     cpufreq_policy_alloc()
> >       alloc_cpumask_var(&policy->cpus)    /* bitmap is uninitialized */
> >       kobject_init_and_add()              /* policy%u/ appears in sysfs=
 */
> >     cpufreq_policy_online()
> >       cpumask_copy(policy->cpus, cpumask_of(cpu))  /* first valid value=
 */
> >
> > This leaves a window in which the sysfs attributes are already reachabl=
e
> > while policy->cpus is still garbage. show()/store() gate on
> > policy_is_inactive(), i.e. cpumask_empty(policy->cpus), so a non-zero
> > bitmap makes them run the attribute callbacks on a policy that is not
> > initialized yet.
> >
> > Fix this by using zalloc_cpumask_var() for policy->cpus.
> >
> > Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating=
 policy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> > ---
> > This patch is based on https://lore.kernel.org/all/83f87db8-fa13-41d0-a=
e52-544d22e228e6@oss.qualcomm.com/
> >
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0d0df986fa3d..3b1b2ed86cc3 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1249,7 +1249,7 @@ static struct cpufreq_policy *cpufreq_policy_allo=
c(unsigned int cpu)
> >       if (!policy)
> >               return NULL;
> >
> > -     if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
> > +     if (!zalloc_cpumask_var(&policy->cpus, GFP_KERNEL))
> >               goto err_free_policy;
> >
> >       if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --

Applied as 7.3-rc material, thanks!
