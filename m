Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D43D9537
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670220; cv=pass; b=NOOc84FraX53RbaVyySNH0yFb188Z0CO000Et5pDM44t/AqorCj6/eR8402STz8WktCi1thb9pxn+lsRQYxuFPpviZeYtVw+X1Z/6VgWcwoeeMj+VbKl8z9fkIlDmt+4gn4ehVNZRaXYTTNJKMHgVXkW6vFiiZxFIjkDpkHxFNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670220; c=relaxed/simple;
	bh=Bk+aDP7Fo6BLFnfF0mkl/u5hMpwIT56K5DBxKBjeA+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaNmd5XKKhRrTcdgUqmS4i2jCQC4Qf/p8nDyc3b+TiJjrlPeyTIMsOs0wEWfL5gRv4bNXkUXX4fDBAyevnIgKzcFDbdrV1A0q0IKXWTf0oL09Xt1RYn81S4uL0jFheYlMv6qF1EhaQn1EMoj8hkx+nGi7Per/86nsxoNndVfGLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptOOUjPl; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptOOUjPl"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2cd04e72f6so410552366b.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 01:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790670217; cv=none;
        d=google.com; s=arc-20260327;
        b=V9KQ+4ZxgeVwvafHoL8etZBqIQ1w4ONZBNz8uCxlfzZjhIe6MZE42bSTu51ExGw25R
         1doqoADB8o0eR7TkT74I28ohFiSup/qd0DK7IcMrFCRQxvXogxwgdFZXwk106ym/P+gz
         1AuKwdyxn0OzkcIfLdmOjq0H/tTABkF2tCHXgwjPTtycIILPRuQRw3NZiRd+YQGu817s
         VRBV22y7HA9EnHimn2YUkOS60McvGiotyQhWhG+2QYCUgul3Qv/0j+eYVpNxKmU17fln
         vEUEDQutOthFAGuhC8tkBWoo4ZX8439k5u7NUry1qcpO5ks7c/BW/77LrDw9rdpBYTup
         S/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QsSsp02Bm0lwSm0F+9L2uo07sOJ8G2AE2hjXwr01EUg=;
        fh=jGxk0aGt398S77MhSOuxsSYhumtlnER1B6iZOKn6UzE=;
        b=mL5grXssyAnGglEJjjMBpFou/4g4ThYDaI3pU2E3cn2M4kvWy9KDQLL80YXDDpzVvf
         tMEmYfJqB/PsPlLWdB2q7T8eFrREi3QR0RcQgVuT1kTRv/5BhuTG0UfOVpv2mwQwjUVv
         EPHyiTuKsUSM8lbdnB14bORS1cpKh37ymuNQfmVgL5Y7s2kHIJ7inWmUmjR1LDLRKwX2
         x7YZ7sMZaAhcvzfTGj7dl/OXy4EaL01UutCQbakhmL3wtK3ds8wB22vexM9WwOayrFtj
         BSBGAfAos1ALtGZmSyDgd0Z2rsmGV9ZxMjxrKcqmtoAFXVGlnTBIuJpOKcqReTj0ZEN1
         NP5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790670217; x=1791275017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QsSsp02Bm0lwSm0F+9L2uo07sOJ8G2AE2hjXwr01EUg=;
        b=ptOOUjPlL+RS3tKUM7QTODf5FGFIgxXCO/zzgYXcYjaiMVz8J1A3zIWXUK23O//ZoU
         EW61h7LlY1kqHxJ3EJYC3AVOTr/+v73lNMKYE+qxowVN0ynN/4LlDT25XzZwCThYabXF
         kqR/EK5GE1s3DIOETLl7nKKfiWsK3VKLB29dHMs5ZJRplBrAXr1u1SaXRVBoKNWUhLDe
         MPu+LL/K8OU/VFMwBqG6u1253AnOIO4OOZ9B9jTEYvZuJmX8QHZyVm4gs9Dd80R+HbxH
         Mj8gOx99P78vj3T+ffndKbGnqJWFTmQL9PzZ66sgEkSQWWNzl2lNDH0J2xCXIuYizwwa
         UGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670217; x=1791275017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsSsp02Bm0lwSm0F+9L2uo07sOJ8G2AE2hjXwr01EUg=;
        b=bHFobZXq23ipu/Pg8kFjgwdCmvlQQeW+wWdctQJ2J65lUksOsyznMKN6ahq7eTiHgw
         4SKiBjEC9843hzKESueFIFcDVfsLJ6dA5bPhgpw5aHuH3CPG0nXwmJSRwTrMXmyIW+5C
         IQZqu3ZGYgrixnFUS/MauTXcUsxspBamRS+yIsoSUs62Dh3CJibGwNBq+Z7EmuCvj2Lz
         9HqzsR0M1RmpSZryvOp5zIiVsyGgeBspe+CZJ6S7BzESmizFT1eNH/lLBJPsvlNMni/k
         bvy9YcvpwpCa4+s6BQxP57+H2+WQ+nOt3iBFXvgptkvI5YIuhwCRY/JmbZAJ6wXONepx
         iecg==
