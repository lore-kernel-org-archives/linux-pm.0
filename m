Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793573527;
	b=Xh8XOZctA8pWanVlxSqgwherhNmftzAzDKJ2WbbXCsFX9CEfrZ2KArJEfsE5wQdA4a6V
	 tIO/aS/Gn4Uklz3H5ZKiWNjDLyaNvfIthToizd1AOJU7JNZIB7VWnAMJ6yPcfsnb8audH
	 NO4x7FvU/VABt3rpBwCebqINjqyE9OIZZh9q1vgmFrmoeENCVs5FTirll09KoBrjXh9Gc
	 egyXaMNOoQKxbhcGRgUoWQK2BZKXJEezeFPl5G3uSWuea+AHCOIlEjHfjjZGtGodjpwbH
	 9f3i1Bo31rgpvlOOWoeAex33/BIiu3OavAzAUnrfmtCFTeaLJzYztUsxyJ3heeCuAUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793573527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wOzU4J0to3q5u75B4/uwG0UTHx1qIwAg/dSoR7NVoag=;
	b=wQRDwUvS5LONcME0SGH1dwZMy35osFDRCpoNqIhPUlWQ9J2KHi0Y+lUzrwmi5EmgZ9V0
	 Za5KclZ8B1+9KWVBNZbmoqjGJ50rY05gkkVBOelV9HpRnZmhEKTjy8IVrk/qHkIX19cjh
	 SabJumUanDci1A47WlWIHMnmMhMfd8ci18/3vbSyF7xuagxEpfSbWkFjBrRUdbkHOMH5/
	 rqMJqhHwFAlYZZVn+a+a3TP/OVt9f02J6CJU19eOMd5lDaW+RlkToQcB1iom/XKzai7oq
	 WGu8x8UIRa8pksTdLbmk8cyl6VP+OsYfrkfkzy0tIRiSgdh9rH+Qt0zKGn1trRmV+4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KZ68MGIt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F39606A327
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 22:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F39606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KZ68MGIt
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67583c777abso2527050d50.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 14:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793573526; cv=none;
        d=google.com; s=arc-20260327;
        b=EnPeMYA1p82RpXsYXHrKSxJO8R+gjH3h5Pp5cUSQaiLjvysjmlhqRJ5Oy78WWeVMq8
         KQxIE125T/182ADWQk53IWTLpZOZXRJv0KFA/gXV2VbQc/gNSGuRkHMXCVwsGhYkiVlQ
         lkCB7d+Z+ilO6RHQdsjlJboWekMi1d0IlnZbAuOhJXYeMOaZsYL9pW/jlGV1JJIA5m6a
         DhOpELfOGfOcof2TntdWWSE6fFXDjAbr5v27lt0l+DoCZgQ88MZjOB/9tTcjUU0GVVhe
         MItTvFotlT7DGzblrgamy74V2yK2g6CV1QtJa211tHFUUcl8DmSS/JtY/K9dUQG6TvBJ
         TFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wOzU4J0to3q5u75B4/uwG0UTHx1qIwAg/dSoR7NVoag=;
        fh=3Y0v6CggpwpOwtUZ5TDKmfkAVU5RtWZwztA/aDY1xsM=;
        b=LiERXapamjCQ0Qfq41g3D13qX1w5X7MeGtmuin1x7C0R1N5WKu5C4H9PTbGMCaQBxV
         IbJJfmDZeH8hCIgveLYGofaFKreY9E8gyoSRoRK3terx9gHvgLsHKG0l572Oj61pfbjm
         AXfb8/c3p0SE7q0KeCD0u5sh4Cd1r1dwJ7x7iuBZWP6lW29NbwG5TByW2P2cmmhzuwGD
         aRHZjxAnAr2rUw+EAxhLFuR4NO/uAsZ5hd4sx+gOYD1v79ErLHyExmI6yr1U/QP4bu9/
         Ew9QUVmphzPUFHAyMZKIYH7iyjaXLCt3akOWQLgx/6o732fGP1yqovHiNyAN9GEDwjDF
         1eoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793573526; x=1794178326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOzU4J0to3q5u75B4/uwG0UTHx1qIwAg/dSoR7NVoag=;
        b=KZ68MGItEmtYSfdv3J5fm/2IoBnChVUSeKbq2Pa66qGPTCPZjw3TnNDR7b/HHfTnOI
         ZSBqujYvLhZYxAyeD7AOQlWvl2xFdw7h5YJjYkR/NPjxhHERs2SmsKmpXIVnrPT4zSPg
         q2Ia8TIOxDqtwOhukNHLVzi51sI/YjxQCjWW2edbHWxYb6U9wnMm+E2pZpD4SE59rzRL
         /6ygKXGOOPT09kBvGn9s7JyMMiYKF8/BEANC3gI5wCCHaOEjUK1RbKZJ9aql47PupZTh
         SxgglZnclSCWdppYicxZ/COEGDmi9VA3TnJnENbWlAKvgs3NxWelCFEKOE6eb1X67v0S
         KLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793573526; x=1794178326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOzU4J0to3q5u75B4/uwG0UTHx1qIwAg/dSoR7NVoag=;
        b=yWLS/JYl4yY08H4mM17ukK7Or+78QruH/8FC0Iupbkak4g/TyPhYnnXc6ZbEiXf3RR
         lSaNiJZVdF+OyW8i+6TIritYXPtd7qu/pklpAr75cjOkMKt2JJMyTJpz2PRHOMwO1ihF
         iNz/sVTCB3eOwjx46bHRZOnhTtPKK6IwHWhWziWLROMZ/gRoSMarjHFrTmi29XUcsNLX
         hyC/l176LUdKeHyGLRfouzEU6DYlyTEb5pQ+MfwCI+qZX9wgNojkjKvZpY6Wk8Ke/o7j
         UA/zDH/mgx63YfNtJhCfp7SOgX9FOWPvFFCuixLmHxDEd48Wf1pQZJEMISQuvRLA9YBN
         k1YA==
