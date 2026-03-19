Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74D3191CF
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945455; cv=pass; b=js5DnNLqjFQaO/hAHeUNAVn8ub+N7si7jUBYgPD/oHUiBg9xtjZvlXQEigf1vWWVIg/jj/OsRRrCECnYR6j5LRQbmQiwabugbtiHnx2J+S6CLzyhljmH4L1cWCQZFFWonOF5xVuvW5tGRCvuS/YETxUWrHN2X2sqGug4dhbZdn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945455; c=relaxed/simple;
	bh=Ljd1nDUnqT7HjpseLLlArUsMFAua4xKP9JZ0zvMVBtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bY4FAX2pOMXVdzdE0jMllopS8LSlscHMtRuHjbqMDCAi29cAfay431YZ/OaDzvQXVzJkaO838I0uOaKK7jn50AZH4GTmtxPiiYzhPxeUGhC2/jaJjHKOTjElpTMLjNAhQS3qIBRcxJbzmRp1hK3D7mEfHt6+Hz1l98T1qE/ESgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvSG/1SJ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvSG/1SJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b611274bso558416f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 11:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945451; cv=none;
        d=google.com; s=arc-20240605;
        b=TRgUgZQEmI+BvQcoVRU4PQ/RSYc0kk5c0SYeR3Ju8Pv2tWAzQ544bcYYV3PX+pXgph
         Hy/WaTBFvk5nhA6GyeUVXJvJnZeQwVfK0hDBZv532XKYxfvw7UNFw3MjITXiHWxiEh1+
         frhNzcKYXzyUVmxdOfU3B39k/fdIM3yZolJ3c2Aki/kJtbVdDASq5fLn1aovhr9pX00r
         0sCjvFI23ZnF4kPE9rxlMzaf6Bbpnwua0UQYl1GH9ybl6C+BqSxbEiu7irWxlLl4IS3e
         ga3IAv+ot4tTvxDDyhNGVgNcPGPzV2kINgF6G7LTmgmL2uBEBMgiIQi8mBC2NjQ+WVhD
         MBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frA7u7Xc3APzc2EM7Lp+OpzxNxJLgzQFv8DZjhDK9GY=;
        fh=sm4RFcpY54OXhpUYqdn/+OGa3t4wUHeOKRbvk++qDcg=;
        b=TTcm6querfE7PoC/UdIbF6UhDPaEkMpDSpxb7VGugPzLXkaJx1/TmxoFoUW1qacbtA
         tO0gqstz7IJ+Wdlj7reEp15JVt+D0+Ku5NDJ4B+FMlIFXcGxDG+s67mBgzsQy0KZigxI
         ZBlKVGNxRELb2UuXh/ieyjZmh9IjvzO6K4/oD3XgenzH3KwIrIHl3gciCfzWDWh0MLTS
         PpULOi1A1qnnRfXxsN5Rr6TzRDSNUd0ORoCerZ33FB1Bv/1jvt0cmt6miNPR/7zj4lNE
         Bn9xt0Q1vb0n/C2BkDvX3ENHPuL6NFIYRsiXrAYAoVEINwgzpscyk61RKfvqpEgkOoJ1
         4Xpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945451; x=1774550251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frA7u7Xc3APzc2EM7Lp+OpzxNxJLgzQFv8DZjhDK9GY=;
        b=gvSG/1SJ6SqTkBbQiLzGcjeUi/b8T6RuyxthouoknB9X5HjwTnyCOqJkos2GEyxwC2
         O5A/j2ocmdwv6LLSD5jGmu41aG+ZUfAt/S7SsqCacRSRx2kSkecsLq9JdkCnV5tPrRzV
         JL315xliybXOb9XI68uVMZAN508touHpDjz3J9JFdhagqagqY7o+RhFlOiAEeSVexIrc
         IAa3u+d73+ohPvvIyU1EsCfXwRl9L4A7x8kS5581txCKQ3UiIMcL2PDWuQw2zEOt/Pwj
         q8gAihaIMbfh7X6ZVX0IkJ2gfKEU+mWpOakEv2dNkIvbXI/0zMG+pL9pZCCpQt7o6twd
         uM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945451; x=1774550251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frA7u7Xc3APzc2EM7Lp+OpzxNxJLgzQFv8DZjhDK9GY=;
        b=c61mGr9Qe0+0pEOabEFp9W9xAukSnn16/EwJJojw666guULYYT/kbQVZjd9WQ99ehJ
         HvKF9C+fEcBcSHvrXXj2lokL/Ex4pauh7/kosl25PZMHQta23IB5wqPNtw/PC8suefOy
         PPApjc+04os39V2/v4fSbIRJOiImlQl6Ikc4yHoVVWfdDK4dtkHGm/RYa7p6uqCBLa+k
         vPvlDjw3qcqc+k0Tu/uXRJdLeYL9kVp6gU7HiNsUQaFLhySOEGWfkZdTPdFSF60qiGqm
         PSLtpCCN9hPXwN48yXNF6i7D91VaP/ZYSYgXenXYg32IA0mch576giCGjJV4n6k2WShi
         VMPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6hwA1MQBn1BcwlL6yO0+nrY7aYVmGU09i1kLXP6tib/80Z8iWd9JBNr+Kp6hUsgxFtdJ26EiNkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTSDa5qomY7Mhw9lM/5W5My4SgHwmB2YcjqZerXkKPOyJx1gd
	YiNZDr62gchNAKEy2Hmwz09ezHU9SWuklby7De1lPV87YJXgfeIHJuyv9pnH1OomMgimqBJ5Vlc
	ZvXYVMmzlIbhrk5XVswR21UMPHjXDUtA=
