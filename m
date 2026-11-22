Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374696;
	b=eBNUMLc9eqvmmAbbT1aGaSu2ITXlv12FofJixRcdb9Dp9ySSU+B8mEZa2FJ3MlrMVLlI
	 hfV+3zj0AkGhkmqtje5wCaaif6b5b0kSaCet6JoR93Lsdd1s1UubOUZmXvsgeZMUgjsp8
	 wA5V4Sr3gvrRXBP1aGH6HhaMJ1UjLwGbgTO4IFK1COHOu8OFVEzwUmZ6Yvn6mdS9/VSeA
	 p9YudbfffSQFPbhRfwwZPIT5iVRWj9IvliED0DwpwFLAvLpngyI7DB+CsDDGWyXFam6AU
	 GIfmrzDa/BOkgUGd76wFpN5gQRWvuLWAIfZtGJnO7HiKJCVYXoQNEd7DXfgd8ogEZmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=oGsMa7wmHQHTRJX2QekmD3Y6Ja6uGmq6iEm7evLlQd4=;
	b=SjMD/RrMYSQU5z21H5Z7R00l1jFao+zZNhrBudnKV1jJLD7aCRLJn2bXcbF7SIqlMdNY
	 zYZ4LlmFgDpra5zdTm9YScAhqffgiYzWgKvDTxvPv6+GCAcWZa/XCiWq6BkgjG20jsS4O
	 SG7MDKeUkwsHfj8yUlvZqt6Lrk3b8LSl7SWEk/KFYW2HCn+tdfgvgRNxQQX/XqpHS/9Pd
	 O+By4yur4bEqiulDUYqsKYzSXrYPtf6FXnNzjx/KuXWsOSerTHAAILC3r4FYzEdm3crII
	 x1qg4aEmDwFo146yv2jzmI7dqg7OOBZY8Y328JJw74OtNAIAc768gLMOpVQawtnR/4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TPI3MTe1;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BE606A335
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 19:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C31BE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TPI3MTe1
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-94960131b30so266787285a.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795374695; x=1795979495; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oGsMa7wmHQHTRJX2QekmD3Y6Ja6uGmq6iEm7evLlQd4=;
        b=TPI3MTe1RlG4SmZzzoCpRdy2QVmmqnbO/w6aR5KNMokJV/Ej+uAFQG7yAYqk56hfkq
         LZC9wKLhxk3NMVRMaR1VvWVuCxA6GsIEcwsr6le7u6bdoCGonrAZjK3eTkxOT3nRTyMs
         kLr2KYSGk0Kdl3U1jn7zVe/GjwSTB8XynoaJu+1hSecxlfaiVnqBhg9qfE6UcOdBFpU7
         K6+K542N8Cf/GVSasbtS0zq1zF4T0u1FTMwtPGg2hgdtwvyFLiHHyHTH+dkRxgJO3IEQ
         VpIReU6i3uKk4uALa/TFB/P/g7vgcldffZQ51PdHza/mx09Vr+vtrjEp2lxRt4rjm1dE
         cSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374695; x=1795979495;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGsMa7wmHQHTRJX2QekmD3Y6Ja6uGmq6iEm7evLlQd4=;
        b=NSnV2Tcfcm4Bakv9Ucz57b0WaoA7vWxEVCD/CKx0mFtZ5rWzzBIsVSo6CoESKwTaqJ
         FJ0jvuFJUB56IiGR+zQfJN9DsZ0toODxsT6cYEGRsvEwRaKcjptj7BTVTBJqE6PT6yjL
         9NFBIe4zODGz+JdN1SksKc6LQ0beBQ7K6DUGx10HJrysmoGELzNh3tpMLu99CRlbXRqJ
         wD5FOUEUO+9f79pqgcdZsZZW6ShKV7fOzr1OW6x7aFbc0L79sjBpuuVNG4AdqqNneGzV
         dJEALZ+Y3oJMKqPKwyLK3oTooyLo16s2iLtARgGUaFiJLlb0qCJBe8lZ9i+Iucs18bB9
         JjQQ==
X-Forwarded-Encrypted: i=1; AL+hErGgoYc64jv4r7D1+0FsRe2touJwzKBXC+fQcKdmcSnbESf+OItyiFhSSVAvsBIoloNLeWpfeiPfCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z95yTLznfZCoW95yUYeRr0++WdzNxBRF7aEBIVvSJk17HqM82uU
	AX9I/G/pKrV+AGLwesGTATTHm12aHtPlMUqyjxpSmDETgjlEYoc+MJOjFnBVDdGct/8=
X-Gm-Gg: AZFdTZc98SN4OfRikaCBl/UkRPciy/nG3TqIC2cIeVnUTTIdMnrknX6oIgg6Kw8WXm2
	OaV9oZqYSP5Fgvl8vVrp5EDRkjmTyavV1BaPkC5fPo9J+PlyEho+A2jsQ95O1Hj9IkjI18u1Qfy
	0mxvHLEUofjFwPwRWH4bO2P2OaqBG5EW0NXqt37svqi0+6TjXet2Ml08vbwOs3DXXhq0PuUjkFc
	Ko54XWAntu2fJ6p/IwCPh7CfSbzgy/RPClwD9XaNFTBXU+zyuKtRmtZOYEQxXqwO6zoTdL9NQQG
	lrXYKy1d6emEpk42lUsV4vnpBKlo+izXwakgjN3GCUYWFZtrd0bYAZcqNrxIO0wulilig8s4dwI
	xH5Q+sfFQSXD6do7Ai7rjZz7eZRBozcsGdffR/Wr5qrF//EGSAbvlcEC9vUWu+48mZCTO9AfiPv
	p88yvDLntHoqV5MWevw2c11hDxEbjx+R9sHxlsXY/ChS33NVr7fYwf3LJCD0XSfbESCACoKbBC0
	sYZCYIEHor6Ixb69I7qh+5OBrMYQEbb827ybNueYKzf6hEDrkHVgcvb/q/TrgquU/85Gfwv2DaM
	OwidWRyZphkDpr4TlbeCAE5lKhv5uYYLKUoPb5a7wb1Z5HT7zlMAygQY0mS/TBFYVGaHm6PIbkR
	TegDnesI=
X-Received: by 2002:a05:620a:4727:b0:949:326f:bd2b with SMTP id af79cd13be357-949ba9aa37amr1639379885a.43.1795374694656;
        Sun, 22 Nov 2026 11:11:34 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38c903sm651828485a.19.2026.11.22.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:11:34 -0800 (PST)
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
Subject: Re: [PATCH 00/60] Private NUMA nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: gourry@gourry.net, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awMdeK8O-5mffg2m@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <awMdeK8O-5mffg2m@yury>
Date: Sun, 22 Nov 2026 14:11:31 -0500
Message-Id: <179537469194.412063.13456998694958645706.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:51 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:08:51PM -0500, Gregory Price via B4 Relay wrote:
> > This is v6 of the Private NUMA node series. The series falls into four
> > parts, each building on the one before:
> > 
> >    1-18  mm: introduce N_MEMORY_COMMON
> 
> I walked through this part, mostly. It looks like you can substantially
> decrease the patch count if you keep N_MEMORY meaning unchanged, and
> add another type, like N_MEMORY_NOALLOC.
> 

I don't see how this would reduce the patch count substatially, you
still need to convert existing N_MEMORY users and need to differentiate
between general purpose memory nodes and private memory nodes.

And N_MEMORY_NOALLOC is not a good name.

-- 
~Gregory

