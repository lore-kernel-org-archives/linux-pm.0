Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB8483831
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053451; cv=none; b=uceHJcr1FDq8nG2X6oYmvQengWnJyjB4ukdcMqMZK0xixiz1zEG2aJUkRg/JvewzIw6wDAJbTApHM5zoAiudA94HDa2QlbcpbRmPrL+P32A0rc3G3yx/wDs3yr0LgR3tRweN24VT5iQrjZj+f4IbjZt75ndKOJFxWLyDy37BPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053451; c=relaxed/simple;
	bh=hhG34pRBwNVfGPERzjm7GlkrPqWfNm+55ytwLAiZfwQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6JGiwA2IQ6QbrdJbIinecXNtgsG7RipFC1h2ILAWZ8BOtOqgHCLiYxDOYdEDqAHN9hvFOa6fggyOdI2sWwTV4B2hbkTgJbCXtWnGe6HdD5450bNvOU5YITcInqn09SuZoy+kGLp0+Gpcdd4p/JdZzePLJASBVLGF3leCR6PlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/sqtBNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/sqtBNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7B01F000C8
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053449;
	bh=Ffv3dgFroz/r+GFDSF0cH2uBXsTK3CbNpA3hXcagHYA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=P/sqtBNw5nzzSfwQAzuZvHa63i5Z7YyOlgL/M1OWIVfQLa9fyRrxPpESGEY2JyA1G
	 7Ucq+7iOU52CVkh4izhxfD/mzWS4iHRHs/GIS20X/Wjv9IjKwbOVEaNiEtsc3qMjAp
	 Z5td+r6YxlUNsT9ZQLp4pLxJmQ1OJS3y0gB6Yj0ZxB2edFkW6Jx7YtT0NZTiXdPei3
	 V6nYebGbXRV2f2xQmXnT+kjciD7l2cuTiF/EO55QSsD4UCvLEDSvhnjLoC2izs+8/O
	 ldfSx0BZ6OI+etzHofaQ20WyM4j/UmBpVFftNZrhpj6ir5mJBCwnUM0oZoauYeIbTr
	 mY1EEE9C4burA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso1266058e87.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 01:37:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy7DkAdMzC0KerDSg2uWE+cR1xVqh1SqpHq74tEyfo0S++OfQYnTFVUM62z7nVebd5w2/DQAh3PiA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgyitJaOaJKciXCV/PrfhdqyMZ1bXxYNPDJm8sCt7VQmkPtUFX
	CMIMWeVfCQVB9vupHfHbGSt7sfr1tNA7Mil0lmTuNWRnnpUZtErR9HvzSbpzoKWOso36WdJYJcd
	14WrQf2l6sNLWGXJItCoURhfI+EuRULZEobX+7EMrng==
X-Received: by 2002:a05:6512:3d14:b0:5b8:d9ce:1d88 with SMTP id
 2adb3069b0e04-5bcde6c7f62mr6490930e87.29.1792053448631; Thu, 15 Oct 2026
 01:37:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 08:37:26 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 08:37:26 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261014175050.21982-1-tvlad744@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179163212446.46972.2306254853726299632@pm.me> <20261014162025.3733-1-tvlad744@gmail.com>
 <179199941686.68860.2209253288195283916@pm.me> <20261014175050.21982-1-tvlad744@gmail.com>
Date: Thu, 15 Oct 2026 08:37:26 +0000
X-Gmail-Original-Message-ID: <CAMRc=Me5ZQ-obg3g28yqc-TMVeu9t-pvr65z2MZdxCY=Pw8jaA@mail.gmail.com>
X-Gm-Features: AclHuK8ZaOArMNUK0s4TVJGKl-Y76el5XziQYBEWdSnDw1CHDECJExL51t1fD1g
Message-ID: <CAMRc=Me5ZQ-obg3g28yqc-TMVeu9t-pvr65z2MZdxCY=Pw8jaA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on
 power off
To: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Birk Skyum <birk.skyum@pm.me>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 19:50:49 +0200, Vladyslav Tymoshchuk
<tvlad744@gmail.com> said:
> Hi Birk,
>
> On Wed, 14 Oct 2026 17:36:59 +0000, Birk Skyum wrote:
>> v2 takes your code, describes the AWAKE trigger next to the WAKING one,
>> and carries Fixes: 3e4be65eb82c and Cc: stable. The code is yours, so I
>> will add you as Co-developed-by, which needs your Signed-off-by. Reply
>> with it and it goes in above mine.
>
> Thanks for running the power cycle on the Yoga. It is good to know the
> stale state shows up there as well.
>
> Co-developed-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
> Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
>
> I wrote my version with the help of an AI assistant (Claude), so please
> also carry an Assisted-by line for it, as described in
> Documentation/process/coding-assistants.rst:
>
> Assisted-by: Claude:claude-opus-5-5
>

It should be Assisted-by: LLM without the model name but even that is going
away:

  https://lore.kernel.org/lkml/20261009083137.3-1-sashal@kernel.org/

> When v2 is out I will run it on the Pad 3 (power on within 2 s of the
> power off, and boots without local-bd-address) and report back in the
> v2 thread.
>
> Thanks,
> Vladyslav
>

Bart
