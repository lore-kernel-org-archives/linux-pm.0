Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017082;
	b=UlofCB+Te+jZgQkCtWhOrytk9TudWJhWcGrFgYuWvoLlfO3+5oRjPJX/tfResD/zNSEg
	 wUZH/x9//rwJTpxC8gjhGErD8G2/dGfUAOJ39rMSyhKE3PX1YL/NdeoczWMW7kma+ffYK
	 tbwbtL26ZgSBDaa4Tk7jIzOLfiS8sCKbOlvCT0rTdfqtX5zphdbVBollgJk61At1QEDTF
	 Mx1cQVLHCLwEI5g80SiC6a77pfh5b/PQ/yMhUChg0IkpvdhAov7wabdx15rvQqEJu+6HZ
	 MfCFdlnMHmiwQoZ45A0e69MIDIz3VzKbkCe4945R4FIxjfTWOCdzj3SH21EK+qPSyGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
	b=j16vkC+G3/XNsMs7aV8sgejEO9TroookdzXsRa4c/E275f7V8WmR4KWvHKB+QWWFEuyR
	 YFffu6nyyiuDKBecJoFLf/W3OF7LRYA7ZNDCHE2gUuPrtYkc9iR6oKZD/zyTWEs8BKjSW
	 2hDPQgHM6/LE45gtmlUj0cMz4soFQGabDKY1Z22t2gljFl2Eo3wvmmSNiDr83LC0zt/1J
	 tyQaCdCz1jzstgr9M3/qkBH2d64mgIG2IV94kZxQfNL7Yz3qzJaesJxfpSQqFpCggScRs
	 ZubzhppONoQjkZ9wFMCshJ+6gy9dmJCl8cpi31a3looRbkyjCP/EobtsXcG2owkuGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CqFB5PkO;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CB60A2609
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4CB60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CqFB5PkO
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f20c3aaa5so109985885a.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017081; x=1795621881; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
        b=CqFB5PkOnM+jvAv7ro+HFL8RPRzHIJTyl492dti2dljQd3wyAFFyu9HAkhm+anbp8B
         uvCfhGnk7pw9Hf6Wxwj+qknoup+tslME/SAC9BSsgKXdywMvXRtsJxl5jXwIbkgrtw0H
         YsXSfwi9ZAXFWkd5QYdFiQUdjvwEGBhFNFkmhoPD0FUTS6O2P2cZNimb4nldmy0cUb1L
         YbzAnXtxIxAeadwaWNpbGyFPOrJLj5xyUbMxiZgzYgX8IDb94l+D7JpA9zYEjT7BrNqm
         pvy8ZFOnH0w+IS7vnDR9ueJvC97X/SQf0ycgblv03SriCllJZcoeAMyBnVHfCbECHmFj
         AxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017081; x=1795621881;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
        b=jTK/bNgpO0imNTi+nz8QS91w/EHPnVAGF5Sbb2+EvAZ2fNkNDonq8grN+g97BbsrsT
         dfQj/ONYzZfXTkTzl/vQvha5mhYeEqicMaBvl6F9tV/5Ej+Rlikheb5LOyxtrmXnNkpP
         PA+7UthGI6ftJm4Fp2g5uBEExguyqp431bp53QYvQRycc0dh6eOjtZDYzdjm8JXrq9s1
         wH+iF2jz+K9FBz8feNuVFnmtlblvmX5DjbYWWL7hklhzeML5sZn+WIDRRvTzw7sM9jZK
         b7J+GWNW0CxQdU77QsABnOZO8d8i0h3cTn120rVhYRSyuDWFX0xdkFLA6h2+IAH25obS
         Jg2g==
X-Forwarded-Encrypted: i=1; AL+hErG+O+m8L6V2NATfqdZFaon3+UEk4UQpgmnaegEENvHLNAYeQbsHgBusZ5B3rYOiKTobSrO8S9P0/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9dYb4d6IayzKsvXQVSw40R3GMKdD/x651+I2h4djKqS4auMxOr
	b15s7gF8oIFETj29qtaHQzhI+SbJM0t31TKVlyQr8RCTYJKbPQzBabNVnb1CUX2KtWM=
