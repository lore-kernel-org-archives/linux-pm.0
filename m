Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DB3955D0
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003846; cv=none; b=GiLYtw98mApjbeqEC5AWk3wKb6S0P2QUgkkEYFsSu3cgZLhgSvZi6ddtqiEP1TvdaYNdTzVcOY1sw830F9Xb1KQSyosKsxy1821ttSoFoGDfEwilX0I3WRmDbb+b9le5hmjBYEWvLdBf3tSXlrCznqNeZe4H9KgyRMIymWaj73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003846; c=relaxed/simple;
	bh=7tp2OWYrm+Ia70rR/TEdzpzDPNkEbn8XJlTwHfsYhiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URkH3p+5an2J9jDmhVp1gvEKKGCfhELXqoRncCr1oLkMnA0dfn9t+07y6iUWDPcm//Waeb7LS7CSbE+wfjo2hHfJnJEV7TE8bHf7i4F5c1cJmphxoplzdCIhRJ0fiKPkZriUb2z/30fbqdfnrV13uyt9RO0yIPG96WAYyD8p1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KWPrLMNa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWPrLMNa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51758478240so26552991cf.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781003843; x=1781608643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDbvCu4VoxfZEmkz8hj4Arxjmojgi1kh7vhYD4neuKE=;
        b=KWPrLMNacAfxtU0PK18LKvHNWeI3xAw18DMOR0LHoaH2EY4OYidAgTXvqiQXXPg/D+
         9g9G0XU4PD20CE9h2ejRvPDYkttJU7bJ9eUk05CBxDiZ1x+qVnNCbS5VcrimMO3taiwZ
         7CIvX60OF/qUrIPuoYUOc3TJRBpXhQWl9BktA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003843; x=1781608643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDbvCu4VoxfZEmkz8hj4Arxjmojgi1kh7vhYD4neuKE=;
        b=abij3PLzExm2qT6sRK3naS63cymopxh72ARIXN0AhVa5ld/Xh7VE6gWze/aQKZcwIo
         gfe0GjEHw8tAh0UKwwcsWt+m6N2VQ/LJw5jDJJovowkAIgoYRlqlVwKSS5oVBtbt3FUJ
         nO8oQQp2KiwguXIrTzTqaYqs2RXCHcAxVpbi7X6+lxTUQyU//XK03kKGnqhtO8NlcOM5
         68Cf0wOmJ1R2YfF3TKwpZG/hJE3yxybUQzpcNFi9+cQRJ1xd+lyn1/ATEkQBCN9wcrl1
         1L3GgB+CdEpo87ZNeHoKKMhZEKEGHwositwECf3WH3rt1VxYvKsQQMdio/XsVYochjsI
         pacA==
X-Forwarded-Encrypted: i=1; AFNElJ/rM1FvC0jazBTNK3B+PlH65ybrRXe7x4NPOzKz1CPx6SNj7AfL6VzisZZTHR6DNUQlqDxop337tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrNycRCz3aTtfP0aDUoTJ9QATSLWO7GYK3GQdYAN6Y6cZlmik
	7tKOuljutQ+61eWFjKTeElT5QeFNQZdXlwSuUzwG5kD8RrlvrNg5ski5oGWzFx6BLnW0u1HlVbt
	XzHjfsw==
X-Gm-Gg: Acq92OF3WClAgb4xhdA18qzdwGFjMPIsw4FtSp41CMDWhjvp5WfuKne6fCnf3iUlf6t
	Jgdfh3xkv7ZkU+uDnr6rTpzWs28rAgbMw7abJlFSLWGaVXK5+z7iJ332HNAqO4QP9oh2OcU9qUB
	RwiC58H85zp9rgL/FLg2IZxwBo5VXB3tS4Q1Ax+EoNOMoaA+fs9Cb2kSMrnsdDNodzsRwOWfGCV
	yyWSlGodA0MXnoMibWXcXRxFdItnBj14rWVySRosmgXkzF2J1wV0pr7oWEs/uGBc88VwZzOZb2q
	rIYB4WFIrhB7yh0gat5vFd+X4cuCsZuO75f735OL+tvfs+BU7U2Rvdt79Ggw7oxy+EV15FWoLUs
	/GNOdF7GXum/0Vv4FghB/rInhy6Fm3vymP9qZxGLn2pMTAfN0IxJdXaHlT/57nknx2CV2aZDGC6
	8j8IhmydP9B2TrdWtGF6/UzIbnhU/b1lbZwI6wqn9BZzTaTTOlmp8kuBAS0pcxYEPHH654Bno4
