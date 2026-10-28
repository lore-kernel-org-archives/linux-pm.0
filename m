Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201765;
	b=AV1boWVJHGfW0xj68nspSAhchrcjoZMXfzUHKKakJJrjlb8C0fEWCRu4vauJzL8cPmFi
	 SFRXnf2I5fn6N8yz5JjKnHdo68nIRIR6Jak9hzj011hoeKTiMnXaFdraN6xW1iKITtN5B
	 y8HcXcr0v6P8wh6HdUqON8rxhO2MElU30x9/GRsIY/1NLr6AqAxKlBVOU3qt+PtCxyQ2V
	 gSCQcpl5jYZ6DAm6nZZAb3/wkQTqN1k/ZBUtwk9UrJTUzHpx5Vr8XFxSR0A385jtZKtmC
	 2881MlpOTb4vA3bBt5Y2TahMGkoTdOBxpZV7d3mhg1fosQwVXqdiS89xnKLTv5lh6iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	b=wmGaw3EnGAEeszhpEGD6W7fZvoFBmrERl2eTII3w7KMgaC4xFAdUUIebhJ/WMkw4/lEW
	 8veZVAxzJfDmvkRcrARjwO4hJWUGpuIE4VyrpEPxAa/m715AMw2Vy05HDK3xYJIWSMltu
	 WwdXcBqmkVQ5Z/nT5BFowaEraNt8lIFXngRhpULuaibfvjPZijjEnD6gRHYtnGid8mwA+
	 LltqEuL2jOstmeGwMHYgS0j/1jfS+797XXegLCgHaBDlX4Zjq18HsOsGXfQhhEKejBTGV
	 CPsLEgkYAekDi+C5PmpeQgeQbgrNNJLuvVD3hazQ0pIwwHjz0bt6dbGfQ0W5I0l5Pzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF09606A329
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF09606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533202fe429so405321cf.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
        d=google.com; s=arc-20260327;
        b=MKnKncRYtdftEzbHhNAlNqUrUkXBD/7rcL6Ur7ovskfI78HM/iX4AbAFV+TDsyhpYb
         iAH1HT85w0K3QYv+ZMrFLcOrzqt8Q32/fpEvpD/dujrg1thZmjh4Cqbmo1BILDMYoDJK
         16maiuDMPMAzCb2Cpy5Z2NH8tiZds0vlkw/LgBisjLmU5Tu3rIXGG5TgSmvMHBkoZlPO
         +c/MutL3dTYgDOwMD1j616xrVGMDOvmgNlyBi0fxSkxLIZnwbalM+CiM60HJJFiFTe1Q
         /qlSGQQ1xoIsXGycJO9oLEHmDV4Q4/rKT4J1VTlBfPmwKjwOcq/JWU6kS0mrr7pMvAxv
         l9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=hYioA9x5hGy+L9aOI+6c6C2eA8G8Iwfb4oSnHndK4j8=;
        b=MWAvw+VKMltEX0FIAkWAVftVLvtmpu4XtKADOKzvUuQqQXWouQsgA4RjfkyNwbBjZh
         Gh3Yi04qOfwtEyGH9RsODiZePtnHZY7TfvMT9oOK3UdF5ZyNFLkVN0BqtjqCoyVhLJH2
         IN/FoJJ7TU/t8gdT+qosZ0vqu/blHfEi+tGFctW5tCGZ9EByvZ/B3auBWxsnd4SZ+8g4
         i0gGQp5KLFyTByzBA/cRXGXxilLCAiolb+at2SBMZH6bUFa3+YCNk0fIjkcD0SkWWIaz
         BoFaXi0KDhhl6+IJon8cl6DdlUA8KIjYOPRBYo/Hk/DS+HWb1VX7/VsX3pIRyrz7b8DX
         I7oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201764; x=1793806564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=iyuv9E6ogXiaYB/Kf9bGMjc5uDovw1VYZpmRLrRXT+kN2fxJMnJdnor+qZvLAhWzf5
         5ZpgEidLwgoDr/m7PqAQNgkvMJs1jQGMfEjgDsfaqWJdA0ll7UHpSzdRyuFyqOtcPvQf
         74bwXpyLamSNVYlWo12Hkt8sY/BkzbtDkw3FeAjFHel30AzWVvD9K5nLau0ciJ6j7CSK
         ZH4qBM8JvT2aPZPJYm3XwzxSYHZi04WkjIZrQEfBjgxa7Wsg9Sh5hAk/6QBMmPYkwRlc
         e+Xy3nhgo0JAgGmpn+QnHGzm1VxXA8IyWASy4/EEGYKtjCnWmnqGfUf8AjkGoqR/opbF
         W1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201764; x=1793806564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=HRUMSsKjvxEo3Ch+ehz2kZlARD4mdZBoC1piOEdu7CAmdFz/IL0vavaC6QeB5p+Ek0
         UTSk6J35/pqWvQIOTQbOZ6qvEOkcKn9VYyqmEk4BrO6diitE9DBMhKSBuqFSRQ5BlpoB
         glHqkgGQzFRIbQWqoMZdghXv0p8J9/vOaY1J4dwyxm9KCx3NZmpc7gbdx+UWlJ1qIeMs
         t/kGQfT4Auwg4aCx9RsKUFL0pPCRoO9+zpUl0GDMDSzRZiwNp8RKa6LOTbelccA/Hu81
         g0Yq4otfNSLW8elTYbx1d9jS5Y/7DiL2x69+WAjzYITZD1OeW91dX/SSDGb+LqljDaRr
         oboQ==
X-Forwarded-Encrypted: i=1; AKwUvBweo3BvQAukI46Dn30GmtflBHYWruCKDAtdNjWK+bcOC6b3hF9gdWbpxguc79Ea58D681eZTKVL7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKRKSQKGSSgG/aXnIt8BlGibVKDWiiMvMSOkSW0/Lq9OlKbZ7xF
	TEj9MkqzVoRaRbISubj0S/MsMhcJtDMAQg12TRPupi8KYQ23rGlor1iT8UWbONw0uOdtUEkvGm9
	7NPq40ecVr6eCq8Z5JhRu4CLDL5d5Ydj2I8aPEOn2
X-Gm-Gg: AYBFou1Bvc7yWphk6I3L+JXCOayBWlVd2qzL7UdUPzM2Jcv/CrT8aE1k2xt4szU/y5V
	augZN1ftblWCyhh6Y6V+0F9mRSdyo2G5t6ltTQSzBNHFbLVul9n0BkIl1exWuIVwm8cYhMn1AXV
	aCiLC0I46el9XtZhcYOeQX32wmkvECAVV6kSXkcLJ08zry2K8EccCV9CjcmliINWGznrBGzJH4k
	txEvEdPHDy0hskjDVzNspIprpj2GiI02HWgyMYkg2Q6f5mwwLwkTzrSZXWXTiY5s05oQfUOuzBN
	l0vAqOb3TJWL52KZ7LEAFhU/Gn5CS3oH4tYUX1BgoPbfEs7cmRUg+QlFgyCdCfuIoLaPYHxYC3X
	ArbsxLpJt5GOnewF2OlOmmrzMgOpr6pAPVuXPfjfLdi0HSEzVY8ZKsG/BV/0=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
