Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C525785D
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353823; cv=pass; b=L/JE5OlnFo/b9Ivoy5buFI4ptoxZB5/DQW4RR23nB1gwAZlBxsYaAvZTjp/SrAXI2kX48ARRtOmsNF6DVsP2XiVkxhD8vdDJPP2po2jJALch+xAej1cslhG+Irb+ga+MoINnVDpSUrZDUR5oCvxnmPEVz0R12chCfzAkcZthezM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353823; c=relaxed/simple;
	bh=xht2//06apJ5sa0rNqEN/FMso5uXuLZ/poM1328nqeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOVfVpZzNlO18KfAEVX/r94KoRigkC2cX78LvODn/2J3TU3oni+2wf/w23b7/dVYN4qpo5xsWAGpZSmxhN5p2Cr7FgP+YoqBnlmvr5Oh7tNm1jLp8b5IuAbFMtyb5DB1JPbbEzb8WIQr/lm32FWxLfoP3I+YcFudkibwHZeXeDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icbp+Uft; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icbp+Uft"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a7bbe9d0so39166941cf.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 05:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774353820; cv=none;
        d=google.com; s=arc-20240605;
        b=EUk3xbm2kmvxt+2cXS0xi4Kl+uCxNyLErhg41VZa3wqcY0Sh9kTdtUNWwVxZhL2QXH
         hroyIoix2HYHBRe44l0GrjNYjgvljkkNPQLH2/74IsOI+0DPqnV6pXQu4ZHbvIkZtkuD
         HAeyZ2H0y2Uv2/el+Ggd8k0LZJrGkiK/I8HxoHdOUt1RAxJXo8nL2qXYIwdrGy19kUc8
         eFmNiz5aEvwWeS/EsnB1uWuwOEpaVePw5/XMVePJkPSf/20ZdNBMeLnn4p+j4t2rdh1Z
         2OjK9C/nqZY0PAAv/WCTZtAYCsi/40AoJi9Sey74oS37pwy4/TDSnp7xcbL/o+LmTjRj
         YeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xuwQvbZgeHRDoxB8YZdL4R9Du7ZDiP5uzm/KqRYSGaA=;
        fh=78vpv8B9iPc2/fH1nG0o2GGk595u6xgOs3uPOvOiY90=;
        b=TGvRPm5oZOC+tR7jHHhUp/G81YQlHoUZIfC/Bd1Z3M37UGT+fE3W0sx3FNODsg3flQ
         ATmcjwvaH9ndsk07sZtkP3g1SLM6o3lcIw0plVg2Ckuj7TZxY/YuQeL4N+gQ8mKXPae9
         +rRRAsP8G9kD3JBuzylzoWA7rrxf/tesFMgqpj7YAZraZM59HF9LMyDvCCTkmqJ+YMht
         l3/KsJeJft04K1Ke8tdWKAQAGEI1/rNyCY4D3Cs3u0n6Gr9KAMGq2p9uNc0/lOI0u5Yc
         8tcst82kK87MNzS64tMxYaf6NoMY1XsPe999PSeVioy0en99fxRQVr9SD4e4STcXnQ9H
         3Wnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774353820; x=1774958620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuwQvbZgeHRDoxB8YZdL4R9Du7ZDiP5uzm/KqRYSGaA=;
        b=Icbp+UftoKedEP+N919TqqfnFiINVP4bY80Vi9H3JRrn5VnhYs2juSQ1IkdTLQpGeB
         Ye0d/7NkIiANR2Yez63mg5NRGD5KdSmy+R1KmbGvEYenpVXOH8ZVEfRKUV8GZIvB+bPI
         7Dm7zpIKOd2sBOM8qL1JAhAjV0y+FDlAWA0I+XN/StAxO0qAU+h0quV255q5QPfaxSS3
         AMivR8d2O8MdGOsLCSVvfOPnStvsxVcqYmWoKODAa545cHKGcJwBVECEfP17lCWuyxlU
         7iBV45yN8Od4Ilk1G9Ihwu2iyqK4PPsYHSw3HoPak3UtKV4cuTtXah/uKRzhondszdc/
         W7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353820; x=1774958620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuwQvbZgeHRDoxB8YZdL4R9Du7ZDiP5uzm/KqRYSGaA=;
        b=l1bdJ/PV2LUXwz/wMHXsUYYhSqHoxBAfRGXpvBuvR58mxCmK4anECXXwDu2ogHGGm5
         iaz0cThlhda2rpZF5NSGKYQxDPbLNcNyEkJ8qrR7IR+XdszlfqG7ZVeY97KFbvFG9wYG
         ZN3gATQtx8OPOI9+2qwqLqZfHJ6l59XMyo4BSfxBucHFB0fxQ8skrpCMHy9XF7eZCFTh
         WaonOBFWgYWdCaG++h/4KYbHpSgJ6blMUpie0dO8dB8ks0MmMnOWMCcKBTHG1YgrVQIY
         z3O++0tm2FMto2gdD4bUT625mi9wkHP/BQPa1Gdr8qZ/BnUazbDHESZsgmOqD+wj+Tsm
         cvyA==
X-Forwarded-Encrypted: i=1; AJvYcCWEZF1x87s7GMx/rZy7yJDyJuATZ2LCx626xfz6sacWr4kX1JItFmGZBWUfN+9kXxJbm/8+Ss2W5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aqp8lmbe8yeiuROBJNwQHem3YXAadYEjdcetL97YK/WLNwTu
	dxCRKsNvBivOq/jZbZ5kIy775R//HRaBoY09cjiHWCquCh79cElpoCKdealB3xwhrOTanxBvLDN
	calSmkJi9cTAIySf5lg2PpZVKj/C6BSY=
