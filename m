Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263410;
	b=uScEDn7zqzUD77X2XE9+xOxZL/NQpuvze1puA8OsKoDnPgFM79CRDDEzPXQwwxxiza8P
	 mOQweTVpRd4LkSYbTguW3dW70kZgSa5BMoaJLdThpEOsFMXsPJpwXp/JUZiDCjPQ3eHOY
	 FJQ/1bCEPXIlDvIXqekLfQCXiojRV8PDfMmmxc3aFqHfgHJepylLNW3slLVOIAiwU4uoz
	 FQFXGHQCIBTrkt7K28S+ZhhrSjM4QD0l8ZPWUDshuA0lBvYSTwn6aznZsrAL+x0dG8nWw
	 YN6L7s/fOMVm1iUogKgUhDvFGmxtCEAX3ruo3A6gL7AFuzRhTOoIhwyjgjMHq7+z49Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=PT+hbVj2lp9DUJIaAmuJ24N1Nw/40UwEfkriZ4sdWFkE5vYb8iEtFTtPT7p4RCI8b2M9
	 ltHrfunt1SvMEu/XWBCciGybzmsC/BvaCRFRF2vFLSANLQ5TEW94v9HUhitrJFjXuyjX2
	 CUshGtI97Bb/v2JMWCcr/sSU+sR1leG5Zj+AY0arH8MowtpSMEl7LPJrhdCBzpSfKPda0
	 DdOjzUOJFNQNf0brmuyno2v2wjnPGcGgosd+2fn1+2mKjiVYyP3IXGxqFdxuXBAGBt1mL
	 VWaDO/aUIyAkvVi2CuZcioe46oyJQoPL01l7Ya8edKuanNJ5XyKMOME7db9B+mXGdMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0D606A32A
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D0D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so33381cf.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=Di4iBJ8qK+XIXpXBRF0yf0GZZ112IkY6/V6mmRePJIMb9Jg6NE+MIkvhoXlPieqU3F
         JACOHXEXZj0Gq/2GqzuWctM+YcKEI8gi/m06yv0J2Tfzjf/ERrzUCe5ZG0pAJukfYPc3
         qlf6F2rkZrB5JFRs3qGZmqOqYkQK5S4g6UlLLHEvEKZXx5e86kXU5LXz1wq262l5qioo
         WCt+h644c7Nb+RuKLFCbT73tg+yS5Bln1R9gzpdQx0GpUBwJCTzLGb0HlFjEvs0Fqr9p
         +EK5e4BmM5usBTejvejA8XhkUhYS30nSPzrZkcFYhY6UiUBb6wm8HNu4ICagkl4C0afW
         ZMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=h5SbIRQKKFkFOaJ+3sWjbz33U/ISfnAsEwVxgJvlGdg=;
        b=oRmlyRhDpq75/GihO/gZGLuBRYCY5r4pY9FDfPnYLhJn2BDFDqyW6FRuwZYZVP/VH2
         JbXKdAIqf/riupbs4hL38QGKgqsbSYYIh3Pb88GXNsJNl8BYfw0HrTHWR4orOOyLqWw9
         bJ9pW3aCc6wIsh1RKtRWIAPOKrVZqPn4DsgLoxgpL6yQwnRD2ArNcF8WNgI7qcpwYET2
         HJmCejtJVyHDT3ZG3TxZBekdLW9Tc45F8iEA6twyuIirxjmWK2qYLna0S37FGkw4iRjf
         GCPLFG/CbqeLekNJtQjWVcYmPGeELvCnxk1WTDFlcsPFeLfMtbFzzjXpwTMczrikDtx/
         G60w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=bc6ecKnXzqp5zahKN5US+W/GLFNu9bOCxLTorv75CdL/TyOgB/Qh6QFUi86M3M/XI3
         3gbxOXuAYS2+xcjqU4SLj5C27dCKM/SCCgBGdSbxDV00eICb4MzgEjo9vjECQ1QTCTmr
         MgCtojiqIWlVyB6AunwAs2qSQJP0tUdJsdT71C1y4WilJg+rQa++O5B+9FpAikzFpyGD
         TU94u5aUZCMHCz2bEPFushfsTW1bpin21NCA0WBKSF7omxyVw4eI3lnqeaGfI4JhzN5X
         ZQZwi7mBvwRBGIVH1EKWZ2xsmVHzuYxoBrVKANockiyw6pDDJKKlw7J5nTOQpM4hDjUm
         KR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=Ni/mOmg21WyNnXyN0kJI8SEVgvM0L02gwFi0M5E9tZwL0Qa2eNwBDWtSPH/ghc37D5
         Z2uoDzUS6JihloTYPVE7inzNkwzukvypxoj/jtHqhqFDOXIfgpwA2LOGOs0gQdYoqu3c
         kOEXQptghLJ3R8aXa6uW9aJHr82lMPCX29TaiYNNd+gEWLklULCBhCH/nP9jJRhikbFV
         sLOblQHsvi+44vhA04x+Iz5CsuZ8J4P+cHkT+ulxllml1V9slL+Dl6es+uSFZh2hv1a5
         CbrBlU1iNe/1wgmQOaHZNnZxVqaB/uQIQFcgm7PhFiVbdPRNoHEtIDGCpeOVI7MEfyaz
         E5XA==
X-Forwarded-Encrypted: i=1; AL+hErGiucKxrJeHhagdA8DD7shVBSSNbIygIWslGPJlVXlvWQGs1GTEqIwkcguB3jMfQusqL0K227kqZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cliqu4qdUDpu67K7exUN0+z/yhFLaC/4Fx27cuOx45FCFBcBs
	LoxB4H3Za45moodLPb4sIIt/BFpbWdB71H2s62SPQaEJQqiGjTm+lYoUSsgAs+qLnnVfh6n6oZY
	uOJOBgZqzUjXB3qAeR8CQsWurC8HKTTUNonJHsFuV
X-Gm-Gg: AYBFou0NJD1Z4cA7PTILIvE5YTrSfb7wbSuTJG90Yw+o/IwjelRHThwPvZw2KHahWM9
	yV/lhuUJhqM/V5E3rcs1FR9IHsaEOSiwhuZekNz06w9HsIZWht5BxnoajN5tE/rfVn2lvIEYHnl
	PUvUd3WJdE4nUWMui9Tj0ynWiXyfX64yC0TIsHfMB5c6xI1LKedJCTP6bHIp9dTTwUYCMXmDgJA
	GsmfOWH2coZhfqRS3sV4uQGt1M6+IHcRJkHYou3T+eDiEVzzN2ZuDBF9m9DxDfeUZPurSczuSiP
	/VcUxVdaXJEyDQTM6wFuvdLPkLFcM0DhEFc49USpdJG1UdUPPH2IGXWR1lysSgQir8o9d+nrTV4
	H9A4WzF6YIo6ky9368WilgMwNdGfhQ54f8Dy88T9dzDHQHHCcHf0v6Uea3a/gEc33unM=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
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

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
