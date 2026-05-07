Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D07E105
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119778; cv=pass; b=qQ+XsDay6V8HjKsj0EaumyQjIVeF85bEK9fAoTUJewu0vqrsNWn7MnUotCyXZImXiUpcWt9cpBk+CGZp4gEAxn9FBWXcCucUx5s7chjYqDGDxWaXiHwzUhf4hGi7M85/BZYjjHIk0tR0qcq6MWC7U/BAFVDSWc8NNzn67yKC1Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119778; c=relaxed/simple;
	bh=5DbtpNe1iZ0qVfL3BJLfpFCZyWf01RXLM9cfAVnCyPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoIwGB0Tw1Y28UPmo9Sn4G07102ut++/Onsio2FuPZ3LQD/FG/KYAfS7OolaH2IpDTdDIMa47RXJLcbi6NZIJ7lYwhrJf+G/Jn+GzcMTUGsm9+ZYxnfVJxLPP7tGMIpXRve4nh4bJV+/8P5/hBX+z9Fr3Xxv82wkPWB7QVZXkUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFtlnZQU; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFtlnZQU"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50fb8e9a4edso2890451cf.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 19:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778119776; cv=none;
        d=google.com; s=arc-20240605;
        b=E2DpF0fW0q5siXpaV6aLC4ELObSg4N0VuSTCPztD9LTQoFfoLbW0UXAZXSFfoL2eOK
         UpEVodBi1n3tokn7+hvwJDPxNARCauWJXZC90fctpyJc2Hq18Xf/IdJ/3ZmUbJlo9kMt
         0sVyfssLni/NMmRA9HwSkw2HrPcHwnWj6LpCO9WvnJfJ/9qJtI24HY7R9n8pQ56aTrwr
         pVjxYZRCA0nMEiiuTmWpoVxOdv6yu4LUn2/IXYil+jA6I9qBFD+ysj/Pf8xHXSrgxcHy
         dLx0G+VuEnC9JDPoES5mA7yEHaeg0kamwGqIshHSkKnQZ3CpBZVQ1UGXcH0iXTQB1k29
         8AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8bxHPHHAlVbOErqzdQey6RGZ6cDcZE57ewPYSe68Xk=;
        fh=NT7caMhM/cOAhN5b/+ZnScmPaTdKCl6KF9ZxhVqH7d8=;
        b=Ka8LBQyMPX4A6J7hFYdkI9pbOhJk91z6xhTGx4lgQBfgROi12Ck95RPINWFzYYuFxR
         QB98DV0j1ROAERbdVd4WlXk2Dlrsp+8nkYKTUr6lLOUNzM4UDWaWVWKyNb7KRTkOj5cG
         n2F5+66WSNT1YfpErg886PhrZgbTbQj8MVkaLsj0fBbTbhCHWCqGK/kkGLWMWZLsH9VI
         xRhiAYrHFSFhM+Xxr0+6fGCExb8+IErwMGe2NIO6jFtvwu/sRc0Ne7yWgUu9/DnHLJ4m
         sR8EF5xT/dr2sUNA/Pup3jJKuu87awze7AbIsOiOPdChxUlvgbKOwHGeMjngLjV9r13h
         eHew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778119776; x=1778724576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8bxHPHHAlVbOErqzdQey6RGZ6cDcZE57ewPYSe68Xk=;
        b=CFtlnZQUbEbMvpFZ5ePRVH6RoEsE63QIAN0yHwVniY5O9yVLq2zelJ405tzhgO790d
         wyKV1ldFexY8BajnHq/8X/GnL6d7g988D9DVkZhsW+FWfQitXMQvJQMnf2pf+u6VKS3H
         a/T7NpKMWrN69xQu8Bb5YO4jvJejx/+Sw83clMrKSsgTqSiflrNj+lwvYe3Ih3cLks3s
         6QFCGF1tdGoNreWwXuXyRhNGiKE/iHjlDzkmnnBhwMbYWzHKcFLr4yNFM8hmr1QFx+fC
         webJ6TYgm03F7Sk3dvYeqgkMrutcAJQWKixKZXpXA76qUTYikN7b9VRdUP+u+Nyc7biH
         KZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778119776; x=1778724576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8bxHPHHAlVbOErqzdQey6RGZ6cDcZE57ewPYSe68Xk=;
        b=BnqCzxF59/sFMipdcLi3IZfMz6pWDBJpNneLDzf3YZksSnMlARm5z3V044hxIwwNxe
         yN9wxBNEN+UWFkWJONFmWhuOdOXqBXTLAh6fM3bBCb1Hq9g0YuO/pdVA2kRaX9Qwu62A
         vg+7tVUnelChdJa0vVa3oiIAi1JauDIXSiTT6EpDUFbDYdWGnN20lrLoDCDDKIbFdALx
         HuTkB18BJxkFWWUQjlGJM0pkuVSWXZHjgGy3XF/TGJMX3irWKK21qNN5kDGyTaH3s0+v
         7dspzQFviNvReoVuUIABG+b82cUs0LPq6k5X87mnsYNKkdyu8fkMKw6tLIEDuwssB0tQ
         /E7A==
