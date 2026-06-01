Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B32EC54C
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336197; cv=pass; b=fSM0QXwgZ/XAY29XdWsXF/dFPr51rv4Xme0QoxuyXN/boid/2lQ+4CP7pJVulNS+uq/TZehctN+Y2ioGl+WvDQnrddPQKfIcMFGMJfs0y3B4Euc55ixRnYd7ridP4MsK33DvkNRG7gIBths0nA0SCL+mJ/kGLukJgtNt7NGs4Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336197; c=relaxed/simple;
	bh=MHMfGyIQO/wWrdZz2ftsSzh09DwykVOPctTnncxFW2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve+Eg+FzSrSq9k3tOjJgCa4YojU0DftRl/1PFEyE9DA6whiJ+WWFbs2kM6hnqQwmjkpn4PUpPzB2SPyYjKXcFt+JS3ZUAb/GvxVnrsZVa1t5axjg+kxDa+Z2h792xV9xbDCSHKx4wEs/+Pc1B4i+bl77kOP1yBxAo+wWR3Q0QOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rryOr97S; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rryOr97S"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec3f69d343so214658366b.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 10:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336194; cv=none;
        d=google.com; s=arc-20240605;
        b=dn1GZsoqmTVFAuFgTcHGVajJX5r0oG3JoQlYj8J1VHfkFqXgJtnsKVIu9g5UaeDCPz
         +i/WGw3w7wakLPv/XUR6gTbefxS2s1bPkJNQ5ONe6zR7KdkfPg2zQfBDRZI8JWj0uXuB
         r/wauz8p+0MioY4mwPwtFzNxxVkiPJLavFTTHoLK8IgcLG5fmHKbYFvkH008QT0eCTl8
         RNo2EQWqQBKSSKjMMBBUKt39uJvSs7CIbMvISaCnAkp5NzKNeWH/AVnonvBDqchmo5yj
         vB+VExCPWhPnictYv3BsaBVv9WrKcwVTxOqTexDVbP8ChOuQVU5msTHz3CeBBbrIDGRD
         c+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMR+vMx9phwXvzk3LCs0RnCPA1OW1RBGgb6+eYeQRiE=;
        fh=7MGX/F/rhqGSxuSPNwd9w7khHQWQimTYyfZLD7cQUMA=;
        b=L9o0hGlYUCZ7hZckWIx8xG/veVfZNNprHstDPevyf+vR0cbG2ZLSS90wbovI9S8OuI
         Qj2NC4WGF4faZShP7r1wjzhCQOF520DNtgeo9UwrEmzv+tbv7KPsK9HZoTpptsjhgb1r
         QlQcSUR5sxbJfCKTAwDeI+CVlpSidpCOK+s00/IJbCn8Qoxy58kVfljDgfpibIAJxMNr
         8URJDIejxYjRSEwsWckpJsPSSOvQMx/F5/psRYUahtsH0IUv6nNX/icw/tb/nwgL8tUr
         EjYtb/AYXwKsufeA4ueDPKUWChqlCrMgQICrTL0L+34Gm7V3xHxwr9yELm5SRJPeGWFL
         qqbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336194; x=1780940994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMR+vMx9phwXvzk3LCs0RnCPA1OW1RBGgb6+eYeQRiE=;
        b=rryOr97SQy0Yvp2+DlBXsOoeF8EjhQ/KHkErallpDjCJTM8vVvnrxje8waUS3RSM6W
         K44IiWvhr+V7Mr1GrVuyd0oPesAgAbYIEwnpHi4ZUzoD45LioXHsBw9NsL+heiwigq4Q
         jDS7J1LfYzKtBTbBUkElNuXKSFoYll0jTvdQ+h1Y1QVtLGUek+o1BsBc8nxV0CMb9q+f
         uSQgTgxyE327kQkFtC4U9+JNVT0j7XQQ+aEzSl5wP/FhIwJxmfqHxax4oX+3vUO4HcQ9
         gcfswYK4PLHucfo6VsL0zt1lYOWydWR49L5Ioiu/uehdq9XGLtyM+xwnzUkRN20QnWVe
         CKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336194; x=1780940994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMR+vMx9phwXvzk3LCs0RnCPA1OW1RBGgb6+eYeQRiE=;
        b=lYlkUfxQDGIB2CvnO8rvb5e5gpxqoSth54KVxpSawhhiUcRdfxYCKysXa2LYTEO5mA
         A3Y9gGcWS4fGnfxtSi9h4syqfWeczeitjU3XE4Po+03SRIzXdbaKUFzxylZL915EKJWY
         tS7uOCYHNbJi0Uxo6egvHHe6RMzRt0LCwn/c2ZA7dm9QZ1HcPythi2HTGESoDbXpN+Lo
         cJvu4C+7oerYiIY62LGpwv81+mvNr5PKpWBtcN0a6q9gBid1qXo0W/qWHVepYrGvwrOA
         e6lhWh6kjwy2yqsai6a3x8zted9SRcJgShix/7Viccly3Kqra9EdpoQv1r6qINrLedc7
         k7lg==