X-Forwarded-Encrypted: i=1; AKwUvBy9QAJvEcN3sKISkOA11B2J1H6Ma8aog9WBoy1jnKDMRhU2lUm3vrIsiyTOvRPOTWVgCbY9pB9tqA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+S95hAIDraeWJT/Rfz+mYR7MkRy/frov2ami75uVLMDHy+a1O
	OiYpn0SHtFbj1jFe8uTLs0C//ldjk8jxeWqrKUappJ54uY/STyVFaQCrSVDs1zMVttevG2niXss
	NMditx9KYoQZIWyrfDessczNoKFxJVp8=
X-Gm-Gg: AYBFou3zTDF20GUVYD/YACTapRlcuzRlzmauwMvuysJ3uenVIkDhjf+Q9eqATXdPgzt
	n8IVkhNPhP1UwjyZd3Nx3MtkrzwJxDP7KKzF+sMgfo06deE3VsHuZpQm44cZmHjMLuB0ehu8qFe
	mqwQ+IUVYbDbgJibb+SZMqzen5zqhOl7bzyukYl4c49AfQmYRmIutv8pGaJi/ibByDsB75JbF5D
	wytpyZ6pgAfx+MUsFVZglVlVs1ZOzyCLnZpbbQs80I4/4nCVl7/6aNl7g5GOKiERUTvZjklBiBj
	5KI95MoT3zxQ5qk0o/snldqx9VLS3WtFQwZOQQVXjkZ6v6dQMABJdVKwc0tNusJXJdeiwD4iovZ
	lqmxWYAhWiEG7qVKU1KIzfzDhhWtOYNoCdNjMI+xST9ds+LVpotAhvAWglu8EpQLRp2X5YQ==
X-Received: by 2002:a05:690e:d8b:b0:679:c17e:407a with SMTP id
 956f58d0204a3-67a8d6465a6mr9056359d50.49.1793573526001; Sun, 01 Nov 2026
 14:52:06 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H> <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
 <at8WfX_G0tfTlFrm@vireshk-B250M-D3H> <9556e959-daf3-4c85-8794-9613e7e7a9ae@gmail.com>
 <A45EC676-5B14-4932-A4CF-87ED3B71108D@gmail.com> <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
In-Reply-To: <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 1 Nov 2026 23:51:55 +0100
X-Gm-Features: AclHuK_A-gwxcDtkBYM_gQIRYpVip7Aj0wblI5gGxYX_krXiPxYiKaGZaOCuxQI
Message-ID: <CAFBinCBkJJeRPKLFBA9KYjwXMxFjow_NOtvFoKRQdxD=rOPW3w@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, christian.koever-draxl@student.uibk.ac.at, 
	neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	khilman@baylibre.com, rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	=?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuan,

