Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3427EFE9
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347049; cv=none; b=Aw14LKOEFHskr9A1mghmtEheZDNV+enZfttx81kA48LE54MkCuHwOKYPXji6Fd1No0rwExd4JjF5zPr1TXAHBQmqktbrA8kgjBPU1CGCUL8/2NX5CcA8je3DyLLu7mc+xhljs5h92SKYJFNPEleTiBzksLgU4lC71K+kV8bbPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347049; c=relaxed/simple;
	bh=aqBHqUvnHvgJQWnufPxhJ0APFMfJweT1QFdea3nbrUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA0OSbAcgaU3mkan6S3pXPumn79h11ApIOAtRr6oQrfNzdaaWXi94zFJcfFnMYmrKl5IKXCljV+8wqJY4kCrd9PtQk/X4LJE/gD+W9rdlvSMPjFKb37oh2cbplUfrw6EnT/WGN9Z9cjyReJoxXKoXmqO1X3+6Lh34pzQBZQ//RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrCaP7Yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrCaP7Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D031F000E9
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347047;
	bh=R37pHFtaprCoupA5VOyUWUg06+Rz9GF0zUKsfOzMWy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JrCaP7YlebxI3iiWvDoqnASrNIuJAE1lRC4pqoii4kV4PQkzuwqEM1D/Z3A9RXNxE
	 uyvpOhswNn/H3046IxIrj6Jxly0L1pP64ZDjVOYqHtUF25MeBLRaSRSGnXio6N/MhQ
	 JfjNwQWk23wI2a8Uij2sfzWfK5N+zngDxefGgIf6cL2/yLSPbAtjhiXbo2Kz98FMZn
	 xzrKwfE5awwm2XB88O6R1XtwMp3b/yYxqR2TdYhtuq8ACdG3Aoqx6yTgxaro/qnsUl
	 5TSZAOdqtOY5mSQGG9JcLLi/9X0l5/oi3mKWs56vkTatlXqIk1xssq0vU4vtG9D/GI
	 D8UvC+vZ4t6IQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2956173e87.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 07:10:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr2+bkkVqnvP2naNp0SpFu+scEzcgzMg9DxjS1QHkk+eEhsei+gA1MC7PqBsxMOCLI2lAs9DOyp5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBKby+62myMZRpKjONzEinr0pTH9Q4XB9/RYnbqmqMgoiKN3s
	gzfx2Dzhi+qH1LWhxCthavVjICjdiFMRAT2RI+AhJ1FRT8WazJS1jnvnjLN6snsoJcCCGjkkvqR
	+v9RNiW5M+wQLkMMQJfpMXBo62w0+MIk=
X-Received: by 2002:a05:6512:66c1:10b0:5aa:6cd6:a7f0 with SMTP id
 2adb3069b0e04-5b007baa097mr123245e87.44.1783347046402; Mon, 06 Jul 2026
 07:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
 <CAJZ5v0i4Zc4HNUdgJ_2=4=wv7vRDTugo71qsWnZxVRRqV+W8mw@mail.gmail.com> <9d271393-c500-46a9-8795-f1371585445c@sirena.org.uk>
In-Reply-To: <9d271393-c500-46a9-8795-f1371585445c@sirena.org.uk>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 16:10:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9AxpqUQUQ-vwG2LN3pfT3qXi3_S=So42=VdVtzg-=Dw@mail.gmail.com>
X-Gm-Features: AVVi8CcJAwLOXEDSeEikIg87rWOwRTBY8I54tEwtPnVuwTxyPfLiA_mSuDbP2Dw
Message-ID: <CAJZ5v0g9AxpqUQUQ-vwG2LN3pfT3qXi3_S=So42=VdVtzg-=Dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, 
	Girish Mahadevan <girishm@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, 
	bjorn.andersson@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 3:21=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Jul 06, 2026 at 01:49:07PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Mon, Jul 6, 2026 at 10:53=E2=80=AFAM Praveen Talari
>
> > >         /*
> > >          * On transient errors, if the callback routine failed an aut=
osuspend,
> > >          * and if the last_busy time has been updated so that there i=
s a new
> > >
> > > --
>
> > This is fine with me and I think that it's a quite significant change
> > for runtime PM, so I'd prefer it to go in through my tree.
>
> > I can take the other patch too if it gets ACKed for me.
>
> I've got a bunch of other stuff in flight for that driver - I'll need to
> check but just in case perhaps a tag I could pull in?

I'm wondering though if the patches in the series really depend on each oth=
er.

There doesn't appear to be any code dependency between them.
