Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D263E7166
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651209; cv=pass; b=KrAay/YvvtkiYzCFo7jb0b8vviHbmyZ6FGjPYIBWxfxy2GYDpw+KcFKiUVp99p4v9TkvtFAqrB3/2HBElnBBxR6sRaNurxJdQpDz+MpMtaTSSiWIa2a+9F1deY9zFrCSjZUVdrjQcdQuLP/uKGGWbOoPpIJ7iceSNL+gN+7OI4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651209; c=relaxed/simple;
	bh=drFBxzfc6W2PaLGZNBuSoVjThY1JgVwWxNvEN6zvNfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1tz9R48QH+bN8Rzi6cfzz1Ob3QxjcpVX6le/oWPx8fwnOV32DIV8M5YlExzd5F/BlkLdDvDSe/6vdIBUammfF8TTu4Buk1bTO1RgLWr8b2cV3Wh6lXB2ZhEyrqbQq9nbpTEMSG4vXPjAlD22GHWjyUkz8DmhyfGY6Spii4T/Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWrX4yDA; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWrX4yDA"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso52821a12.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 20:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790651198; cv=none;
        d=google.com; s=arc-20260327;
        b=aB55puH19rNdmZ+64E5Negi6zNiXkMDHtFlKdlBvNA+jUQiN52gRR61TkgVTLj4mij
         iKu6x9va+Mz3GpCF1TCUowgLGdV1tj/RndJlGGwX/8dpoY3gx4+BmkHMi+59+9HGE8zQ
         azyYvC5Mso0svO6vTx1Msvwl6E71Sh/BZe/d10dd682VdRLCvn0M3DLVkn9j9mqZrj+q
         cc2ECq1kSoYbvHS246GOURX4uatDaXwxL2K6UJK5veiLgbmK4JD6ebatMxUDaNhdMUnD
         aQ+a7/e0ZJXnKtoodHscg7O+ND9p29z99EtxPpORERPbNeA4bTsXfJEC2h0sU24jvw8T
         elCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GsgcGMq63dxBO6lpCOoish/kEuxevaMsXSsx8TcWvog=;
        fh=pLxtB2D5fdXnfjeJk/pL1qe4HxYkeibzvYLhcQTLmGY=;
        b=R5ijJjkNF68l7EImRJE+U353iQs0IMv7gVdGa7qsIHZMRYfw3YFPCD8wc+uCul0Uyj
         u4vCYOBPHqdqTtR9tFZFcbvA/cWLN1A/97cJ6YPNKeV7otiIZ/0Gvd6plr1NGgJdzzj4
         XK162anngSRYQe3CTP4OJTdvS92E9IsKCPB6aho2/UzuRg7m2BHoVJb1It6XkQghvD+E
         Sa7XGAC2h5qXMef/SI+9yQmWwNXluHw0knygA/lbA6DQxZhlK+lTXdnPF92Y3qSAJw9P
         GVIiHfMGCT4zuucycN5JeeGDJsbbYQheAZdQG8ii1ef0QKmHX1UT8mXPtdFI2unRqij4
         TEiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790651198; x=1791255998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GsgcGMq63dxBO6lpCOoish/kEuxevaMsXSsx8TcWvog=;
        b=kWrX4yDAa4RF9Glu41S/GnWcgrNxZd8gOe2sNxpzDU7tLw4CGL6aO4lBL1jY8rwAqY
         NsMxS0KyxvgWvsrSH4uoMKp/KsHCAIph2e/ZoIQsCxRss3uRoHcCVMKS74M26yM4PrLU
         qGm7/6YB6q6Vl4XT2KXAlBeFIIz/oP/O4URoAFukMEWKMlTezySm053hR/Q79oL/EkOB
         PMTzmR9w8Mgvxh2XTdwzHBqsm/rpW3kkbzrcm6Am7dlc0qnlnTEKItjMKQqOkc15EjY7
         6O8caKHkhrKqQo7ZY8L8tJR+1BF+P2GZUOx3olhhXP01sTrge7XiSE7fzwDY0sEMDiy0
         /ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651198; x=1791255998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsgcGMq63dxBO6lpCOoish/kEuxevaMsXSsx8TcWvog=;
        b=QTn9gs3pJlvX1EVtolTb1eLbLOTSrSEQm2hQs83ehlgdPDt9MXoysi6ryP9QgHN9jm
         kQL/YEWhmxdB8kGhWgalQz2cRh5JPl8eApHGFYjdMzyQEf0Efj2j+OgSv724tOKPKJug
         iojGUEqaCZfaLNtffLGFUNaIocqbYV2/hDLQBhijKZMlI9UN3PbX/KJsQfeBmm/jaY8v
         SIRsnqId9F2D7cnqTzwb9qKRK0Lgxz3tF73uXuzMAVQi6VKwRmKdMkZaPtynvtgBBeV0
         tR/Ih0WQKNMZGvkLVrNwAEAVhjUChdEH8NRGuDsvNOlm2eu7dCn9i0sZ8IvjSrqLKEsQ
         EvSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXNJI99F7g3CdfBfr0M1CtOW/NVAkUqFpDYd5cdXy0h69cQQk+4qUzTsPq4ff9aZrMH9tvtHwsZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKnzbtC6Wqd9tGBL17ETTaIYB1pa7f/k+E586h4PrIfAvjnfB8A
	VSsQYJkSWpGpPaH6MoH+nQlD21fl4G7VrK2RB+xsKdbKFeVcWamZFglynyyoM1flbUXq/2wbEyG
	lJ3YpsOWM9shE2rUUfigKe4QQrMKF1gY=
