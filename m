Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B403750CF
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418676; cv=pass; b=qpv6qAiEc/x0Fv9vetcRZ+MJoaFvaxWhhm8MMW7EvbKmmtbm10U71tPlpPpHDP0yy8Rrt22A9UyaPOZOWP5rggtoo1YgHPp+40m303bp0o1ow4z5KydSaEBTj9OgSSTxLdz76/5lNk1dPXG0Ou2cFeMrMHtETHDusYYNxJD/6f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418676; c=relaxed/simple;
	bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHFCbNS77lanHTFQM06Hptbact6kCT3O+1ttCRy7ntI7iszxRvuC/ZKyOm3++8iGfEemMVg2J8YomPbxwdEJrRzhebUao0nRBXxEoNeBnkt63evUr8qmml9lNhCq4eAaSHCiSZTxN4xW9fIGGX8HCPJIIkPj1yg6bh1NnwlbkP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/MLWywZ; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/MLWywZ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c858961a8efso1235797a12.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 09:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780418675; cv=none;
        d=google.com; s=arc-20240605;
        b=h/XKWhi7puIWcat/wrjWgpaDkpROIBNoLNPSpC6tBrCtQAhR+uIh/+ZRzx1hg997LN
         r5YPRXEw5STA+iNISXru2sCbjaJ7rqvnsuy5EKF3ovStnim5eZ+MOttXexG51/pSf2/d
         t0Wo8DdxzT2+Okib9NRHGbLABWGVjBTpbg1UBATO1ERkJWu5nojdrIVQ4qS9RmVSm4uC
         I8y0V0nGuVWJYo2bdhkzv14VR9eUvljO5hlRVjE2ysC1kFZNbHU6IxAgsbM072RPI1Ux
         3k7wtpxagj6cne6W/srsWHGGUrKhWqoDTe3YDPc0DIaCPITwiNue7wvXsgaANbXOxPpy
         rqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
        fh=ZKopilMnU2Ng3GBG9O4YEFj5I0O0yatjERO8RHaMn6g=;
        b=FssxFDA8w4bO3zvbL0MWJ7ena5fD9dFcA9jPqxJ4P2ysvwycpjNkxwiw3zYv8rSfQt
         1YTk5oevMYHwOTTRECngd+r+7pCUO1ZfKSccZIcxOgp9zRjWK4K0aGW+LwKIuh9APTHB
         89vMm0DX9jE8387pJ45yzwDRzjohtWAoT0SDko0kAkIIWvnChJs6MLLniXOYBj1u5CS7
         Kvi/Tz/H3O+Vp6k1pJQUU07UM64dJhzyyvwX+1w226pTfWcK7g5EVEA9R7sU6iIFBItk
         WAed6fPeIeWVTVNxp6C5XHOL5jc3/IplIK9jadu0A8Og5/YWxgBclHTgkPmMLJ9DKLzS
         OtYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418675; x=1781023475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
        b=Z/MLWywZCoC+QfNtiLgLj8EU9clq8bFIxzJ0/mif0iP1sT4BNdoD9a4CVY5+z9OgUV
         PSvnvN6MyrDysnHrwm0pc8sPddccsqGgOYg4ZKRi8YOXX9qHNZFaiL5/SQZixPB1cHI1
         Cl3SydJdOWqBaYjZF0kHYrRx6aUps0S8PzmqLrQ5gwYbIi1Z9/MgS6l1nRWZ7v2jFx/H
         kAHQgpebijwxtsQaDIFTQ+iyI6gcCn3DtkkCKO3ZxDS4SwH2RJEHe03UV+nLlx7SOOAH
         X16LqJqtGjRJL6/YHt7S9RRJ/mkRUibKWeaNI9XhngN5FbtwCLrODBZyKanOdRxq2WRT
         5MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418675; x=1781023475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4X7GafgGytW9rIihOEjdmCsRPquH699r4PT+HiQB7M=;
        b=PuzC8rnQLMdLWHyaTLKLE0kf5O0cC+uCbKfB4wNPPEwbkudaKb0WB7cNpoKy7e/08b
         8mSdXT6x0u1WzBj/n5Nb6TzrUQUrtlJ/RC+RStF6yjT5CfELIXA/2ojAOThcmp+2dZvN
         FkG0nsylmY/qT/nkw7rUl4gEOok4sbtc5lgpaBHxyoYbcn4znFhkxxukm/aMeuFsb+la
         MwuN5GPMjeQCXelEB2zKnTBhRwern8W/PAEJo9gXFkp+QpSvtsadY5OeVFYnI4MWqr4e
         YaY0UpNby6yqHqPOFgNkjeWxF+p06dluFXmJvdZ1Id+3WVlD8q84J4anYHStxwBn84eQ
         ixwg==