X-Gm-Gg: ATEYQzxcsnqan2IPOJ/UXfM/VBaoq0UNl86T9qBZbiDRJDVKK/0MzblXdUw2Wwnbb2f
	Ef9fW9TEc6+pPyMAHOjGNOK9iP6uKfOwG0U/97fleJgbKorupqW+E7ayt2aHmLjMoFg0QD0gKow
	XezNT6FfJYlJTz9rAdPgoWYFnTt7dKEf+5uVRSL5Oexv1Pn8Efw7h4OFcrV85m616NFiu6m5LOW
	92bq/PIqFVpyhOFTuXm1Tr5wpEdd9KeKitdkpKGEgVPK7E/y1J7E0EB+qVfSACN+OQtbcQNZVNz
	sh3lFaaV
X-Received: by 2002:a05:622a:8e15:b0:50b:33c7:5d97 with SMTP id
 d75a77b69052e-50b374f5c91mr221708461cf.37.1774353820361; Tue, 24 Mar 2026
 05:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320113148.7308-1-xuewen.yan@unisoc.com> <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com> <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com> <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
 <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com> <CAB8ipk_7MGUza9_izMypMxPFUjAoB34ZZp0-ts4w6eJ+tr+MDw@mail.gmail.com>
 <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>
In-Reply-To: <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 24 Mar 2026 20:03:27 +0800
X-Gm-Features: AaiRm529CioeCv2wAkTMW67vGkmaLJzrBEh645HIXNHAypmBn-ao8gEf8RRAPg4
Message-ID: <CAB8ipk_VftSn4U+Vzdv_ST7apiONVoYy4PTe7usRetXry6uSOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in get_load()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	di.shen@unisoc.com, jeson.gao@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:45=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 3/24/26 02:20, Xuewen Yan wrote:
> > On Mon, Mar 23, 2026 at 9:25=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >>
> >>
> >> On 3/23/26 11:06, Viresh Kumar wrote:
> >>> On 23-03-26, 10:52, Lukasz Luba wrote:
> >>>>> How is that okay ? What am I missing ?
> >>>
> >>> I was missing !SMP :)
> >>>
> >>>> Right, there is a mix of two things.
> >>>> The 'i' left but should be removed as well, since
> >>>> this is !SMP code with only 1 cpu and i=3D0.
> >
> > That's also why we sent out patch 1/2; after all, it is always 0 on
> > !SMP systems.
> >
> >>>>
> >>>> The whole split which has been made for getting
> >>>> the load or utilization from CPU(s) needs to be
> >>>> cleaned. The compiled code looks different since
> >>>> it knows there is non-SMP config used.
> >>>
> >>> Right, we are allocating that for num_cpus (which should be 1 CPU
> >>> anyway). The entire thing must be cleaned.
> >>>
> >>>> Do you want to clean that or I should do this?
> >>>
> >>> It would be helpful if you can do it :)
> >>>
> >>
> >> OK, I will. Thanks for your involvement Viresh!
> >>
> >> Xuewen please wait with your v2, I will send
> >> a redesign of this left code today.
> >
> > Okay, and Qais's point is also worth considering: do we actually need
> > sched_cpu_util()?
> > The way I see it, generally speaking, the request_power derived from
> > idle_time might be higher than what we get from sched_cpu_util().
> > Take this scenario as an example:
> > Consider a CPU running at the lowest frequency with 50% idle time,
> > versus one running at the highest frequency with the same 50% idle
> > time.
> > In this case, using idle_time yields the same load value for both.
> > However, sched_cpu_util() would report a lower load when the CPU
> > frequency is low. This results in a smaller request_power...
>
> Right, there are 2 things to consider:
> 1. what is the utilization when the CPU still have idle time, e.g.
>     this 50% that you mentioned
> 2. what is the utilization when there is no idle time and CPU
>     is fully busy (and starts throttling due to heat)
>
> In this thermal fwk we are mostly in the 2nd case. In that case the
> utilization on CPU's runqueue goes to 1024 no mater the CPU's frequency.

Haha, indeed. When we debug IPA, we also keep the CPU constantly
running with basically no idle time.
In this scenario, we tested using both sched_cpu_util() and idle_time,
and for thermal control purposes, there was basically no difference
(likely because the load was at 100%).
Maybe we can cook up a test case where the CPU is overheating despite
having some idle time? That way we can compare how the two interfaces
perform.

> We know which highest frequency was allowed to run and we pick the power
> value from EM for it. That's why the estimation is not that bad (apart
> from power variation for different flavors of workloads: heavy SIMD vs.
> normal integer/load).
>
> In 1st case scenario we might underestimate the power, but that
> is not the thermal stress situation anyway, so the max OPP is
> still allowed.
>
> So far it is hard to find the best power model to use and robust CPU
> load mechanisms. Adding more complexity and creating some
> over-engineered code in the kernel to maintain might not have sense.
> The thermal solutions are solved in the Firmware nowadays since the
> kernel won't react that fast for some rapid changes.
>
> We have to balance the complexity here.
> Let's improve the situation a bit. It would be very much appreciated if
> you could share information if those changes help your platform
> (some older boards might not show any benefit with the new code).
>
Understood. We appreciate the balance between complexity and accuracy.
We could test these changes on our platforms and let you know if we
see any improvements in thermal stability or power estimation. Expect
an update from us in a few days.

Thanks!
---

> Regards,
> Lukasz
>