On Thu, Oct 29, 2026 at 6:30=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com> w=
rote:
[...]
> Regarding the concern I mentioned above about supporting a unified
> cpufreq driver across S4, C3, T7, ..., A9, let me explain it in more deta=
il:
>     - These SoCs fall into several hardware architecture categories, and
> I'm wondering whether we could take all of them into consideration and
> implement them in a single amlogic-cpufreq.c, for example:
I think the main question here is: how much code is shared between
various SoC generations.

>       * S4/C3: 1 * cluster
>       * T7: 2 * clusters
>       * S7/S7D/S6: 1 * cluster + DSU
>       * A9: 2 * clusters + DSU (the 2 clusters share one DSU)
>     - For different hardware architectures, the resources that the
> cpufreq driver has to manage also differ and are coupled with each
> other, for example:
>       * S7/S7D/S6: the CPUs and the DSU share a single power rail, and
> the DSU frequency scales proportionally with the CPU frequency
> (typically dsu_clk =3D cpu_clk * 80%)
>       * A9: the resources that A9 needs to manage are relatively more
> complicated ...
>     - Optimizing the cpufreq transition latency:
>       * Clock latency: for most S4/C3/T7 customers, the released bl31.bin
> only supports configuring the CPU clock through SMCs with discrete clock
> rates. Frequent set_rate()/set_parent() calls in the kernel would result
> in a relatively large clock latency, and would cause the sugov thread to
> consume too much CPU time, hurting scheduling performance.
We also support a few more SoC generations upstream:
- Meson8/8b/8m2 (32-bit ARM Cortex-A5/A9) where we need to reparent
the CPU clock to XTAL for stable operating during clock changes (which
should go into a cpufreq driver that implements target_intermediate).
There's no secure monitor or firmware involved for CPU clocks.
- GXBB/GXL/GXM use SCPI firmware CPU clock control so to my knowledge
we're good with what we have (meaning: no custom cpufreq driver
needed)
- G12A single cluster, no DSU: needs a cpufreq driver that implements
target_intermediate (currently it's managed on clock driver side in
kernel space, no firmware involved)
- G12B multi cluster, no DSU: needs a cpufreq driver that implements
target_intermediate (currently it's managed on clock driver side in
kernel space, no firmware involved)
- SM1 single cluster and DSU: needs a cpufreq driver that implements
target_intermediate (currently it's managed on clock driver side in
kernel space, no firmware involved)

[...]
> The amlogic-cpufreq.c as implemented here can indeed cover the case of a
> single cluster with no shared resources, such as S4/C3/T7. However, for
> the upcoming SoCs where multiple clusters share resources, it may not be
> sufficient to cover: for example, on S7/S7D/S6 the CPUs and the DSU
> share one regulator; on A9 the two clusters share the dsu_clk, and the
> sharing relationships among cpu_reg, cpu_sram_reg, dsu_reg and
> dsu_sram_reg are even more complicated. For such cases, extending the
> current amlogic-cpufreq.c would be rather difficult, so we would like to
> make an overall evaluation.
I think you're making a good point why it's fine to have multiple
cpufreq drivers for Amlogic SoCs.
My suggestion instead is to name the driver in this series
amlogic-s4-cpufreq (or similar). From what I understand C3 support
(maybe also T7?) can be easily added to the same driver.
For the 32-bit SoCs I'm planning to implement amlogic-meson8-cpufreq.
I don't know how relevant DSU is on SM1, depending on how tricky it is
support may either go into amlogic-meson8-cpufreq or (a new)
amlogic-meson-g12a-cpufreq.
And for the newer SoCs like S7/S7D/S6/A9/... I trust your instinct on
whether they should be in one driver or multiple.

> We have done a lot of optimization on these issues from both the
> hardware and software sides, and we would like the cpufreq driver we
> submit upstream to cover these optimizations as much as possible. For
> example, the bl31.bin for S4/C3/T7 has already been released, and
> updating bl31.bin may cause extra trouble for customers, so we would
> also like to balance this and see how to minimize the impact.
I agree. I my opinion it would be best to allow the OS (in this case:
Linux) to manage clocks so (closed source) firmware binary blob
updates cannot cause any trouble.


Best regards,
Martin
