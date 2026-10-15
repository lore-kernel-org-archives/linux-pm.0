Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEB54147B
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084046; cv=pass; b=Y5+g+L5aG6/XkByPZcfELnVBULtNngObVcJQVc5kk0Peuok4z+Z0qEEifPpykTTAR+2ul5OWRx4eFvXEcNbSRgiUBfbgXgT5dX4meqjPLfihclJ2N1ADZxXMTVMYb8mDJKPMY3EV58d1mTnbYh8wW5AaiZpuCPMnVwtVn2hEanw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084046; c=relaxed/simple;
	bh=TQWSF+hQXVkwcjIKu5CbKZ1m9kqfy6YQdFbRnYAAUMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptdewj54U9FmANHXsh+u71DBdLyohDLPxnt0kvvv0pg3m2ZD4VJLfMJki4Zty7hNrE0bHQGCCV5oLTclxHYxSvCRQcSrO+n4MiS2roAtRRx3ZXV1JCoYWGrwn3zMsMgRd6SPQacTEFaHjHbEUxx+rFnTYUhpoNzT2afr0LvXoQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6kD8zXW; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6kD8zXW"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-676804a3a22so5578757d50.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792084034; cv=none;
        d=google.com; s=arc-20260327;
        b=WAMsJr1SnYjtc2KSOxBn58KKvU0W8xGgKsmjpr4gQeURk8vsXdKzrN08CuudPww5tA
         XeUyNHEnT4DRQi6h5XE74hQ7Dx4MGE06GvVw+05VWdnSUZmDk+GY5BH+b5I5fZiwCKXt
         1kU+LlQcBiDo0m37VffKXQK3b2OFKmJbFWWw4jFpFpoRGJD0b161+gAMOClgBMpFqfFP
         otuHbXQcdj2kTL6S20DBoFpqcj9jpVTB6MdHgljUrCp/xQ6yQF4QVa8U70ZNtccvRp1h
         otPN1UviXB7BdJOFT8La3JVqA413xQpDr36xhBEZc7a9d3Pz4UEHd4eLfvRfF7tGBUQV
         xcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVmHsDqBQJBCxGh36k+fMkdYB80rlDP45cvKKDDFmfE=;
        fh=Av3ULytgBtZdu50bXMscQfTHJ50epylYV2GY6lPB19M=;
        b=WpCg8l8L1Bf4OUZt7J1b3zEnptSrm/Okd/d8NjM4WFJ251hmiV/z6eJ1GFrlurGz0P
         hsMfrGJWI4kbVMbPjps79Y2Q2TCcg5TkopSG7KGsUBuWMLhRx/lHmTSo9hJTMfiRLe7B
         Zjlur24ksA4Sg7Uz+KqfUUJMvS66J+m76Io1xWWb4+nYLtYL0AgJ6Ui01WZ9WJfPDOoy
         +yJE94I4HcRUpvhrzSbeCiewa7bc9uBTOvIofHPfHY/G5uwk/WxRFnTb4DwNbJxlLeR+
         G2miIeKTBBe+/0fpR6WzQCE6RH1gVKJjfJ3b43ZMojE+TSDWlrkcij7SIzyu4X/yjgZl
         CV+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084034; x=1792688834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVmHsDqBQJBCxGh36k+fMkdYB80rlDP45cvKKDDFmfE=;
        b=m6kD8zXWcnmAiMQzVyuLdidYavXtf+nQ7ABr3woBFglpqfezYAe8wvEANjiTg5RvWv
         ou5XcH4D+9KegDL6JVchuviQsJjDVplt1gMuB2Jo5ABdm57SXXfwq7IEx4dySTyuvTrp
         Kcuf0Rn0dbOzVLf9byOY0ksZjidHLtNZKtVqnn9kHHZtYgzJJZDMz8B6OumJYNWngfr/
         1L1tNCawWilOWbVq1B8cOqWtBNdG/yRYT/Jav85vZAySj9zP3D7TxP7sX8fjeKW/SA2m
         /BojeSywaiHwEJEmP+lx4E52BeSt+DqmZ4yblcJYt4f28++i8Cfx2t/RRDxzJp439Hpx
         y6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084034; x=1792688834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVmHsDqBQJBCxGh36k+fMkdYB80rlDP45cvKKDDFmfE=;
        b=U/ydfdd2YtWG9D7zC+rc1ngMuRvC3IPvMNWdG46QXZWzQ0eOIg3STVYTZG/KuFgT0V
         +7CetrBrpHTS/P8vLJLvYLDeW2q0CTHSQuz2xnK6SXyuBu55ZKvq4dH54Z+rFobYoold
         NxRwtssOIwvmGvFd6L8S3IS2RlT/ibun5x1H2X9cah26yeXyH9w273joH3oxlMvv9Kgi
         05KUzUISF0DA/lHJj5p4d/w1QcCEoCnDunLojKv4J+DE+33oCw6jHxXiw6dFg3kuTvO2
         XjtfB3j2iY4sDVR77QpbsCyhRr4pX2yio9Owy8UvG6dc30HRIftz4oKdj/ToJ4jZR7um
         ab5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzl611MiOb87CeSDrSZXcr7AAofYr9D7nPhyb1qUMJzBH9KJY9lXIpogoZEsZQM1XJ+dviImgWS1g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2PDUlUnwcKk45Eek/JfHiWRhaeqKGzzC6AbV78Au+6+C9uPNV
	eHwonbn3gYnD8vAOy4JJA03YUMQUYu0GVCycyrdoYj7LyfIARVw87FXgCXv1o99Ik0InMqV+PJr
	x8iNrt6tzy4RyOqVc4K1+RrXpGzqYMD4=
