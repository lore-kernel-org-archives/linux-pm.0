Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5E3FCB22
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456561; cv=none; b=gttxUplft95pQ5CUZkxLKsX/GN8gtYHFdFuBo1VXCa8WTHetnTUuDNGa+T3hKIcYnuwLsz3E/yD3pQIMFVw0UX2YuAmSQKR/O+1Ja8fsSfUjQrootizgOXnXDRxRQO7riLMaz3GBm20xk+LwujkrzuHR09M5Dua9HFna7iuoLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456561; c=relaxed/simple;
	bh=vX6p1CDvWad+GoKbzvthJkwyI07/wTijn9ZWHgYK/o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLNeyl/TtD5dd5qM+RnjtHdOcuFGxgzHlObaZNuP2rgcAvm8bmEr5MbJZ0tuZ6DkQ7Wjov2yXY9Y/DGGZihT90ZxgPMNG528XJch9A9zPFVXNH8qVEH82f7EGHCkmgoitk8yIaKUjQ1smn72HeRgmRLicTdSSOhiV23q4/ajCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso101366e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 09:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774456559; x=1775061359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDjwaAywwU03wv0+eLKkG3IGOSH5Z69cyrkxX7M6ckw=;
        b=CkPGTPPs5Qirb5+GsUpsm8iZcKDo1R2fFQt5NQlTKk/xUAfyel9B8Et+UXBhrH8jra
         UmfSc0E9qSq5o2cuXNnFqT/Fzst1cf5paVcvqAhmE/9l/NVGy3CGNUrpJO7aisvCLjNs
         /W2wKEowlwu8Q7+isD2x/uVJDBIq3wowXDxD0OvyBAG1+hV2ZJxEGNKhOQAN1mdq87rH
         hGqRWOVVEgUIG9So5NwEI0FV8WRQk7XmOqQcpSZQysqSiiG/xfITbDRxepDPOa1zMvF2
         xDztOHpVFmVMptb3P7uylJY7Jy6WeT3e/U0Iz8B5JZjL8mNcqdqy1KaSARRPMlpRzkTG
         wveA==
X-Forwarded-Encrypted: i=1; AJvYcCVE14YHYtT+59YXNV+Rr3JRRwdKvkUDHYetUuQXBcAHpMDA6pVIOvizXDIjLQ1xvPHTkmEF3xfQHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67G/K6wYR5WO0xm7XPH6EafmVNKTQgpETC9EN8SsWgg98GyBb
	RNb00Gkq6QBuhpjXAcKl1pDglfbpf5JTW/jTeSd3x0E2UTKATryd1fDGH2lrwJeV1kw=
X-Gm-Gg: ATEYQzzQY0OvlT3ggx9V2Thx8BvwPIrgV98ac1uk0TsoIP742viidVuW38E3rJfPtEa
	dbbDbNh/nLuptxIKNPVGgo82DNg4vnUyUSiPW4yD7Bpuyh9FyWVty9ZV37ZGJfTze6tg3f3EY1h
	dEj3oUSYyrT9noa2ZeNLrT7Zvia8OliIoyZrxsjauhno8z/AMFP+wuzALYuCXYmPzJArq0Mk1ON
	Xke2ZJpJRO+3SR7B3T4ZoFygGIDtM0cJhw5UhEkfGwfJ4WKn2grU7wUb7hWxH2nRLuxyRMFYEAm
	fxnh8Jj1bsiGH18feaggti9aLkSJPYtEQhAvWNFC2oo+qDLJOtcShzSreHFv5HKCDFol7jwF7yQ
	7QQVD3sAJozDSR8mLRbBVSTppSOXz2La5uZRoC0m6sO5m3FGIMce93a+uYS0ilBKil78OXVnX/f
	Ybui0MY/6hJ6kTbwYAPm0yKbj0TId19Q7puC8n9INQgWTBBrCsjQm9StEfKaTbHTXNP6DVD7A=
X-Received: by 2002:a05:6122:218e:b0:56c:8e80:7191 with SMTP id 71dfb90a1353d-56d21f2956cmr2436408e0c.3.1774456558955;
        Wed, 25 Mar 2026 09:35:58 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31bf7190sm460242e0c.3.2026.03.25.09.35.57
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:35:58 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-60406d330feso816836137.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 09:35:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoNz6BnPkj+UfwDPciIhI9ofX+H8riHrxYUfTMofQjsk19F9BcRHuKU6Dx+539GnqFdYh3m2eCQw==@vger.kernel.org
X-Received: by 2002:a67:e703:0:b0:5ff:ea89:44b5 with SMTP id
 ada2fe7eead31-6038753a92emr2391289137.32.1774456557341; Wed, 25 Mar 2026
 09:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772468323.git.geert+renesas@glider.be> <10876b30a8bdb7d1cfcc2f23fb859f2ffea335fe.1772468323.git.geert+renesas@glider.be>
 <20260313215912.GA3415767-robh@kernel.org>
In-Reply-To: <20260313215912.GA3415767-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 17:35:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXFd5Sva4Hu7KufgMfiiF02Z1z+UgLyJH=KYPvch4673Q@mail.gmail.com>
X-Gm-Features: AQROBzAa9n7pyJe-8mgf6m8MWZ5EBfxKw9iKFNekZ5OaRcP6UMYY0cGuEWeDl6U
Message-ID: <CAMuHMdXFd5Sva4Hu7KufgMfiiF02Z1z+UgLyJH=KYPvch4673Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] soc: renesas: Convert to of_machine_get_match()
To: Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Fri, 13 Mar 2026 at 22:59, Rob Herring <robh@kernel.org> wrote:
> On Mon, Mar 02, 2026 at 05:29:11PM +0100, Geert Uytterhoeven wrote:
> > Use the of_machine_get_match() helper to avoid accessing of_root
> > directly, which is planned to become private.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This is an alternative solution to "[PATCH v2 8/9] soc: renesas: don't
> > access of_root directly"
> > https://lore.kernel.org/20260223-soc-of-root-v2-8-b45da45903c8@oss.qualcomm.com
>
> Greg applied this, so you'll have to respin on top of that. Next cycle I
> guess. Unless you get him to revert it.

That was my impression, too, but apparently he skipped that patch.
So you can still apply this patch, too.

> I'm applying the rest of the series.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