X-Gm-Gg: AYBFou31L5p1B+APygldXZ58Khiabe/H4mCdnBQKBe9ZE2s9DrhOzf+R6m74Hv9vzz0
	DfvZQdECqQNSCLvybWh4G3uapifeG5FRU/zfQhkD1ug7WT05NR8meYnl8qSeI+OWnCVFWLnk92v
	j9m7fc2FXqzn3Cd8rHAAAF9vRMvOoSqekbvDCPWNTgnBbdL1B70kpCqP8SUrEbtdAtYeA2wG+yu
	zucbiOA6dSAVFurF+Tmh2IBVTlLx6ERdSbiTeiR8p63x+VLX4tFayzadQ4TPQi1CIKMnm1yp1RU
	aRhAUARDSOQ5qIfIol1W/MwzYURbgGJ6RHhHTQJ5TqtbHNWndaknY5RR+uP5IuleBRbc
X-Received: by 2002:a05:6402:1d55:b0:6aa:7fb:7678 with SMTP id
 4fb4d7f45d1cf-6aae8a518b4mr7987012a12.6.1790651197346; Mon, 28 Sep 2026
 20:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790561983.git.zhoubinbin@loongson.cn> <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com> <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
In-Reply-To: <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 29 Sep 2026 11:06:25 +0800
X-Gm-Features: AclHuK-pCkswqNWZEVmRnm0h2nAuqgvV_q4b0kCJUY7w_QKyo1tWrrar9EH7iE8
Message-ID: <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel:

