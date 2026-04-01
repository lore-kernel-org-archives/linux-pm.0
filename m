Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7AF375ADE
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043724; cv=pass; b=WHBpUBHZrQkA0GmBIRFQh8AygdexkxE4UkZHZAG7ZIN1rqKP0eKv5oCm3M549ACYsy8e9Cg84OxNlxk7gjA829LCAnlNL4oEpt9bvvZraQ9ZdZ2Wzk6VWxfn9cfjN3KClfzUxhzxbVXlAcmLjWqL7XvlnQxv5+9DQrJNTmkZhLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043724; c=relaxed/simple;
	bh=JYZ67gNA0pDvTW5bg1nbkHWatH4Q1qHBC4hwtpn+QI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiZC+ZPt8ld/4UOOlwp46pevfs+VYxwr6nvqtVvJh8WXRKUjfd53dTIZPLJIUEX3DbEONLoqCxIAgiU2wS1K2s3MXS/QroO78xRumDSV4NLf2iedoQ08Rv/pS/dz6c1Pk8dQBPcpGJLENu3lSPqo8nRRlZsBaU51UkKR/9e2cpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BR2R1v0e; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BR2R1v0e"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a279ce9475so916938e87.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 04:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775043721; cv=none;
        d=google.com; s=arc-20240605;
        b=KENL3HKwEPXFhkdQq7tscpkG2ayl+kekh3CnNmW043jlV/ly6iUs0hwybyFoMUyjnI
         F3k5DrcLAVH8qnDODeb2bawCn+4HV1zpBiRQUri4VP/8zEiDi0jZbkLh2yrCWNb3Rrmu
         Tvk/EfE0GkLNZB9x3wkCirpBWpJ+/rUqvZ4CfYcjEFoG6ClOTUePVTIXOcEclN56NFx1
         WJKBi5MwwQ31AyISTRYEBzmXlXx8tIvFjAd5eFwP2PcWCQgfbkS6nKSzihGBpjtgbosP
         Olt38blb1x43qEHgKelNEQJA/hHErSveLHgC0JKA0xGkZnsb0D0Rc78S6Jq+QojOs3Yy
         rjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JYZ67gNA0pDvTW5bg1nbkHWatH4Q1qHBC4hwtpn+QI4=;
        fh=KDZ0ukNp9vAg8wEh3GAaaGA7rTCF4FqavyzbKP6LOeQ=;
        b=jPpuJfo16bj29dFOYHHDZNpEht1lf0Ye1pVjeBs5qkPyZ5ly8YIB+HG5O/MsgM+B3Q
         l48etOT8HwYSmrK1pkAXbBkW6ijcjHrODQ+u3GiFssDAbucd3QCgKXoIkoU26cPmr5+9
         EKlJo/s9aQF/N5JPYRqgwGxiqqKoDh+kQdtndBioxHztgMKl8PXgh3+vR4CeVZBWXsZT
         Ad5BkVAeGTF6myXmzslIvy1mcVazOxJBpVzZGpmmBe4H0MxSyBVMSAGnX3E3uI6cvoMw
         1rkhRw1cqPJ9/mIH9TYDR6koi9zvMAD16MX8Q+6Y2PCsiviswyCR3nQwf2a8dMa1+XAG
         SHWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775043721; x=1775648521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYZ67gNA0pDvTW5bg1nbkHWatH4Q1qHBC4hwtpn+QI4=;
        b=BR2R1v0e0PaGNJeS1VJkA2AzBVblBa7e+P4LYXlp/xUbfOh4B4zcznrJuYV6FlyDGM
         +DoPIdY25DO9uBhPM0tCiaxh4WS3ohjSsBt1i3/0yeIpcOHMXBPNG6qWNLriK7fOUS/w
         U+YFVGRqPoDicGKLXANVVHkrxU85qIZxxJapMlU0Ezlc5lI6UKzkiREo4r+PXTHdy9im
         WwWI5rYjnVTb6YOmGEVGu5l4slMQAgAne8qAk1p4BXhanDYgzp4xBH8XArkzR3UGs8Hu
         YwJoDivTehJGoyn/pPPF6BeObx8Bau9C6fbVhMWWIsvSlZcW2VUWtRX2RzEWGPUU/lpl
         mPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775043721; x=1775648521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYZ67gNA0pDvTW5bg1nbkHWatH4Q1qHBC4hwtpn+QI4=;
        b=sflwWbQi45BJj0vCiXl8xM7s5WkW0v1/1R+gQA8EWeEiWKDFtpHvobJDQP3TSZtwWL
         EmK4Tehwdlqv3JAve6o2XkOga1F4byd8rh1tARztx0rqIIGICGFWNOLe0MjWY8L/dWc4
         qUBXAEjcRPEH8tcxIE8Arz9smje1J4MOhxZu9vCFQe/Q6T6rpUH0GZaSEzNrvtNCh+o/
         uVUM3mNTyN+IyM3OEB7sZv21p+whjsH/ew1il+tPTpzR9Jy+oqcaiXCOpi3AJjHSTsw7
         tkCkSvgDsbAbHlcXqN/sLvaHn+CktxrnSnOQVvd2S3mYV8JP84U8zKxFGde1U+tjquVC
         hKyg==