X-Received: by 2002:ac8:5f84:0:b0:517:b58e:a1e4 with SMTP id d75a77b69052e-517b58ea315mr136199391cf.41.1781003843500;
        Tue, 09 Jun 2026 04:17:23 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm153966781cf.19.2026.06.09.04.17.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:17:22 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765331535so2348811cf.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 04:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+jO6fPuojfzid6P5+Z7DuVry+5ZWLNFGTh7lYtYRuKgCw56I+0J5D6zj2OAubNoAT3Psm+ByKxCA==@vger.kernel.org
X-Received: by 2002:ac8:51d3:0:b0:517:99ea:ab82 with SMTP id
 d75a77b69052e-517abc8cea8mr19118391cf.28.1781003841615; Tue, 09 Jun 2026
 04:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608021526.1023248-1-tzungbi@kernel.org> <20260608021526.1023248-2-tzungbi@kernel.org>
 <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
 <aifWwEyHuFejW4ac@google.com> <CAJZ5v0ja1ocM+W4hbVsHoZ=fFdmQ-=z4xzviNwo0eEyWT8ssBA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ja1ocM+W4hbVsHoZ=fFdmQ-=z4xzviNwo0eEyWT8ssBA@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 9 Jun 2026 20:17:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bmm4VeJ2ygOJeQYmdTq1DLBsQdvDkhstA-tUPZr0rB1A@mail.gmail.com>
X-Gm-Features: AVVi8CfwcVOwQBh6bKtrJBXA0oWlGWFm1bcG07aWA20mHmTZKYZMKn7BpYcKJWo
Message-ID: <CAAFQd5Bmm4VeJ2ygOJeQYmdTq1DLBsQdvDkhstA-tUPZr0rB1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: core: Rename module parameters prefix to "power"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 8:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Jun 9, 2026 at 11:03=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org=
> wrote:
> >
> > On Mon, Jun 08, 2026 at 04:11:30PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jun 8, 2026 at 4:16=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.=
org> wrote:
> > > >
> > > > Currently, the module parameters defined in drivers/base/power/main=
.c
> > > > use the default prefix "main" (derived from the filename).  The pre=
fix
> > > > "main" is too generic and non-descriptive for power management
> > > > parameters.
> > > >
> > > > Redefine MODULE_PARAM_PREFIX to "power." at the beginning of the fi=
le
> > > > to group the module parameters under the "power" namespace instead.
> > > > This makes the parameters more descriptive.
> > > >
> > > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > > ---
> > > > v3:
> > > > - No changes.
> > > >
> > > > v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungbi@ke=
rnel.org
> > > > - New to the series.
> > > >
> > > > v1: Doesn't exist.
> > > >
> > > >  drivers/base/power/main.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index ed48c292f575..cd864f3a2799 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -40,6 +40,9 @@
> > > >  #include "../base.h"
> > > >  #include "power.h"
> > > >
> > > > +#undef MODULE_PARAM_PREFIX
> > > > +#define MODULE_PARAM_PREFIX "power."
> > >
> > > "power" may be confused with the power supply support, so I'd rather
> > > use "pm" or even "pm_sleep" (in which case the "dpm_" prefix could be
> > > dropped from the new module param name in the next patch).
> >
> > Ack, will use "pm_sleep" in the next version.
> >
> > Regarding dropping the "dpm_" prefix, should this also apply to the exi=
sting
> > dpm_watchdog_all_cpu_backtrace parameter?  Or should we leave it as-is =
to
> > avoid breaking existing configurations?
>
> Breaking things for someone would be unfortunate.
>
> For consistency, let's retain the "dpm_watchdog" part in this name and
> use it in the new one.

Hmm, doesn't the prefix change already break things?

Best,
Tomasz
