Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729C12CDA5
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955799; cv=pass; b=ll+FL4pVYa+uD2nIpwWqoOSUWpf6kqFFPnOrS6qnWSyPzC2H6C69PcYFXn+UqM55p0h7HAptNrcxq3DXXI4kNuNuogKN7PcHETkSLiT+sLvroT3aF6V1KR6yvrdkv2ERdLnavOXuzHdfLrAlBqC0CGUSuiJPTI7q/u3IsCtclsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955799; c=relaxed/simple;
	bh=PlZOaj5QMEwQ9f/NbjFyXWBBhXvCrxn2EYbvYVQJYV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzF2/NPRHNS+/Qm9kQqz5OXW5/yg4ph38ugvP3H1ga7+iT5JBSeZdFUMAFtjAuRKmTmOnzqgLLP8OPYR1NCDIINSN8YLM3DrRefxryDWFvfSvxrrpe3AYpPqtO2JgYBFF6JOt7kgjXtmHAQtZAMN1Y50qLSZ04X11ppZjCbCrjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8iu7lh6; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8iu7lh6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso2621704f8f.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 18:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775955797; cv=none;
        d=google.com; s=arc-20240605;
        b=esVzOIRqCFnESbgS26iXU+ruGschd6LoKQUOkY+CyVMM8RAFEQt2VvBboiiH2hw7GX
         l9VdAAKuLf31zS0+kbUz1aVbjnbKWus3Y2Xu24z0NNscNj99OMxih+jI839kVRs0xc07
         JLp3EhkbclpsaHrtkNbimsfsqK9Y8Kym+0cB41FR12A/OygswDthpLqcX05oktKUt7Qc
         9UbPaAsnlAjW9lyWGmKoT0gWqEJuCK838yCLZCROdOkcrIx9PjUpcSyWmfXdVM1j2Mh4
         ds0lM9j6uX15y+sNsZEkN5ljd61Z6GDtnq+tdVSvWW1DiYFhHf8rNrCbC2WFvqDobxoV
         3zSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O/lCR/Upuk85s1KKtsj70aAhwIocyaRuQRg4fGGyx+k=;
        fh=pponzvyidXDpWjOA70Tnd1dZbkeCkDM/Mur+neGJDyU=;
        b=Hpi2ZT1L93D8BuOlU8iyYQnJP5U5PaHRwk29GsOJZdI7hdwgwdCLCgvmQj79/I51J8
         cBr+X2UYqUB1b3vn6p/xUSe08uXQ1HbepPSWP2GPmndda4d2tuXEoDjfmgZL50viwmaD
         gv9Ap/q1EXTHswczvPsuUvxo0YWL2t9tWm1lljth9aYrnXyO7b5CcUH2/sBn20/m8Oev
         J30I8nzztn/yAJY+YooACuH2jLzoTJrRxqvxsItg2W5bVHtE5a9OfWp+EPzTVqoYyUke
         BJSk5n40GXL3fZQB0iuhGSjW67bogpM/Hn7cCIBXnMrJQvvOqx3/xrgLMSHvj5n7Vext
         Mmsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775955797; x=1776560597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/lCR/Upuk85s1KKtsj70aAhwIocyaRuQRg4fGGyx+k=;
        b=d8iu7lh682alIilkEG+IQW+0sw9tkdjLYdICcAXX41fGk1khJN1o/oRhp+a60E96jI
         5SUor9IK/3qHbp0MgFO45hMezpvW3IS4RiQFoHh3grpdUBVslchzZzc/qxmuIY1I6vl+
         KnQD8EQ7SQdU0nTD6FKFCh+lpuU578JondNumuZYuZX5x2S8Q9o5ew4w4HDj96+RI3C5
         GZnXatBbGfal/g4daouUA1IQJI72pB70si4J2JaIr+HiThjBHepX8YMM+HHlSZBsrDaR
         qBOKpE+dHijWTqCm97F+mYAtmb6thTxXn2mMkFyogokueMvSGQvIuRGBQpuZunOzlRt8
         L3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775955797; x=1776560597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/lCR/Upuk85s1KKtsj70aAhwIocyaRuQRg4fGGyx+k=;
        b=lEz1hMWQi5u9M5RzdN+V6i508ynj9Lq+r/iGt1z4jHXyUqvm9F6oNyXtp98BjncYFC
         JWPG9deHsAI7tWCAcHcRHepOdJp+Y4VdxnzNJbAaMtsBhSEp0Ke5YG1cAaKr6Rie32Ui
         wmCWO1zKllE/IoXdUABOkudn5gY53Z0clTbZrYZjyugcAVcZlkRwoCUTM8iCe5fgjfKk
         UHZ9jcfYXYKsfVKXjqASqtkX6TQJEgjWS1a42HlyJn9X+ucZmKg3P7Yb3eBjwY7xA2JR
         QjoWlJZRNrfk0Bfrg1zeMJJ8aZqHntYonG5s4Bb9Hzt8tN7oM/6PCXI+YVLjDivxEa1+
         Cjiw==
