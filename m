Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E94E73AF
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608786; cv=none; b=tgVsIrnm+WI0fvkqmf64xgl9x6AZBNNV3hoqOIK1Iui4+z8OSh4WCaNtxOubG8F8huSQAURH5t8c80fsKVa2f+5L9wFmk9Qz5MHlXwq9xZ+PQuTbkMjpcDHSH2CwxAPFPAozYt4qqRQR48YW2xrZg2hwIvc2RdzgRcHZ+4ybzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608786; c=relaxed/simple;
	bh=qFYBnXNYmhhsHxNx2COBADOmOdhhnVq5vY9GOOKIOJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFk2FkenPicSfvivC0XAivf7YFaUJAjgUgLJgADKXn+6IqNv/QllTTSN1BSk8vX4OPVvoJVsJKca9qrD6AKFR2qp96ST8td+TWNM8l111+7coLCbV7dLkp7kxWW+Z4gVGJLD5L9eJ1eJeTY5x8BxEjVbD1T1xDzTy7Vur1jptr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mcv3pLez; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcv3pLez"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso1127125a12.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790608784; x=1791213584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2+B+TCtU6LhjPX3KEHp5ZhDWyuT2oD8RctAdhdkStc=;
        b=Mcv3pLezAFyOR8F75xJ+N1J+sl5iObide+S4U96tO+DgnijX5Dmv30l2bJPwN1+1O/
         aDuzJbHgkNaz0lfw14o/KwYbNznQUu7xfoxAvpVI93mnAYbKzBCw1eNQDku74CY+HfZZ
         PW4KSnS4CPVrTmns0V/auUXCoQVjg+oAMiGULt1W0MA2xWn7cLmEQSDCHD855uvtV9X3
         gmimRXAP+b8P5tg4Y1swbLZRAvkFTJbDFLJEEFCREXen1/VjjyUloPUHnLfUPQXAU4AV
         74V9RqUw2P+Fwuuwm6XSQxgYih2pRhfqAVjfgoKGuEwYAv6/0uviPGmqijunI+77tcYn
         bP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608784; x=1791213584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2+B+TCtU6LhjPX3KEHp5ZhDWyuT2oD8RctAdhdkStc=;
        b=x8tMe41YSoagjhELVZu+a4be8Ucuo7nvRkTucNLTIvWhajClw5RwyQ6Z2OiOv9eDUj
         e8fuCNG0Fm/xmwmf3e3EJEpXkdgx89y89L3/ZNjgoB9ZIXDMraPr1V892vXgqKAohzmQ
         yJldvetndWcz8LfLzAAbK0kyCvDBJgrBDWJzxyVNVuCLFrdYjIPb7MyADxsBUR3avTiQ
         fF5jTgL9aZfSJNqNjvIRJmI7yt4QRVQOaCXmKP9rr4gZhFJUTH3qiAiFVML4g300N/We
         HBJxnq3+HJ0J856fl5PsbnX/WhfWEsZ16wv7UOha1yBbRD5KJCdKOYeiIvkc2t8g3ln2
         3VMw==
X-Forwarded-Encrypted: i=1; AKwUvBw3uToDU5vWzIoJqiMFLSpZ7q2poy9qaUQLMLKkAosGvbJ1A/P/SfAS7h3TJKpZWf8KY/fxjl5gpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLf1CjbEyRToG/gWgfSBmQdKZGcekpMhBAC9Ys8ee72IiVZSENi
	bRHmR397jIIdN7uhYqShrhwvNQxzMhA2RbgjFnaeRKvjpSn0G6Pi1lqC
X-Gm-Gg: AYBFou1cyP80PUMK6rhR+4TFV4s12ZcvWnttgsaIP9Axa0d5rUbym5YtZ4ttKEm7H9o
	3X6plsMPW8B8bwZJ5HhBL4siV+dw7OuhDpogZ0k8M6fg+NGwaEINi8nhRJMIP0PYE2KOQ9Y71od
	G1IpNUSk0aaM2e5APv9uu9VxhIWqJ1xo03ZBawPiBtbwFOtmeUx5EozZytCJ8ieQR8ldkZDW2wh
	rPgsHqMRsin9j3KtBCGVOyvwtuOzXneQy51a79CnyH0bbXZRsFVOBIBanWWrevMnt/ad8hX+WdK
	5P3kYnSE1oE0lRK96n95SX8K1YgvQwzTVLI8QLJeGNCWgva6/tsZ7GGi7pZRKDWOO3Vv16yb3lW
	n2/0ideKCL+IXFSDg/SiNLqqCiSkC6htEAJKebws9nLL59r36RmfJ+iUkfWB2yZm9HnS3hY6inM
	NiJXlHGf5WHHnvuDIBX/PhuvdMh0JQDIU3VkQKQuN/eWjzpYa1BzSght3H4NjTKFxVtAr0LNKYD
	Z4tblY+Ms/I4jG+SVE9De5EqTbHQs9xca9evMpkOReb1LkXGjvx0Itv20f7rcf+s1vDIcgXv1fa
	iXXURaIjcB1HdjKmdfArsmlOP7Wi0Y5Y63XkHpZrXfoSalsK8URrV5P5p2o=
X-Received: by 2002:a17:90b:3908:b0:3a0:c20b:2fdf with SMTP id 98e67ed59e1d1-3a0c20b3132mr6450444a91.17.1790608784281;
        Mon, 28 Sep 2026 08:19:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9feddd0sm7247965a91.2.2026.09.28.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:19:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-api@vger.kernel.org,
	Alejandro Colomar <alx@kernel.org>,
	linux-man@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	util-linux@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate offload
Date: Mon, 28 Sep 2026 23:19:34 +0800
Message-ID: <20260928151934.2686418-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arn4xOIxFRD8qY_x@infradead.org>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com> <arn4xOIxFRD8qY_x@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

> Either way block devices must be safe to be called from paging paths,
> not just for swap but also for file system based paging.  So this is
> a bug in the implementation, and not something worked around in the
> swap code.

Agreed that a backend used for paging has to make progress under
pressure, and the zvol example was a poor lead.  The series isn't
meant to excuse a backend that can deadlock; that would still be a bug
to fix in the backend.

What I'm after is different: backends that are correct but need
memory to accept a write, where the better policy is to use them for
cold-page offload when memory isn't tight and keep pressure reclaim on
areas that don't need to allocate.  Two in-tree examples: zram
allocates on writes and fails with -ENOMEM, with no fallback, while its
logical size still shows free slots; and filesystem swapfiles must
give up copy-on-write, checksums and compression today, because swap
writes bypass the filesystem.  I'll make that the case for v3 instead.

Thanks,
Matthias