X-Forwarded-Encrypted: i=1; AFNElJ+yh0USrzisg8Zn9hGzyYVRM0S5DN0awFRR5UuAJtJJU4YvdTlOv3j2NlmX9nEzoC39DVWJkl2JnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5kKCMuxU5yDJMDsw4tT+SMcRzgl75ddl10X8Qho7az2MgnnA
	35c2PWBmh8tZw1Am6z5dgB9WAlPpdR45Ijd/v4e2OgWNRoddSD/1kr1FWWLYIRphaYES5BjMDO+
	FsUsP2FrVwyzEpX/Q9OtlZaXF4TCd93E=
X-Gm-Gg: Acq92OHjMXIX1CU4bucu3OnKmbyudfdnRplXhoaCLSy9ttjmB2Jbq+V308lIrl95QHz
	wxmqTOmDJ9paE35ZWhrBV3QENl6cngeuswOrDsK0NUifRkODgzRbfnLhCT4aXHAMbltF37QgcK7
	/o2g1a+KiYtzeK/TtQ5j9exXEuvZSI6gWU2Z3b7rHAqxEVPaEzRmx2Xk3TTexD1hX9OAz2NAPB2
	vriwgK6K42yv9eXn4psMYX0S3ljnQV+EFcru3vcRC2XltXNg9XTCH+b0upSIyR9vvJTpP0eKlpq
	nhMSOuduA7BjElHhh/MdkKMJfYWo/ASbVwHgoCnj2WxrhtTl+Oc=
X-Received: by 2002:a05:6a20:6a0f:b0:39b:dea7:5624 with SMTP id
 adf61e73a8af0-3b494703049mr283643637.47.1780418674638; Tue, 02 Jun 2026
 09:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
 <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com> <CAKEwX=M3WAkSY=Zd35dEuQ6V3ZiNR02bKAN_DnCgVr69w9=0sQ@mail.gmail.com>
In-Reply-To: <CAKEwX=M3WAkSY=Zd35dEuQ6V3ZiNR02bKAN_DnCgVr69w9=0sQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Jun 2026 00:43:56 +0800
X-Gm-Features: AVHnY4KpeXrvhgct7XamiE1lkAmJNELAfrV_3bpnCb4RsNbEUjdlDb9oJ5aU_SQ
Message-ID: <CAMgjq7DspvGR-2V6Go6tpCwBTWc9-pwK3WhMUoanWBAijmuypw@mail.gmail.com>
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

On Tue, Jun 2, 2026 at 11:54=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Jun 1, 2026 at 10:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> >
> > That part should be indeed coverable by the si->percpu cluster though, =
I think.
>
> Yeah agree - we just need to be a bit craftier with it. The
> fundamental problem is in the current model, we're only storing offset
> and si, then look up cluster based on that. But for dynamic vswap,
> that look up takes the xa_load().
>
> Once we move to per-si per-cpu cluster, then I think it becomes ok to
> store the cluster pointer directly, correct?
>
> The reference counting needs to be carefully handled though. I think
> in my old vss design I did something fairly silly - just hold a
> reference to it while it's in cache, then add CPU offlining handler to
> clean up. Not the end of the world I suppose, but maybe there's a
> smarter scheme.

Yeah... I'm not entirely sure about this at this point, maybe it can
be sorted out as we process. Maybe we can also avoid the xa_load with
other techniques too.