X-Gm-Gg: AYBFou2tzlk1IR9T/3JDm/WfQNVa4oqIn7qfrLkrHBDBrVBJw2FApCG4/dGDAIkiTwv
	leBQJzLX5NDQCQszazCVTRriC/oLAxtKA4YyvvK3CYmP4wsiV6DTBRBGfOy+Xycpx7z3DBLggsZ
	XyqPkrPJSufh4qaBHBG3AzowmodTWEVTKTkKV3OEy+/9wwKDshygHSAr5hLpUuSI056tsv3rGt3
	u/PGeiP8rVYQ1tORUI8VKMXK0SDJeNNuv2yCkQmkW1NaJuiDnCpfczvZ7w5drBAtMnpErjX94Xl
	05fGiOjb2hDoAFElS//tNnyvUEsdiKhP3RRC7xHxTKmBsAd3XKzUmNarWZ/J7RCsChu2UbunxO/
	XXaXOmmWH+1bQQWh02acehLWGyNSv6giTHGDBoR67142OZSJIdPIDnQktNUPxlWw9pvKbx+Rjdr
	1c6zFnniakPfgaoiLQr6jXyaXHcb0dSVNyN83lKJ8OuzfgJor8NcUB/nmdaUWZW2Hd+bhojprW/
	qqG2olToEhXnLLhK9cGi0UvTnwBXEYNjzghw3pZMi5umtzFYm9NMtGuUuqR8Mqmz5hXtFOoXl9w
	KaTXrzT7YZJBJDZqcHJkbiklYHdhRBVPDA/4S6gFf8JF8pMtpVQWKxlQrfozFX2PfsGhsVLVB0W
	28zSOecg=
X-Received: by 2002:a05:620a:8086:b0:93f:2938:48ba with SMTP id af79cd13be357-949997ac21amr514417285a.55.1795017080864;
        Wed, 18 Nov 2026 07:51:20 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b454facsm210842185a.5.2026.11.18.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:51:20 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/22] mm: introduce the common-memory node state
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av2_8Z2sdM_9zUEL@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-4-gourry@gourry.net> <av2_8Z2sdM_9zUEL@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:51:19 -0500
Message-Id: <179501707902.1206716.2408532904937875068.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:24 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:40AM +0800, Gregory Price (Meta) wrote:
> > N_MEMORY is overloaded with two meanings:
> >   1) a node has memory.
> >   2) a node's memory is reachable via ordinary allocation or
> >      an arbitrary MM service may use that memory.
> > 
> > Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.
> > 
> > N_MEMORY_COMMON nodes contain "common memory" capable of being managed
> > arbitrarily by the kernel MM based solely on zone membership. Following
> > commits convert relevant N_MEMORY users to N_MEMORY_COMMON.
> > 
> > Add folio_is_common_memory() and page_is_common_memory() for MM services
> > that walk folios. Following commits convert folio_is_zone_device() and
> > page_is_zone_device() callers accordingly.
> > 
> > Expose the state via `has_common_memory` so userspace can identify
> > the memory available to ordinary allocations and common MM services.
> > 
> > Add has_memory to the docs while we're here.
> > 
> > Every node with memory is common, so N_MEMORY_COMMON equals N_MEMORY
> > and there is no behavioral change.
> >
> 
> This sentense kind of blurred me, you state that N_MEMORY_COMMON is meant
> to isolate the concept of #2 from N_MEMORY, I expect something
> making clear distinction between common memory and private memory ?
> 

Sorry, basically as of this set:
  node_state[N_MEMORY] == node_state[N_MEMORY_COMMON]

Later, we'll introduce N_MEMORY_PRIVATE and the sets become disjoint.

I realize posting this series in isolation was a mistake now, and I am
going to post the entire v6 of private nodes with the reworks you
suggested instead.

-- 
~Gregory

