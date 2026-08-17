Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4D3D170C
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960875; cv=none; b=gZfHflesSEz9W4cq/hbbxfqqIh4H2qqRINx8UYOlDjCLw8I3ACgx6cJukRgTRdd1f4yKQkgAseEArmbh+MkYteBzQTr+sSO7Wnb4oCxi0rm/2BlUyXPGPjuiWpYQXSOWOwxT3vz341yE7Hv2gtY5mTdrYiMos3lhqiSNTLf96Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960875; c=relaxed/simple;
	bh=QFwGflSg/xbQtdgC7RkCRrTPWLiVkClzm6dle6b12Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ0j8cuDma//Zdi6KKYK6vZtQuqlFQzsTzxRW7APT4tNKCCz+viy4YAOa0gqXVmi6MGDNj7w4NeOZlXtQxv/XT4qp7ACXlUw7uUBZlknsloYpk5gj6iWRnqgSGLoLIbEiNSNOr2gvNpUW/nw9r0HaG8kDcaOxUPSnIwzLaHb2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ca4f02483cso4409245ad.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 03:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786960862; x=1787565662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SFJhRYMaeccSWN7O5plNjrZM7NMQ7y9/USAmz9QApWk=;
        b=nzTSvkr1kwuHA1OjYDrtMS73ixgY1hgIc5FmKY4qxuw/b42jEt3IILbNMSsA+tEXmh
         t0PDGL+tKJJXEk7JCjdrzXMiWk52h71SwJiIqX47pQwWQQSTtunmxy2nWPbUprV9tzOb
         aPAk8AM3v+VCZOofJEvs+q8hHCzGvSUn23ytSrmmiA7uUiEEmbIKWVhQC9dpMKVzttQ7
         lQvHHXX1oNPsxX4rdYw/N9wEwlyF0d1Be1xaDDx+CQ8eU96VpCV/wXSXYdsSKrbgAhXW
         mBmHg4+H66l7Rc2ApmzXTWbRAu20CGRGavty9iAXmY0dEDw3ioNYVJQx1et/7bdOZ1Y6
         Ge5w==
X-Forwarded-Encrypted: i=1; AHgh+RpDaBI2ejOaKDW9QWzfsxOi6fRlZLGRWWGk+Al1v5z6gOYHwHZdFXdFEZpiEJfqASZPjQFTl+v2YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziW6/h9VSKlJZ1+VjxrtsYClT2IlpR18L3X3rgz8ZarQU88UhC
	zC3VceuMpVbo2Z3cM0kwphmaHXfONZBTJVnTdjKeOgN6KDBvSs+zJrT2
X-Gm-Gg: AR+sD11HbbevCnYO3J3449EJMYKzL75jipAJYS/o9wzsCRhBJkgPe0OLd8GimUHYnUl
	E1e45zKfLy7S65Vkwmuf5NLKgPUYA0hynNjTNP8HqE4EKXxSmHCGlovZ+XObVlGZifmBwBMXqAC
	PtawRzmKFgt/ST8ZkW67SY7rRCzeBPzpw9Ax34PhabmPxjyqaFs70+HqHRsPSSs8fN7fLjiogBX
	m2SVmVmxEPz4OQuhLlt29SLQVyF8LidMWQbEfxPPelSy5ULoVfV+zNEMOh157Hq/P+8nscoI+yh
	vxKc2EXv1bvgkL22vF2LOFqtJNE4csu+MYtP7UqK3YUeevzYiJBjMIJn4f090JCNrK71YW8rjKY
	N1WFvctTJVdWaTYTmb7WOmFqu+7QmOtdQtUFKPNlQ8O7HTQOgNZ5V2CAhcLCHTdTiCnvmW+q9MK
	AmG1+IwOYa4BqAjsUBrI6MN7eguBWfeHHr8q5R82AseQaKA16cNElmbFnz3uzHu4JRrC+fMc88K
	8uIKbxdMAc=
X-Received: by 2002:a17:902:d2cf:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2d3affcc11bmr193339195ad.11.1786960862073;
        Mon, 17 Aug 2026 03:01:02 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ecb162sm274525ad.69.2026.08.17.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:01:01 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: christian.loehle@arm.com
Cc: Beata.Michalska@arm.com,
	Ionela.Voinescu@arm.com,
	dakr@kernel.org,
	dietmar.eggemann@arm.com,
	driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	luoxueqin@kylinos.cn,
	pierre.gondois@arm.com,
	rafael@kernel.org,
	sudeep.holla@kernel.org,
	sumitg@nvidia.com,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH v5 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
Date: Mon, 17 Aug 2026 18:00:42 +0800
Message-ID: <20260817100042.1291471-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <840da3ba-1d65-4a28-a072-a586ea4dfce5@arm.com>
References: <840da3ba-1d65-4a28-a072-a586ea4dfce5@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

Thanks for the review.

> Does this actually work if highest_perf would now be the equivalent
> for >1024?

Yes, it works correctly. I verified this on an arm64 8-core big.LITTLE
system (kernel 7.2.0-rc7-next-20260810). The runtime highest_perf change
was simulated by writing to a debugfs hook that invokes
cpufreq_update_limits() on the CPU, exercising the exact same code
path as ACPI Notify(0x85):

  LITTLE cores (cpu0-2,4-6): highest_perf=1900, cpu_capacity=670
  big cores    (cpu3,7):      highest_perf=2900, cpu_capacity=1024

The normalization is purely relative:
  capacity_scale = max(raw_capacity[all CPUs])
  cpu_capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT) / capacity_scale

Test results with runtime highest_perf changes via debugfs:

Test                        cpu0   cpu1   cpu2   cpu3   cpu4   cpu5   cpu6   cpu7
---------------------------------------------------------------------------------
baseline                     670    670    670   1024    670    670    670   1024
cpu0 highest_perf=800        282    670    670   1024    670    670    670   1024
cpu0 highest_perf=2048       723    670    670   1024    670    670    670   1024
cpu0 highest_perf=4096      1024    475    475    725    475    475    475    725
cpu3 highest_perf=3000      1024    475    475    750    475    475    475    725
restored to hw values        670    670    670   1024    670    670    670   1024

Key observations:

1. highest_perf=2048 (>1024, but < capacity_scale=2900):
   cpu0 capacity = (2048 << 10) / 2900 = 723. Matches exactly.
   capacity_scale stays 2900 (cpu3/cpu7 still max), so other CPUs
   are unaffected.

2. highest_perf=4096 (> capacity_scale=2900):
   capacity_scale shifts to 4096. cpu0 becomes the new max at 1024.
   All other CPUs are re-normalized downward proportionally:
   LITTLE: (1900 << 10) / 4096 = 475
   big:    (2900 << 10) / 4096 = 725

3. Restore: writing back hw values fully restores original capacities.
   No state leakage.

In summary: the normalization is ratio-based and architecture-agnostic.
Whether highest_perf is 100, 1024, or 4096, the relative capacity
model remains consistent. 

Best regards,
Xueqin
