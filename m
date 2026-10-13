Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FA3E5EF7
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854428; cv=pass; b=Voj6VYlTtauc3h+V1SomofSgZPR3ut5kQF1ftShwOd7mz0ARTuXz5/h2sf7rwbFb90fCNZY3mtRvo4Eq+3J11syV4DRLHxpGHjMbmUTfJKC1wnK730Oy8VD0etIJHXOM3Pnd+o/K6EqCenevFbUE18FDeqYNKL/PSgj9YuH8T2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854428; c=relaxed/simple;
	bh=GLdPP9wdTOmg3Lh8rLtRDBnHGBuo68uFmOzknvlhkJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMnaTrngHOqVnPK080BrvGCbop+eJvZxJJ4SVKHn+cCjAaQp5n0PlaB3MP1u1jqkZa+7XtgWOTZU3ZissHU22AmPOxKaTEvfLmatgwm8xK06ZcfO2EUrKZMqBIsgebvpZbwM+X1Rwsyv/LPI0HVuOqLOxIogmHUSPMMvZ2BAPYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDDr7RJc; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDDr7RJc"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so387994966b.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791854420; cv=none;
        d=google.com; s=arc-20260327;
        b=grlFe4b5UU6+s+RxBrmsvjB7z7k/vE3GJ+tIIM+Knl9rZ05xwuITV8lw7Ju8S0yttx
         h72ODAOphKSNa1ubVCsxxshK6uiIQexNLFmHWIYms/VPZNU835X/lxcdZg5ExiXZNYSk
         iUKezQE+lMPrOm+KASsGWy21PvYnxROlL+LRAvD32mgeZgKRlNtqN5bG3IcUMzabcBzf
         F4LbQDx7WZud6MMU7i5441yViShSHFcm5xuzbAyWpg9eP8ybobSu8CnRXV5zhjHaECA0
         j6g7RugjqmAjMVIea+ISs3rvNMGe5xE6IfMcAF4wiOHzISXR8jBE7rhmX3XiO2NBkOtI
         cduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eDiCNa90nkNCt2ySXS6KYJDJLT9XVCk1KGiWa9GtHAM=;
        fh=xByXtoZfQlinnCCzi9d2J52KDttQ9892Uq+gpASStjc=;
        b=OCVBFrA+XH0H5KrAg/fVzJJvNQ84KW1o5qxOeedCf6el5s8ftjf4+2ZRuZJAUMpjUY
         g6e8Cas/Tix6kc1mub1NDKV+QXYfATGc8wLEe+TaH9F60iKD4s5F97acAOAdxnXejaQl
         V+K5PaIkz+Xa7drvyxuTqhnap4fzogkUA0y7C93UNJ14ywvXX9Ea1aLou8fuY/Sbe6l7
         CqCaSjOqG7Lgm+hJydY2i3YAuspSaRAJvxoMAsoZiA9L6JuvJzAk8COVYBdHgGpOt6E4
         wHhK/ldPH4xvywVfZ91IpDHFKVfDiHhmS7LG0mFIRO4I8f4iPuIThYdlpMyHvWeNxAoZ
         4dtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791854420; x=1792459220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eDiCNa90nkNCt2ySXS6KYJDJLT9XVCk1KGiWa9GtHAM=;
        b=SDDr7RJcD50209XiYVlGtKVzVGK0341G6s7mIi4MXGNJwxjdSqXlxg1HTQcZyFUmZW
         svNrjobcTS9Z+K8eHEdqu3LithUMYDGe26DrcAv2VMgJHbXDl/9TVKHNlsKPYUwOlpUh
         jx/O4Ej9Nlkn0mW1BYIJz4lm9HuotuaZ4cbzZV8oIGck4kuNGSgu0rauz2FQEzzmyrov
         /nRdXsi7kuCXOYrKqpt5JuQaq5I86hUyQn0b8xmUMXcSg2JlkGFrYotlYTJz4tbkoVNC
         cfrSRuSOS8N49t606ivWj/66KLRTSfIHucO1UTPX+qWrD5D/pYcgDA2+Lt+8EZSbi5tC
         FOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791854420; x=1792459220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDiCNa90nkNCt2ySXS6KYJDJLT9XVCk1KGiWa9GtHAM=;
        b=k8j/vjN186HfPsRc0jW+UuAOnjELNmJX/xbLaqRVQJ6LCgb9u3I3gCjjDXtii1oZiw
         1ucMTjN9kUx6iRE8fV8d8pL61lCfxPSIdAS12TvzNp6xAVL8DajTTnrAVnyBKHTZ9GV7
         Cw4YhZanaw7QWLNuajxT9KgDJ3HwnCbV2AboleWHV+Df791r64mTUIZS0DeUJ8QpDR4A
         2tQm6V57gJL6huWMnHFGbSO6YGHgydThD9qkF2ysHnGlMVxpmbhKddirOafAJ8a2v7LY
         mN8o8knhj7kLoUTI7IggOW+G6xh/RtTvt29f38YkpZbZ2UTvt3GxAoAfXLgN8ZTFwJx6
         cYfQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8kLyYEuYph2rcXYBFi2GfHQpa117hyt1DQQ8fYOrXL3/H6CkRAiEqsjfrZCWA5yFxcYcI4LDqvA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvzqTCy+8Q+Q+tNlmgXvYwcribJm52nprQHDpMra9vZBoJoIsk
	8sZp4h8ALN3pIHIYR0sDls33Ib0RG5Km3+Q+igZxuLskamFmywW33H2/QUdW3bzdjN8V3oUjZMH
	q0vNzlMOhuAhWCLCH/dfwHuCVc0wRkn0=
