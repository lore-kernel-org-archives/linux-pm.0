Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A4238150
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962894; cv=pass; b=LV8zPskknkW0RWz2lTJUFB8y2ggygeWSv3TciXCOB2JsKhvmFYqWlyJERYKxO3G1lbOSwBUXGodUx+PP7dEm+O4AkNLJL0xXNMn9jqrmlASiPTg4oiNZ3hyNBERcnJhJU5KZpVgnn/9fuRKz2Fe0fRost0I4QxIpdAM5tw5QIWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962894; c=relaxed/simple;
	bh=/dvPkx/pvBcotP6nSquXBwzk1NIgIOFThsc2f/pMPDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N16bfJo3sDsNvYw2KgdeqMNXfGLH2gCOutN92am3TVAsj+kwq5aitcSSJuqQYC/9W9GE4NYSdYhwjrvR73T+0NBHAlkPUmNsWTdxGfvOOeVoljj28pBV7E31WGCGs3XRJo9yMTRZPat5wh3MnoAiH6lOvOUKBYS3znH59wzE13M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntpMk/SX; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntpMk/SX"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so1846045f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773962890; cv=none;
        d=google.com; s=arc-20240605;
        b=XU1vN96OGc/Oz0UnsR4Fok47FNZTYvG3czNUyFnLVyWASQ8K5lIobjQSWIDqYlYckS
         aoWueyP/UHmIPo3hZVqBp386dzDO8g0gkIJUnVqBJd/Vtmy0OUp56yVGcoi6z/dHhZbP
         kIYWAze/1RU7ncnNXCfRAMuPk+wRqGG9JAaC0v0r3RqSFk0eXBy1+uG13mHZXRiY6sCf
         RjHrb5I2kz/CyxyS2sSxcyZqG7WBEyevaSa8k3WyS62DlrHcy3HNdR9fnWR8GS3IQAFv
         wsoZy3cBnGjH28oDEWbN1kpRivfaTkUtxlcuNT+bNreoCH1kdx5pFHLf7c0+xOk2QWmu
         DceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9OWBtdlQRn2CWoGv55axZFQst3AHYCAYnvEd326GJU=;
        fh=WNCNSUWAW9zUdCfTT2lteO/Uz/ljfQ6bTDFrBadpWBM=;
        b=afx1MMiGBgld575H+hpSQGB6jpE7wcL4H1es7ZAYm2E7PIpNNFoXmCTMrec/rvluu2
         J3gpVDqIqINBPg++1TSRiGhTPXs3vfqvNViiSnWbE0TCOAxoLhD0FKJU5+0suMxxMAyl
         KqxVfyG1ilxOzWhTtcbyUjz12lkZ/4kmNgve0KDrLG/LTJBTu+rc1u/3UQLyCd8Qde6A
         GPQShq+q92EOK8dHR7cjFdv+GmhoJZEqYjz9iJVDm8wamYj3a6ITcqlUB31BawZo0ITU
         lm4Yua5xmKglSYels61XRZ3UvZr2cKw+FCLpcinYJiajjz51+776PEyP7twkvRl4d9MB
         uwhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773962890; x=1774567690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9OWBtdlQRn2CWoGv55axZFQst3AHYCAYnvEd326GJU=;
        b=ntpMk/SXT8L/BMfU1kroeGlMTpVflTCl85zJA1Ri/XLJcf5zwibQhB7rcirXdez8aJ
         9FqniLfYLEUBkzCdkHfs20VKBtyTpFgEVZwYFnwhj+/BA54+PPBfxqYLV3naEiuxLYup
         dq75/wic9EmRt3OOCYK6k9NjnYowMCVRQf84j2SmB4JCDhImb8Sic84cEqsvsWX2Av4V
         rI6NBPbw+SKY3BlDHA/L6VOf/HvhwhlsV1aqUe8otDybTcam0l+Jk+O038pKW2qCDgjh
         Xz0cqeBA4naGv0AvPb1hPZH0nymqjUj84/MK/YGsGFnWaqUxVZpnRTZTxwqvaK969Nc8
         DTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962890; x=1774567690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9OWBtdlQRn2CWoGv55axZFQst3AHYCAYnvEd326GJU=;
        b=sUKqfRzgrxdPE0fXaCeAlFqUFseSbbpaJr8TTIDB1/k/ihsOi7GdAjKBgA9ZWfbvot
         XhQAK1RK9JcgwDhPRNEaZz21cD321eOuTpdnSltuhK6YyjJyXrAhFYezQqVNeI4THf57
         uNXyEDrTe/jT0vZboY+J+6kGx0BvV638HP8aCN3b31P3tvWaqwwwcEgGX/Rgru9K1GLa
         bGBEgt20DUrJEPRRN1MVOePoL0p1H4CEmStGGa4iNu3I15CzjpdBd8+vScy7Hh+uWlz0
         FwqhFuwQ9uuuLfJT4GvsD6Pr2J/DtnLQbnRs7JIdnwdVat2Jk8cRfvuvb2MuvB6vRpz0
         ib/g==
