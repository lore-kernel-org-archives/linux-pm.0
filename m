Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798079;
	b=NHZRCpTQXJFe80ZkOUFbLzRAuG6deYFMcjGhEpoyOUCXN/yFWiGrjehDLkunP9xPropH
	 hA35fqE7tgQbEFPIQcKd2eSKn9K8UQ9ivbML+LBMosCU8LzwDZxGVbf30cu/kjv3IrObo
	 K4IBMv9CV2OGtxDuzTkUQ07lqRE7ZQ9dTTLsjyQNIpcVkJXoxEmvvT2kSDuO+Onj/CX1W
	 T08DwjCP2IiRZPbXBqbxSybkCQ+oQNfpEPSi69Ersckcc51kGl96ue9Lpu3Iq4qpJrydX
	 CWlYVHSCwBsolaP3gkSbngz/i6Gu+p3X3I0EadEm+wBgNiErJueCHDNBD/30KUOWDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798079;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vajkXxV2I9Y6AOy4iqgYfUPKodpE+hYIP6A4IuPiEFI=;
	b=hIc65g6nO3QepIuTlUiMu/b2dFyFfJfYDrIfFg2cJUH3nt99AoJw9/uDflbphvug/R+K
	 OsDkQkBmHpC/sXx4kZ4n31fFOw7aFUsdPgvlgEYGZYTSR+LqAgeQDEd8C/xal3J9i/jOu
	 YkuXENnqTGDxoDGhvHJqfKl5oJcS19TtSj4Emt71TcEi64e0SUoxpmjQOl+Tg8Ms8yoEO
	 Y+c+I2d0Xs4DW7EaOtxKx4vDx7E5YA89SzM/AehZAEPe/dWEYc+rfoeXYWiN1q5uJScGr
	 +NkWQd+uinMwjq0/om246/wMQ7y1oQmuQikUuygr3ZqpmpGSvot69u+WoBOtkZ36z5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616D606A331
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 13:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A616D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c43373ae89aso97698366b.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 05:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793798077; x=1794402877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vajkXxV2I9Y6AOy4iqgYfUPKodpE+hYIP6A4IuPiEFI=;
        b=ddZyBKkCF53sfcY/ZPQWr/kLeLYrIhZGo1orEQKyuKnSvFwhGJJNBJEQabVuWtuf+R
         PD2NhC82iUvKA7ucMeFVP6BU9vjm/UTe1kr1Ox+WVmU/1mjr+CtlblbuRAgFRdTZEbZK
         yGwlXKFf1jjJGj5maieCqvxHCf4930ntm5pe33EbDOK3dSUxAiVDltVngTj0x5w5E+sg
         DDAOpfIeRgrahmzt0+PlfEqmUL9GDG1Oo2hwe9jmznGo71jknmI2ZwZ9+U0J13Vv/YmB
         YQ/XIMBgk92DVbt9Jw3aCzs0Rm45zcEh6hRgTAJgCTCfiRN06/p0Mam34ZDGaKYGP992
         Bm/g==
X-Forwarded-Encrypted: i=1; AKwUvBzZEgSy7XW3xX+G/6MpZImTFH3MQygVu3XiS6TQMHFXWfCAw1ahH6MposWm7/emWBIvMftWs2XbfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8aUQaWB6RZ3tnvWKM+xZrqlQ2OpRW4RHWZMm1sil8awNM+k0Y4
	jNzt9+um4kmFOzEimOMR5do2swXb2QuNSAFWe/CwJ021FsP9dMMbI60OC/Am6gc8BNo=
X-Gm-Gg: AYBFou2ZviI3PkmBQtQEk/0VQnrDkQjihJBBFcq9WxfgjEHNnk9XlWRQBeCiCr75Pvf
	JX39QFpMSLkc09jYnp1q1g683EVMvkdsZjZbPqvjT6y7Cbw/E2oz7qqNzJjEAugd2ojrKdZuD/Y
	KfC30ymAljSxV9g1OefSldgNGeL/bkSmmlYkSALzsg9XewMj5DUddNZIuyusTnb0emhrqPUwnWb
	EPCX+c5UrHK11RjkUhzgdtQWtIKjFHQXHlmfcD05iPA8oQe3HnTUpDgb3va+45XoKJpUE7ghavj
	pcCAb4rVfVXnqGofvwevGHINcJEufO3Ea3KJrzUgXcXgmim1nyszKvoE8tjLESmN3wtPGSeC9BZ
	KWECh4yg2BJZSrAGnkQmGdhXRtuSuiuCG62zvu+qi1JX2SAD7gUhUza/rcBgIiFVZTKIoeE/tPh
	PMKOhG/W4UmD5yBYWI3rLZko0ZX0G/bxLcEGZvL46RUlouw31MohZdWrV+IgHZbbm6Xe22ORjs7
	Kc63GSUcCqf7TbO16S/VJ8pov4yJnHsvkyhclT71C9WjTgcV5xbxSQ5vVxXIDyIr0bMGoetmW1O
	PldkCbzHARRAgvsccKZ9iPT3Cgz8QSe/enA7rP+/A8lSAom0QCdxZ0FBDJMwdjGZXQ==