X-Gm-Gg: AYBFou35o4VUsbkEEh34v9ASka4Fb4YXLL6lRFZoiEtW7kFEXimckz85JcZcolwnZIt
	3u09H++FcblWejO3I85XHzTc71OnQr26895WZpUR23qzoDzyKaDR5pyp/Of4IIgmrYJjKjraKiR
	tN6Yd4G48LlzVX4t3aeLsHUQQQvCaaukYSk3qcr9bcT0QGEMroXnaigOex2OUuXl4d/VZR4qBUX
	JqgHDKBaDXLHfi4ktUQ0rQPACwR3vK6HpB7cAYxbTR01EYbpXed4e81sExlT6bR41L2Rad1TmyC
	TpyLGlo9n9MnyHLIoWFGX3Ul+0Vcms/Kv7GWYVnleMl1T6idK5aDd6w=
X-Received: by 2002:a17:907:9816:b0:c2e:378c:8ceb with SMTP id
 a640c23a62f3a-c31a9fa39abmr1029769166b.36.1791854420304; Mon, 12 Oct 2026
 18:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791512067.git.zhoubinbin@loongson.cn> <38f8e7cde8e454e7c6b72cb1b9a1c54e67c8a7fa.1791512067.git.zhoubinbin@loongson.cn>
 <66a8df16-01c5-4653-9fb5-7d746f03f782@oss.qualcomm.com>
In-Reply-To: <66a8df16-01c5-4653-9fb5-7d746f03f782@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 13 Oct 2026 09:20:08 +0800
X-Gm-Features: AclHuK83THTSYAs-3kkd9FBwRhF3injKe2tsHVZYn3kSJvncbd8B50m-i70KpDA
Message-ID: <CAMpQs4KiGsC0=xwM+4M0GMWy9XEc60sTpPACK1s97p_JURUr-Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] thermal/drivers/loongson2: Fix negative
 temperature conversion in set_trips
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel:

On Tue, Oct 13, 2026 at 5:57=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 10/9/26 04:57, Binbin Zhou wrote:
> > The `MILLI` is defined as an unsigned long constant. When the
> > temperatures passed to loongson2_thermal_set_trips() are negative, the
> > expression `low / MILLI` triggers implicit conversion of the signed
> > operand to unsigned long, and the division is then carried out in
> > unsigned arithmetic.
> >
> > For example, with a low trip of -40000 (milli-degree Celsius):
> >
> >      -40000 / 1000UL =3D 18446744073709511   /* unsigned long */
> >
> > After truncation to the 32-bit register field this becomes
> > 1271310379, instead of the expected 60 (i.e. -40 + HECTO). Writing such
> > bogus value into the trip register leaves most of the upper bits set,
> > which may hit status/trigger bits and cause spurious thermal interrupts=
.
> >
> > Fix this by explicitly casting MILLI to int so that the division is
> > performed in signed arithmetic.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal managemen=
t support")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >   drivers/thermal/loongson2_thermal.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loon=
gson2_thermal.c
> > index 4d40fc706a53..f5ff0cac1442 100644
> > --- a/drivers/thermal/loongson2_thermal.c
> > +++ b/drivers/thermal/loongson2_thermal.c
> > @@ -108,7 +108,7 @@ static int loongson2_thermal_set_trips(struct therm=
al_zone_device *tz, int low,
> >   {
> >       struct loongson2_thermal_data *data =3D thermal_zone_device_priv(=
tz);
> >
> > -     return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
> > +     return loongson2_thermal_set(data, low / (int)MILLI, high / (int)=
MILLI, true);
>
> What about using MILLIDEGREE_PER_DEGREE ?

Yes, that's more suitable. I've been looking for the right macro for a
while now.
>
> >   }
> >
> >   static const struct thermal_zone_device_ops loongson2_2k1000_of_therm=
al_ops =3D {
>

--=20
Thanks.
Binbin
