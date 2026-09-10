Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FB35C1A0
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027534; cv=pass; b=Skd4U7Tv3wnhvOnTeoj50ykZY2nQgQGfksiLBW+qoOc1aBkoHBe0Psk8R2NkgmgO8KtNqbCHvwk9Qp969gV8wbakaZNvEIrihdleN2Vavbxsu0GB2DuP9fRjoBgIGuPCy2Ikag4e28W2lOxk5GA/t4Xeg+JDAjutOnUo0ikps0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027534; c=relaxed/simple;
	bh=L0knm0WwBNsA4D7m6jWr47bQPvrrL5uG4WzP1rJec+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cT2VpgXJ1PyYqWZ8ub0/klo3SKcdicmkxNBaisdONP6paaCJIy/Aawmq8ulWpdTd/WY3RoH3p/vc8IhiOtxyQL6IKFdsRLqwHsJ17Al40zLgD16x/S00Rb4l5rYZpBlrUJmtyrSgB9adGoBb8PyzAbAPm/aJXrfr2yvesDobSYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cU47aJDk; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cU47aJDk"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2544ff970dso1026856766b.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 01:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789027531; cv=none;
        d=google.com; s=arc-20260327;
        b=BA+Sik1C6JwQodgHhc3nFd/8b+6+m5Lo6TXdN4ANcsCmRq+OmOT8ZGRvoxjbSf0n6/
         XAU9OoVMOllj3xaB776INjTCyBYLVQiYX4th6zlrC0rKSjKmTfjwE4OExK9mjAv8A4bF
         7xhNNfPV33YWYOO0as33mB++VGaS79W2F9TmdkeiobQ9rrZ/thW3IPatW+yuuTOX0gJh
         XrTFume84wwZfc+CD/JdHwOgOv0zKrMdR64OrvQCiPKId8Y0GttHF4yeYqnNFKPSehve
         F4BggGsqN2ABDTA1BLrXX8EkOb69HeeqHw8ZD4FIA/2LbZ3+rkIBvWx9ALXcIYaqDAuY
         yV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=idTG+kIgG4BE6fViCSY/GmRMddNGdFY103Ar/WRtmPE=;
        fh=XsNZA4l6gt8I7zovMkaKt395KFOrHTXDJ+yrD4yQ9DU=;
        b=oX19nZbGC19xyRCmW7kMGA3hFjIAENm2GKEA2T4+f+Y/iDc+0Q26dYroQZpWIGzaE5
         Bz87pX7d2bwUps5uF8awKUPA8oX1+6s+mDaHILl4/W0WTmNzNEWL9YOFFJxIZryuGIcl
         8SSSnO//rwcQ2lR6t+mDgoRpcyTLIhKlB0S3XOGbPK3qCYjwtlMmkbsjKW7su8scq+5q
         L6fp3LiqtGDYKbwxgi7KUnBilo13iZT9+elb7/Ht1CILyWBspAW3mRZpHGNRQG4d4Ujp
         AJXI6O9ou3ylWQMKBdrlmqcK2D+OQRHjiN4TnY2MOPymwydFHLDnbDN71uJHZlifSe8Z
         kRUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789027531; x=1789632331; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idTG+kIgG4BE6fViCSY/GmRMddNGdFY103Ar/WRtmPE=;
        b=cU47aJDkfFJmaeKaNxEc2FTZmBscN1a5MIuLC5VRsAuUl44/MIxGXLiApy+WAC8Jye
         pXvzGPcwOlPVWuMAn4xYPAk+lZlcbHjLdoKqiRbrARkAzfuIPkoYzIlLenapU7rH4VKL
         TUvbASJoXF0cK7DaU0v3AP//Zh3IQ7EhMaZPhSDnjLdMf0ssABTvdsY6tjEWEsIUg2vn
         lAGmH0pY8nzW7vwBR/dEA7pK0bAZFLWjm18Eh+NHAEpnfMSh8G6eiYKvVP3mueI2tGud
         WoWfc01Iy3/49J8UKD8+Zop0vMEVll2aEFxf84JuYvxulbtjIA03Ptbf5lBTqTpOtLHK
         MBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027531; x=1789632331;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=idTG+kIgG4BE6fViCSY/GmRMddNGdFY103Ar/WRtmPE=;
        b=jQYQV7/UqXOHLNIUsAv1cvntZFUvTt0KVzfydKu3ImNIA5/Fmp5/f+NpACXoK8lOQu
         VEvlZPiyG0YcrePiJ+tqH+YLnbc8nVzvtyI/ajEIPzg/V42DsQnV1NtvpUZ52BYiLC62
         YpsGIuSIcchVdXFZP/IxM1CJlSiyQAo1jpYkjIIwLHAsiUwSuc/QJTAMmkEYzFXzgPmK
         jPNJZD0WEZH9bqOmpGcFw6ul1VtMGGiTB/fi504akkSMH/Ol1HgjqWaFNWurNbyiXLvC
         Yz22EQsm67GdOfzqiiUuqf3Zon+VEouOdTuUYuoBLsBEOhX8jol2uBM4kn9xyjGk9UUX
         Y3Bw==
