Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067160;
	b=M5yeLv8qjhp6OSYIGaDQy+MsXAI+UWBq9S9eMKo73YM+uysyL2kIBzIPO059xLkJQe+D
	 czaPaWqZ9mJuD74dVVfU1H3E14VRsEk+btezH7ByzzXACx6PBCBhpvlSmiMA9N8QPG4UK
	 r7pJ4a5CIf2XQjNS48I0KJVtOAZdj37r1vwSKr+n/q2eL+iUU5EdwIAbfoax9+qqj+5LW
	 aq9+tsZRn8OaumGdVfHQZUhoszCt0tHQX8f513ciZv/1MrB65iIAseMdbU82thywlB2M2
	 a1vHCeMmq6cINU51RmoHoJU2fj/PP9zheIVaFlnS5H2yWC8SyyXTos7ZFxEaSHI8ZiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=o0UKICnPncbEeTMKcuAHrSknwd4sw9YBMwgq/SdwOmOXRojgEkJlotBuzVg10EyvCGQN
	 f7fi0Njsb/nj9DF8yLYL9Zn/qssbPydjU/hp4gIuxRGFX1SHD/k6K23l//Ck9lPgrP5kn
	 lkYaM2kaJ45iZqqVQ9o0OyssORZ7hDMT/1V1axPW4cYViLOJK7qpJjy7PPO2VeRO/fBDx
	 fU3dFL2OCe5B0CxROLKZ+D7Xs6ffHRG3+XMH7LZQdMtt3WD8DPhhPEIaKXXIVnBlW+Gn9
	 1X/WSwhndY90wceN6QXv78PXUH39oiqLgR8N8GOjxktMBDwK9QRVFax2vBiZMeqPUNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695E606A334
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 05:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1695E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55be673e029so117251cf.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=q6ZFSqTh1YvgwnREICn4YHDFQAYOx4/3i2HUP+9oSaIUndFDcnbCTwW5PsryY6FQWw
         lmaWV2FcmhM+HmHrYneeqdCt2yXRVfHc7+b5AGYlzukXg8xVFsjTUtITnCBPSRQdf0nj
         ZWNG8SYFtVZa3hy+WJ2yFdZFQu3GPZS9DgnABEVMP1whFBX+Wpz+BVS0d0GN5nDU7SIS
         AT00yqlRsJ137Zd0kjkoRTvY6zUtvpKhD7ImGsNhk0mdGxTTHa3qcQDf4T9o5PC8lAfa
         gxnYnciX2uF/MoSlnHk0Uud22/FnV4hh9rEdpTRzGOSLCHveyiWIPNe20gH3fu+whJma
         odSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=s05cERuR6xi16Vm6BDl6Z1zbzBD6lC5knH9z9YDZI2w=;
        b=JNd6ZirXv0PqB20m2Hbu6U3OXCVwVj936FMqeBfwblLLdYJ37s/WChyGh5ueQA66hR
         Br0pnIeOaqv7nmQh6/4iVYHlJrew6OK18k7oWn15dkq9RdK3me/v1ksFeUa8pb4GAQSH
         9/ODoqb7IIT3EkgCyOqEwqFaiE9FdYYcBRUZEl4l1I+yeCEf6E0BOe9Oa/CUETkDisSW
         mtEAWWJbhU00H92wgqOHpOBea7O4qLl2W3lZTIKSSYFrLp1Pv0hVLHBLybn0uTka3lva
         YlUbwNPIO7oW0j+XS0DSgGqSe9zc1YpCk9agNcicSn7VegtvltmKAYjtApHy05otz0lS
         hSoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=G9sTcZLhDZovHsgCx5Yv7CDMxJM8G5FDawL5JBd36y8NAy88YZsvFaSPGxL2OJDQWl
         D8l1zhaslplXpC+LH5CUyVM6fiya54hKkm3044CoRWwH6cYkMSxwEs9IE4R9vJJik3G9
         PaGymfho5RIhVhS+d5TUg18WON8Y60WBZxMM5gYyXKhy/KCwkwn+iT9No3gldijeO5tx
         xp5Gg8oePFUL/bdSJWKKtm4OA3cKKfEuUGn9FzCr/u57K1nN+6BjTy/XuUfYpf49AuBU
         GF3mrNTIV4ZWpGu4KegbuhUlLkOSriAaKH7KHmdnomUVdJlrrfe8QiZH1hsMd7fqVOCf
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=eHZrg8maLEHsdfes935ant8UadVdL88EZRnj7YTVLLazPupcFg2EJ0NmLxzwkBfWtt
         IxuqBJwE+0VsfZYBjf0KoCAn2lryAGn8HoQQwFuZ5JBEsGVYYdl1m7GFnxUNsvuZyyqU
         fmtcHCRpC2n2jPsFkSV1Ldz5NAvvHKbmPLRzk2c84oaBH1eadH6gHvVSBW5OtbLVlTEr
         L1NfCtRGxM4UZLZaxF7j3zlCfx/xGM38ATvfIbmRunoXzqANm34Acq5JImfJt3eG7iSK
         IX8zY1lD0+R4g5Z5ae+7xyCxCbtwotE2vWDLEXyd+ZAaMBzdPQQDBAdKK9Nmvt1T/IMm
         yaOg==
X-Forwarded-Encrypted: i=1; AL+hErGjw5WONIDdoOrE9uuUTLUt8S3FV1QVdvywCY+wdxJdbDcyQP4NaRPl6RJK/waW8m1J3BFOfW+8zw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9F8jEw/eeTeG9O2NhQJUkpPRImhgR4RM4x85nxKO0wxdEeQQRz
	HFpJhNaq3aSFMA2jjDNb+iiKUSAhJg7I3rWrI50LG0n7WlUXf9LS2+1dda7QOA2a3YwXElHbbxP
	z0IM203wZBXhluvmzkFcpu/DpaUQ4wAhZF/IjhY0X
X-Gm-Gg: AYBFou31TsWE90DdqFCkOqNCnTbWy8kOznrrJQTrVDPV2ATk0AdZOV0SNC7BpBlL+fc
	ECyc42WN36cVdZFQFbJm+zp7HsZNhSusenmO3V8AjSidvkx7Z2b3VRuGv2niQWkw9pQbhNcWbmL
	Pj4w6cuZAfvWBnr03uV+jYHO3AN3ctL2zHRZ58x9c37xCwRIb5sMCuK6JQdRMBeuAXf9MfOCKt3
	MtPBlAdoUeg0S0uhm2W7ofscLE2dfol/79a/jP2y6TmM9BQau6NZ5IAT8HQm94SLMSM1JCI3Hzr
	wEwYVn3elNlLP5VLOQnTsMfjxh5lzZv9CrU+rDQez9zBPaa7NQ0gmTKRtm3GSvQtM18etE3eu1h
	R77VLG3qYuH5M9c6gJbfd2sqDqiXddv52cbEt
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
