Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266423D2B1;
	Thu, 19 Mar 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954218; cv=none; b=XXpV8Xz6jmy2C6fJ/15EwLvCMPCDw0qxWns4RZQIW/LIfCqt9GDB2ZJvhGIQoDrEuOACcG201AViQM+V2AlSqiWfdsy8AZ8b1BNP3furwAwDUCaWQPkh3ducoZAipU3NMcW5pD1OKMVdIJEJxLdXK/blLXgY2ktBXynbQoKar9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954218; c=relaxed/simple;
	bh=CZ4LzfEzmBrFuUMplyx12SbCKkallZ+U8mGHkQc28mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYF8Y2bM5A7J3QYXBMvmTn3avYcKRYpDKlT20vKLcR8r1A+/o4lguerY4MPW3zOOoeWsj9ZZ+/gy1pwmEY+wE9wrcTsnmVwTWNuagAgZHM0woYCHQj8uVK6CaNsclmSxs8MMGp0aoEJ5jY3eRpEHlPqyB96XrjKj/TUOduffZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkctCJ8s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkctCJ8s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+rvv7aCV1Zjgon2qQiEl2mtSdsKlc0SDViVfsxmkIzE=; b=qkctCJ8s0PBLGwlTgNfXJ6v6w1
	+VxML8vgryMgKlLKhFdQ27LX/P2FGNvblHvkdzRJI6NDbO7O8sxoYPLRRCp3zW0lB276UmZnvwgyg
	Q+LUjBlMBUHBZP7OPmKT9Yi3YKOn/Cx7S716Tu0udYGW8/QaAmQIbgNeoeQx3pj8TJApBrarGUdP2
	yRq72P7FrVALDUoWCPwWiJhfo6azskQao609g/wkQyQAcMgzDCOm54msAjWJhYhPOsBy4HEc2iGsb
	2Gspf9vmoI5lNieUu/1SuqR6MZIfqHL6VSWk21BlfQahBUzbHWpAgWpko6peSZh2WSFNCitx+i9g4
	/z1SHTyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3KWY-0000000ESkE-0XB9;
	Thu, 19 Mar 2026 21:03:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E08433004F8; Thu, 19 Mar 2026 22:03:19 +0100 (CET)
Date: Thu, 19 Mar 2026 22:03:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
	hughd@google.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com,
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com,
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz,
	weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each
 swapped out page
Message-ID: <20260319210319.GK3738786@noisy.programming.kicks-ass.net>
References: <20260318222953.441758-1-nphamcs@gmail.com>
 <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
 <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>

On Thu, Mar 19, 2026 at 11:37:19AM -0700, Nhat Pham wrote:
> On Thu, Mar 19, 2026 at 12:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
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
> > > +     for (order = 0; order < SWAP_NR_ORDERS; order++) {
> > > +             cluster = per_cpu(percpu_vswap_cluster.clusters[order], cpu);
> > > +             if (cluster) {
> > > +                     per_cpu(percpu_vswap_cluster.clusters[order], cpu) = NULL;
> > > +                     spin_lock(&cluster->lock);
> >
> > This breaks on PREEMPT_RT as this is ran with IRQs disabled. This must
> > be a raw_spinlock_t.
> >
> > > +                     cluster->cached = false;
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

Oh, I think I might have confused DEAD and DYING here. DYING is the
tricky one, DEAD should be okay. Sorry about that.