On Mon, Sep 28, 2026 at 9:23=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 9/28/26 10:17, Binbin Zhou wrote:
> > Hi Daniel:
> >
> > Thanks for your review.
> >
> > On Mon, Sep 28, 2026 at 3:15=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >> On 9/28/26 06:44, Binbin Zhou wrote:
> >>> The registration loop in loongson2_thermal_probe() incorrectly uses
> >>> dev_err_probe() when the sensor is not present (-ENODEV). In that cas=
e,
> >>> the driver should continue to the next sensor index rather than treat=
ing
> >>> it as a fatal error.
> >>>
> >>> Fix this by correctly handling -ENODEV and only returning on other
> >>> errors. Also add a final check to ensure at least one thermal zone wa=
s
> >>> registered.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>> Closes: https://sashiko.dev/#/patchset/cover.1783670011.git.zhoubinbi=
n@loongson.cn?part=3D2
> >>> Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal managem=
ent support")
> >>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>> ---
> >>>    drivers/thermal/loongson2_thermal.c | 8 +++++---
> >>>    1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/lo=
ongson2_thermal.c
> >>> index 4d40fc706a53..99b7392fc68f 100644
> >>> --- a/drivers/thermal/loongson2_thermal.c
> >>> +++ b/drivers/thermal/loongson2_thermal.c
> >>> @@ -160,16 +160,18 @@ static int loongson2_thermal_probe(struct platf=
orm_device *pdev)
> >>>
> >>>        for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
> >>>                tzd =3D devm_thermal_of_zone_register(dev, i, data, th=
ermal_ops);
> >>> -
> >>>                if (!IS_ERR(tzd))
> >>>                        break;
> >>>
> >>> -             if (PTR_ERR(tzd) !=3D -ENODEV)
> >>> +             if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >>>                        continue;
> >>>
> >>> -             return dev_err_probe(dev, PTR_ERR(tzd), "failed to regi=
ster");
> >>> +             return dev_err_probe(dev, PTR_ERR(tzd), "failed to regi=
ster sensor %d\n", i);
> >>
> >>
> >>>        }
> >>>
> >>> +     if (IS_ERR(tzd))
> >>> +             return dev_err_probe(dev, -ENODEV, "No thermal sensor r=
egistered\n");
> >>> +
> >>>        ret =3D devm_request_threaded_irq(dev, irq, NULL, loongson2_th=
ermal_irq_thread,
> >>>                                        IRQF_ONESHOT, "loongson2_therm=
al", tzd);
> >>>        if (ret < 0)
> >>
> >>
> >> The [no]error paths are confusing and prone to error, eg: 'if there is
> >> no error then check if there is an error', 'when exiting the loop
> >> without registering any sensor, then we assume tzd is -ENODEV'.
> >>
> >> Please make a less cumbersome and implicit checks here. For example
> >> count the number of sensors and then do the check against.
> >
> > I thought about it, and you're right=E2=80=94I made the logic here too =
complicated.
> > Let's use `sensor_count` as the counter. Is the following check logic c=
learer?
> >
> >          u32 sensor_count =3D 0;
> >
> >          for (unsigned int i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM=
; i++) {
> >                  tzd =3D devm_thermal_of_zone_register(dev, i, data,
> > data->chip_data->thermal_ops);
> >                  if (IS_ERR(tzd)) {
> >                          if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >                                  continue;
> >
> >                          return dev_err_probe(dev, PTR_ERR(tzd),
> >                                               "failed to register senso=
r %d", i);
> >                  }
> >
> >                  sensor_count++;
>
> If I'm not mistaken in the previous version, the loop exits at the first
> registered sensor
>
>         if (!IS_ERR(tzd))
>                 break;
>
> Here all the available sensors are registered

The name `sensor_count` might be a bit misleading, but here the loop
exits after the first success:

                sensor_count++;
                break;

Let=E2=80=99s rename it:

bool registered =3D false;
...
for (...) {
    tzd =3D devm_thermal_of_zone_register(...);
    if (IS_ERR(tzd)) {
        if (PTR_ERR(tzd) =3D=3D -ENODEV)
            continue;

        return dev_err_probe(dev, PTR_ERR(tzd),
                             "failed to register sensor %d", i);
    }

    registered =3D true;
    break;
}

if (!registered)
    return dev_err_probe(dev, -ENODEV, "no thermal sensor registered");
>
> >                  break;
> >          }
> >
> >          if (!sensor_count)
> >                  return dev_err_probe(dev, -ENODEV, "no thermal sensor
> > registered");
> >
> >
>

--=20
Thanks.
Binbin
