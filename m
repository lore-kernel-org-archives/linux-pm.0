Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F9373BEB
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316532; cv=pass; b=lw7NZApegIGSulzcmU4lcs4GL2Groj3DJN4d86dCJCvJ92ZBWbz52MW8rjR9ylsAZOso7B6hhLUi592c4Bu3T1J5E8WVfbEVOHUTK4Du3Cmn9JTetR2ycDb8LwOk2rwZ11fmuwwwjoPMTOFxfkQALCdcuuN6dWxIOwJhylGuUw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316532; c=relaxed/simple;
	bh=r7y211ubp3omMELp5KqhHWQhgFjAYpzJD+K9D8lTZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmpEc+bct1z6hOwQxHh714SEUMgTbyfHndy3eXo3HZBAOoVqsk7/6ywLKpFLiMqBiiKxsNenHizEMz2txmUMTboiGBBJYgze4UTr4U5s3UEFHigloxlGHohyUzcgNRVbQnnVRWAAEpBadfurkmfqH9eBsiZTB5TdomHbwEXHZ+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKs8pDCn; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKs8pDCn"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so702578f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316529; cv=none;
        d=google.com; s=arc-20240605;
        b=WFYnqjFUGYJ5HU7yM3Dw38597RJ7xQzS6nkCnsIq7/ZavtUhnuEPahlETMCY6xH5ob
         togRvLjFGxsr5s2Zyd2mYyMr8ACTleSSp1k95L2QvUsqc+w0eivbXC+msTWNhSpkbaej
         TzODjd5bm9i3H7tJcrqCuFn5+0QEYkmu4zamtYa1HNVQn2EZzATMvaev24R7ckjeZnpF
         MN4bWSef93X0PL04gHMrgCj375RgVQz3aWPC74xUeCIMm7UAFP7C0u4Lxdx3ymj1I1hc
         Q1q5TAWNgG6tHDdNKSQtVQeVXlunhmT0X1p57FIcvBh+cWLPxB5kVkQnjHA/IWscRYio
         BjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        fh=Y/5gjkD2XuxcujArqo4yyIlFPuEe1oEVFszU28Y8RvE=;
        b=WcWrb3sYkBAe/2tFgth9tMbd6yi1FBrKRKTKz8p4RKJdv9poXJPvyCyzhUQFt8pgdz
         Z4ZBXu6hQTLKk5qr+9HYvCiMSKe3oiSlidQMPHD60MwQacKim3KG9EK/bni4pYzvJB5b
         EUUpJ7LhjPIJmAVSkE+G9kXgt4DoVA+6MBDuhWt7ZkvhySw4dWQYz+YTs5oWjlk1pP/f
         luRTOOWm4QdqMhSnY3Iv4E1gaUy/2mGI93WC7hRxmhRdOxTuJZen0t3j35fmqeCWRCVj
         ch10rGNUcGNj4pFtT6rj6lznjFUnOEKBpP/oKEsEuCRlP9mzmiOc3rBImFrFaL5QfOFy
         WoXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316529; x=1774921329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        b=HKs8pDCnsqZbg+efqRElU/3hk6RLrt10qQMxA0BouX8bW2WiqL8v/8xhFzltMnQNA/
         EsD9dCLiUldsx+eUvYw6Z5eIlhOe0gtw+6qGIxgauhtJONqcqpyU2kJa/g8RDRVtQtY6
         9vj/mTdgeMLpAPr+spnh9AN+CQLdMklT784IMUbZAST9HZbfXCSbUjy+gPp3+T6msxwD
         87opeLCtObJYEKqRLDR/xi3rVnZ4rFQiL1j/AmA0dH7k4ygujsBuFnuGOunRkOoLlbRS
         2R6jkrDMryrb0uTEJq2rYcj98zFn6vxOqI8SpmL3aQ+xOGBL2g9iQMEkvIVVPz6ovjml
         r/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316529; x=1774921329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        b=r02jWhFeFNnag/N6WBXSwbkCmCTGoyjhEUcBREKEm6Hbr7/UCrwbaUUhxqogOBVjfu
         0Y90oFVXs1n+nPBFopj99qirKSBgn8FASMMKhnDBZNALoWVDNrIsVXlaIO8SnU4MYapL
         wdC5kX3MYJ0Ve0KKjU+tt1lgstAZy08SNzg2hCqMeUJ4Jc3FCxkVIGiZg7b6Z5uOz48l
         d07bFN+3qAIPr8OC7uzEo8OaMzAvIZQZN9L13wz2XJAn6fa5/OftfFThfYNXeec7Efyw
         os3/qXIApzrnhEtCtbUtyuvc+3q5Hfc3EuayQryrZHnDWm6ks/15mk3d4eohPexFu05/
         PDWg==
X-Forwarded-Encrypted: i=1; AJvYcCWxeD57im+PchN32IBDBbQ3y7W6nBuWsXaJIUb8cbPCOfVGotACOWdLel1Ra52JZXaZBRYBJ5nHnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyegvHEAeKO93ETpfQYAQ88dglZG/LvCuXLhtv+vKNHiVJFiwr1
	Hf1Iatfo18mNsOiT4xTyMKQfO9xwohwtz3C0oj34UzcppECNdhnhaX8c0uNXkMib/zMgEI8wQfl
	jtcVeQKrs+ZNe5ANYOBCQYxAVwBYh1oo=
X-Gm-Gg: ATEYQzyQRT+jwoKfx3qDXMoqtG45H1rVFwIf2fi2jQMMnE8iyWLJMLpPKgo12Qd63sY
	sAgU4u/G6HqPBc/g5uu/xCRI2UZpPXqltG7FQmNiS8Z8RN7xJncqtUTzY5wU/cORargy0/3rkhi
	ZBRpNhJEME+7l4hZ1C4Hjs58kY91LBmwQCUbIWq20da+AfPEgpxNj6KBLPzkmKiWd/EBD2ecG+7
	b+UJ6Sf3Xn/VYxXu7tGQbDffU7tIlDXK4F2E+D9T9Ebw2gHNC4aJ3CWcE+mJs2iAcpXbHxpUWzw
	7fMskb/URUCTZ8L9I6tbMnA/np7eQ05ealykt2j9KzgbHOlB9u2UG6hQaGg=
X-Received: by 2002:a05:6000:25c1:b0:439:b3bb:2777 with SMTP id
 ffacd0b85a97d-43b6423bc5bmr22855250f8f.22.1774316529365; Mon, 23 Mar 2026
 18:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-6-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-6-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:41:32 +0100
X-Gm-Features: AQROBzCFkof4eO3sQ5Mi_04Kqc10_skG3cyZZaVxF4JXZB25lRZil-hxigAR01M
Message-ID: <CAP01T75VaNGk+adULuX3q_8uxc0z78J5B_5ECLy2VR=i7pBi0g@mail.gmail.com>
Subject: Re: [PATCH v10 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> In preparation for defining smp_cond_load_acquire_timeout(), remove
> the private copy. Lacking this, the rqspinlock code falls back to using
> smp_cond_load_acquire().

nit: This temporarily breaks bisection (or rather, leaves things
broken until later commits), but I don't care too much.

>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
