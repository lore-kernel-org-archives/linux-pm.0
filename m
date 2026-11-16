Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794826378;
	b=Hxr/KmEpeRexoyM3aeUIBHAcJSM9GGUrl9CUxc2/XaEOBkoSfGVhVTlBt8gW7HCA5qDs
	 Hct0n8J2laHj6vrmPHpr85k3CirWXTFZF7fnO0ZQ+qN0s7P9olfVFXi9IC2V8TIy8POP7
	 2J4LKGbF1/U7ONzpQYWIe4rL6GBkJAbYmryMXVQVGL56Ep5Nuvd1XYDGjI6el64B23TK/
	 7Rke29rqf5dmDw6z+JQie6QNz8zNN0HRNAafpQjtLmOwdKaaGkkg9+HQFkJrtKg3FVCHN
	 AJJ+ul7HpTucZSylzQu+mRSaeiDprfyQUqQHyKf/Lk/Rl21okk2hh0lTNnrftnL3hCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=s9FB/Bs8Bd5wsc28/znh0roBsQAvM1ySQVBJj73PwBo=;
	b=yjss8ALHHZkQOpXaRKPekUR8X7EmaM9lEMYEgVXjFBkPd98YewG0+VRKXXu2n6qAMV/B
	 /Y+A6r96JhaXp8oszHRb6XXkTJc0rVxbbOHJ7KNrsaaNuqM6rcjRuemxzYf25naLuab0Y
	 t5EIvcxyPxToMpwHg7zXktbNFuQ/pUwS0jY8ZJGT9buzEGv8rYRiecWE/ztJzunFYTpya
	 RpDQq182TrVajVTzTwqZoCm6OxH0VtEZ73gyjo5EC3fzUlr8aZBLxaFfNrSMVW2YgTOIP
	 kM/QS9PMGCQEtqg3gozA8gUa9iwVWfQsSSUzkLyna+AlblhNBMZPtcz7C3ioY+OUhWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SoL0YF1w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57871606A323
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57871606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SoL0YF1w
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d21051042so60419066b.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 02:52:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794826376; cv=none;
        d=google.com; s=arc-20260327;
        b=WoU5fRCLRxr0V+gRW7aosUFESHKgsxQJEC03GRHFDhm13yk5VcIwVUiFiHohefJ8Qh
         nQSe9eMJO8hjgD9krQAT5dKbgo/dMKM6HM6QFvJAuDGJRNxDZtGZTBHvv1qcv6azjPu4
         P1JXxYppN5XcbWIfooF1m+UaTRej5OrB3OeB44qtFEBWjy2xc98u3F7WRWwBB+qDlhz4
         lxsl/cmdf/h7ht+7Y740CenUrP046NzatzsXz9/eiXq2hnmnAP0dBbEQtEpRkok7q1Dk
         dAw3+nti85TR6fwhIZAnKRupo2H5umDsfwXCY3ZkieZJgoSsble1x4TwNSnoFh/steX/
         r5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s9FB/Bs8Bd5wsc28/znh0roBsQAvM1ySQVBJj73PwBo=;
        fh=4+Tr59umgaWBluc1n10smPpi2TQ4w6iTuR4L/PpUxbU=;
        b=pApRV28uV8VIABRKWEsWl418s44M5lD9zy8EUJMHBBHX2MXU/SxvIAnaxrjGX7upvW
         4LwkvgiRRz7kHY8GldAFPE9oI5txVOnjT2bLZddniJcwfzzY2BxBnB8f+muV/MW4Aen1
         ZGF6lyWCV6neRmd0UUvXDXN+fLhEjsoHkIhk8sQ8Dd6R7/TteNqhyAYA8o/6L3oZAr5g
         JTaLZk3jEVyRATfFPIPph3PCl6Ig2+aVPPInZRsVeKY7RYh/2Z4jQ9prPgZ+BAFiRTwU
         oarSpakEkfjA6rOuOzcHqkhn0OuzADfmj4dmcVpkGi56Z+UAZ1t36Wqt5YgAF8Dus9CW
         yj9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794826376; x=1795431176; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9FB/Bs8Bd5wsc28/znh0roBsQAvM1ySQVBJj73PwBo=;
        b=SoL0YF1w67O2J7dNyp48D+VRR2CeInfci74PcgSve1N1zOU87pUt/1L+2JjQv7NWVo
         6FZKjNEDLi6GPBnAoXYDHkmSt8UJipbV0ytbV4La/B79RlFo+y9YqZEf9FBm2TGVpC1l
         8Zz2KlqTnsYNOtDTfPFSNVqJUs3VBErYDiBugrGwQliZ7BSnLyhX+UZ3BFeObWf+LmeI
         cJiqu2lBt/xjTfUpgIhb0urUvMHuyEKdGdcJDLLHO2t8tINlzYOPar49hJqEKYPnWb5q
         AyRJJZ0P3fK/Y/gS4531TsrQ4/+xFEc7MrcWToxv0blPrPrwS+NVsQhLGvXzawNNCnl/
         yNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826376; x=1795431176;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s9FB/Bs8Bd5wsc28/znh0roBsQAvM1ySQVBJj73PwBo=;
        b=W3PI5p6wMkU/IOgLe9Qb36rGjTncbTJViXY46N7nomPJy9IhTSUU9g4R7CwMz6nOPG
         quzoFprVyHHFcngyb8xQ7Klv77ar2qkAvRVoOYL2L50ZUZ8iIvzlgUX9zRLBkAkh3u0v
         O2ugEWpxZ2CphqJYLXRUS/bjsmadt7RzuwUtzZ8uyUMxU7lR6xhd8eqetIWYYH2wSNT1
         lVqL2Ujlex83BxSd7p6hsdh10TI//89GB6e6UygoMgEK29oXHonYAbN9y3HCvV3eobqR
         2H+gNaF57zvjL2keVOCY2oVl1+gmz+F0ROWjUDHk2e+wdQv6XNZo7SdyVrO4qJbbfMFl
         7sPw==