X-Received: by 2002:a17:907:96a1:b0:c45:d8aa:6ae5 with SMTP id a640c23a62f3a-c4ca7b605e4mr1443944066b.42.1793798076559;
        Wed, 04 Nov 2026 05:14:36 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41e0a8sm71104066b.15.2026.11.04.05.14.33
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 05:14:34 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso890590a12.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 05:14:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx1JO8BpzkTnGLkyGwQMgO3FAblkh75uIUiViPrvWaErFyXc1T/gFaUQMDW9cyqBRN0TRDd4AhPhg==@vger.kernel.org
X-Received: by 2002:a17:907:9c06:b0:c38:ee33:2931 with SMTP id
 a640c23a62f3a-c4ca7b5f423mr1315927766b.37.1793798073731; Wed, 04 Nov 2026
 05:14:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103084604.700540-1-lixicaicai@gmail.com> <20261104120840.GJ1959885@ragnatech.se>
In-Reply-To: <20261104120840.GJ1959885@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Nov 2026 14:14:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-K+S3W3R58Tjk4RZH5KNdwRKNS1qYmMyshL+VNYj_rw@mail.gmail.com>
X-Gm-Features: AclHuK9fH8jlqLC7CTY_wgXt4zpoH5cDgRjYOD9LVeoHWxOe1XqqcCj35WRDWsY
Message-ID: <CAMuHMdV-K+S3W3R58Tjk4RZH5KNdwRKNS1qYmMyshL+VNYj_rw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/rcar_thermal: fail probe when no
 sensors are probed
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Li Ximo <lixicaicai@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wang Haoran <haoranwangsec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Wed, 4 Nov 2026 at 13:08, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2026-11-03 16:46:04 +0800, Li Ximo wrote:
> > From: Wang Haoran <haoranwangsec@gmail.com>
> >
> > rcar_thermal_probe() returns success even when zero sensors were probed
> > (the per-sensor loop simply falls through with i =3D=3D 0), leaving
> > common->head empty. rcar_thermal_suspend()/rcar_thermal_resume() then
> > call list_first_entry(&common->head, ...) unconditionally, and
> > list_first_entry() on an empty list does not return NULL: it returns
> > container_of() of the list head, i.e. a wild pointer into
> > struct rcar_thermal_common, which is dereferenced at
> > priv->chip->needs_suspend_resume and in the MMIO accesses that follow.
> > A malformed DT node with no MEM resource triggers this at every
> > suspend/resume cycle.
> >
> > As suggested by Niklas S=C3=B6derlund, fix this at the root instead of
> > tolerating an empty list in the PM callbacks: fail probe with -ENODEV
> > when no sensor was probed, since a successfully bound driver with zero
> > sensors is meaningless. The error path through rcar_thermal_remove()
> > already tolerates the empty list (it iterates with
> > rcar_thermal_for_each_priv()).
> >
> > This issue was found by static analysis; we do not have R-Car hardware,
> > so this is compile-tested only.
> >
> > Reported-by: Wang Haoran <haoranwangsec@gmail.com>
> > Reported-by: Li Ximo <lixicaicai@gmail.com>
> > Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
> > ---
> > v1: https://lore.kernel.org/r/20261026115018.3227372-1-lixicaicai@gmail=
.com
> > v2: completely rework the fix per Niklas S=C3=B6derlund's review: fail =
probe
> > with -ENODEV when no sensors are probed instead of guarding
> > suspend/resume.
> >
> >  drivers/thermal/renesas/rcar_thermal.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/r=
enesas/rcar_thermal.c
> > index 9a9038671..6a1e977d8 100644
> > --- a/drivers/thermal/renesas/rcar_thermal.c
> > +++ b/drivers/thermal/renesas/rcar_thermal.c
> > @@ -514,6 +514,12 @@ static int rcar_thermal_probe(struct platform_devi=
ce *pdev)
> >                       enr_bits |=3D 3 << (i * 8);
> >       }
> >
> > +     if (!i) {
>
> While this works I think it's fragile as it depends on the loop variable
> of the last loop. If the loop is changed, or a new one added, this check
> can break. Why not make it robust and check if any sensors where added
> to the list containing sensors (common->head)?

Yeah, then we could move the loop variable declarations inside the
for-statements...

> > +             dev_err(dev, "no thermal sensor probed\n");
> > +             ret =3D -ENODEV;
> > +             goto error_unregister;
> > +     }
> > +
> >       if (common->base && enr_bits)
> >               rcar_thermal_common_write(common, ENR, enr_bits);

... if not for the next line:

    dev_info(dev, "%d sensor probed\n", i);

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
