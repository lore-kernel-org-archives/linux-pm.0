Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC54570CF
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166466; cv=none; b=SEaRoezo1erF1zCfLGtqwqPm6m8CBi3Xt1AbvAM6vh+3vD5GtcjtaGYcY1rsbPkQVH+WejlEP0wgy0h27TxqHr+Vd5BCDZ9i4T2s56bct79EDXFF5BSdQmZWkM4QdMQYPPQnJEj9h/CO2MzvWnhteJFQtpIcBHvPMRVpQqfevzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166466; c=relaxed/simple;
	bh=iB1X6yc9MU3O6Kpid7OWc6ghPs6cxaK0vVaYt7GQq78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+AYnEkAPnL5rJXvFabS5JDjE7nM+ekuNdeuzTQTJFoHIdlUPE0ct+i4bvd8BENRm6RzUChh34u8zOIqpm6tJ2ahpTaJbsF6nEh+/K9RD24TfUK+Ms+wRX30EoB1Gg2kkaYhlulh3MfLTvX67vow48aEDGn01GupnzfoBsAAmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4d9197so535792e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166464; x=1790771264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWcv1ApL6q2ZhyUuH+tMQlo7vXHYJanHFmdCnLCsLWk=;
        b=B40qYH8M+knt0eU72G4cm4HY7h0bf9AcsTcEAcnEFc56BXAOzPlZrFUa+x7JamPaG2
         7K/F0D6TEK9zPOAb5nXsr3nsKsB619Xarj124ham8g+H8aHIMuHbUK6ZJfHC4jsngF2q
         IcBsVPfQJ7L89oUr/GBt6ZpKgGV88NoHRiKyXEbWcwAObC+yFYwlw0MYYbuDlabW53IR
         K1T07M98QrZzgTTgDrv2aWD1ZIBXX5YGGKWI3ZIYk8vEyL3N1LXH7cCsjvPUSG1pk/O3
         8BppnXvpqsmmdlDhZXKAVfqE7/LmTK75ku2arxmvhdq8pNgbrDFuZWuFHSQ6TvHrIItb
         0IHg==
X-Forwarded-Encrypted: i=1; AKwUvBxMGjWWnhAhGG8J6A4ksKQcjIVRPeZbx10OexTw+LgBjs1BDHLji8cJZS23feSauzrxU3XTSWUgIw==@vger.kernel.org
X-Gm-Message-State: AFuF++lBVHk5qFYrcaUI+8VynSV3UnlVo+TIxlDWhRaH3W+a/7/AGN9f
	Q0yi8KHpDaoOwKOGFeUz9JKmiw13rh+GzxrdarfQN4GMSwXSUDnZUbeUi5feNxKCuCs=
X-Gm-Gg: AYBFou3BYzHxUoflLJV1jxjszCdgpEWOmwuVEiqYgywK8Z2MyX0CfvXxmQ5OkFGvGlz
	xFZ4AI2z9aFsR/gEUdRkeGTWcUElfYruJcQHIJ9RVUtUELLjVR3eElmk/0J3dLMuqfFfupLBpg9
	d64eDkaS9Lua9lgIdvUewYW5pIJrnRjpHbCtL8X7e6Ft80O+9Y9/9Um7RXlWJhPn8qBoMxClChX
	PSG18dWkZGdM+IRT7TjlB1Mmyb4n9kXO2nLz5YyFr5wV87oTEJuaKhX0cNBsfAnnhBwtPhKGF4G
	aEdAc1o9vV3OsypaftozY+0aXe7abNE6TFIvOXD8DH7oVDige1BJyso+C8Xw8pBCOHlxyZzz/7s
	oSVHf8JMmKusDEiH8ZkNThJLwOeLP9WgT9mxs4hUwM7Ud4QQyG4t0s4Ip+p56MydbKEIIR7R4Yi
	l0kXW4gYuzYijDaHCQiUJfvg3H4/C+Rppkbpf/Zrb+D9SEKC4J0N95r+5sHMm9SqiyCG8LEPpXk
	PlpKXvEKdc7bLhj0EVpiCYKeHQABf4jjUmPaw==
