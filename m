Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A743FF89F
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663150; cv=pass; b=ITzdpGnJxrbWHyVa6+czGByNUjDIv9QAL8hE9nRNbySanqLhdRBmt+oWQk94C13+m/7Pkrj23Jc2gdPZbrWuA2uERQr9V4Rib+EcB30goWNHzIVGZ6S3OueHmZPCd27Iv1nEBXn3V1Lns3hBdAhma8M9IjKjcGi3PIDMFbt1GgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663150; c=relaxed/simple;
	bh=9DV6fUySyu0fPPG5ZKiaYwk7IdWQDg/HJQRQydzcKAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ3jcmM79RagbtxN6liLnaO/K+THM139F1+beKkeNK6NanMbi5v6gVFipVZkXmysDqEpAlDDDP+9YF1TkXTg/zAUGBiRfwKy1t44JvwwEtyp++3+46YP5w2EHgbzud5BlllOSl1CQP1KGO/yq65usPV6oNWmWNUqNiyT40Jm9ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAiS1laC; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAiS1laC"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec3b429a3aso4339320a34.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 06:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663147; cv=none;
        d=google.com; s=arc-20260327;
        b=XYhkNaLbvtzSYJyH6P6EJYNvf38E0DvkT279JYEuIVF/pS5c5DBCm4NAOgZwtPdg/o
         4IlQWDp4gt2cF3Vk1WcHV6G80+2r8AykNH4fTFMpUdRUaAfgIc6stR/nXnni/CM2JM9v
         3Ta/3Zu4kb3zjYtNVb8QsJxbiWRihhQUJhSTk77aI3JkkZit1fMLDAfhxAddFNJ66LWn
         CPIXk0MlOJL0cThte89Fjedor+QSNKGssW7UOvoHpJmAoDiejyFJMEupbH3B81ExA6o0
         9PcYFfnue12PmJHoAqdkHvCQnnhdT+I8egCNMGSFgnqONOA4OTyhuZEwPrmHneozUghU
         jgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H8+A9U5NujdwwlfLoLIBho3eUDHGlakAhC5OsH1+nME=;
        fh=8sz3tBYN2X0ykRqKEupK8kRHUrULWNqZGvwDimAUxR8=;
        b=l4kJcBzqsHW7tPTp3nHAMOEAMVTzO0kU8yo3ZJC22uKVN9QaiOzYtaZZYlI9G22ZvX
         1F2icARLUaR1QLpWahJ2dM3decFVxsi3fzKN56cGlOOqNKJg7puqrOsGFsNP6DCjkIWd
         MnGTr4mG1NYlHFjtZBBEBMVyEnpdP4FfmyQ6U5heJnksEAKI8ritnYHhh2hIaQ7Cyw7Q
         +RgHg4DCF6nRcYIwbIlL+SfCFCYRsb/xC7Hnznr0EagGh4lAZ6mQvelveGZZ5MzjVNji
         NlGQ1wO8El5zrIDR0x6iqKqCrVxzPqPC6LZOtstkDUDPMpM7VUC81xDj0hOEQZTBF/qG
         R90Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787663147; x=1788267947; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8+A9U5NujdwwlfLoLIBho3eUDHGlakAhC5OsH1+nME=;
        b=mAiS1laCsJl0qXMLSyuTqmxjsyS9YJVpwI5khs5L8YMfH1PMvO++XdZ/jHyXMqXA07
         l4dD1DsBibJwc++eb8A6sCRknV9RrZvto/qh56FSWstRoB37AjfAXGtNwKtpJKLz8CwB
         J/BS028DEwcOIdfL9xLrs9c3VIzkau1m2EUtqX00mjrQQ6WK6WGuQtdorAqEC+4F7tf3
         mi7Mz4pjwYfdni+biFwhk3ejRGcjiiA0q7296nmCWQ8ncGC81FP23TrN13rQqjZDCVg/
         9xt/VuseyqDRNx7KeyMr2GaDa0Jvz51mmDbTtGWk1Qx0dUzwz5upq3oiD2mwLWa4FXGQ
         JXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663147; x=1788267947;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H8+A9U5NujdwwlfLoLIBho3eUDHGlakAhC5OsH1+nME=;
        b=meMu3LHarIC1KbAIrhvrKn1lITEgGQtsb4J8Mnbbl4HdCSz09WBsviWlD71IIm+NdR
         xtiA1WO/t/TQpl9GDPZwdZTPApCZRc9/I8f9bwtDpRy74sDn7HlnzRZCBN1OYD/SBjzj
         AulOqH0FXm1ohLaqvOrpEDoxyCTsZJVf4OCwovFNHn/f5KO4xAOFKKDrSBIkjW4POP8y
         OyurA/fQFsL4D6PzIoT/MIGtYPGAzmqTxf2bZaoebP0+a3N5MCMN1EPXAcCSVGNkuwhH
         MkUyosSaSt5Ev/oXNuMWeLtarVbjxntoqUzQUVfUDGojat8ITfKPUcfZsKzWUZFlnuDY
         DyjA==