X-Forwarded-Encrypted: i=1; AKwUvBy2PMcYe/4MztjG0i/j1UyJPel5juVe53qLKAH1UZnBQifvSoWJKAa8QGNcHuSUJcQvXfBh9baJXw==@vger.kernel.org
X-Gm-Message-State: AFuF++mH2oMWuhCgI1doc67pcyAt3P4wRrB0oIzt7QNVGGP2xWYfr/Bx
	yHwQKz8vgLuKZ22Q5T9Hk1nPxdrYUOVaRJQ6AJwK4/f7OD5lDhfsW+OGcYZMuqCoaK0ZaQ86NUd
	YtcY9jOxsbXeqLQwhpPYE0cdj46HMKXsWPVOnUCRj/w==
X-Gm-Gg: AYBFou0TWdHMxUH/3Wkmyy4z2W0A+n9rRwdRntVAkR6+4r5VV4XrxnY18bzNU0nR2hL
	s5cQHWp6xtno9mBXHOUskMHhU5kL8JPR+fuqUqFAdzFzqNSSE1fLng+p6qCHt1BSfV1BBSSSQEY
	Wa8G5yzXPl4hcbMy9X7jsnT2c/jAcVlrTtudvcJBvSbvN0454DctFew+kaU8oY5sI/UHKqjQCh2
	5RBXH/uIqbZnfW11pQ5WciXdzMdafsF3ac0DwXFuE2VXadkU/uWZGnHuHqMQLxzHBcx/pUzIJST
	eT0Zr5oOO+Y8lF7wER82drA5ihkuOkHZzajJoQncZtkqltz4vxL5Re5o5DjBy/t1ccAwb8ObP2k
	gM3PwaWUTM+Lj
X-Received: by 2002:a17:907:b049:10b0:c28:ec7c:27ae with SMTP id
 a640c23a62f3a-c28ec7c34famr682895366b.25.1789027531169; Thu, 10 Sep 2026
 01:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821073927.455475-1-wujianyong@hygon.cn> <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com> <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com> <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com> <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
 <4e39e935-2339-442b-8b14-a688b605c35e@amd.com> <a9dc111b-21cb-4bcb-ac91-f6be04bc2e06@transsion.com>
 <a2466e7d-2dd7-4de9-963f-6eb8c58d4a49@amd.com>
In-Reply-To: <a2466e7d-2dd7-4de9-963f-6eb8c58d4a49@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Sep 2026 10:05:19 +0200
X-Gm-Features: AcwNN1VH2gMqHpwpWnaAp6twlTnwHZeNCf0JHsNbujw4sKknNgTyNhM_v95_0BM
Message-ID: <CAKfTPtBji8dkr5ixhtZjkyrWLA68TF-KHLrNYWoewPWLyuUd4A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, jong wu <jianyong.wu@outlook.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>, 
	"huangsj@hygon.cn" <huangsj@hygon.cn>, "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sept 2026 at 12:05, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Hongyan,
>
> On 9/9/2026 9:39 AM, Hongyan Xia wrote:
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index b898b6544069..97f4a3ba5107 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
> >>
> >>      cpu = cpumask_first(policy->related_cpus);
> >>      max_freq = arch_scale_freq_ref(cpu);
> >> -    if (!max_freq)
> >> -            max_freq = policy->cpuinfo.max_freq;
> >> +    if (!max_freq) {
> >> +            max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
> >> +                                      policy->cpuinfo.min_freq, policy->cpuinfo.max_freq,
> >> +                                      CPUFREQ_RELATION_H);

As long as the reference frequency used in cpufreq_update_pressure
remains fixed whetever boost is enabled or not this is ok. We don't
want the pressure to change when boost is enabled or disabled only
when policy->max changes.

> >> +    }
> >>
> >>      capped_freq = policy->max;
> >>
> >
> > LGTM.
>
> Thanks a ton for taking a look at the suggestion.
>
> >
> > NIT: I do wonder if we need a full __resolve_freq() each time. We could
> > cache the highest achievable OPP on max_freq updates, but that's future
> > optimization.
>
> Sure! We can cache it in the policy object during
> cpufreq_policy_online().
>
> Jianyong Wu would like to take a stab at it? If not, I can send it out
> early next week.
>
> --
> Thanks and Regards,
> Prateek
>
> Disclaimer: Hygon emails are routed differently in our organization.
> Response might be slightly delayed until my NNTP rule finds the email.
> Sorry for any inconvenience.