X-Forwarded-Encrypted: i=1; AFNElJ9YiiWVY/xynhVGm8LgyP1lHe/aXps6em2IvwgzSO0SSSD/RPUjCW37mNUHG+gWV7FwHKjqKiBEuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iHMehLCJuoDeScdVUfXknAXnB6A6u/YhltKZKnnpqhafxOZr
	gxIW+g5X8xw9A9VArBGajpj9eJ61J6XD1kB6/i9TTRdSem68JpiZCXFhfRM4Fwao7t5M9Sm4qEe
	dCKhHhr05eaWA26ecWVLMd1MzVR00m+o=
X-Gm-Gg: AeBDietoOd7l351psj3OORgwgA5mLKgS+cLoGRTtt2rs46UWJDPMo4s68hzg6G6VjpQ
	sZP086Bo89c3Lmdt76a1OW1Lpb3l7bHGRziXHKho7ALmYbNS34dOAaoXu73smEfT873j2UFiFq4
	KWaGUZ4rTR8WlDs3DWs3qvSPBszmzTCbK+oEPkItgKCK5CeDsG7eHCvbZH2/ontSdV+Czyx+85H
	DniSN8ipSobNr2zv6xy9jLe44n5UHXs5UTsCf7R2eJ/6Z9jxcGVV+tSRAnNUJbOM36tl6xBmgw8
	6fP1czJh3shao6v5xTF10IfUN23FfG9QE9sUJQ==
X-Received: by 2002:a05:6000:2dc7:b0:43d:2581:3053 with SMTP id
 ffacd0b85a97d-43d642d9d6fmr11425935f8f.45.1775955796453; Sat, 11 Apr 2026
 18:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com> <acQvNRLpHwnHt7i+@yjaykim-PowerEdge-T330>
In-Reply-To: <acQvNRLpHwnHt7i+@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 11 Apr 2026 18:03:04 -0700
X-Gm-Features: AQROBzD_Pt7K9MF5OX7eBfMwphwrIpDFPvFIpxySkOPErMwdGQw3LLfvFpdgRuc
Message-ID: <CAKEwX=Pt04pYfhYOwmtXJKU5OqcxBC14SAf1wpBxBo1D7rPpGw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: Kairui Song <ryncsn@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:53=E2=80=AFAM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>
> On Mon, Mar 23, 2026 at 11:32:57AM -0400, Nhat Pham wrote:
>
> > Interesting. Normally "lots of zero-filled page" is a very beneficial
> > case for vswap. You don't need a swapfile, or any zram/zswap metadata
> > overhead - it's a native swap backend. If production workload has this
> > many zero-filled pages, I think the numbers of vswap would be much
> > less alarming - perhaps even matching memory overhead because you
> > don't need to maintain a zram entry metadata (it's at least 2 words
> > per zram entry right?), while there's no reverse map overhead induced
> > (so it's 24 bytes on both side), and no need to do zram-side locking
> > :)
> >
> > So I was surprised to see that it's not working out very well here. I
> > checked the implementation of memhog - let me know if this is wrong
> > place to look:
> >
> > https://man7.org/linux/man-pages/man8/memhog.8.html
> > https://github.com/numactl/numactl/blob/master/memhog.c#L52
> >
> > I think this is what happened here: memhog was populating the memory
> > 0xff, which triggers the full overhead of a swapfile-backed swap entry
> > because even though it's "same-filled" it's not zero-filled! I was
> > following Usama's observation - "less than 1% of the same-filled pages
> > were non-zero" - and so I only handled the zero-filled case here:
> >
> > https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.=
com/
> >
> > This sounds a bit artificial IMHO - as Usama pointed out above, I
> > think most samefilled pages are zero pages, in real production
> > workloads. However, if you think there are real use cases with a lot
> > of non-zero samefilled pages, please let me know I can fix this real
> > quick. We can support this in vswap with zero extra metadata overhead
> > - change the VSWAP_ZERO swap entry type to VSWAP_SAME_FILLED, then use
> > the backend field to store that value. I can send you a patch if
> > you're interested.
>
> This brings back memories -- I'm pretty sure we talked about
> exactly this at LPC. Our custom swap device already handles both
> zero-filled and same-filled pages on its own, so what we really
> wanted was a way to tell the swap layer "just skip the detection
> and let it through."
>
> I looked at two approaches back then but never submitted either:
>
>   - A per-swap_info flag to opt out of zero/same-filled handling.
>     But this felt wrong from vswap's perspective -- if even one
>     device opts out of the zeromap, the model gets messy.
>
>   - Revisiting Usama's patch 2 approach.
>     Sounded good in theory, but as you said,
>     it's not as simple to verify in practice. And it is more clean design
>     swapout time zero check as I see. So,  I gave up on it.
>
> Seeing this come up again is actually kind of nice :)
>
> One thought -- maybe a compile-time CONFIG or a boot param to
> control the scope? e.g. zero-only, same-filled, or disabled.
> That way vendors like us just turn it off, and setups like
> Kairui's can opt into broader detection. Just an idea though --
> open to other approaches if you have something in mind.

Yeah for vswap it's probably going to be a CONFIG or boot param.

But in the status quo, we can always add a swapfile flag. That one
should work already, right?

Thanks for thinking about it :) FWIW I think zero check is really
cheap, but yeah it's just wasted work.

(ZRAM folks - do you feel the overhead here?)

>
> Thanks,
> Youngjun Park
>
