Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F1323417
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102578; cv=none; b=lJyKQJbAesSfjLTaqzhhKFCzhzFxLDkNcQmhi7dmw5cLrr+a4670xCJK9b9YiF68X2McTFVYZ6RcBPUhsSzBPqlMocwa/GpUQS2mvVYjzzFQlPjwL+8NKd2nt8tJQAjl6xpvNWPQt48QI2iM+JSk9P57DuOv2GEIlRnY+pVjMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102578; c=relaxed/simple;
	bh=tHaRnBkHGDwxe27vTn4OgEjwyrOSNdq/sa3ntNRDUrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azjg6wdtVEIXZJSBzKckTn86j0MN7h4TLG5B+WEWWkYYc2oj81gh6CUcRw3Sniy9FFVMwGi8AA3z3NO6ORLBZO0jwfwnN10bpSqAV9GnY1/XuF/5CxCxWdHrMrJoK9x4ag81VQvVrZiefF/vdt9Sn8VQ+smvVULRFCZnJf5bOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHwECOXa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHwECOXa"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso487070f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783102574; x=1783707374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vsSwgqydI0TUTd1LdM/qdllikjjCJsaJszfdOZPreSE=;
        b=WHwECOXacfOlaFdVXkN4YzhO4D6o4cjLpP9QdnIb10K0/XQqjQRQrcAOmrou58QHlj
         rFYMA+KOGIiJunbI3hoJTotQ2gu4haGYpfWRqvSXprOYB97UBOSZj/S5eJLNgooT8ze1
         8h4r9G7Op/XhAjuoeaxOog8U2MPjcnzkzyaUaVjsF1w4/eCyaOAhNh7C2k6XtY+i7vB0
         txYIe1r4KDL6POc+hVQKh54v/F6L7c6RMaPCLV2ZeKjRW6JbgIaQbUlBAzB+PxQVF3lP
         YrVMQbCm8rYFnh+CYYc2UFWSVpqpNOGeLHSaIlBdw8YM4ovnxp93oBkfXtcgXvFM/Q21
         YvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783102574; x=1783707374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsSwgqydI0TUTd1LdM/qdllikjjCJsaJszfdOZPreSE=;
        b=YHpE8t4QSIwJBA+J7N0JiLIH3i/QBpuyK4mVBloQV4Nn/321eTBEdyaEXSVZswHPDE
         EgIRtOvxnNNShjo2Z3Sq+BbZWvfER4Ih66Bt8qLbcBcGUqrkUgfntumiDmK1RxqkNCPg
         QO8QauyDvHmLkaZYr8c9JKbOBaBEkdAFW9ATx57ZzAtQITkYTgAQJ/xdeH7EAdDlLvRb
         2H936kCQdGf1H3ph0hk3omTS+r5XYHMOrIMPOdcXiZHp0xVdExtlUbzoOPV0k+qEQ+d5
         SxsIo6qpKOSUg8NxpYJ08a5qGI1RX3C+zbdbY59RJPHN6E7idfWUkqWmDFfd5TkLE0dW
         mFZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9WeDAqGwLqtx59rfwWAZ7O+0mkxsClzc05nvcDk7Ar+vYqjqFlwA7fAs2WI1NcSB4C3FF3S6tXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJBHpFRZHbmHGxRMYCFPnE2kNzZdhcL9jmIiBdAZUtk84WxyC
	3z1sz8M+u+UHZYfhHDRHLHE/MEkTyQ5Rc/pHfuZ2DKwWU+3TIcyWkRtd
X-Gm-Gg: AfdE7cntBzYJwQui74mQ+xzRiItFY0azeVG5vmaeF7KxOwFfl0IV4nz3eYqfb0tdfQc
	9OdkWHoceZvqppSYShbBAkO+Znbx6AZDN6y1UslM1usKeHLCog8ALaAIlkDQlQwvF/+Qubvtup9
	f7HmhQwRaGb5hjoZ8CIqRsF7GUd9bbJT7BogL5z4DqZQbFOWCpsvCotEVV2pLio85UyV00dDtUf
	5zy9ycgTWDcrkp2Ns2nov/g6e+ofNorETCjjhfs8I75ReeP6ut19LMTOOL0nhoCFYSpUTeMTSui
	wwTqYEyy9enj4dlw2oQDF/32pCm/Owjq7JnoHN2MKqveYpSEQ46kVORo0Czi5+sn7Ks8jEireAL
	7uFV6tyqolpiz9pwCeMrP29U4v6hX4MW7AV8d9Emk2i37YSrzlE2Et2xE4zwnGEEm7vzqXw+yIU
	XeH0KXLvgH+ZvQ8kps9sU7RKC1wcXruiZdn7weXZ1bGgOgv89Gm5d8cu3kWvBux4BoV7SIuw7H0
	WqyQB+9
X-Received: by 2002:adf:f3c8:0:b0:470:a7d8:75f5 with SMTP id ffacd0b85a97d-47aab77041emr390229f8f.42.1783102574577;
        Fri, 03 Jul 2026 11:16:14 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm1195806f8f.3.2026.07.03.11.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 11:16:13 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <92264294-afe8-4752-9f22-2b633373b288@gmail.com>
Date: Fri, 3 Jul 2026 19:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 14/15] barrier: add tests for
 smp_cond_load_*_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 david.laight.linux@gmail.com, broonie@kernel.org, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-15-ankur.a.arora@oracle.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260702013334.140905-15-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ankur,

On 7/2/26 02:33, Ankur Arora wrote:
> +config BARRIER_TIMEOUT_TEST
> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds KUnit tests that validate wake-up and timeout handling paths
> +	  in smp_cond_load_relaxed_timeout().
> +
> +	  Say N if you are unsure.

Could you follow the kunit documentation for the kconfig entry:
Documentation/dev-tools/kunit/style.rst

Specifically, these two guidelines:
1. "be named CONFIG_<name>_KUNIT_TEST: where <name> is the name of the
test suite."
2. be visible only if CONFIG_KUNIT_ALL_TESTS is not enabled.

- Julian Braha