X-Forwarded-Encrypted: i=1; AL+hErFf2veDZvRG6faCI7hfKqmsUS8vDuAZMNXVx6mGMX7nEfUxL5ugQEIMklXo8nqGT9Ks90C/JW8e/A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9srAVeB0E7yJ6+hnmyGuXXZU/zRCjwgfmePdiMTRYL4JCDoG3n
	mM/QGAowZKCkuACPE53v76Q4Vuptxiufd9SkT2PdhmyZVhmpZPZIT9MqOHrUgMbH2fPRa93zYfc
	pOTk4MoKZrmuoOcKTYabhFFAWgJpWShbO75QLwYz/Zg==
X-Gm-Gg: AYBFou0maB1cKXnf4/wq94LnoLsJVuWiniJtY6SpzpZG4bGe4xQQAhIklyuOqlq1Gv/
	PwRy/h7S1ZyabNIsiYi9Fll9S/hS/BcNMhwc9Apwy2mpTQRZSjRuZUPx29IGiDZuyeiEby/Q7sb
	pionAzYim2G52U3AyS2fggyQy7q6+GrLGsv2IfUQJqA1KKD9rA5nG64pVopO4+5QR7koRpNWUp+
	5MpfS7gGV5XVet4PErxUxffczUzpBJrX+Yek+KS3Ey9qjshG9RCyC9niyOCc0Che/1zW0VVcPt+
	NFKsQeOwmyg+x6hwDwsTLxLhc30r8RImpdhr/dreP7tbuEMaRCaIbmEeuoxgxcpH3SQ4mPzwyTi
	uqAgMjkK3j4kFFu5OqjdBaMnm8SyZCBnxDLGDsOAYPNtwfvNMA4JXrufXHKTsReuUl4zRPg==
X-Received: by 2002:a17:907:9492:b0:c2e:52d6:1fb7 with SMTP id
 a640c23a62f3a-c509636a2ffmr724576366b.22.1794826375556; Mon, 16 Nov 2026
 02:52:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108145028.2483131-2-thnkslprpt@gmail.com>
In-Reply-To: <20261108145028.2483131-2-thnkslprpt@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 16 Nov 2026 11:52:43 +0100
X-Gm-Features: AclHuK9cE-Mnx9JYe1o94mAtkN2_2exx_lHlsDO2PKsOefc_zOkSXXwznfhjwPo
Message-ID: <CAKfTPtD5vLv_wqfGxVB7kEFDQmB6BQDTvJRGLkHXNZ3d0GHuOg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is inactive
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, zhanxusheng1024@gmail.com, 
	zhongqiu.han@oss.qualcomm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 15:50, Avi Weiss <thnkslprpt@gmail.com> wrote:
>
> sugov_hold_freq() uses the NOHZ idle-call counter to determine whether
> a CPU has been idle recently. When NOHZ is disabled or fails to
> activate, the counter does not advance, causing schedutil to treat
> the CPU as continuously busy and potentially prevent frequency
> reductions.
>
> Skip the busy-CPU hold when tick_nohz_is_active() is false. This
> also handles systems where NOHZ was enabled but never activated.
>
> Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
> Cc: stable@vger.kernel.org
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v2:
> - use tick_nohz_is_active() instead of tick_nohz_enabled to also
>   handle NOHZ enabled but never activated, as suggested by Zhan Xusheng
>
>  kernel/sched/cpufreq_schedutil.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 14405a614991..50249cc1a594 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>         if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>                 return false;
>
> +       if (!tick_nohz_is_active())
> +               return false;
> +
>         /*
>          * Maintain the frequency if the CPU has not been idle recently, as
>          * reduction is likely to be premature.
>
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> --
> 2.43.0
>