X-Forwarded-Encrypted: i=1; AHgh+RrulT8SQoTuF39Tb8tHG5ptnyfZ0om9GbP5yk5bosV13nZ3kiH2X6sDwZrsyMoQeR3EwVTuSlbWNw==@vger.kernel.org
X-Gm-Message-State: AFuF++lw7X+17fkb014zYErXGJRd6xtQ97YN/XF6H8xc1Uzu9jAUG6FD
	olGiMkCyK4o9zLok9kPv4nQKZEGLjtP+9X3gi41l/kRv3II2MwIDW7cgSdK2B+92NJ5jrlHjElK
	2fzPqwDOX32sAHpGI9gqjjKEa/gEGvfR7DIlH56OusA==
X-Gm-Gg: AR+sD13AUcM5ODaXtRZjpf5VtIciLXW3AySqk2U3UK2AOdw/kCshT65aetFf2yBCebP
	llSiJXocSzxd5RgS+L5AqjMWn7TOAZT4j44ONj9AG/HDDfqR2JU1LIDUmZa1lLL+B6oDg49lt0V
	TsE0LPCqbHi4Xirr/ue2zXpUrnvNTTC8WlLqbR/o7mgxrf3tozffJVEH4PuFdUz2GB93nEyNi8S
	NkblXW1dWmcrlF+9Yq7hGmPwYinRVN8BvGLajrDteR6kYgk3k4jkDCKTAfP/LWhYP+IokZGP35H
	Uf7CS8zyd06jnwwjw5GpOyt95X/+XfVnzngfKjya5M3VuIJqA73xYYg6eQMkU1SKWyDo6LQN7lH
	bYeuce2XwbAlnYQ==
X-Received: by 2002:a05:6820:2d05:b0:6ae:42c7:ef83 with SMTP id
 006d021491bc7-6b158fc84demr33017702eaf.0.1787663147471; Tue, 25 Aug 2026
 06:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821073927.455475-1-wujianyong@hygon.cn> <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
In-Reply-To: <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Aug 2026 15:05:29 +0200
X-Gm-Features: AcwNN1XAun6uf_-uzsuAQY8KIifnEq5qRJO6ALHdukG7nygqZwgGwrvEJ-fcnMo
Message-ID: <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Jianyong Wu <jianyong.wu@outlook.com>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>, 
	"huangsj@hygon.cn" <huangsj@hygon.cn>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 15:06, Jianyong Wu <jianyong.wu@outlook.com> wrote:
>
> Hi Vincent, Hongyan,
>
> Thanks for your comments.
>
> My original commit message did not clearly describe the concrete issue
> being fixed, and its explanation based on frequency invariance was not
> correct. After looking into this further, I found that the issue I
> observed has a different cause: the cpuinfo.max_freq fallback added by
> d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
> cpuinfo.max_freq").
>
> The commit message says:
>
>   However, in the absence of arch_scale_freq_ref(), it is reasonable
>   to assume that cpuinfo.max_freq is the maximum sustainable frequency
>   for the given cpufreq policy.
>
> That assumption does not always hold.
>
> On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
> autonomous boost frequency, while policy->max is resolved to the
> highest selectable _PSS state. With boost enabled and policy->max
> unchanged at that state, the measured CPU frequency can still exceed
> policy->max. Thus, policy->max does not represent an effective hardware
> maximum-frequency cap in this case.
>
> Nevertheless, the cpuinfo.max_freq fallback makes
> cpufreq_update_pressure() calculate positive pressure for every policy,
> although no effective maximum-frequency restriction has been applied.
>
> The underlying issue is that cpuinfo.max_freq is the maximum possible
> operating frequency and may include an autonomous boost frequency,
> whereas policy->max may represent the highest selectable _PSS state.
> Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
> that the available CPU capacity has been capped.

IIUC, cpuinfo.max_freq == boost freq and policy->max reflects the
correct highest frequency reachable by the CPU when boost is disabled
so the cpufreq_pressure is correct. But your policy->max is not
updated when boot is enable and doesn't reflect the highest freq
reachable by the CPU.

>
>
> Therefore, this patch checks the wrong condition and is not the right fix. I will drop it.
>
> Instead, I am investigating a fix for the reference-frequency fallback
> in the cpufreq subsystem. One possible approach is to use the highest
> non-boost frequency-table entry when arch_scale_freq_ref() is
> unavailable, and only fall back to cpuinfo.max_freq for drivers without
> such an entry.
>
> Does that approach sound reasonable?
>
> Thanks
> Jianyong
>
> >
>
