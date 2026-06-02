Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419D3F210F
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415684; cv=pass; b=pYS7M/s+hzV9GXJa8KLjCsYPtMFhvlSCwXsZ9994ASnJDA9E+Yq9drjS8eflwmtaMo//hRP3mHarZtw8TP+yJcNusBMIpU2YMyqO3nTrfI6CdbYnKtSlu/BWaT1EdcYfBLdcWaKuxgvqiaVnT1TabSftuBue6Wopll0Nmf8l9Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415684; c=relaxed/simple;
	bh=uv9Sy/kwsbhQqkAS4Zhet+9C0cGQwDE+yhgPZ0iyMCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9quizMEwHcqZc0VJr1cOr4AcGvAnC109PO//SLkjCExrNxpKvRHdUH4lBoLTOS/rRIpEf2cFXA2KSKdyaePSJWZ/077cluHbf+y7Zr1EfqrQNjrNXNOcNad2qcMUR3x/k5YIVDwzgJ/vWtBL0LwqnpuTmNoz1HSeoiauV1WhT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9C10OTg; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9C10OTg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4906238c62eso95242075e9.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 08:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780415682; cv=none;
        d=google.com; s=arc-20240605;
        b=Kx7az6qr7t5sPzF6EeL9HoEJPl9mKlNs6gJHvMNW5g1xuWqng8qs6MAFjtuXNFgr0Z
         J/Ny33pluiFDWGY+Ff3kcQL1YrforPYqmDq9l/GWx3pIshlCD1lzzxJ+3W/Zhm3Rxg3x
         m3Cqd4ZsN5VZycMusTVjYDdzFRZI0rdkiaFMph2hdpnjTb0bRVtDqCAbhKmU9C8PMMXp
         gA2NibGMxioOGmDOgBlzMv5VZwLnAq4gAZy6I7zBQL7B0BDwIIteBceNSdcpSwA4sIpr
         mhD5hdGgTjOognoXpAXYk6G+YOTz/XxyGPGaV54htDyDlTNyuoOeIOdS5ccAgLezZ1Cr
         vabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1R1Ix/hNP2c7DmSyPCrvcGynZL8Qs5aPHoY+LWWhkG4=;
        fh=Bnv5wxbHlDc1nHrWhHrLoIDoTBQlosdGPGHEZulYytM=;
        b=NHIRVLzkBukU3NWrKSdZWhnE/O23Suv70I2YpJF/tdYm90FOApiYSqk3fpkHdnM1YO
         Jw4VjE3ygjSy7JJJwPs4E4Jq3op5XQPBaVTIlcQBqb/9n8sXItIhEfp7ebcNpmZKFd7v
         yFD2d0mYDHyKQb/529+jVyr73F1hJ4nrzwXQBNH+Aq1Ys6XDzzfs2v+DI+DFlHCKChfU
         mXb1RJdYtXiAE4scVCgpdlu+h7wQODl2Ah5DdsnpiMzo/FnV2Iq8UXp4+C4T6bzVz/Rt
         Mt6uke66Gy2hDgjz7t57SrcPqN3UtZ+RieIxfD/ekojTR5nt8TO4ikxO3anFE4YVeFYV
         2ZjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415682; x=1781020482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R1Ix/hNP2c7DmSyPCrvcGynZL8Qs5aPHoY+LWWhkG4=;
        b=r9C10OTgSxnKjWCcHjPcC+mNsq0xKy7Ozk1R38OOFbFehZ+8V6iPcdoKkWf7kDf444
         yJj1/4x36RJHIsqGQw9kaV0ITPluinJ9VgYn/+iJMAuu609iIANZLUS2O8W9qtI7U/19
         9//meuOMjWYZ4UXDSt73vFRYq7cN50wVkbJrYWBveYCyAnQKEwHhA4o/eXxQKn6p6rur
         ASEd35m4rMBRC8/YSSoj4bA/Klpt7gGv48iuzP2fcENnIoJLauUwVaVdEzOoCMXfolcO
         64ujFypgd6zOKXE354ognlSLL7+N5axMy6OH2g4sPdPlI8+pz1qP3Y1hBoewNkuKHmym
         lEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415682; x=1781020482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1R1Ix/hNP2c7DmSyPCrvcGynZL8Qs5aPHoY+LWWhkG4=;
        b=MF00AfD0fGL+tvL0GV2kmUH40slaC7Ndt7IJMNmmEX9j2Vq68CKjnJ1mT2Jy14E7Zh
         CTZBoQdCWYrvf8bTsTJ3ow/YR3y9+AKnsOedY3vVj0D3KYfz36ayBQ5XD0lz8IxTsbJg
         eWl+cN9tKkj0+3ZN/x65PKN+CcFq91/48irRP2UuTIN8tZFPPU9lpWjjAQdjiyBs4NrJ
         +Kauz4S2G/X4hZ6v4hBLdl119vJwGpdCMFbKUtL3wzZkOiA3EUmaDGIDlXMFL9ZTeJuZ
         xiedb5bLsCDEbY+sYTjO7IkYDBd5bNnzS9KDOjYgUzp0N0XpkTbKs5fOSL3fBSArS1bb
         M++Q==