X-Gm-Gg: ATEYQzwu/7MS3/MCSq648lhSefOmvctUFFdPrtWyJG9c2TE2/PFiIuQ5iHe54irk9FX
	AawsrZblYDSih+L06TgJb/ep7ce0w8LF0grDinImusRmYOpLT5eLm2Ce2NfJ0wPmzAeiwpHBv8i
	ihsKwRPTylnj2S1fXFyNlOQRz3XJKk0TAIc0GzbHkTMhAufYAlY+NUDBadY8Wzu8ub5O4x3KvhA
	H8S/0Aq0tHzTS2g1jRhgZmOkgY3Mgu6Zb7zYIcCu7qxJOmG7LWSVGahQOxT40Q7dgT3UjWE69pr
	Oiumf7YlCqfbcsPUXfizckehivgf+broND8ieQI=
X-Received: by 2002:a05:6000:3113:b0:43b:5003:e300 with SMTP id
 ffacd0b85a97d-43b642814fbmr636579f8f.43.1773945450700; Thu, 19 Mar 2026
 11:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
In-Reply-To: <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 11:37:19 -0700
X-Gm-Features: AaiRm50Q6KPbZbD6bEq0DQLWi-DLG4OekR5us80lL4mbKl_agLxOnXc4Kgcmx4Q
Message-ID: <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
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

On Thu, Mar 19, 2026 at 12:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 62cd7b35a29c9..85cb45022e796 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -86,6 +86,7 @@ enum cpuhp_state {
> >       CPUHP_FS_BUFF_DEAD,
> >       CPUHP_PRINTK_DEAD,
> >       CPUHP_MM_MEMCQ_DEAD,
> > +     CPUHP_MM_VSWAP_DEAD,
> >       CPUHP_PERCPU_CNT_DEAD,
> >       CPUHP_RADIX_DEAD,
> >       CPUHP_PAGE_ALLOC,
>
> > +static int vswap_cpu_dead(unsigned int cpu)
> > +{
> > +     struct vswap_cluster *cluster;
> > +     int order;
> > +
> > +     rcu_read_lock();
>
> nit:
>         guard(rcu)();
>
> > +     for (order =3D 0; order < SWAP_NR_ORDERS; order++) {
> > +             cluster =3D per_cpu(percpu_vswap_cluster.clusters[order],=
 cpu);
> > +             if (cluster) {
> > +                     per_cpu(percpu_vswap_cluster.clusters[order], cpu=
) =3D NULL;
> > +                     spin_lock(&cluster->lock);
>
> This breaks on PREEMPT_RT as this is ran with IRQs disabled. This must
> be a raw_spinlock_t.
>
> > +                     cluster->cached =3D false;
> > +                     if (refcount_dec_and_test(&cluster->refcnt))
> > +                             vswap_cluster_free(cluster);
>
> And this... below.
>
> > +                     spin_unlock(&cluster->lock);
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return 0;
> > +}
>
> > +static void vswap_cluster_free(struct vswap_cluster *cluster)
> > +{
> > +     VM_WARN_ON(cluster->count || cluster->cached);
> > +     VM_WARN_ON(!spin_is_locked(&cluster->lock));
>
> This is terrible, please use:
>
>         lockdep_assert_held(&cluster->lock);
>
> > +     xa_lock(&vswap_cluster_map);
>
> This is again broken, this cannot be from a DEAD callback with IRQs
> disabled.
>
> > +     list_del_init(&cluster->list);
> > +     __xa_erase(&vswap_cluster_map, cluster->id);
>
> Strictly speaking this can end up in xas_alloc(), which is again, not
> allowed in a DEAD callback.

I see. I'll take a look at this. Thanks for pointing this out, Peter!