X-Forwarded-Encrypted: i=1; AJvYcCURLcjE00Mbzf/ACuRMBRegIk/sYh29UA9AGr69CZjkgyB3PluUB+TrdOqERpBptBQq/ZniYJfZIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziXgnRvf1yZ+Wb+V+nex8oioCgKNYTunzDe0q5uYoP7aJszzUV
	3uhc3QsiyAJEteiA+lHQSTKAA4ZH+oNylqllmQg97ASCDmuCd8tG0TDlN21lE1fujIUUhG207/d
	MgcSlRGZhV47BPZT66wZLKvWKdVlhuOQ=
X-Gm-Gg: ATEYQzxdt0TduiaG5CaEskhLbtddyFQvy5Nt9BhQ36iuM+CtjpdCnvn3N72FzlqRPmI
	tuZcFk2OSseR5fUWKD3f3cDUL4W+VFHjviphFr/DFOCu6hJZph1QGEzSJYiwz2oKKkfw5sSZTDC
	fsYceORcAJj/qXmUJpEDIaFoYuDFmfNR1IkCOyswSU+KhocC/XDlwe8wpxCWOLlOHZx+RvAlzj+
	YIR+br36CknQLdZ6zsm5qG2ZIPlC7iCYs9bSUMSOYSNlVjaxg9/ooJAkYFKl9kSVb0RqFhJUg3I
	xJpgk9KLoJoWMWRF9n6ZGyPb9JlqkOjKyMpw6wY=
X-Received: by 2002:a05:6000:420c:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-43b6427973bmr1895992f8f.41.1773962890359; Thu, 19 Mar 2026
 16:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
 <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com> <20260319210319.GK3738786@noisy.programming.kicks-ass.net>
In-Reply-To: <20260319210319.GK3738786@noisy.programming.kicks-ass.net>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 16:27:59 -0700
X-Gm-Features: AaiRm51gvauVsANsKDMAP1QUJ1JVBGH5RQXhUw4QEOuff8EZUUd-LXduXX7csLg
Message-ID: <CAKEwX=N_oAjYy3pKzXG+oq9arhNrmPVBm6gvVC_Hx2Utvjfr7A@mail.gmail.com>
Subject: Re: [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each
 swapped out page
To: Peter Zijlstra <peterz@infradead.org>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:03=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Mar 19, 2026 at 11:37:19AM -0700, Nhat Pham wrote:
> > On Thu, Mar 19, 2026 at 12:56=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> > > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.=
h
> > > > index 62cd7b35a29c9..85cb45022e796 100644
> > > > --- a/include/linux/cpuhotplug.h
> > > > +++ b/include/linux/cpuhotplug.h
> > > > @@ -86,6 +86,7 @@ enum cpuhp_state {
> > > >       CPUHP_FS_BUFF_DEAD,
> > > >       CPUHP_PRINTK_DEAD,
> > > >       CPUHP_MM_MEMCQ_DEAD,
> > > > +     CPUHP_MM_VSWAP_DEAD,
> > > >       CPUHP_PERCPU_CNT_DEAD,
> > > >       CPUHP_RADIX_DEAD,
> > > >       CPUHP_PAGE_ALLOC,
> > >
> > > > +static int vswap_cpu_dead(unsigned int cpu)
> > > > +{
> > > > +     struct vswap_cluster *cluster;
> > > > +     int order;
> > > > +
> > > > +     rcu_read_lock();
> > >
> > > nit:
> > >         guard(rcu)();
> > >
> > > > +     for (order =3D 0; order < SWAP_NR_ORDERS; order++) {
> > > > +             cluster =3D per_cpu(percpu_vswap_cluster.clusters[ord=
er], cpu);
> > > > +             if (cluster) {
> > > > +                     per_cpu(percpu_vswap_cluster.clusters[order],=
 cpu) =3D NULL;
> > > > +                     spin_lock(&cluster->lock);
> > >
> > > This breaks on PREEMPT_RT as this is ran with IRQs disabled. This mus=
t
> > > be a raw_spinlock_t.
> > >
> > > > +                     cluster->cached =3D false;
> > > > +                     if (refcount_dec_and_test(&cluster->refcnt))
> > > > +                             vswap_cluster_free(cluster);
> > >
> > > And this... below.
> > >
> > > > +                     spin_unlock(&cluster->lock);
> > > > +             }
> > > > +     }
> > > > +     rcu_read_unlock();
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > > +static void vswap_cluster_free(struct vswap_cluster *cluster)
> > > > +{
> > > > +     VM_WARN_ON(cluster->count || cluster->cached);
> > > > +     VM_WARN_ON(!spin_is_locked(&cluster->lock));
> > >
> > > This is terrible, please use:
> > >
> > >         lockdep_assert_held(&cluster->lock);
> > >
> > > > +     xa_lock(&vswap_cluster_map);
> > >
> > > This is again broken, this cannot be from a DEAD callback with IRQs
> > > disabled.
> > >
> > > > +     list_del_init(&cluster->list);
> > > > +     __xa_erase(&vswap_cluster_map, cluster->id);
> > >
> > > Strictly speaking this can end up in xas_alloc(), which is again, not
> > > allowed in a DEAD callback.
> >
> > I see. I'll take a look at this. Thanks for pointing this out, Peter!
>
> Oh, I think I might have confused DEAD and DYING here. DYING is the
> tricky one, DEAD should be okay. Sorry about that.

No worries at all. Thanks for help taking a look - the other comment
regarding lock-checking still hold regardless, and will be amended in
the next version :)

I'll stare at it a bit more while the context of this portion of the
code is still in my head.