X-Forwarded-Encrypted: i=1; AFNElJ/tMvmc0NEoFuvihIRtcFPbrGA17eQSttj+z6i2gXXDCtHeA2QAtZ8dxABOOv/w7HkChDGgi3GbNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHutLpkX8TKKRbGH/L2qUO48ZJHeI7FiAzjklc+NlTlJpxSgE+
	rNkDdl963oU4m4cUUVLfZ3Uj9HAtu+RQbHgEBQdW/ydVJl/+7kHTvssRNbmMq9/tb9e4TiyAZeC
	TOuq9rwZ+b/qWb7qkY/Gi/eQoOJ0Kg24=
X-Gm-Gg: Acq92OEZ/+qFeP+33OK1o7IlK2Qh6N6VE4mmhOfgOOohTjQdomYSYzkZ+nCe4huziak
	jFvihJO8pS7Yizzac2uS9JK459IbpZPrNH55l3UtzVEG6Ac9e5U6h0TSWmBUL18/yGkCVerIR9t
	qyUAqfB4wmMrVuOq4Aop9DQsKhEGiZKG4vEYxIUMy0KIDHgIT4aeuzki83bAv4o6oiXX2I/lW+Z
	YAN7PHGP8JZSc9CIDU4v3o3MtmcEquUWLVD658Hh28++iV5oQtAUIGxcmGm/2idHnjzQlpE/VVs
	2eirjaGbenlc4JxjHUrWHPDbbgCUcFGy1IMuH8Oc/M5xbVNlknrBorQzv3XC
X-Received: by 2002:a05:600c:3f0d:b0:490:6e11:c303 with SMTP id
 5b1f17b1804b1-490b50800dcmr5883175e9.13.1780415681566; Tue, 02 Jun 2026
 08:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com> <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com>
In-Reply-To: <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 2 Jun 2026 08:54:29 -0700
X-Gm-Features: AVHnY4JuNWTHfiBCJhA05cKPBhtFvToyOb40WTAxv5a1N06Szobh-7Laznmn538
Message-ID: <CAKEwX=M3WAkSY=Zd35dEuQ6V3ZiNR02bKAN_DnCgVr69w9=0sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 10:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Jun 2, 2026 at 12:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Jun 1, 2026 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > > > > III. Follow-ups:
> > > > >
> > > > > In no particular order (and most of which can be done as follow-u=
p
> > > > > patch series rather than shoving everything in the initial landin=
g):
> > > > >
> > > > > - More thorough stress testing is very much needed.
> > > > >
> > > > > - Performance benchmarks to make sure I don't accidentally regres=
s
> > > > >   the vswap-less case, and that the vswap's case performance is
> > > > >   good. I suspect I will have to port a lot of the
> > > > >   optimizations I implemented in v6 over here - some of the
> > > > >   inefficiencies are inherent in any swap virtualization, and
> > > > >   would require the same fix (for e.g the MRU cluster caching
> > > > >   for faster cluster lookup - see [8] and [9]).
> > > >
> > > > This could be imporved by per-si percpu cluster. Both YoungJun's
> > > > tiering and Baoquan's previous swap ops mentioned this is needed,
> > > > and now vswap also need that. If the vswap is also a si, then it wi=
ll
> > > > make use of this too.
> >
> > Oh and the MRU cluster caching I mentioned here is not the allocation
> > caching. It's the lookup caching, basically to avoid doing the
> > xa_load() to look up clusters for consecutive swap operations on the
> > same vswap cluster (which is the common case with vswap). For v6, it
> > massively reduces this indirection lookup overhead. Performance-wise
> > it's an absolute winner, just more complexity (because I need to
> > handle reference counting carefully).
>
> Ah alright, that's interesting. And I think we can keep things simple
> to start, since sensitive users is stil able tol use plain device this
> way.

Of course. I'm hoping vswap-on-zswap will not be too terrible at a
start. We can then optimize for the swapfile backend case later.

>
> BTW maintaining MRU is also an overhead, I'm not sure if the lookup
> pattern always follows that?

Yeah I had to be a bit careful in v6 to make sure the cache (and cache
invalidation) happens at the right time. I've had this idea for awhile
- there's a reason why I waited until v6 to implement it :)

For instance, when physical swap allocator runs out of slot for a
cluster, we try to reclaim the swap-cache-only slots. That involves
taking the rmap back to vswap layer, to check swap cache and swap
count. This is a very random pattern, so it does not benefit from this
lookup cache, and in fact invalidates the cache :) So I had to add
some hint to avoid going back to the vswap layer to check for
swap-cache-only state.

>
> > I also just realized we'll induce the indirection overhead on
> > allocation here too, even if the cached cluster still have slots for
> > allocation, because we look up the cluster (which is basically free
> > for static swap device, but not free for vswap devices). Might need to
> > take care of that to maintain vswap performance (but it will then
> > diverge from your existing code...).
>
> That part should be indeed coverable by the si->percpu cluster though, I =
think.

Yeah agree - we just need to be a bit craftier with it. The
fundamental problem is in the current model, we're only storing offset
and si, then look up cluster based on that. But for dynamic vswap,
that look up takes the xa_load().

Once we move to per-si per-cpu cluster, then I think it becomes ok to
store the cluster pointer directly, correct?

The reference counting needs to be carefully handled though. I think
in my old vss design I did something fairly silly - just hold a
reference to it while it's in cache, then add CPU offlining handler to
clean up. Not the end of the world I suppose, but maybe there's a
smarter scheme.
