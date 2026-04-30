Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E847CC86
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574129; cv=none; b=dw3HW5euAoUTWiB0bMq+vLkjCMtQ7euAv+z5l0yqIh7qz+55D0WPRf4Fwf+mFbCer2XbW0L0Lb4VO2xbjifIc0EzFm3wgTkc/Jh4ElPTfVsRwozm6/RybejRRboVdyiRWilsrolLHsEfkw8pfebSOvIbdXjjFVqZF0SayD2VlPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574129; c=relaxed/simple;
	bh=mjidQwhgTPS5ymc6PF2cFzKEGOZes6LTWPDInPeiDnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rze1IaBQX13G+yV44RAy/IEgHLMWewfA2/DgBUBNPZBk4MnGZvaDWAD8Ie0bq7Ak6+PdHPaRr21heAEGubQ2nYfQ0A3IBFwlxMBKh5IkuWXQ38I+4c1bGu3EAD8/9+EHMCwv5v5MBMwj9CuuTVHdx0B+6GugNgpb7FLPMeWDJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouh8BzP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouh8BzP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E520FC2BCB9
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777574128;
	bh=mjidQwhgTPS5ymc6PF2cFzKEGOZes6LTWPDInPeiDnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ouh8BzP9c096d4TULbB5B5svtO2LMjtA9tOj76irZ6OBnsv5L9vVGJG325lNAEPxA
	 vj6Wg2vdXmJoAAoqFXxHy6wlqGxgLcyli4cbqwpjTZJFE1WxWtJHl8Pliis74yaGpf
	 1GfPQE7CYIfH7llItM/lqEf//Pd0M70KA7Uj+RD6mv8U7G4YME6OxCW49qB/ATLjLV
	 mIE1wGmSRj+XVlf4GsY1URmfCr+F4FlIULzSbjYHSu9nqyyX07iEDRTJ1COvg+gv2H
	 z2dRBluhpFXnTy2yV1B4E7/ZA0i4p3fEJbZrDBiH4AxiIkyPxQeXiEQXTxYNhs57sC
	 SfNdqOpHjsmwg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so1587536e87.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 11:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+6JXxoQ8zOR6wVtS1Yglqw4/b1W75bd7zD5pwAaB4PRqRX5I+w/dLZAelbjaeYH5kI+c/Um4PORg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrR1Ucz7x0S3BDiQoBnrvg7vIyK92UlP/mgIXbabSGRESd0MOT
	15xVw9jUeVY04+e8dEjyhco84lPEkPvFWZMdkqQ1Ogf1KytkTEfRTq3srn0NyQ4xQk6gPMi0MCi
	kJDsq8cj0oLXeV7807hqAoiuBkbmidSc=
X-Received: by 2002:a05:6512:2350:b0:5a7:49ed:8aa with SMTP id
 2adb3069b0e04-5a8522bc25emr1200888e87.11.1777574127250; Thu, 30 Apr 2026
 11:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071208.3610628-1-13875017792@163.com> <d23a53f21083acc1d370569d4d9393b777509bf7.camel@linux.intel.com>
In-Reply-To: <d23a53f21083acc1d370569d4d9393b777509bf7.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 20:35:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBKKHhr0CLhN5wT=R1Lw+Tx0q8zWa+_0vUZyuhKcUCnQ@mail.gmail.com>
X-Gm-Features: AVHnY4LHHhBTRwlDPJ9E9qVZnqNlG2OZQjv_z8RQdkI3iTjo_aPIHUEWdxpGP8w
Message-ID: <CAJZ5v0gBKKHhr0CLhN5wT=R1Lw+Tx0q8zWa+_0vUZyuhKcUCnQ@mail.gmail.com>
Subject: Re: [PATCH] PM: tools: fix ValueError when parsing incomplete device properties
To: todd.e.brandt@linux.intel.com, Gongwei Li <13875017792@163.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gongwei Li <ligongwei@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 7:38=E2=80=AFPM Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
>
> On Fri, 2026-04-24 at 15:12 +0800, Gongwei Li wrote:
> > From: Gongwei Li <ligongwei@kylinos.cn>
> >
> > When parsing device properties from ftrace data, the devprops()
> > function
> > assumes that each line has at least three fields and that the third
> > field
> > (f[2]) always contains a valid integer. However, due to incomplete or
> > corrupted ftrace logs, f[2] may be missing, empty, or non-existent.
> >
> > This can lead to the following error:
> >
> >     Traceback (most recent call last):
> >       File "../sleepgraph.py", line 7142, in <module>
> >         stamp =3D rerunTest(sysvals.outdir)
> >       File "../sleepgraph.py", line 6255, in rerunTest
> >         testruns, stamp =3D processData()
> >       File "../sleepgraph.py", line 6181, in processData
> >         testruns, error =3D parseTraceLog(live)
> >       File "../sleepgraph.py", line 3470, in parseTraceLog
> >         tp, tf =3D loadTraceLog()
> >       File "../sleepgraph.py", line 3398, in loadTraceLog
> >         if tp.stampInfo(line, sysvals):
> >       File "../sleepgraph.py", line 3073, in stampInfo
> >         self.parsePlatformInfo(line, sv)
> >       File "../sleepgraph.py", line 3177, in parsePlatformInfo
> >         sv.devprops =3D self.devprops(sv.b64unzip(info))
> >       File "../sleepgraph.py", line 3158, in devprops
> >         if int(f[2]):
> >     ValueError: invalid literal for int() with base 10: ''
> >
> > To prevent this crash, add proper validation before accessing.
> >
> > Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> > ---
> >  tools/power/pm-graph/sleepgraph.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-
> > graph/sleepgraph.py
> > index 1555b51a7d55..f6d172254829 100755
> > --- a/tools/power/pm-graph/sleepgraph.py
> > +++ b/tools/power/pm-graph/sleepgraph.py
> > @@ -3155,7 +3155,7 @@ class TestProps:
> >                         dev =3D f[0]
> >                         props[dev] =3D DevProps()
> >                         props[dev].altname =3D f[1]
> > -                       if int(f[2]):
> > +                       if len(f) > 2 and f[2] and int(f[2]):
> >                                 props[dev].isasync =3D True
> >                         else:
> >                                 props[dev].isasync =3D False
>
> This looks good, thanks for the catch! Rafael can you apply this?
>
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>

Changed the tag to Acked-by and applied the patch as 7.2 material, thanks!