X-Gm-Gg: AYBFou2ymbZyS9XT0m2Mb9RTWhnByRKmdfXMnf9maJzxIGty909jTttmT80dKAf1A8h
	Vl3FIzzBriSM7VuzeQVvLHHLnBtgIklM/KgoL3A9qL22V9OHuQXPqyoyHQbgdq0Omq8dMuDZ/lm
	LHhe23l9jOdjRIAskKyBrIHhhgc/GJidUJ5ApuX8cUEy0cXBjbVjqrQG8yBrltA1Xn0QWyKZtuy
	HUnrt2plNeytfduGAiGLZmg+lpg1OgLmQgdJ0H2Th1OiK/wavp5rAPNJMGiduMPiKDWuXrFDpj7
	yZcmpbyDoCBJ5HF7RNTZ85DCaSjzqCbP0Be6+gumoxSumH0zQaX3/LIp
X-Received: by 2002:a05:690e:bc5:b0:679:8da6:28cf with SMTP id
 956f58d0204a3-6798da62973mr1956198d50.98.1792084033716; Thu, 15 Oct 2026
 10:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
 <20261008-04-k3-pm-support-v2-1-6f778a53dd2d@kernel.org> <20261008-df80c21d73b287d09b6baa78@squawk>
 <cbba422d4ba9bd4a036536a50fadc2760efa1ae2.camel@icenowy.me>
In-Reply-To: <cbba422d4ba9bd4a036536a50fadc2760efa1ae2.camel@icenowy.me>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 15 Oct 2026 19:06:00 +0200
X-Gm-Features: AclHuK8t02_cYn6UunMFOXXUfkheTlCkH2rjdH9KDS5vlihve2Jh2xK0A1qMWCU
Message-ID: <CABdCQ=MQ5soNSRQ97aOytYCjtKpqZJ0frP3mqh+mL2Dsw+A7Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 03:44:29AM +0000, Yixun Lan wrote:
> Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
> Domain Controller is SoC internal module which is part of APMU (Advanced
> Power Management Unit), it is responsible for managing power across multi
> power domains, which includes power on/off, isolation, power-on sequence.

Tested on an OrangePi RV2 as part of basic enablement for the PowerVR
GPU. An RFC series for basic GPU support will build on this.

Tested-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>

El jue, 8 oct 2026 a las 12:31, Icenowy Zheng (<uwu@icenowy.me>) escribi=C3=
=B3:
>
> =E5=9C=A8 2026-10-08=E5=9B=9B=E7=9A=84 08:27 +0100=EF=BC=8CConor Dooley=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, Oct 08, 2026 at 03:44:29AM +0000, Yixun Lan wrote:
> > > Add initial power domain driver support for SpacemiT K1/K3 SoC, The
> > > Power
> > > Domain Controller is SoC internal module which is part of APMU
> > > (Advanced
> > > Power Management Unit), it is responsible for managing power across
> > > multi
> > > power domains, which includes power on/off, isolation, power-on
> > > sequence.
> >
> > You should prob mention that this APMU is already documented
> > elsewhere.
>
> Maybe it's also meaningful to mention that APMU already has #power-
> domain-cells property, because the first reaction of me is to add such
> a property (and then found it already there).
>
> Thanks,
> Icenowy
>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> >
> > Thanks,
> > Conor.
> >
> > >
> > > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > > ---
> > >  include/dt-bindings/power/spacemit,k1-power.h | 14 ++++++++++++++
> > >  include/dt-bindings/power/spacemit,k3-power.h | 12 ++++++++++++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/include/dt-bindings/power/spacemit,k1-power.h
> > > b/include/dt-bindings/power/spacemit,k1-power.h
> > > new file mode 100644
> > > index 000000000000..41ef540b5c44
> > > --- /dev/null
> > > +++ b/include/dt-bindings/power/spacemit,k1-power.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > +
> > > +#ifndef _DT_BINDINGS_SPACEMIT_K1_POWER_H_
> > > +#define _DT_BINDINGS_SPACEMIT_K1_POWER_H_
> > > +
> > > +#define K1_PMDOMAIN_VPU            0
> > > +#define K1_PMDOMAIN_GPU            1
> > > +#define K1_PMDOMAIN_LCD            2
> > > +#define K1_PMDOMAIN_ISP            3
> > > +#define K1_PMDOMAIN_AUDIO  4
> > > +#define K1_PMDOMAIN_GNSS   5
> > > +#define K1_PMDOMAIN_HDMI   6
> > > +
> > > +#endif
> > > diff --git a/include/dt-bindings/power/spacemit,k3-power.h
> > > b/include/dt-bindings/power/spacemit,k3-power.h
> > > new file mode 100644
> > > index 000000000000..519fbf946312
> > > --- /dev/null
> > > +++ b/include/dt-bindings/power/spacemit,k3-power.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > +
> > > +#ifndef _DT_BINDINGS_SPACEMIT_K3_POWER_H_
> > > +#define _DT_BINDINGS_SPACEMIT_K3_POWER_H_
> > > +
> > > +#define K3_PMDOMAIN_VPU            0
> > > +#define K3_PMDOMAIN_GPU            1
> > > +#define K3_PMDOMAIN_AUDIO  2
> > > +#define K3_PMDOMAIN_LCD0   3
> > > +#define K3_PMDOMAIN_LCD1   4
> > > +
> > > +#endif
> > >
> > > --
> > > 2.56.0
> > >
