Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7231D372
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349867; cv=pass; b=bIhjlTDg/dA1bzCapPafHRAtKyK9ICbcBqmKYIzy0VwVp2zc1VkoGuucBt2sZr/qPDjjcBaa07H8YeBrh6Cfo8BjcW13mpk7obcGVLaszb0lyIBsNaCgGvd79wmBd6/VJbwr0fRz+3O3OeGAvjlO3QWHV/bOuVFLrZ7psjTv5Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349867; c=relaxed/simple;
	bh=lAMWqqhKSyY/Nf2CObC7T0sTaNj2kkWAhArcE7c93gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gocNq3K3qAAlxJabNUPyqdmjr3X8xXbyVwjZE3+UcXvJ+xLtaMyAveToA7IuHXpldFc7YNJsL5uPVibG+TyL8U0KG8yEnUM6Ul2fG+N6i5FJLsXjpZsVVsKCD6H6AZcisKoQUXzPR4YBpI79DXYEmaabNjFspMDRH2Rz2Tp2FQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHm9tpak; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHm9tpak"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so10204830a12.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 07:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349864; cv=none;
        d=google.com; s=arc-20240605;
        b=hq+xi0FMifGsKU1bm7aUfLX2DT3JzXMa+pXSuyyNH67ojo9H8LIZHa67Vyb/WqSrTS
         gdhU2BV3NYawzLBuNgqQEGjbGI5WlL69lyWh1OBnGklfN1/vOsveqwdVgfq7q4HJ+5AS
         PcZrGwYAgew+B0lFY0JE9tXoi30TeoYnE62Uq8njzYp/CEVa+ahrGTU7ux9oXKKEOq9p
         YnDPawdjUPt9231o7+6yY5Qcb4P2V/ZCDXSk/WTJSMrRTHgZcohrJpRTkZDixgZkP/a7
         1PRp0AUKFamtaKU4m8wsKfD224vb8t3d906alKe3opaDrBLMDbOQ4P0O0Xks10VkPbU7
         0iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZB3AGd1NxBc9bv+uq0JeWBVkPfVV1mCHpCACim+jGiU=;
        fh=P75f2PKDcIUXNlMQsK4h3171MPj9ClsYNPrnXOx95Ao=;
        b=XYuopJNK4TXQ/2BJxpBLpSydnvxg8fxe2jQP5xLAo29RulhC42GrC+kNhfocHzbkXG
         6DTfYh6DD+J+XPvAaElH/Vanz4J2Zyv6JA4x8uPHsbHIW1qKiEGTvzDehky+mlNN47EM
         4AXWH8T/qciA3QxHpU8fhdM1u92Mwqv+3ZQxwqLc4sWzcbaRqQesiDc/vzklVan9CsAV
         KTcEKss/poiLbu4tTPaU6Z5JaQ7D99ZLjxwW5lXaLMwcUQw+mQMbF6otX1Z8xdQhWCuk
         mNziZw5XTZXse58KLfbnIQwqOyAPP5uN13DfgyBX1WKRwrj7NfvGWCVh9DWVoDD5A16E
         r6EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349864; x=1776954664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB3AGd1NxBc9bv+uq0JeWBVkPfVV1mCHpCACim+jGiU=;
        b=dHm9tpakmRWMsE618K7GNdsuVtw6suY2Z4Zn/Er1YQuEMw99VGCYeMeThKIBExXqA9
         R5htBfu/Nz2nHp4ti+WhQnKLP0w1/wLmCSqQTlNhS98QwrdnhSsx4pPEzUUMC0iMR6Lt
         C/sKQx2NGwpLX2j9bzo5JQp3ukzZvV+6gvG8OwvutGgdjLDnPBz1FWbwCysPVxl4dBcB
         5FxLElVCrpZnEcTojdiP8Mw6lY3GoBfcADxEG198mOsk9A0ib3Xlss+aGwxlKU0PYLwn
         qrzoteJzsk/kehW3LjyE6fCQ6H9XaPa9rtX63QeR9hjHBra6ksETxYhnZmFcms/Hmbjc
         6X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349864; x=1776954664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZB3AGd1NxBc9bv+uq0JeWBVkPfVV1mCHpCACim+jGiU=;
        b=YLDKctoA50dYPRGpVs1NzWck7idpixWfpYHhXwM+jqmdu/33WnnW8YeMMvj4AixXuR
         tTvZkPscjuu/FmqOwwM2HOrqKytQ63/gHxSR5SRNw+UQMCf9K3Hp9BOj+KmOJTjKqvsk
         /jf5/bXRs2FIy3TEgJf7Wg+iuWZtcBZmd7knrO+m0pYeaOX64CsAcbZfw1p9UHEDjq2b
         gyJ/G7MqW9VVeROKVuhgLDgTUU1nyKKLNXFuHlBYOocvnCjWTvXIDDJYwaDQa4gS8F7M
         opsNKaxzYZfTvwgNBnPaJi6yCEWGLfhtJVOGSOhub3MRiwUsejp3FTmowMO6M2qQ2rtC
         ECxw==
X-Forwarded-Encrypted: i=1; AFNElJ+eYhq5RnODf/gwEX+M2mpjgbFv7p7oEIjh1ANjHsYFrzGsQfiOR4T9O8+g59Nc8Z1tZAWUVBJOuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Mggc5lk/8+LQF1Rr3rREr/GfD8K46HwI4fhoWg8qqIYtnGah
	/sfKGJfYPKkN6Xt6BBli6uNLIjEeejHKkG3EWDHv2DDM4Q4/eHNsLoRMDZmPil1KFOqICZAA8XV
	bJQiNpskfF81Toghz/TJK5aBEtiGnymA=
