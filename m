Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDC310645
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273013; cv=pass; b=YIHl53p9xRfaMtapjLk/CjCbWO6Au29kcapZQf3ocmqZlSJmJFMvxkrjjCl3pCKEZvzNvBCWobe3VmsI9Wg1Dd4emsNJC/GqISeNzgeBKpCuFxFEo/73aLKBEjr1ux6W7oyWktqluTlgKIgC87pEyHw45xdI3FneOu96ITyEbM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273013; c=relaxed/simple;
	bh=hO66QjvFvGCV1TK4yqeQYuxk+Mmmppj+GGDoeW2H4xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpNFc/Sz9BjkMHqr/bNUdwegPmlcRdXd+5Ne9+7QHQsV+CJw8HQ3fTPTvddVFs3t7tQL28XAZSF1PUsXvNqwLhgroG1qpS/uK0aBvYxxja0hH6L52DyywI22BvQqtiSbyyYFkPcjX5UWSwZaTqnDPLg0W5zBbcS6wNp7KqYSXkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8i0PAXA; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8i0PAXA"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a61910369bso4957342a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 07:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273009; cv=none;
        d=google.com; s=arc-20260327;
        b=FkMmInWK7+dZYLS3VQaKVLRycj2Y5BPOkvjHKhExGoHbteQYUg2Zi+J0QgonTk8In+
         ze0tqvbWQSKqj6mZtD9tV1zHC+C8jb+NWaZ10oLQ6yaZa0ha+J424qhWj16ISb1QqwjC
         yxpIOwXN2fgBlN2HTd11Jh6Rb++Nh/gcNag6g+4fbolPxu3ecfaI6ph0+8UyR0GbYB3C
         kpxVOR8mbDiO2AQ66+TB8G6RIVpO2D0vsjSQWb+bWVE8YB3TsfOOX69eTmaX8IUHSa3j
         ezshVcr3H5AhNuxYsl8uKJanlf2UYdsbwnfqcrJhG+TKsSUQWLKpd8OfDLrH8Yx/KMVG
         44mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=81FUhWMTlJ+wMcQRgyjk2bEtDAqNufgvrwMi+leycFs=;
        fh=Y9oD8gKf1AYrREWYH7tXHElcVlARrmt71+WpWJZSfRg=;
        b=nJUc0Tu/y1TT2aLJgI9h9EofzCxblOI3+wSq/GMX0rJUd7obyODiQ6F1VQsE91MwTR
         gRU0WXJrxtUQNpx7m2/O/6W3jgJUClqRGsWsRM7t67WoPM0hStxe9YizsFF35HQBucZs
         FgSb4emPNVtXcL1VEVFJn4cOjX903ACTTOUvNnWysI7IfH1r2o/Fd3rMg2omCgLCBQzi
         7+78tue5v0uCSSOGshYpFowz5uHM9Fg9ZjBElDjZiPJa0bVQbT++WSNVXkaq46/XdvM7
         aScXxdtU8Mccq9fJZwRD3QgFDwqSfrZnUG34fNZ9KnoI3zZWs1T1HyLViYethD5VTRZh
         /J2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788273009; x=1788877809; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81FUhWMTlJ+wMcQRgyjk2bEtDAqNufgvrwMi+leycFs=;
        b=G8i0PAXACK+x6b7YMOSSEYqE2ah4sBav28gW8nzr517OMaqMhws4nSJOpQNNmn7zW1
         wQ0/a8VuGvLZTL6b+2OBf4bupxWVabAFolphncNoqCCQU9gtffm8iGSAep3sG+NJWy7l
         gyQLjWQUeNNL3lccKQ6eBbjTtkBycAD6f6cT6ei6GTutS1eK7Drv/VudGrJdjcEeE2Jb
         ii0TUU89Ne4TkN5HNaD0de43fZSand20o59WVIEEAWSH6kj9FunPEkcA6MkOQmqpRNsk
         y8rCYtMIXWe68PRx7aDWHhs9b5jvmRYqEJGx9lhOqmgDRIt8luOtxljjqwfWqJ2Vtc/o
         gsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273009; x=1788877809;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=81FUhWMTlJ+wMcQRgyjk2bEtDAqNufgvrwMi+leycFs=;
        b=Mq6eq1WEbw/KygRMoQCRwnuBrCri+oMOB4VyvxIgssvj/2F/1SsZKJsPXHZVHOgMJV
         z2vqLhMMzlOa7fJxbxyLbsVgjZuBlrUjljC3AxznxmrAtR7qVMZMyqkdpRqoSCw1RLgJ
         ki/HyS0G5W86P3ooaKPh8RlTV+YSrbvlPHoOzZXO0lcinQXbnHf0+V1pyy0J4ccV5+uu
         icA2yWYP88H4l5XYPiRxfrARHoiIotU5y++0B48yYAWcMJUxfQpMD7yy009yn0Xovsch
         XAL41ePsegK/piTt4MT5v3x7zgu0qApCGhQ1oCHRcTVBGluO+6Z0gwiMdnuYxJdUGLKn
         4Vqw==