X-Forwarded-Encrypted: i=1; AKwUvBxuczuFeDpvat894bw7kW0ENn7KnZ0uFoG2vKw/ruMqA3z1hR4Xwr1uhlwed2WaFAZEViM4jAp0bg==@vger.kernel.org
X-Gm-Message-State: AFuF++m9HY6carniH/7Ye1r4jAKmb9NFmq5dytqrF6ImOsEFkoWuMmLP
	0s2spKy0bIH/sTi5CgJoBIkupCZDgs4vuC30Mck7497eqkaR4V2gxjDjsCUVmVxGlK5dYr+bNor
	SS8CjScs5uLySqV/NHCdE2fA4f+pdOu0=
X-Gm-Gg: AYBFou3CCQiNgm/2RwnLUgKfTTlxEVmMjCR9Cmvy+xcj+C3t79lpJZ/ty4S8ethD7RS
	ETnPMDHQIftyVKx+yBfIxrL8X1seEvMvOP0L+PLRqWvQOs3M0/H8Rm9zPQnmsJHOEuA5ylnZe0j
	Gmu21G0KPrfhPc+QV1J8yWKrlQonxT/nTqzJS65KZxQ9zo3oKdEeEVL2Ub+xROCa8xH33TiIun7
	UGEPbkBSrljpjZdnYtcbtdGLglqyA+qp05xDjuZOj8Vt5j9GdSc40jzmPH2Rkkth0IqdKBC5hhQ
	9PXPUeqouG0PaUDKBl9aN5a9AD10K75TXXxMHQR2/z9GUrPjwcePfTPEGA==
X-Received: by 2002:a17:907:7b8c:b0:c2d:c33d:a9cd with SMTP id
 a640c23a62f3a-c2dc33dad54mr618259366b.4.1790670216558; Tue, 29 Sep 2026
 01:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790561983.git.zhoubinbin@loongson.cn> <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com> <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com> <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
 <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
In-Reply-To: <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 29 Sep 2026 16:23:24 +0800
X-Gm-Features: AclHuK88BsaqlI4K2ocbd-PK2C68a5LcpD95joZ3dWjYgjyNNn2FFfvJo1d4Dpk
Message-ID: <CAMpQs4JvLOUv3o8tktg-EOT85KCunY9gJhgxQVkZEXPH_C+4EQ@mail.gmail.com>
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

On Tue, Sep 29, 2026 at 1:46=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 9/29/26 05:06, Binbin Zhou wrote:
> > Hi Daniel:
>
> [ ... ]
>
> >>>> Please make a less cumbersome and implicit checks here. For example
> >>>> count the number of sensors and then do the check against.
> >>>
> >>> I thought about it, and you're right=E2=80=94I made the logic here to=
o complicated.
> >>> Let's use `sensor_count` as the counter. Is the following check logic=
 clearer?
> >>>
> >>>           u32 sensor_count =3D 0;
> >>>
> >>>           for (unsigned int i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_=
NUM; i++) {
> >>>                   tzd =3D devm_thermal_of_zone_register(dev, i, data,
> >>> data->chip_data->thermal_ops);
> >>>                   if (IS_ERR(tzd)) {
> >>>                           if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >>>                                   continue;
> >>>
> >>>                           return dev_err_probe(dev, PTR_ERR(tzd),
> >>>                                                "failed to register se=
nsor %d", i);
> >>>                   }
> >>>
> >>>                   sensor_count++;
> >>
> >> If I'm not mistaken in the previous version, the loop exits at the fir=
st
> >> registered sensor
> >>
> >>          if (!IS_ERR(tzd))
> >>                  break;
> >>
> >> Here all the available sensors are registered
> >
> > The name `sensor_count` might be a bit misleading, but here the loop
> > exits after the first success:
> >
> >                  sensor_count++;
> >                  break;
> >
> > Let=E2=80=99s rename it:
>
> Can you clarify why only the first sensor found stops the thermal zones
> registration ?

This section of code is based on the original version by zhuyinbo; I
noticed that you=E2=80=99ve had related discussions about it before[1][2].

I=E2=80=99ve reviewed all Loongson-2K CPUs that support thermal monitoring,
and they all have only one temperature sensor, with =E2=80=9CSEL=E2=80=9D s=
et to 0.

As I understand it, given the current situation, the loop here doesn=E2=80=
=99t
seem necessary=E2=80=94physically, there is only one temperature sensor (ev=
en
though its SEL value might theoretically be non-zero).
`LOONGSON2_MAX_SENSOR_SEL_NUM` does not accurately reflect the number
of temperature sensors; it is merely an interrupt input selection, so
using it here does not seem entirely appropriate.

Therefore, I believe treating the Loongson-2K thermal driver as a
single thermal sensor better aligns with the current hardware
behavior.

Just use:
         devm_thermal_of_zone_register(dev, 0, data, thermal_ops);

[1]: https://lore.kernel.org/all/ac5b3982-a658-e05b-1b5c-3aeeda1585ed@loong=
son.cn/
[2]: https://lore.kernel.org/all/8ca44091-35fd-cc24-9896-0317772c5620@loong=
son.cn/

--=20
Thanks.
Binbin
