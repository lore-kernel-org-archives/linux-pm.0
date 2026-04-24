Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6183E5EE5
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053909; cv=pass; b=ugsdpd33RGnyQzyZzTnW7RHsWHv22pf0ITXgIx0zKhzrYM1R8gJ0Ur3bxUq/vTrXLMA6plCBeaoTdhquK2FvB+OmSzHe+ZcImv26tUuwHOWPCROjqGy4VM+0Y1ofQdlaHRI7yyO6iAtdzh1pfwjAvwGcN04s7xqVcKyyne3HUAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053909; c=relaxed/simple;
	bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMcsQbLLLQdTRBuSxxJnLja1PNYPT/CtprcImIM31RUCLfr8B8CW5EvLrv8IVlcVJZNwT+yBIJa2RkhJcClBdYRzg1dCJXJTpLfuwSTk4GfJQ/Fd7IfGMg60EtweylgqJYeVqt4DhUa3fkQDCHdOhgZQhDtS20PArNzvboU7os4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+fO3Xf1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+fO3Xf1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671d60ef9c6so10904914a12.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 11:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777053906; cv=none;
        d=google.com; s=arc-20240605;
        b=juINk24Qzo65gEha9wC9l0XS7InxgNUjSkdpeZhvFMHlfP5hieP1rEX2fLtjFFfm+0
         CuIHp23oB4wiKncRmeeKfU7DN+AmlWA5dkqu7wSxgyuH92pHyVuPNLmzso5PGNWQtz7l
         +45cGmy/9PYynBzRvwewJnWISNO6HlyFU0Wh/N+7wRznmEQUOjsQEM7hlkNpyTdDmcUN
         sgc/iuOmmkrIepTwV690Z9h992OJ+BJN2snej+/zZi3CVMHXKwCiQZVwuvrS1g757UN8
         gbQkSLpO/QqufIzriERTZ2Qx+jZkfmn/FChWk4YoPFXzZrlSAIWawgWbB815AkTjpaM0
         RHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
        fh=KAxR06+G+Sqrc3l7XvPVCZvBvxjDIysRINBxoQyyANY=;
        b=KtMO3gwSsIRZUnN7dJUGlA5fPrug/MdrNYn9GEYY2ti4ZPLlONFyrsinZtSMcE+Crx
         AlioIEGKXsT6Svv3b3lNEY75qyb/u2UdMMuPJAfE+27Q6n5xD/oaBS4PZvFeMIh6u6ZS
         nCdOwAXMujakfoMUaNZ0A+43Lz3MAXHHbrp9+2lUGX/i0gGrF+nBB2uUwp+02tAyBvjl
         2L+ZQwMb7P/U2egVKhF90ymKcyy9C3XC7RFVx9K1LtfaT1eR+HYYwWsrHFdMZY2VEDXH
         4zVru5FHnc7TglOTnwKKubAw58jUzDWx3GKaMMB6sAmcIBM+0QNdRpTxY7EuH8twGmBA
         vN+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777053906; x=1777658706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
        b=M+fO3Xf1vte+M+aoQjf74GeOr9LhLe0bgIpEioKluyhRmvrLpnfU60D8N+6F+ykenf
         3htkjMfL1eJ6AicOUcU/lN6H/Rg1Zd3W7/N3i/wTPhvnxm/9a0ArAdNwDFdHQk9U+Jle
         eBiTX/awkW61px0cmxTfgK5O/7KYbJWysfvyLrbsFc6oAOHcIJpmwD/8bLt0A2VdC46L
         hwbBAzca0rab/fuVVaerHg1DaZE7WFdMxouL7H2/JZSVW2iJ2+wpGImYx4pjBCKIZ2Nd
         XSdOBnWOtnssKv1QvjdE7lH6iUa5ZOV7f5MpUGTJc7UT+BWrEnHgcERmQUON/KmdtnW0
         yn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777053906; x=1777658706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wCED2gyJ66NMivSm3uMeQZjOR2fIAqNWj1/nJY0+EM=;
        b=seTjmQgE5TbyXLKnYhgLAo/5qn+USXh6rdmSHyCOluqTdb10rAKg8KpqqOzK6/+yi0
         Q4QyIcFSxXwm0j7ywvTUg6GyD6n37f/bQBP9Z32cOiv/0FRHVppfSD2i0yMqzYH6C5l1
         LzZzzDHP1S0XQT7fhiVqPzWfK3aOsSeigF28Sx9Q2CZqCR6RZYcGuGRNc4Js0kd2FpoK
         hS9QqcX4ydTJ+ZsnBwVtOAdal9gYgblBXWk2bAxIK3+GxIZe7hpsKKe4koqJMlhNYVXl
         3phUhTtwFLKqZBudDrFOuNptHIkY8GX9e4EZ8kuNF+LSuydczietnCzStqlHhM2omGs4
         SlfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MDbrHEG+3FgnxJ7EOsatqEWNNUgVTvAN8+SineHKSvX83bBazmKUgVDc/dZNKELVT7vqfe2yggQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VoQVWO1/wmIpOT6us630HHmIdn/oomET1+mS8S6fOg8eWCHM
	F0Zz3Wfs1NcnvloZ6BO3YDVg/ZWi/NWQbNgk2Gtkn3vC4EZmJOqF4e2K9XzvM8SLXTh4IEn1bko
	uYf7eGdTkhYta1+2SfKk/Mbsvz8LITfDW1/dr2DI=