X-Forwarded-Encrypted: i=1; AFNElJ9CXAWQ7jkSr4HDI57MAif5Hmd9Xb263RMADf3PBqqZlel6Zc9Zkbj1sKfWpn8m5BNOf03n+8jvwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzi+dWHeK6k9J9YWBlLzQdNQZBWvqrbfxsryb3vTG1aYEoiKcs
	GXJ7wvPJYTDtd4IHKJXTiVScyKkv9fTvwdt9hhXgv+HXqS+Oeqni43/+xOaWzmZC39HTRkgB67x
	3yeTrSVQJiTBvnfzMQQtipF4fi2qi+Gc=
X-Gm-Gg: Acq92OFcz2xhbrnVN2aj2bf0CnfNBwzbbJQTNWE/0c/l9x0O55gFDshQzSnZZe6t3u7
	HoNQRkaTuH6J3h8g6+tYRX+xpikcL1gAM+6YCXBTsJdSz2ZZcHL+x1Ch8pmDt0XUiNbm7hNohXv
	ZPN+2oYFLUXxAxupXZAzvbCwVYKi+MSUYca7h7UEWZeDxI5plhcjh04/R4ecrK7bjLaPTEHS1n9
	rt1sfHtgklpWYL2U1EveLUG/sp0kuT6t7lSLCQVSA4aSsch3uvN9gzIYvx2vQsUPNcoiREWC6ZD
	jItvG1dV0eojzLM1O/NLlBMn4SdvtYET8qvhvkCIP7VotuZFTvQ=
X-Received: by 2002:a17:906:1ba9:b0:beb:e13b:b3eb with SMTP id
 a640c23a62f3a-bebe13c09c8mr420086866b.9.1780336193926; Mon, 01 Jun 2026
 10:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com> <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
In-Reply-To: <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Jun 2026 01:49:16 +0800
X-Gm-Features: AVHnY4KkMWDCgqvQ0VtgzLPCLTVcd18CUg6LbNn4WT1rDML5IaDfG1WZK2GBXNs
Message-ID: <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
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

On Tue, Jun 2, 2026 at 12:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Jun 1, 2026 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > > > III. Follow-ups:
> > > >
> > > > In no particular order (and most of which can be done as follow-up
> > > > patch series rather than shoving everything in the initial landing)=
:
> > > >
> > > > - More thorough stress testing is very much needed.
> > > >
> > > > - Performance benchmarks to make sure I don't accidentally regress
> > > >   the vswap-less case, and that the vswap's case performance is
> > > >   good. I suspect I will have to port a lot of the
> > > >   optimizations I implemented in v6 over here - some of the
> > > >   inefficiencies are inherent in any swap virtualization, and
> > > >   would require the same fix (for e.g the MRU cluster caching
> > > >   for faster cluster lookup - see [8] and [9]).
> > >
> > > This could be imporved by per-si percpu cluster. Both YoungJun's
> > > tiering and Baoquan's previous swap ops mentioned this is needed,
> > > and now vswap also need that. If the vswap is also a si, then it will
> > > make use of this too.
>
> Oh and the MRU cluster caching I mentioned here is not the allocation
> caching. It's the lookup caching, basically to avoid doing the
> xa_load() to look up clusters for consecutive swap operations on the
> same vswap cluster (which is the common case with vswap). For v6, it
> massively reduces this indirection lookup overhead. Performance-wise
> it's an absolute winner, just more complexity (because I need to
> handle reference counting carefully).

Ah alright, that's interesting. And I think we can keep things simple
to start, since sensitive users is stil able tol use plain device this
way.

BTW maintaining MRU is also an overhead, I'm not sure if the lookup
pattern always follows that?

> I also just realized we'll induce the indirection overhead on
> allocation here too, even if the cached cluster still have slots for
> allocation, because we look up the cluster (which is basically free
> for static swap device, but not free for vswap devices). Might need to
> take care of that to maintain vswap performance (but it will then
> diverge from your existing code...).

That part should be indeed coverable by the si->percpu cluster though, I th=
ink.
