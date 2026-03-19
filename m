Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B03559DF
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948386; cv=pass; b=GGU8cr73aBKWKAf/orJHtNz6W/cB9f7wdRCY8lkS6NZqHnI0ai8HLiH+UJCEFf3pciVPFlTIweALcVTFZPYi+0/Qt2LlC12epp+8WlzmxYpSVEnx7CkCuMTbMYjIq4ICqvFyHfsQalA4xjs+mEKnR1vXL00JTJNUEikwH57KkAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948386; c=relaxed/simple;
	bh=SMnbKcM0hUtzaR1GU2NyR71o3cgHMSUw0IGV8L9jlGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnxdtTTIkqNk3ACXi0BPSVMhSvzJLvNZuhqtSh1qaS0f0JRWjOT7+RHOj86g2F5fLpDjU0scKVTkAHN/J56vTLsKURwiCqQeLCvh8austjnr0u8oNakrpqqa3bVt8kBQi/uzmBK3Csg6dX1pUPEKX8v5ZjYS4mx9qFCzkKLWiN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azlytz9z; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azlytz9z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b4121c40aso877301f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 12:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773948384; cv=none;
        d=google.com; s=arc-20240605;
        b=et57YA75PgfMvfAfikivmzkyGUmoKX2RoiKgCHMzq/GvURKfH6WMjTuyttjNi/AAyL
         rg0we9w9O06IuTNIZCmhJtP6118F//hXDFbZ1Rr8G+4zq2wD84Xl1JL1cIXmSnHxWFVp
         vgtUavImeGURCLQy9q458AkFQcQDJm8zeHK8/cehPbIKB9WoFhHCJVqiWFdsgfp67+Bl
         /aGfGPRFJ32Vo4QmhDy+fDQgbmhHkVcSL2xIYSnFJrQY3655vJ7woH1b6kL7riKcmawG
         nz+iqN0tLlvs7MiM7tsWrXA9OMVicsUmRQvgVXd26rFqMGdPXmPXcTGy994C5c+gK7mI
         Zr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=STbYRptw5mPVfwcJPai4/18g1DT8t9j5hz3bTmCzNvY=;
        fh=WwumwjnIivWaHQuhuDIVJ6+c9TMu00ZIGajJ/IwOXSU=;
        b=lYWxY2b+Q+L9IxFAj6DIdWwJGkCCeq/dQuQg8VnrCxrk+pTNZSrFZLD7P9DQ3EP+4K
         i2sEN/XbzWXF+5ourz4HHoAEdI2SwRAZy1dgH/+LhPgRwx4LborNLTLuNqniC7s9gnI8
         naoAEnU6IyKxJ+RBASmSppFeMHBcdYmlB5YenUxzh9hrG85QuL09ApSj9q0g8O1qCCL5
         RhT814uZ4amuavqIKQGb55L7pPfrb51V707/rUcw08ADbQoAnIUrIfm0pASfh0Z0xHTA
         u8GLUPhgux6Va+HEEpZf65AFZkKzkbePqimgtWMOp1XxYNpf8ll6peTQB6v+XHQ9rzRz
         kHBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773948384; x=1774553184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STbYRptw5mPVfwcJPai4/18g1DT8t9j5hz3bTmCzNvY=;
        b=azlytz9z55giRucLwQBXJnvDsmJgVV+BvIS/FGWSJecbPojKY/ZcQUn8Rj5aDVJgAY
         ZDGLwxyrsNJRRvBEemL15yO608Lxdy+Nn3m/HCX5r5CoXt94c1cmaxTt0chgxeLh+kpZ
         Q6wXw3mIBrdITdVVJR0h0e9y6ZNROAXvyh97dhS4HQzW1CNnx5/GidRn5KSN+zSKa4nK
         39iah9St5FqmEIIOH4831/3EUu+so+c4qqNe5hI57VDjFpuUNicWJA36I9nCcr3hS1u6
         oYSts+zQ17grXi2ECuJQmVIuBz3x51EzlsDTrejuSFq3C1zt4NEl1z5GQ417Vr+A7ohV
         BohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773948384; x=1774553184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STbYRptw5mPVfwcJPai4/18g1DT8t9j5hz3bTmCzNvY=;
        b=Ij6XMMqXuX6yTLxxc1a/qu846QFw9cGY/fZLWMzzIj9kV8LfKVFKsaLHxNXPdFDf4E
         XyeTOEuD9PZ4BinebZNeqrDtr5yjPOOnLLOZuhtyAw11c0M2Y6UyVjsQn+aJ+LsZ6tHM
         P7Ce9O48CaueTHJV8rMRewDZu2XDN/mVskjPnb5n/ZFK4rmpf924YNIgTlVuUqJ2Pijf
         aWnlwBbyhNmtfVsmHayYxlLs+jpArDVAz7Kre9NYd9csUobqKRmUnWIBgCFfxkFskGS0
         zr4oJMF1PGE8cShcdPmngihvVxwrOYtdnwWsRvHfHcABW6A7uIJeLeZWh8zoftdgUAw8
         aTAw==
