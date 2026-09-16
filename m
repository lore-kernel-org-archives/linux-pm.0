Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E094E234A
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556786; cv=none; b=gaIBiZDuNQXhfkX0orLQzHGdFFussGlVbqBGttBqTO3p2xHGt7QJdyqWJIg9/tjqoqg8dUZfFFkJZJeQGXBEWGlINTDqUmquLOaCxTohtOHV8eAOwvVrmmUd1S6xvcfy66lm3nDxAt7f4FCDNLX92QRX7THxWYGdmAbewZpjOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556786; c=relaxed/simple;
	bh=KvGxbBIIZYJxbA/goM5wib5m0sHgZa7QQZXkuKeLEYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LweXhZQXF2vu/CSISq3sYc2SOkZIx3dWbK8WWLu8ySyGjWMug1EKPxiez1tm7tnZIRu3xMweIiq/6OIi+nRgOsdm9VCYfP4uEJHTXSy2AwLazRweVnEXVaHENi9pvrq8bXUpaaHlF6M7OMX+qH1TtfIG3jz2y7WRQyY+MyBgIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZJWZyHA; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZJWZyHA"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7c6dbc60so300185e9.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789556767; x=1790161567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2mTRCT19PSs98SBRuFAUCXLrvDpRI5nVmcGar4PNf4=;
        b=eZJWZyHAqYXeVTNchjC9I9QwFJoLYPtSyZtlG6pGc3rWiipTdZHhkzH2ccNwbFFbJY
         AfOThFsFxM9iqFAUNFjo+a6/Nkx4tvgr4m6GIC8nLIXkz7wYs+H/yCRzxXk4IKw0F5HP
         RHKFY9R+VKZbqqncFb7w0E4P92Us+U6JTK3uydVF8IWCdboZDKoh2/uYjgehalpAffZ5
         vvJXlRkR4BtSB1OHdHzhn7BVOFkqUeMUZ553vbYI7XGEEkv5U7kH5mTwllavBWrVlr8g
         q7IgUmRFCDe5CbAGO57T/gxfS8t+IoFAG65ETzLvZp7tCU+YABc6QiI7OqXmPlQRJoFJ
         2EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789556767; x=1790161567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z2mTRCT19PSs98SBRuFAUCXLrvDpRI5nVmcGar4PNf4=;
        b=DWBwNOpSQZtLsKTXhq0k7KXW0B+KBDfPhD2UKiUS4jGLOE4z9wWhMYqK4oLBpeGfWh
         bOwQa+6FLWhp20dDsWJrmQHWJk5tfmThM2X3X7+t7ZD1IV6lVvX7aMKI1SJ3DWn6Sr1B
         v9C5AdFnNQZWekMfJpWmRnNGnI5WaeNFqmKAk6dKHt9z7+Ft2nqvbVvnW+ajLV5o/10G
         VeGQBu//khOxQ3/jTEub8Rhbxn+hoTHa1wRrkQk8T/zm+A3AEqacwR+90S+n7U7P6/xH
         /tABD+KaVg7e9RcShFUr6V4MlJH0qpUQTo4YrMjiODwzNBjIFnaSRAmXbdWbqttvmcdt
         Ez/Q==
X-Forwarded-Encrypted: i=1; AKwUvBx2LzeyjifyFLAehi8uWE6+8drRTeK/OOdKEke9xd8n19WxGEqiZ98KazfhLY6/x002kX4oXEN/4g==@vger.kernel.org
X-Gm-Message-State: AFuF++mWvLMb4sqkZR5oUJumG85aJtHlj4MAPJbC15C60lTvQJ10mggb
	qBeEBxrZ1youmdr5OGHP+mJq5dGbiy3B0xZD4faDV19Bw7X1YfI84Ddg
X-Gm-Gg: AYBFou1QLISVwiBTRaajMps3r1ERK//8hc3dxylSFJP6rhxzI9wKr++v/D5yrKgTg7b
	7Aaf+noHyH9WnBm2rojB/1PMhTXawUvcl3cI0PKiZgwGp2DL3e28Q6h2o0i6ScuGssGI2gmnd3a
	MZzmvgl5PwidRPstYQBkrhcM/kEj6y3s3gb9ibqIM4ZwwfnW2v/MIn/EQj6uBCOdWgG9N5sz1p2
	iKiW3kq2zq/B2s+ChFb3Ha6MTVOlKllqfbs7pzUuJmepjEMuZrARGSO2wU1VDF7UFsXdrrlZV/d
	WeO4SUhFL3JMV1s58bjbRZm9lIYS8jSEPte1QPjW5tHSAkBbMCTzGQGZc9BRv0PzmlKiudH+vZZ
	yr1YR5aCVie3gLtQ1mXvnOp6l2p5pnbl7/cC7i46QHsXbto2WY6u6+Anm3RmmhuK2rWruYQfOhR
	9NRMaGz+CL6Eq1Qf/eqaWdGA8iRp9OQhdouO/AuHwMn1ZEHm/N910GU4ic+6utZelR2r80WMm6H
	jyiBeH68+NYWLbyOj4L4O8=
X-Received: by 2002:a05:600c:6995:b0:49c:ff81:e062 with SMTP id 5b1f17b1804b1-49eb7328137mr21808175e9.2.1789556767374;
        Wed, 16 Sep 2026 04:06:07 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d9057dsm79447295e9.3.2026.09.16.04.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 04:06:06 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: christian.loehle@arm.com
Cc: beata.michalska@arm.com,
	cl@gentwo.org,
	daniel.lezcano@kernel.org,
	dietmar.eggemann@arm.com,
	elif.topuz@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sh@gentwo.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path candidates
Date: Wed, 16 Sep 2026 14:06:03 +0300
Message-ID: <20260916110603.24230-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916100116.701206-3-christian.loehle@arm.com>
References: <20260916100116.701206-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Christian :>

> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
> slow-path selectors can choose the same CPU before either task is enqueued.

> Use reservoir sampling in the tie branch, resetting the candidate count
> when a lower advertised exit latency is found. Use the per-CPU scheduler
> PRNG and reciprocal_scale() to avoid variable division or a second scan.

> This reduces deterministic convergence without reserving the chosen CPU.

OK. 

But, your test platform was 160 Cores too. I don't think randomization has the same effect on lower
CPU systems.

Let's create a scenario:

On a 80 Core System, that %50 of it's CPU's are idle the randomization's chance of choosing the same CPU
is low. Since there are 40 CPU's to choose from.

But on a 8 Core System in the same idle conditions, randomization's chance of choosing the same CPU
is really higher. Since there are only 4 CPU's to choose from.

I think this solution works better on higher CPU counted systems. 

And I don't think it fully removes the issue. Just better than the original tho.
Thinks can still go bad on this one too, just harder.

Maybe we could add a fallback. Because the real concern is the selected CPU's state
changes when we come to enqueue. If possible tho, I did not really test anything.

Thanks,
Kayra :>>>
