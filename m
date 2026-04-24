Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595B324B1F
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003436; cv=none; b=D5oCZ3SgzZCfjhYjFHDUYX8iO2flxGsBsJ8ziHfRxFOdaLDRjOxykRzeQhRKurYqKxnaSVA+f6JBBX3JBYx4nMhz4Fpk80C8Ee3LHDMNcf1uGTIVEDKsdegDQAqP2s+nc/UqfJP9zwWcM+nxa+huH6W66iugNfAhBZYF7RgE8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003436; c=relaxed/simple;
	bh=vFgN2he2wn7NXny2fx3vIJs8kMnvkzqTUSZ0mPgUoMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1NLDBMHLHtngPiE2oTsvmw7XqsQiGVPwgArL2ZCI9WDDppt2vA54GkBbWZ7kwcFDDl/jsASdERHU83x3dpyBdIkgFaN6sfaC4r7xPQumvqKBn8xlMIorH6cEJyHx96HTSP4MJVY0EQLYDF83d0VhQXQBpqJCb3TdZAUVAuieUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LE5Ak+/H; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LE5Ak+/H"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso51341376d6.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777003433; x=1777608233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0FSatf25bGDOpWwH0IGYTUNBidZ18cuj6W5qCjaLYU=;
        b=LE5Ak+/Hq4WkxgBgHnsjhWLAGCQZ28AIxOFH5UUuXNJcW9XvsrE1KGN50Ei3W5EyTa
         SCXQHvs/IJC36gZukDdtk3L/nIS9yD4LyRD2IaMGsBO8Unphd4emO2xP+PGUrNC3MPQK
         NtQPdOVFXFH5LAEiSvtf0/tc0s5aWPnEieXa9x25jzrFPIeFLO+bVtw5/EX99eoDVozR
         pHldb4B0SzyA/8lwf5yMQPXg9pwUmO9g/XIAZxDVi50e8Sj5SqF0gG2LIfmGYtSq62ov
         yH9squnmpC553pKeu75AkKkiNaMzRXP+2j7xn2RtYkEPbEOa0+LfSnJo32ETianLvZJl
         WMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777003433; x=1777608233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0FSatf25bGDOpWwH0IGYTUNBidZ18cuj6W5qCjaLYU=;
        b=XPTwuNwnuE32isNTrNr7cDJr4vNQH8kDih3A7T1AbTPO9pc6uQIi26HfqPUokh5DSm
         PM2XjDVbWu73xi4mIJJc9PWFYi2EFwAQdB8E0dJEJkUfYuZ+GD4JtB1mmHH2G5aEdQDH
         kHj3z47R01bnAYs3ayzRMhfXhQMKCGqOLdKaNl0ADSJVJxzcX6EQ/vZsFf2SnXs+Zlm2
         sDdAbFsfmIajRIQG97H40USPyVqlf++rNIZEctEzuTZtV4bzfZt06dhnDmYhBuOwrnPK
         amzlXaAT4jqyh7yFr4QpU0T8+Uie8EA7tS1UBSCtwv77zHBAmAK2l5UxdrTUcfkcCTHK
         TfKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/q6oSF+vKVWV4PB+LjLElRDPh0c/tFSRfMCig9HEG5ry5R2razgRtodgLdOzmUGFmyKdKcS1+uWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry+6fJHJ+aTsT5yBt9/hXhDXYIBluQBcEwbychRfPoyu4104Y
	XGO5XMq9lvWNHr1onYXj2Ck4VxlJwXy2W+FJXPGoY3VMNNY1XeyJL61Z9XURZ7s6eUA=
X-Gm-Gg: AeBDieslyJIr7hkvcTBUjaIyIHPyOns7ikgkBlL036XM2zackreTdpRzZwHbjTd/LVk
	vx+YTdGlIZxWe1uG1xP9Dv4EF0+tKY4el+Bb7y0Bm8DxgabDhzcXFUxH1IL9doS8uW0a54R1jla
	0iaZqvhbivMgHywykwyHodTXcNR48+h4cA46JEUmqYhmmAeGgBltYnaBhfj3pGn8Yej8q7eI/FP
	eZ0ZAnyHQETahRZYgEfPuUXLobFSzzmhwmJN54/gWn9bykIFh4ozt9lrUsONV5uJoH/L88Sr7R4
	zqpRX19DSz5n/iDXVmDA63K29zf3G6WX9iwA7k2xYxYATI7eNakOUUe+6IzMMcWOEZtbEbbiVeX
	+NnyjT1rJ+9KB6cmkR/J6TBiozr0DR8okyG+9Vf0ptmd7VJjG55h1RzVhYSTiqTLqZxerQlYYvK
	DeOfiAqz1y7btUHLIAVGqjxANgiVZ2lKuO8RL2vR/F71Dia+GBtG3GgMTiUndJaeJdvZDB06+jz
	UvLo7NyuTh+IY13mg==
X-Received: by 2002:a05:6214:5b86:b0:89c:cfa9:f1fe with SMTP id 6a1803df08f44-8b028324ee8mr410764656d6.2.1777003433560;
        Thu, 23 Apr 2026 21:03:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-70-94.washdc.fios.verizon.net. [173.79.70.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae97d89sm178440226d6.42.2026.04.23.21.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 21:03:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:03:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, hannes@cmpxchg.org, hughd@google.com,
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev,
	lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org,
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org,
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <aerrps94j70MkgdW@gourry-fedora-PF4VCD3F>
References: <20260320192735.748051-1-nphamcs@gmail.com>
 <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com>
 <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>

On Thu, Apr 23, 2026 at 01:47:50PM -0700, Yosry Ahmed wrote:
> 
> IOW, I think the whole reason we want a virtual layer is to separate
> the backends, which would facilitate tiering. If the virtual layer is
> itself a swapfile, wouldn't it become one of the tiers?
> 

Sorry to add to the fun, but i do think this is mildly relevant.

I've been testing hardware-compressed RAM as a swap tier (CRAM) w/ vswap.

Will hopefully be publishing soon - but was waiting to see how vswap
would go first.  But I think this is a good insertion point.

With vswap - this integration was so absurdly clean.  We just add
VSWAP_CRAM and being able to writeback the folio to zswap or regular
swap was surprisingly straightforward.

The alternative was to inherit an absurd amount of boilerplate from
zswap, and then the complexity explodes if you have to decide whether to
go to backend X or backend Y.

So I just wanted to say, in support of this series, there is functional
value in the virtualization here that isn't fully represented by just
zswap/zram/swap interactions.

> I think this was discussed before but I still wonder if we really need
> a reverse mapping, if it's only to optimize swapoff then I don't think
> it's a requirement. We can still scan the virtual swap layer to look
> for slots to swapin. It would still be better than scanning the page
> tables as we do today. But I think there were other use cases for the
> reverse mapping, I just forgot what they were.

For the sake of discussion - there may be value in the reverse map for
CRAM, since it can soft-fault its folios into page tables read-only.  In
this case, you can have multiple mappers in various states (softleaf vs
read-only).

In the case that you want to writeback a multi-state cram folio, the
reverse mapping may be useful.  Right now I'm using rmap, but maybe
there's an optimization here.

Maybe not worth it "until something actually uses it" though.

~Gregory
