Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277C14884C
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406144; cv=none; b=KK8jiOusFOy7YIAN8eXW+/CwKxeT9YFtvW3a1F0iA90dnKU028W7/TeZnZ3HakirpFPEF2GxU0R8SrMfXq4+WdY54YG3t9NNE/x2ihgLgS5Hhe4PO9owZJINkZExSismLkcUhmwcWgPmkH5lEuPukpkwWzKOzXt6MIgRYS3rGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406144; c=relaxed/simple;
	bh=ubJF9m/wLx7bYWwOAm7o0d8tY4ejMPWhdFfkGi74I9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAQhUrSGGTgV49qqGFTV0KSO5M3t3AfDbPQAVXJat4pxKwZW/nYPeAZw70H8L9NQAP+PRuFdTmz3daA8YWUWlAT0J4Qf50Ml+yRkvqaeQmO7jOIgdW3qV0/ukCxRyfKkFOJoIu3xskwQ5UV8xW8zPSQF5b72vAfM8seh0oiXuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EurudgTY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EurudgTY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so4355063f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774406141; x=1775010941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/WqiqBCLyiLY/v28qTyeW3QcaRTjQUhA8ri92uqPms=;
        b=EurudgTYj3bgYiWZTc/rEzyiUkWBbjOsAiiT89wURxO/FYynIbN13FcNHNxXUEpLH5
         /Hb3dxM9wI3LWT6fQ5036QJudRU29qe+LzX3WYY+DrnqYjm50GmyAGBog6ncaWRbumnQ
         j9Hw5HpXl5ug1Ipp+IKmtX/y9qy9vtWQbd286QzAADbonJ2P5qDII+qKVzKMvGwhErgI
         A4RwRjBShlN9WqEX1FNtyhvyq2k6x3DhqPez5rTFgr+EWTs1wEJ7zzb/xtyZKALiPudX
         +JX6EGkr84JxVMtmzypATXAPr5qWwTj6xgiW2sFrJCMJ3WkV0VqlYIFSxQ7AyLWkrz6F
         n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774406141; x=1775010941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/WqiqBCLyiLY/v28qTyeW3QcaRTjQUhA8ri92uqPms=;
        b=oMFlygwebvnryLHB3soZwI++5vd2XvUGN9/uubrhiiHbqJYMVihVk5Y/CJYrsJpDzY
         j9xK08nTScFIQL9d5TVk/EUuDIyQn7GzxubW/VyqOwk8h3IhFoIfl9+DRTGDcnbt0IGN
         k9IFaZdcWzKTw3KMnUNYJU1j/5l46mVdkkwLm6KxNzkhV9Xxx87tURkYb+bjuX0t1gmm
         yBxytWsWjz2GunnIfjt+BY38gvn5vyX412XF5Jlb92t9eQSqnl9SbMGgpAzja2+09lUJ
         WvS54DxZ1H6VfYXnpmSf++y34S49AEgtbQFJj/B+Jl7LL5qnTEX3ZB6PmA9fnG3i369R
         MoLA==
X-Forwarded-Encrypted: i=1; AJvYcCU3lgdZ9iXfBRPp7Zga0/SfxDPP55texdMEr3mYtF5BikrT1FAAfH31zRfSB/f4ynlacuUP4MQc3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMo4OsS+5AQPEGjop8wWmWLpK3wrSBfFqjCoAHe6SP6sGTmkQs
	q/ZoWHItPHhWYaCfc0+8lwG9j7KPSWLP8itQ3wkhh4n3JCfHbZIxUjAZ
X-Gm-Gg: ATEYQzwKpb/8iQ+Rvn6N737g+SLOEzTNMAC1uWUgdmsy0RroOWlviSlOuuHH7yPEM23
	lIDU51T2Voy+XeXCD/voSJyzLcSOiUjXwym91naTEmUV5EgQgRqhzhxy46jJTONGASY36XDiySP
	Ps/b8acO4omZEicMwBd9uKeevqQnIvliW8AcpDLT9vnJd/8ZTgMaUQXyxUuVANS1wpCisAIyF5Z
	mky/eNP9Sy0DmUUml4EuC9yBrvQ/Ge8S2geSbhLwtQ2KiBmYV2j933yKLT2o6jOeVvKg8dS/UpD
	hlj0Tdk+wxE42DZkC5iQhM/Zk+gxxBvOcPA2fbazTkzifTbgleAEInDKxO7WHxfRVdpwm5krBnw
	QRphcGeKN19tuNYTCog5f2EKETpAtnAdNAAgdTf22XfCdlCJiW5LasH+3nMKar7lVfAu4NRN0Rd
	RTK+g4ydYKRacoByK7RM1SMX+dHnjQdg==
X-Received: by 2002:a05:6000:18a8:b0:439:b440:b8a2 with SMTP id ffacd0b85a97d-43b88a0d156mr2181278f8f.28.1774406141184;
        Tue, 24 Mar 2026 19:35:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b6470f902sm45426571f8f.28.2026.03.24.19.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 19:35:40 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nphamcs@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	kasong@tencent.com,
	kernel-team@meta.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	willy@infradead.org,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Date: Wed, 25 Mar 2026 05:35:30 +0300
Message-ID: <20260325023530.222944-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAKEwX=MgoPmiFdBQXK_4=XuR-8mVpGr+3Ku2MfjPmHCeuUdGJg@mail.gmail.com>
References: <CAKEwX=MgoPmiFdBQXK_4=XuR-8mVpGr+3Ku2MfjPmHCeuUdGJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nhat Pham <nphamcs@gmail.com>:
> I'm aware of that work. It's an improvement, but my understanding is:

Thank you for answer!

Also, is it possible to have checksummed swap?

I want to have checksummed swap to be protected from disk bit-rot
(I already have ECC memory, so RAM is protected).

And hibernation image should be protected, too.

I tried to put swap on top of dm-integrity, but this is
incompatible with hibernation in mainline kernel.

-- 
Askar Safin
