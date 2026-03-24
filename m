Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58101405AC5
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373019; cv=pass; b=n5ijmS2ec4D5yMyK9+fotPfP7RFMM0RxhW+2WQQCzFeV/LZo7KSLFB/eoSGs7JFYluta1RLSMpJM5hT0uOkmhMwvcCWdUb6NWsVvThCAZXOFzlNF4mRpmPeFrpQXmCc2AVhYw294YjU/XO+pqDI4soDmJjm0al929+reWcHxAJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373019; c=relaxed/simple;
	bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZwynsYVnByt2M0020vgKcQPDiAvMkiPpx15ek1/m5wt+ZC/58JRR8f9RY89TtrZhXpVIiH/m1dFigFEX+8XaNKiLZfn86JY8wX4JgLs4xN1VL0VAsll2aKiL9emNho0rypstypDHcghU36I9hMz4QzQmRXkce4nNet/JDhnLhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbTa0vl0; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbTa0vl0"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b94a19fdso3930898f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 10:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774373015; cv=none;
        d=google.com; s=arc-20240605;
        b=dEAZ2tI8uJjVi3SJIRl5LbJsMh/B+WMUqot1R9/v5YQy/JY5ApqfkPq6NYUJn4Iwpz
         jvBVzSbN4hswOIJ82T8SO3LwcwNg6Jtqk1dRgzncnRcmwyih2HgL+13w21zoYKV1da2q
         IlySyb14LH1F3FhNqGWkkJ6XJC+nboiLDzAzd9b5IuobWiPfjallN5YVJxOOkbREpj/C
         of48ftjPxoB4MrJT1m3AWttrZA9dgQNL8o98N2D6/yI0ZdaKYRfkB7be+Bitw8M8GAOF
         O4OnFrfdkX6kBJDL6kH2qq+wm5E8fWFpnm6jFismQolEJVwBTKFUsC1u13PVQSIQDMd2
         bl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
        fh=q/olGqFNOaRvXWapbu+ljtg4g5jlqbrNgoqj58eyqjw=;
        b=FSTRQDZdZzjnViPzJcDa8786ZJvfL7omo8/9ACZ/aApRWKTymmF3rYARbqOci3JgE0
         f5fjucda29vAsV3dWGeHx99Q0WcC7jvgyt/i2slOM3frAniMSeLXFly/nJvkhx7J5fmR
         6hL7iZ/JuhTmKo9yKJoMkGNYKuj0stLUiNLqlH30NBYQMD4PnSJMExmDZ03bRLVTAR6x
         cuXvzPN2zLUPE3ZEvkj25uJFtqGYAEErJ3mfoEtpqfizIbKNZNnJ5uWCw06Yv1OP3av1
         AoNXQ1Z1U0w4Kv2kREJUCjNQe4OsV5mou4B/p59CRceGQk03ETOKsz3tDulaHerVjU+K
         TFNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774373015; x=1774977815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
        b=QbTa0vl0TfCraCZXg8A5WxS06CK+SnCFN0gfJV8GMmRIJohko8Q/3NxWZ2G/IOvZXZ
         d4omFGFmipRl5bbiPZjiUvCWtZDOrc9HEKAJHiW9imEND2pW1dB0U6U7nEphDG3xka0o
         JjOZ2/zh6GeVEqCanRKx2sfgfAaFkvdQdBFV+YaoZjP14VKVAxVELn7kvvNTVutzfOi7
         0hFufRHeHPWsUw44qWKhyEFBgbr4YrMxiZcIur2crcE/RAO/bi7PJyNeYCoVPI3jOwSD
         dKQbWnGn87K+NEb8OM7qq6VEg09KE1dRC4q58SP3FxHiH1SqqlZNRredealWSJClIaHq
         3D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373015; x=1774977815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
        b=Yga2JcRBGxHxYwcL2r8YIJMAN0o/LJv0FVbRkojV9wLDh33NWJuMQjWDVFATU7/cAc
         MUxZVHI78sND74m9h2DlzBJLvTJ18wdEZKRXoOXlKLhfB+5ld4pjujHM1ZFO2EAVQA/X
         18srs09K8ABpQw6IcvGLzQEHL5ymPOueBSYXyxiY5Or0zd59PuSKsR5DYA1QpNNKS/R2
         4+UTvH9FCLWUugETSGGvYqN/unpYI7ZAjPJKsYXGuCBBA1sEAUhoVrPdHVJbtm4J38+T
         2d3ef4uVB7Q8dFAZxEnFUCOYj0dYfOS4AdCB0SxO9Lqq/WX+otBh4KwjgKwExvm5Bdmy
         btxg==
