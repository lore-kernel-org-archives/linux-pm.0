Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B336DA19
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865758; cv=none; b=X4zPX7ASIOq39awcnV9D5aVhY5coxXzKwWXayLKLatv8XF85311S5T3vkiVxM8FcXGCHYylpDx+UFXHFmQTg9mAMCEsjFrEEEc35hyQqCLzgg9qe6/Z9KB2Y3gW8Fit3HS8e83hiuyPIA8tCY4dxzQOOIyzXarFYpzGbV7r3olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865758; c=relaxed/simple;
	bh=C5XJZIUUYTZ9DV8qkJmpbXu441VwHkjYyxJ5/Q2en4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDcg+ONQqjAo96FVKnHKOEWVH+l2Zi4IHepFfIfPWoQ6J+jimCDx5NyLOACm2/2XdpWucVHXkW1HmissMaQPNHdBGdfgbi9mLlJXeD/fjhPahp0UOrS1jaAkdUBivg5/i2kZMnN0OWWTAUTPzslvDpi6DcTEQ14+QRWkTI39AZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLU6d/6j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLU6d/6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB065C2BCAF
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773865758;
	bh=C5XJZIUUYTZ9DV8qkJmpbXu441VwHkjYyxJ5/Q2en4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gLU6d/6jJos2xaoFf3mM6HsMYchZBN6f7CRci/cVQJ3+ulGgv2A7+CXO042Xbwvvr
	 f4FWrPTDkJ0UFf3/EQo++QH5v/6vVdqEIRmfR7sgOSVEd3t0Pc+bdvp77+KAPF8/P9
	 S+bgno1o7VJwF4Y42GIeXDHUn1jQ+Q162fJoiQhV/6+DBViU3tmoCaraykLuHveLjH
	 D4RAN3zweCJnlQPjDeJlhNIL9HHLMdlhCFc6VI56ImRmUQZ2HbVY2O5FiEE3dQOqb+
	 2gOonMvWNC4Rq5vlAh/FUKwQABkDrM7eiBIpt0204ZfnjcR/nz5UqLV1CXfDX4vhmN
	 OGTh0y0qKcQcA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-467166cb638so164984b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 13:29:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy03A9zYvxkweEeIt7eY3myZHM4iH395uBUu5v8d+7CQCF4PD9W
	Vg70/hc9ky48mvjobv0a6Febe/VNiXRa2MsCHLexDPmSRHCYu328qNbJdOz47q7mJ82n/3iVlCv
	NRachysRBL/p3UK1rg1o2T3V7w90o1OM=
X-Received: by 2002:a05:6820:8185:b0:67b:d547:26e1 with SMTP id
 006d021491bc7-67c0db0cb57mr3033017eaf.43.1773865756895; Wed, 18 Mar 2026
 13:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314192544.605914-1-ynorov@nvidia.com> <mzahqtkpyq7eazninszlipmzdgvxnw5ftp5gwhlaxpdqxbyzlz@kdsl4jafdgdq>
In-Reply-To: <mzahqtkpyq7eazninszlipmzdgvxnw5ftp5gwhlaxpdqxbyzlz@kdsl4jafdgdq>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Mar 2026 21:29:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gU8tU+2za5FtvoTyG9qsSZEV11RYhcLv965J46iUV_wQ@mail.gmail.com>
X-Gm-Features: AaiRm51i3AE8MmsbftgTsjEcnSOHGYTHFEI3GU7JGBkoSsn85nPkV70NttZYfCY
Message-ID: <CAJZ5v0gU8tU+2za5FtvoTyG9qsSZEV11RYhcLv965J46iUV_wQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: optimize policy_is_shared()
To: Viresh Kumar <viresh.kumar@linaro.org>, Yury Norov <ynorov@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 7:47=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 14-03-26, 15:25, Yury Norov wrote:
> > The switch to cpumask_nth() over cpumask_weight(), as it may return
> > earlier - as soon as the function counts the required number of CPUs.
> >
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  include/linux/cpufreq.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index cc894fc38971..8ca2bcb3d7ae 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -232,7 +232,7 @@ static inline bool policy_is_inactive(struct cpufre=
q_policy *policy)
> >
> >  static inline bool policy_is_shared(struct cpufreq_policy *policy)
> >  {
> > -     return cpumask_weight(policy->cpus) > 1;
> > +     return cpumask_nth(1, policy->cpus) < nr_cpumask_bits;
> >  }
> >
> >  #ifdef CONFIG_CPU_FREQ
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.1 material, thanks!