X-Received: by 2002:a05:6102:6448:b0:7a9:f088:14ef with SMTP id ada2fe7eead31-7ac1bb51adfmr2055172137.13.1790166463983;
        Wed, 23 Sep 2026 05:27:43 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5c6d7b2sm3748956137.8.2026.09.23.05.27.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:27:43 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso597322241.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:27:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzYt1PJ55/JLIxPde1ee4cTT0Qz9/hb+xggpp5AFpXteHmeaRTB+qwX1QIjA4IV0k3YYSbIWNx7bw==@vger.kernel.org
X-Received: by 2002:a05:6102:162b:b0:7a1:f7d2:e81e with SMTP id
 ada2fe7eead31-7ac1d2e81fcmr2402107137.23.1790166463439; Wed, 23 Sep 2026
 05:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com>
 <20260921134432.50338-4-ayman.chaudhry.kc@renesas.com> <CAMuHMdVkh_qpJKqD7N=njG+35gS+rE7cFfWQ-kS3aRoTByxH_Q@mail.gmail.com>
 <CAMuHMdXmJWu5DD5sQ0epWX8FnWc7zt0CTvJ5_jpjj-Hnvgg_cw@mail.gmail.com> <CAPx+jO99DnXLzarD_rWgr43e6vzWCJjYWaVFh_hhr6rtivXxFg@mail.gmail.com>
In-Reply-To: <CAPx+jO99DnXLzarD_rWgr43e6vzWCJjYWaVFh_hhr6rtivXxFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Sep 2026 14:27:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqNLG15fAUt6EVf2-Ek1T=tR4jykean3c-K98+HP4TMA@mail.gmail.com>
X-Gm-Features: AclHuK_87NLy33tHoFHeNjhVq_Wp4n3b4z8txTDgsw2XX2yqZfJAlI229NijKRs
Message-ID: <CAMuHMdWqNLG15fAUt6EVf2-Ek1T=tR4jykean3c-K98+HP4TMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] pmdomain: renesas: rcar-sys: Add r8a774a3 support
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Wed, 23 Sept 2026 at 14:12, Ulf Hansson <ulf.hansson@oss.qualcomm.com> w=
rote:
> On Wed, Sep 23, 2026 at 1:45=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Wed, 23 Sept 2026 at 12:33, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> > > On Mon, 21 Sept 2026 at 15:45, Ayman Chaudhry
> > > <ayman.chaudhry.kc@renesas.com> wrote:
> > > > Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power are=
as
> > > > to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ=
/G2M
> > > > v1.3 SYSC, however it lacks the A2VC0 power area.
> > > >
> > > > Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > v1->v2:
> > > > - Added space before closing brace for `ca57-cpu1` area
> > > > - Updated include path to SYSC dt-bindings
> > > > - Added Reviewed-by tag
> > >
> > > As this has a hard dependency on "[PATCH v2 2/9] dt-bindings: power:
> > > Add r8a774a3 SYSC power domain definitions", I will provide a shared
> > > branch with the dependency to Ulf.
> >
> > Alternatively, I can just collect all pmdomain patches in this series
> > in renesas-pmdomain for v7.4, and send a PR for that, similar to what
> > I do for clk and pinctrl.  Up to you...
>
> Usually I pick the corresponding power domain DT bindings and share
> them via an immutable branch called "dt". I would prefer if we could
> keep doing it like that to avoid confusion and special cases.
>
> Note that I already have a couple of patches queued for the renesas
> power domain driver this cycle and whether this series conflicts, I
> don't know.
>
> That said, I am planning to pick patch1, patch2 (both shared at the dt
> branch) and patch3. Would that be a problem for you this time?

Fine for me, too!

Note that I will have a renesas-r8a774a3-dt-binding-defs branch for
the clock DT binding definitions anyway.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