X-Forwarded-Encrypted: i=1; AKwUvBw1LH+hlO41jhycZXvb9m426vOOkhruCNDPPb6GcEd7WiFLRCa+JMTofiSaVpIhYnhqckzNd/Yt9w==@vger.kernel.org
X-Gm-Message-State: AFuF++k9MxYK4xgcIP5elFkOp047MohUnHH+5tKLMsa3TKxhb/B5Djmg
	R6sxVchZbz+6V6g4FN2Hi0epFCUfQcC4Fc1e6c1D2/tdSwRpgLnSJH2MBIVlz2kTJil/YTD9RYV
	jYj3wYn8hefoQg+lcOMg7D8Bxp2rcSJA=
X-Gm-Gg: AR+sD11Br4oN2wn6xE0Wohc0Gmtn1rMgObWWOv+xhNcNzhaAv1ZUuYiZVkl2lN+wLZ2
	hzFowHzls65yn69iBXzP4SUy9QlqX5ADPNVOW1oxz3CLhsoTeazrmtci5d38UpdO8Q5M+YtYHea
	j/VwFmDUcE3mCvRl+WRGOg5CvjFcCuvBkdgcgOo+uEGrXuS9vclgbWHG6n/Fl/p+DV+mdTL2alc
	zIrhPmUuGYiC4ce2zQLqmd+UtqZ1KIWyUMYq60GYASHulI1ZfVlNgkmxcgS7GnWtrlJ0mah34TM
	z6nvJq8JxSxT1/dQh7U8Mjo3yhlFLmBbOwnE5/7CM7GQMTwWd3qSP4B3ggjo7SysFQOMI8kX8Kg
	D1QB0m7yEUaJ59UYG+awBQcOU0+GxRsTo8XI=
X-Received: by 2002:a17:907:c1f:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c25b3d6fd4amr496747966b.18.1788273009053; Tue, 01 Sep 2026
 07:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
 <prxk6xpxeoebz5da52a6bjgmaaop6mj55eemxdm5cjxm276tyi@jfeziqcrxtfv>
 <CAA-+ukJWFm1YOoWTO5TmuF8ymNuRGtsvOm4zruwUUEGpcmKNjA@mail.gmail.com> <as35xamspfwpmbravcz6g4miz4nfotgsmg5afchgudoh6fd3kz@kbp7kotpxyet>
In-Reply-To: <as35xamspfwpmbravcz6g4miz4nfotgsmg5afchgudoh6fd3kz@kbp7kotpxyet>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 19:59:55 +0530
X-Gm-Features: AcwNN1Uomn3Xc_3Adcsk8DWFI-MLIGjMbU2Tt_GmbXn_JHJipzIc1HtCVCNKh-A
Message-ID: <CAA-+uk+orBPf3uCpwyC02Wnvk9mzChukO494wuPfu2r5PpX9dQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, radu@rendec.net, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, 
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 19:51, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>
> On 26-09-01 18:22:34, Sreeshankar K wrote:
> > On Tue, 1 Sept 2026 at 17:32, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> > >
> > > On 26-09-01 09:24:35, Sreeshankar K wrote:
> > > > This patchset introduces foundational upstream support for the Qualcomm SM7250
> > > > SoC (internally codenamed Lito).
> > > >
> > > > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> > > > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> > > > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> > > >
> > > > This patchset is organized as follows:
> > > > > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> > > > RPMh clocks/power domains, GCC and cpufreq hardware).
> > > > > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > > > > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> > > > interrupt controllers, clock providers, power domains, and reserved memory.
> > > >
> > > > Dependencies:
> > > > This patchset depends on the following patch:
> > > > > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> > > >   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> > > >
> > > > Changelog [v9]:
> > > > > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > > >   Make all clk_init_data instances const across the driver.
> > >
> > > You sent 3 versions in less than 24 hours. Please slow down.
> > >
> > > Give a chance to the reviewers to have a look at each version before
> > > sending a new one.
> >
> >
> > I apologize for my actions. v7 was the intended new patchset. Unfortunately
> > there was an interruption during submission of patches, only 08/12
> > patches submitted.
> > That's why I submitted the v8 patchset.
>
> Yes, and now you have sent v9. So even without the v7, you still have 2
> version in just a couple of hours.