X-Forwarded-Encrypted: i=1; AFNElJ8pMGSCcNHp2+1huBRhLEgf72ThfHIcwJm8TWCErPbhTylkh6HF9HSqYLKfERgB0iGSw7VKKcogUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFARH+PZPZIL1et9UvWjuaTq9ykOgQmABkfCNWngEAl3N3tW9
	fpTOMC207I2udjaon9mIhXHC+elFXeL8Ce0yjFrRhuH/5u9MqbPo7sgjj+O97lnJHKXQidso6bc
	0lW6BU6MJKbjv+hjy7W08SuZo1sZtTwU=
X-Gm-Gg: AeBDietMcbc2pfy/+CZL0lcs2qfhvzQ7elv28zvLzA34pTKGBs3qlNGlRK2+Hz3EpDF
	XOieDXg31+T9JcirVcbyx04uzEFZdLlcrMyEwTaLhXBkwcPklumJ3oG8jEfguDrWnA1BDsZUcJ8
	Qb9UVr8EHq3anXDwZLwO/34fcKkoF2SZp4xpI7U2Jf9tVnpQVdJ13LoAKmGgKHlicQ1OxIlPXyN
	EHJev+ct+9/mnxPlYbGBCivn7RLrBzLRccRskiV1Z6a6EYHKlAkLBlIIbrG2y1QeAItZtRTiskI
	HKdBUTRQORoUCB5nblA=
X-Received: by 2002:a05:622a:114c:b0:50b:41bf:4ee5 with SMTP id
 d75a77b69052e-514621f338cmr90455811cf.57.1778119775649; Wed, 06 May 2026
 19:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427120047.10830-1-xuewen.yan@unisoc.com> <7k6ttcmptilvxmp36dvtznor2gfd33rzledbqfsigmjbkx2rhy@iv4lyzej6ibc>
In-Reply-To: <7k6ttcmptilvxmp36dvtznor2gfd33rzledbqfsigmjbkx2rhy@iv4lyzej6ibc>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 7 May 2026 10:09:24 +0800
X-Gm-Features: AVHnY4LkTYJ47rhDOVgn-bmKzmw-ituo_F9h4YWjf1BFbqZ61jqmMJdQkGklcpY
Message-ID: <CAB8ipk8XGBtChKV7ub6UcqYyfmnJSvuTX5DmCQrgf8ci9f9cMQ@mail.gmail.com>
Subject: Re: [PATCH] pm/opp: fix race between opp_add and opp_get
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, di.shen@unisoc.com, 
	ling_ling.xu@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, May 5, 2026 at 11:36=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 27-04-26, 20:00, Xuewen Yan wrote:
> > From: Di Shen <di.shen@unisoc.com>
> >
> > There is a race between opp_table_find_key and dev_pm_opp_add_dynamic:
> >
> > dev_pm_opp_add_dynamic                dev_pm_opp_find_freq_exact
> > _opp_add_v1                           _find_key
> > _opp_add                              _opp_table_find_key
> > mutex_lock(opp_table->lock)
> > list_add(&new_opp->node, head)
> > mutex_unlock(opp_table->lock)
> >                                      mutex_lock(opp_table->lock)
> >                                      dev_pm_opp_get(opp)
> >                                      kref_get(&opp->kref)
> >                                        refcount_inc(&kref->refcount);
> >                                      mutex_unlock(opp_table->lock)
> > kref_init(&new_opp->kref)
> >   refcount_set(&kref->refcount, 1);
> >                                      dev_pm_opp_put()
> >                                      kref_put_mutex()
> >
> > This would cause the opp be freed.
> >
> > So use the mutex to protect opp's ref count.
> >
> > Co-developed-by: Ling Xu <ling_ling.xu@unisoc.com>
> > Signed-off-by: Ling Xu <ling_ling.xu@unisoc.com>
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >  drivers/opp/core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
>
> Good catch.
>
> Applied. Thanks.

Need we add fix tag=EF=BC=9F
Fixes: 7034764a1e4a (PM / OPP: Add 'struct kref' to struct dev_pm_opp)

>
> --
> viresh