X-Forwarded-Encrypted: i=1; AJvYcCXoE8UDWmrcCIPj3BhJFZZtpJe8EF3gWPESYStp0VrGL2Ikcbb/n6CWQDWZGJAB8nLKz4b2N47sEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5iCLw4pl+F645r4VmTde8xsI+xjdBvjM9FVJzE5PONRaVWgR
	MRIQmzh5MZvDOfDgO4zlWgCY7BdQDinSE19aHEw2UAupNbaHIkp2YWp9Mfxn3Vv2YhMcpAeNRdS
	2PFD+HBOcPM6Bx9ov4NoLndyKOlYbFXYUtFc9P6dbtQ==
X-Gm-Gg: ATEYQzx/XN39obAG0ymc7yb/NqR8Rz5zOj+UlYL/r1uoxUrKS4GimRntTADWOa2ku54
	o3Jk0Aw6poz0IitWZI6vNHHjsOsraFEZeAlfF7wZEEsfsHxAFtZMFQj6+/VDHDwc4bY2S3475Fn
	Py8aZui1JcL5HXlQ2OLhhY2RxqvexSvCvEidJYWaUjmzgSVNiQQUVzJVAp+tBPVs+p4SoFdO3rP
	k5SuEskP53dPoUD+L0SO8PwamcP52dg0M6F340OnOh9wdROyZhYIuir3TkMJ+nQk/mPBMBzfdP4
	VU0Ds0gunM0lNhl8wFs=
X-Received: by 2002:a05:6512:1048:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a2c2204c2bmr963346e87.18.1775043719389; Wed, 01 Apr 2026
 04:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
 <20260209-iris-venus-fix-sm8250-v5-2-0a22365d3585@oss.qualcomm.com>
 <5e2635ac-35de-645b-b5e7-235923f844ce@oss.qualcomm.com> <x5gv6dxdum5klzfjyo7xjqull6o43okkmkn7avssg26epbvrz6@z2brpssbk7iv>
 <0b41ee7c-83fe-d604-b750-8a5a0bd62bf8@oss.qualcomm.com> <CAPDyKFrO3DzfG0aW4z4w87j_iWM=3dpvp=2Wgr4MX1Bin5-6ZA@mail.gmail.com>
 <6yfn6ux3gbin2dtopdxxv4okinspueryuey5vfdq633gsewc6r@ttp56brnpgvr>
 <gX7v5Lyaw6K_7HLFrWAPRIukMU5BJ9bGDg4RNePhYxZ4A9KcMe1HWULG-XqG1czNCzN3e2BMPQV85a2184NwPQ==@protonmail.internalid>
 <CAPDyKFpm7ujNw51dVpPaHCwssjgYe1JVBEyrQ_1CsPbDJuW0Ww@mail.gmail.com> <39b31606-b4e1-48bb-b9cc-911c1ac350fc@kernel.org>
In-Reply-To: <39b31606-b4e1-48bb-b9cc-911c1ac350fc@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 1 Apr 2026 13:41:23 +0200
X-Gm-Features: AQROBzC6yQBtymEM8RF6AwP2-8_VypiX8OajhW6JswzQtD6SYu97waxO7DoNljg
Message-ID: <CAPDyKFrkVbvZcnbhxbLqFySn4V+USCKAjooT3yXN56jq+D9XGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] media: iris: scale MMCX power domain on SM8250
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Dikshita Agarwal <dikshita@qti.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 12:58, Bryan O'Donoghue <bod@kernel.org> wrote:
>
> On 01/04/2026 11:46, Ulf Hansson wrote:
> >>> The intent was for this patch to be part of v7.0-rc1, but I failed
> >>> with my pull-request to Linus.
> >>>
> >>> Instead this will be part of v7.1-rc1, assuming everything goes as expected.
> >>>
> >>> Is it possible to drop/defer these changes until v7.2?
> >> It would be very sad.
> > Right.
> >
> > Since it's my mistake, let me reconsider. If I rebase my branch and
> > share the necessary commit through an immutable branch that you can
> > pull in. Would that work for you?
> >
> > Kind regards
> > Uffe
>
> Yes. Please go ahead.

The patch is available for you to pull from the immutable branch:

git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git pmdomain

Kind regards
Uffe