X-Gm-Gg: AeBDiesKQzV0rqwGDUvb3fJPRIB3hWAL8FohOhKMC2/67xpLcih+iYXUXoHWnE4uvlU
	IQy9/eXoFA2VFbg8uOvdf1uqXO+Mhwde/Cg63v5OHP00jXYtKke/LfT3buYK9JX4LxFvlWdHLHs
	s/aZhei6lB3XAOWCyVuSo/fhGtqERrBzSbcCRWO4Wz0ffjkrJYcJaAjHAqpX6OMD/CdYZ0Jt+J1
	xyrc+Pp5lQnVL5WMBTnQRan06Mz+Poz8uWURXp3hARJPXwFhnC9fQBTaRf8+3PgAe5KDHbDZ/3X
	UUKcXxXddp7OBXm6rEs=
X-Received: by 2002:a05:6402:847:b0:66f:2fff:683a with SMTP id
 4fb4d7f45d1cf-670786a2df4mr11774668a12.4.1776349863492; Thu, 16 Apr 2026
 07:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415165139.14113-1-dbgh9129@gmail.com> <952b0192-4ba8-45ae-a71a-79854d558702@oss.qualcomm.com>
In-Reply-To: <952b0192-4ba8-45ae-a71a-79854d558702@oss.qualcomm.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Thu, 16 Apr 2026 10:30:52 -0400
X-Gm-Features: AQROBzB-S0qJ95mP9dbf54WbJ4ysiQcb8J8ffLTIReIV_w3-oy_NuhILBeFwnFM
Message-ID: <CACrCO_X8Dv=Y54Kp7cHRq26_1KiXD7gMk=1EvxnSNbxMnR0SDg@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: pcc: fix use-after-free and double free in
 _OSC evaluation
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Zhongqiu Han,

> 1. I don't see why this header is needed for this change. Even if it is,
> it's already included by <linux/acpi.h>, right?

You are right, it is unnecessary. I will drop it in v2.

> 2. Would it be cleaner to reset the pointer and output.length, and let
> acpi_evaluate_object() reallocate the buffer?

Agreed, that is cleaner and makes the intent explicit. I will adopt
your suggestion in v2.

> 3. The sashiko.dev pointed out a few pre-existing boundary checking
> issues that are outside the scope of this patch.

Noted. I will address those in a separate patch.

Thanks for the review.

Best regards,
Yuho Choi

On Thu, 16 Apr 2026 at 02:04, Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 4/16/2026 12:51 AM, Yuho Choi wrote:
> > pcc_cpufreq_do_osc() evaluates _OSC twice with the same output buffer.
> > The first acpi_evaluate_object() allocates the buffer because output is
> > initialized with ACPI_ALLOCATE_BUFFER. Freeing output.pointer before th=
e
> > second evaluation leaves output.length stale, so the next call treats
> > output as a caller-supplied buffer and performs a use-after-free write
> > into the freed memory. The final cleanup path then frees the same
> > pointer again, causing a double free.
> >
> > Keep the first _OSC result alive until the shared cleanup path and rout=
e
> > the early error exits through out_free. This avoids both the use-after-
> > free on the second evaluation and the final double free.
> >
> > Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface dr=
iver")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> >   drivers/cpufreq/pcc-cpufreq.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufre=
q.c
> > index ac2e90a65f0c4..165826b5d6844 100644
> > --- a/drivers/cpufreq/pcc-cpufreq.c
> > +++ b/drivers/cpufreq/pcc-cpufreq.c
> > @@ -23,6 +23,7 @@
> >    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >    */
>
> Hi Yuho Choi,
> Thanks for the patch.
>
> >
> > +#include "acpi/actypes.h"
>
> 1.I don't see why this header is needed for this change. Even if it is,
> it=E2=80=99s already included by <linux/acpi.h>, right?
>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/init.h>
> > @@ -351,16 +352,19 @@ static int __init pcc_cpufreq_do_osc(acpi_handle =
*handle)
> >               goto out_free;
> >       }
> >
> > -     kfree(output.pointer);
>
> 2.Would it be cleaner to reset the pointer and output.length, and let
> acpi_evaluate_object() reallocate the buffer? For example:
>
>          kfree(output.pointer);
> +       output.pointer =3D NULL;
> +       output.length =3D ACPI_ALLOCATE_BUFFER;
>
>
>
> 3.The sashiko.dev pointed out a few pre-existing boundary checking
> issues that are outside the scope of this patch.
>
> https://sashiko.dev/#/patchset/20260415165139.14113-1-dbgh9129%40gmail.co=
m
>
> >       capabilities[0] =3D 0x0;
> >       capabilities[1] =3D 0x1;
> >
> >       status =3D acpi_evaluate_object(*handle, "_OSC", &input, &output)=
;
> > -     if (ACPI_FAILURE(status))
> > -             return -ENODEV;
> > +     if (ACPI_FAILURE(status)) {
> > +             ret =3D -ENODEV;
> > +             goto out_free;
> > +     }
> >
> > -     if (!output.length)
> > -             return -ENODEV;
> > +     if (!output.length) {
> > +             ret =3D -ENODEV;
> > +             goto out_free;
> > +     }
> >
> >       out_obj =3D output.pointer;
> >       if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
>
>
> --
> Thx and BRs,
> Zhongqiu Han