X-Forwarded-Encrypted: i=1; AJvYcCWdlJmi/c/io+0T2Sc02FWqCPiC3NopKoo73r4Ta4cT6gEMPSWuTmWPddwubDQ3uNc6f2eL+PM6Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mo2WHaSyCTvuBXoUgd5jUgKHpTqRnPwJeogrKUbRQLLcKJA0
	rgzhk0lneHl9ob4rvHz56lputWUdsE5PMIylHxIGVZp2taaXXgUrjifXlkBPW+HCwakR8mh+nOJ
	j/qWADTPeseJ9XQqxBGlAwlT/IMY20mY=
X-Gm-Gg: ATEYQzyHLBmN/TKsYw1MHBiyNeHX+Y6VRKt2rv7FJx6DcchXwfk9DpgTMmOUGxmCN5Q
	aokDuPZE+wEUezpZ8GRtR8lkGbXkCutkMXTNzfm4hjOsN+ShP0YOE13RrWorgSvqABSwGWOX9mt
	0oq6W0MCP/GIa+xifPO/tK5CL2Sl4vnOoSZKceayeg6Db+IC1214K59+WwlbLZdVVM+Z4WqtWTt
	x7M4CcO7xW7a3LcZQmzlWVeZU/LgTmVDx1e7qKZm08sEbHFXD2hzChDK3kRRhaksh3ei2sqNm0h
	/lU8EPzOvYo+Vz+hlQJPoENLEQDSoMne+rYg8EvMTgYoKUjbSw==
X-Received: by 2002:a5d:590e:0:b0:43b:4352:1bd8 with SMTP id
 ffacd0b85a97d-43b6428ba33mr631337f8f.53.1773948383714; Thu, 19 Mar 2026
 12:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net> <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
In-Reply-To: <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 12:26:11 -0700
X-Gm-Features: AaiRm529wWFONjiD2biQuzKZu-r4Xpu1F03-qQuQMU-V-fDEyZaMmWMBQx2xjec
Message-ID: <CAKEwX=Mp3=E_nVhFFvdyKWjHtdp6TB=edp9-x4OajZp6MPRwrA@mail.gmail.com>
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

On Thu, Mar 19, 2026 at 11:37=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Thu, Mar 19, 2026 at 12:56=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > > index 62cd7b35a29c9..85cb45022e796 100644
> > > --- a/include/linux/cpuhotplug.h
> > > +++ b/include/linux/cpuhotplug.h
> > > @@ -86,6 +86,7 @@ enum cpuhp_state {
> > >       CPUHP_FS_BUFF_DEAD,
> > >       CPUHP_PRINTK_DEAD,
> > >       CPUHP_MM_MEMCQ_DEAD,
> > > +     CPUHP_MM_VSWAP_DEAD,
> > >       CPUHP_PERCPU_CNT_DEAD,
> > >       CPUHP_RADIX_DEAD,
> > >       CPUHP_PAGE_ALLOC,
> >
> > > +static int vswap_cpu_dead(unsigned int cpu)
> > > +{
> > > +     struct vswap_cluster *cluster;
> > > +     int order;
> > > +
> > > +     rcu_read_lock();
> >
> > nit:
> >         guard(rcu)();
> >
> > > +     for (order =3D 0; order < SWAP_NR_ORDERS; order++) {
> > > +             cluster =3D per_cpu(percpu_vswap_cluster.clusters[order=
], cpu);
> > > +             if (cluster) {
> > > +                     per_cpu(percpu_vswap_cluster.clusters[order], c=
pu) =3D NULL;
> > > +                     spin_lock(&cluster->lock);
> >
> > This breaks on PREEMPT_RT as this is ran with IRQs disabled. This must
> > be a raw_spinlock_t.
> >
> > > +                     cluster->cached =3D false;
> > > +                     if (refcount_dec_and_test(&cluster->refcnt))
> > > +                             vswap_cluster_free(cluster);
> >
> > And this... below.
> >
> > > +                     spin_unlock(&cluster->lock);
> > > +             }
> > > +     }
> > > +     rcu_read_unlock();
> > > +
> > > +     return 0;
> > > +}
> >
> > > +static void vswap_cluster_free(struct vswap_cluster *cluster)
> > > +{
> > > +     VM_WARN_ON(cluster->count || cluster->cached);
> > > +     VM_WARN_ON(!spin_is_locked(&cluster->lock));
> >
> > This is terrible, please use:
> >
> >         lockdep_assert_held(&cluster->lock);
> >
> > > +     xa_lock(&vswap_cluster_map);
> >
> > This is again broken, this cannot be from a DEAD callback with IRQs
> > disabled.
> >
> > > +     list_del_init(&cluster->list);
> > > +     __xa_erase(&vswap_cluster_map, cluster->id);
> >
> > Strictly speaking this can end up in xas_alloc(), which is again, not
> > allowed in a DEAD callback.
>
> I see. I'll take a look at this. Thanks for pointing this out, Peter!

Hmm seems like we can just defer-free on the cpu_dead path, and that
should be safe?

Right now, if a cluster is cached on a CPU, we know that it's not
cached on any other CPU, and it's not on any other partial lists.
Maybe can call_rcu() here to defer-free it. Hopefully cpu dead is rare
enough of an event that we dont have a backlog of free deferrals :)

The other alternative is workqueue (with some careful rcu handling in
the free callback), but that seems unnecessary.
