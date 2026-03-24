Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84070372EF3
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358384; cv=none; b=WvfTS/zqnQz+Y/LqVIhpzMOBsFVoljxNcs2S2DesfG6uucZXD1jhLY9hFo24FQwoyHuN2Kx2TviBZSf5LQdEII0XNyBS2xB+4vUYeq8igd+oDkmV8uHHokra+QOx/wByNxblwXy5aU8IpOlQKyruQS9ISMt3khQkxj4gu6vlQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358384; c=relaxed/simple;
	bh=V9oMmKBuAy0HzNU9dHvJsrEVQ950oTkPENYiU9M38dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyA8ymlmdWHqEBEalFfKo7PsOQFIX/hT+a6rw+B+kE/6C9lc2AjDVtMuSsf2/rmfUISqNTXK3YjPZ3K6UOJpj1ekKdnw1T97julatQ4nYF2jlFg7bH5OuyA8S+8i5UVUeuMAHYJ9S5+QuwHI9pMN8EWDwsQG9tbjceDIePcGyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZLBQI/n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZLBQI/n"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso45323755e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774358382; x=1774963182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDW9QxylvtudolC4OrULLL0I8iMCwV1m1od/FFAOgBU=;
        b=AZLBQI/n+B8UQ4z/PBbbRta7WCkJBhIqf3t/ICJs39g27m1N9Qrdtn6b1Ql6lHrDN9
         plFbuZcDzjwS3556cyOQBHeMrKSy9RpbOH3fvO0hsgy+iMAhnlJFHQgeGfiUwKz9MgeU
         rWoNt3C3hwxsyqGLHBb14NxaVWtCHUcqeNDe144p+yucaoAtspkoTpYAajWyt7FMIPxt
         2UklR6rODfMt/q/bNs84cmy6iSxqHQkoyEQrIvUuAHRUXwGzCHnxjsDsuN1FA1cJWPQ8
         Zvc7NjeF2RATIqk5C8e8snnd1qvtL/zhJZl9Ntlgr+0NmKmg0i9poPa7lttRZFB4vgNZ
         NQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358382; x=1774963182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDW9QxylvtudolC4OrULLL0I8iMCwV1m1od/FFAOgBU=;
        b=bMZmAr5vSsQDEIC7n/yLD8S1gLfrMoj7GhfeDsK8LO0svnVGWnIXtvHdA6NmKIiXlD
         r7xNFi7L8ZdTT+LPVn/kZOTbwV8Gr+gBrY0gqwtGvq+hv+0sVbE8lRvRWi7mIg/Ov4So
         l6c7hFE50L262MXi4jqPOmW0uPVlnMbQenkHVOAgoGT/ruAiMML+XcxNDkd5Z7XI9Ccg
         9DVx83Lr0kWCpZwyQzragKkYOWfr0P3GRp6adkwwiPwo+f5YFP/eX4I+aXW9wPeB3feY
         vrFyPFKUyW/NRXybcMK7Dh0iK47JGjR6xTUf6ERqCL/QZZJL+lJkitgvdVmyGtEpyY4V
         L+zg==
X-Forwarded-Encrypted: i=1; AJvYcCVxc0Dvd29OzGVNxHnn3YTa0dwqXBPTbbbM5HxXSYyYCiqwH7xJT032deEAXwz2tEU4/L4vfHQ+og==@vger.kernel.org
X-Gm-Message-State: AOJu0YymJun8HvPNidOiTv5DMBZl1Xnvv0DhyCvHfDyyc/Er551nl96U
	MpJeeFEh2eV0S1K10b19Mm8Mqp7I+GsA6loW/rhuZ+24v42Xa2VxvLrj
X-Gm-Gg: ATEYQzxchEyd4e2X/xIw1Zlj54gKkSVez8QHJ+tOMbcPHPjL6qmpIxcHD+78wF6WePb
	FBiDodaWRcoNPpkXV6tLyuWEWhI/xcYy0flRrRBHzBBsNmSnl4cn1RgGCWvvX4yEB8Sr8nQEd5i
	jhpPajUH+c917RV909Og4b+AGkQ3kI9jQBGIEJaz9DfXYaO827soTRF+TCcdkirI1Gj8IFCmCL6
	Qxn9sGcLxKJvMvqCxkQCa8+UO1wxIJFSr5Hw6JQwPdzikWZLidTN8w7q5y8uIwBlcPukRcZPpfz
	oq+JnNlu4J+zxIEZ0sPhduD5OIDrTqImvZw385qcCdLfAQ7sKyfjODL7vBE+S5c3eWGYtaE9oFX
	qcwRC3GDFBzUOLNodql3ypeit4iLAdofiy3s9RzeRsXdqtcizRkn84Xe2ntim/6rt7rStZgOE0J
	B2jIiar1HFUXuZgjX59QU=
X-Received: by 2002:a05:600c:1c16:b0:485:39d4:2dd9 with SMTP id 5b1f17b1804b1-486ff04fb4cmr260524475e9.33.1774358381485;
        Tue, 24 Mar 2026 06:19:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-487116939b8sm77926095e9.3.2026.03.24.06.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 06:19:40 -0700 (PDT)
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
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Date: Tue, 24 Mar 2026 16:19:31 +0300
Message-ID: <20260324131931.4004123-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nhat Pham <nphamcs@gmail.com>:
> We can even perform compressed writeback
> (i.e writing these pages without decompressing them) (see [12]).

> [12]: https://lore.kernel.org/linux-mm/ZeZSDLWwDed0CgT3@casper.infradead.org/

This is supported in zram. The support was added here:
https://lore.kernel.org/all/20251201094754.4149975-1-senozhatsky@chromium.org/ .
It is already in mainline.

-- 
Askar Safin