X-Forwarded-Encrypted: i=1; AJvYcCUUvPx4Oqy6jNf458iGc0AIlZtfSqWQg7Nti1fIxbwMd6DPdxzqaWwxHl45IgS014Bt9idqSasaHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vx+duk/oVgQ09e8s5iZt/W58YsC8d0TVH1EInUdHV5auv1Tz
	L5so4R0npdzz6cgD/gXIMSp/HiZLoMVbWtXeM+AknTDCjKruVF4oM9nBowbcYOsPf2rkRlA2r0y
	N+a+Ao/78bZYA57tMvitdCzjUZEoyjK0=
X-Gm-Gg: ATEYQzzHgQxkziIn4pKkclHETn0/2hZEMJq3M0TbWOVid9eXD++3o3wkEKD5qvPgVqx
	yxymMXUX0VEg/8e5j9wM3p1mlano+LRzlF5CxbtgMo8gmCjcNy0LEsIcttfpOIbVb1hZKt0lpZm
	byKx4CeHRo/zt3ca/R1pf59iPJQaPlgFwzo7RGZI9HRLWPSdJYf2nXvlrLizZSmhKBr2Pia+SR8
	DQuzlVqA0d3aXJUyOnDPMkN1uuVbYqhShuyj0KV4Bvh/7fcdqVaLRDjhpYMUmsmK/YZ8OTy8Hcm
	2kwM38KuOP6lM4XLGePNMVmkbtmSDvje5okBHsrWt2Wp5uJFnwIZisE=
X-Received: by 2002:a05:6000:4028:b0:43b:436d:781b with SMTP id
 ffacd0b85a97d-43b88a1acdemr451493f8f.40.1774373014027; Tue, 24 Mar 2026
 10:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <20260324131931.4004123-1-safinaskar@gmail.com>
In-Reply-To: <20260324131931.4004123-1-safinaskar@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Mar 2026 13:23:22 -0400
X-Gm-Features: AQROBzC3hVhU93LxfbLzywKCT0KcJoCMPUplZMLmSEgnO1rcgM2PnL8QUVFELHg
Message-ID: <CAKEwX=MgoPmiFdBQXK_4=XuR-8mVpGr+3Ku2MfjPmHCeuUdGJg@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Askar Safin <safinaskar@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	kernel-team@meta.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, Kairui Song <ryncsn@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:19=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Nhat Pham <nphamcs@gmail.com>:
> > We can even perform compressed writeback
> > (i.e writing these pages without decompressing them) (see [12]).
>
> > [12]: https://lore.kernel.org/linux-mm/ZeZSDLWwDed0CgT3@casper.infradea=
d.org/
>
> This is supported in zram. The support was added here:
> https://lore.kernel.org/all/20251201094754.4149975-1-senozhatsky@chromium=
.org/ .
> It is already in mainline.

I'm aware of that work. It's an improvement, but my understanding is:

1. It only works for zram.

2. We still occupy the full PAGE_SIZE slot.

3. The writeback IO request is still of size PAGE_SIZE.

So we're saving the CPU work for decompression, but not the rest of
the potential benefits of compressed writeback.

For zswap, decoupling zswap and disk swap is a pre-requisite
(otherwise every zswap slot occupy a PAGE_SIZE slot in the swapfile
anyway).

Then, we have two alternatives. Either we implement a small-slot
allocator for swapfile-infra, or we writeback a full backing page for
compressed memory. The second option is a bit more straightforward,
but then we lose relative age of these objects - a backing page might
combine very recent compressed pages and very old compressed pages.

These approaches have different performance tradeoffs and need to be
evaluated. But anyway this is future work.
