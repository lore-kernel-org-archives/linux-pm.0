Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507C3BB112
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537837; cv=none; b=czWFnz4Xc+sYoxzu3Ca6lZp45tjqjFZsxxYnw3b94xTVuJdXOU049aleaGiL339Kv8MfGMd4OO2obZSx/Xj0wT4MIE66jSndvSRKOSTGWPmKGa+563cD8xbYJB2ABp5g0jN6bAn/iObxgYWfC6NC61KTflCZY7RUSxgIAX1MxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537837; c=relaxed/simple;
	bh=dwYpB4UPZRfQY3y88qC6Q+iSDcIijtraEl46+LBFoUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+TsEKrh9NC1ND0Jsh9dxEaI3CB9mhcwYgzlMt8nyu98RHHwk0c8Pf5tQKWUazpIR93tGe+IWtPryFxUx6mZ6Nn9u/P3yHrFviK1rIxr5Mpfkf+C0Bo1UJtTjbLO4f75luLcNUnmkdE3+wdh9C+zr0NyP1gC68dDtuykXe3BGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDnO+y8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDnO+y8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B01F00ACA
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537835;
	bh=ldIq+F8nOlAbUH2eoWqdxCJavo0VkxCg3Zmbg8MzPNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QDnO+y8yKAhQ4LSHuX2dqHxA8J4fOEAe8dfmB6oEohZHOTAf7lHpNnbDk22mFwJWE
	 CQBHaOo5Si+hzg/GuaAd6Kioxq+fUwq3daLYTF/l/jXqwQzWKrt53Myhpor8TnaMub
	 I340Lk8N4i/22c0B/ccabZNOl8V3/Sf9L1EeMmRIUEIeaz9ZQovo2boGdbvTATWdbv
	 ccjoNVbrfFUTGlE7vRo7s10fCW5uYYsBYzSqHOSRmMmWQcS9Vx9pWpay2TUKYQYBSy
	 47DLYpqBNVE1yZJyDmg7PJ29F7ILovXTCYrgJk/OkALTD5MGzNwIdSya9j8TYNErP8
	 9eEgBSEFSEOAQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso1013542e87.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 09:03:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBydFYDRubWM3BXT5ZpyF5CUZmeSaEepJAF0ZP06SkqGwXh4EG/lbO2ssDi6Pm+zRWp9bYxaMcd4rA==@vger.kernel.org
X-Gm-Message-State: AFuF++na3GVMtc3luWtXYWJE1qP9WeEyQuv+ka0jhsNWQdgMVmaHrMIL
	mLpOB9LB+ig0anKP95czWwYpt5ooVf9hBBH8g7ajqCnr4GULXBiZZZs3ZNzqczEQqNXc6cr9cFX
	YiHThmGmX41eOtEeXxex1yQZFh54TH50=
X-Received: by 2002:a05:6512:2311:b0:5b6:1a7c:aa1c with SMTP id
 2adb3069b0e04-5b61a7cac90mr824179e87.52.1788537833747; Fri, 04 Sep 2026
 09:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903160751.734704-2-manuelebnerli@mailbox.org> <3d656f96-c2c6-4783-847c-4a6c0f6398a0@infradead.org>
In-Reply-To: <3d656f96-c2c6-4783-847c-4a6c0f6398a0@infradead.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 18:02:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iq02vx1=GR0Z2nX3Lvf0nUSN0xP9V8OgmTpixY5msH0w@mail.gmail.com>
X-Gm-Features: AcwNN1XzLH-hyhpEtB8RRgMIur_yGiVcTYJ0ARKDCSydD4vBpdbfVs2EQjamVK0
Message-ID: <CAJZ5v0iq02vx1=GR0Z2nX3Lvf0nUSN0xP9V8OgmTpixY5msH0w@mail.gmail.com>
Subject: Re: [PATCH] docs: thermal: cpu-idle-cooling.rst: Fix bracket
To: Randy Dunlap <rdunlap@infradead.org>, Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:22=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 9/3/26 9:07 AM, Manuel Ebner wrote:
> > Remove needless '(' from equation.
> >
> > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 7.4 material, thanks!

> > ---
> >  Documentation/driver-api/thermal/cpu-idle-cooling.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Do=
cumentation/driver-api/thermal/cpu-idle-cooling.rst
> > index c2a7ca676..b9d4c91a7 100644
> > --- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> > +++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> > @@ -161,7 +161,7 @@ tree. So with the idle injection mechanism, we want=
 an average power
> >  specific OPP and idle another amount of time. That could be put in a
> >  equation::
> >
> > - P(opp)target =3D ((Trunning x (P(opp)running) + (Tidle x P(opp)idle))=
 /
> > + P(opp)target =3D (Trunning x (P(opp)running) + (Tidle x P(opp)idle)) =
/
> >                       (Trunning + Tidle)
> >
> >    ...
>
> --