X-Gm-Gg: AeBDiesC5NCDsorqZdRbbWDoPeBUeZvxvETJPqR6BiLPjk4vKxz3EaUyxPAcvIekN9u
	BKWXbxDuVLTyuz6SLvnpZoiMbej3Y0yIp4ohNqERwxGAvG1YNVyPIz2TLml+L4p+YL/cjWA3MZX
	O32Gv2KTKkEeXL46VoM1uKCMi4nb6ZHr5cvK8fNlCe3JuxFVg3ve58fXGs7O/2UwytAfJ5HP5dG
	PuE0mTNmfQ+1zKF9KrLxhmmHbxdkm5XKhTWaMqjLqRKLOJ6Q3yf9DcRrEINRTsnLqP5Z94fupdY
	qwANG1tRfra6ay+WCewFl9olT/j+aJ0/x//NHSxgCwkrSUkpFuW3EWzDTPoctg==
X-Received: by 2002:a05:6402:5051:b0:672:c366:b088 with SMTP id
 4fb4d7f45d1cf-672c366b207mr11251845a12.8.1777053905724; Fri, 24 Apr 2026
 11:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com> <CAKEwX=ORdgAwaJLv8CidOQZ0r6ZBHkDYVUxZv1k2PiaZi3qe+g@mail.gmail.com>
In-Reply-To: <CAKEwX=ORdgAwaJLv8CidOQZ0r6ZBHkDYVUxZv1k2PiaZi3qe+g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 25 Apr 2026 02:04:28 +0800
X-Gm-Features: AQROBzAYXcS_1H5K9HyPupUmr2KbUwpuBsIN1OBxlrG3dClTVKgn5H7GzhL8dcs
Message-ID: <CAMgjq7A1YLyxBKqVi4moxGPBh0wbnehW91uEqxrNUm2ziTy_dQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	Alistair Popple <apopple@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baoquan He <bhe@redhat.com>, Byungchul Park <byungchul@sk.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Lance Yang <lance.yang@linux.dev>, lenb@kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Brost <matthew.brost@intel.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Mariano Pache <npache@redhat.com>, Pavel Machek <pavel@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Suren Baghdasaryan <surenb@google.com>, tglx@kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yuanchu Xie <yuanchu@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
	Meta kernel team <kernel-team@meta.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 1:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
>
> My apologies for delayed response - I'm cleaning things up, and
> fighting with some memsw issue. I changed the semantic of the
> memory.swap counter a bit, but that makes it diverge operationally
> from memsw. Need to be careful not double charging or double
> uncharging here.

Hi Nhat,

No worries.

About memory.swap, I also thought about changing it a bit previously
to make thing cleaner:
https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d19815@t=
encent.com/

But I dropped that part so swap table series p4 can be reviewed
without any behavior change. Not sure if related.

> > I think it's actually functionally very similar to Nhat's design
> > already from a high level, the only difference is we don't need
> > standalone infra for virtual parts.
> Well yeah, great minds think alike ;)

:)

>
> As you have noticed, I have also converged towards a lot of your
> metadata design and operational arrangement.
>
> Case in point is the delaying of cgroup check merging with swap
> freeing - I did not notice that patch you had in your series, but I
> realized I had to do it as well after studying the regression for
> awhile.
>
> (I did think about proposing that outside of the vswap series, but I
> was thinking it would not be a problem at all with the current code.
> But in hindsight, since you're also merging swap cgroup with swap
> table, it will have a similar implications, albeit less expensive due
> to no xarray indirection).

There are actually more issues behind that. Later we would also want
to distinguish shmem / anon swap entries again, so swap cache
allocation ensures there is no conflict between these two. That is
also causing some real issues.

>
> Hopefully we can iron out the rest of the differences. I have a couple

Yeah, definitely. I think things are already getting much cleaner as
we keep unifying and simplify the swap infra. Consider the current
swap file something like s swap mapping as an infra seems to make
things easier to understand as well.

> more use cases in mind (compressed writeback from zswap, discontiguous
> fallback for swapout, etc.), but without virtualization they seem like
> a deadend :(
>
> And Gregory's cram stuff too - I think it's not undoable without
> vswap, but it's just a lot hairier :(

Ah, I'm not against a virtual layer at all, actually that's a shared
goal, I mean we might not want something mandatory, and redo
everything again with more overhead.
