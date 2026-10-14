Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624905616C3
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996286; cv=pass; b=NBcX8gxD4wrlT4BPgHev2IpdcILAMqbDTbUAW+ZVrej+gz4eBi4GIw8AoFsaAz9IprwkG5sd2O3oDKk537eq1ewE24Q/pNToZQWwLVM1ccQc7pBsvK3OPFHVZkewKUCQFGUrWZcBN/xZPdTzAOE0fm48BRM6d4wqYhpJo7v/wpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996286; c=relaxed/simple;
	bh=aCsxctc/xcnHv1pMHQu5CMpv8HUZNsqkMA91yRiQJRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWR06swWaT2Nf9YeN/UIZ+tmroWT1foqy2wzA7RRmHfEB1YO5u2P206F35m4YSofCTP2zbDLud3XQ9XqPvWlNOqkD8XpJLcOI8Jg/Z3xDBiJuXQ6bBOLFPjcjku8Hhy62rse0gqjhxEao2QoMpiLUIqPr0QpETAtRLiPKqWDFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfSn5+O+; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfSn5+O+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so38176965e9.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996282; cv=none;
        d=google.com; s=arc-20260327;
        b=O8C/W9sEEPQ20f9csNffzGX5Bm986sct0KchxQXIjhpc7H/ILcf5D2UEbPjMLg1tcr
         37hFT/+N9uhdsr5xS3orwki1Ws0qtu46+m5TRVjgHLLxeT370hApctiRmgq3Ek2P1vTK
         T595W9H96jfvGxsl8h9DghMkZ0dbVuM+ufxRYP+mqEjZwq33HRGVssvzkCFbyxHctrWs
         OzoGnNqMJBjXDpN8Ri9jnvSMS4cL6CRlh7j72h5U0yRSWZVZpxmfwv06B8MB97ex5Afu
         gxp1ilRWZVh2o4XOFZqt6XgIANCtDj2mK8G79b/w1Ggv/1WB5J+Y+NsikHA0DafGSVuE
         7fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        fh=JGkQpHXhwUpyDbO3GonUakWRjBQs+r5W1ve1GP7WtS4=;
        b=iBdPeHiJpe+yQEB6HW9GXfuIVgayeedbPld8slXlVzepz+Xc4aZr9yfIx4ibahUeXS
         ynF89vtrAIP/AFWZTiBlDdqXg0EpnCbA0bVIVfQHuDzf6yB04lXTKRHQlFMrTM2ADjeH
         C2mL86nN5NXEuLPDCqMKaygptHTPe9RTtZjuF4FXk44Nan1AcDA72GMjReqcCeO7qQT6
         PpbE3iCswmWdZYQyGHcZNuanDy4jVWDHbg5hm6IEqhjOcUaNRwVYsgEON85Snm0IFHqg
         HZJ3bG2dN1Ud0VNWcJ5NRFQ/7sdm13aNlAsVUujDw8CkuGiJEVLg4E+CW7MmO272c1vT
         J28g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996282; x=1792601082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=MfSn5+O+jWmDzU6Qat1Y+ZlT9jQoLCDnc9H3KO4dn05UZFbknls9QJdUQdVHYrbH/r
         BjOqlf3kmLrvBEN+Mtojy4fbT9cweHy1LxBSI+bW+ULfJ4/rlZFR25iTxRiVLmL1gGnX
         c8rZefI4LK2DJZIZjJVSTObVpjKw+wSEK5PJDepzjqgXoKlUd1jDQgsozfPwxsvd6/DH
         QdTpkMk+HGHIM3ND3MsUt45ZR7+33r6TOkpgl6cxhB1Gizo3hgEYuVd3UeABgWu0Jsfr
         6IcFCEE+7ZpZDqM6N6SHznacNDYLDeiilTwNXJL4XcQzUiy1RKhY4gBMUtMEVldNdt/7
         vPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996282; x=1792601082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=QCudTby2Dn8sMXf+yF29bMzaVJp5TxOt/zrp4RWg+fG++Ja3+2QF72wESNhgQr1qFE
         I1XIg0uqGbVBCtq1zHnnQNV/ndS2fNi5TQY0MS18urzfR6f2vglQ9LaQ/IvlRASNMR7V
         VeprmhirSWWi33Gg8u5hIdqlQQVrm7ILIMiccConK+o1tQkUCnD2pWr7Haz0qdnEjMRo
         IbM3Igf451AHR5CpDWod22YoS6OaajFBx/lZlS0jy1npipmyfjdMcfTXpjr8j7xGjp01
         T1fNPx7ncmynsRR+hrkrku5qgB1O2jkJkYqmUOHTZfZz8y6aQGA2DJVIgNpbdrvCTytL
         xtaw==
X-Forwarded-Encrypted: i=1; AKwUvBwbJpfjfdECtMPkY3jmCgVKF6ElQNsyzcL3+uk9dJV2BFp/wsb135r5PYOs4iPex2JYvGTGuo4lDw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJHrKv00BPS/3ZzLG3BPWoShmu1KCbFCCwgT5BhMhabgnug4+/8
	hjxYf81v+V2SAR8ws31MPT3+mMuGKMv5CdkR8ZI+B4u02WqkbyyVSOzfvrNQt78XbpMtZMgluVZ
	RuTjzVw1DEA4JM0vbjMoEO+67ib3x+c4bNDOJdMxa
X-Gm-Gg: AYBFou1PlSdwqJ2YiGyWPkc1fYSD0S7g8olMKylTn2ShmneaY6FNZ2vVe/QeXn6IEot
	ZFYe1PoNB66a3o8TqGfy2qJt96idTLdCYKrjIfusr3gFsTsYS82tO6mFj4ebpogfblf6DndzPB9
	bQNwnQnKNVFmvPzUZyxYFQDyER2ofE9vljN9gGkX7t1hn7Zrq4TpGXPj6E1ZmoFJhA+uT07ZLds
	o/uAw5VGWnaxg2FLphv9n7FTTlSSLsKRxyygnv1JCRxT7fd8lYctLfnArqjq6SMvkzBo+hFzNW6
	PPSNyoFRptx0QnUxrZu0BsFy5r/HixfoAd2Hzv2DvBvoGaMfGny91uXOYWXHdDAnW9Z3mZV5y4N
	6DWbjLwmwEZKUoVolPFjcNNs5/ivIdCNX7BV0jjUWJn8F8yxtZOcV8OB9iCKtT5CTdBa05pqWFY
	T7l7DF85DYosrDRUvn+OuTwmHw3TqMQKUAGpC10QmnF6PVzFVoFsQM
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com> <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
