Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994E18A6DB;
	Fri, 28 Aug 2026 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886745; cv=none; b=h/jPQOi07Yr0WnK04BU2u5IP7sCrZJz4RrkVqy/IHUqrRhwa7c9ZsSQfrZUtKOyK2jsjtgcxIrKYZdISqZLJDH8rvuO0qfJfal+cGoxjQcx4lFy2kcVo2mNb/zP/fib2vbuxt5UZR1W90OrAkVPctfrx3JLyHoacrwmFsfebwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886745; c=relaxed/simple;
	bh=4KOGFjsL+inYC/qd0pSucrj3B/G3auaLZEAf/ZnyyhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TR8TIefeKWQrhiHU4ACgkZs4gViaezq42brcLO9sNz6Y/IdH7hJE/7xD8ukzsbsd+eGOkVbJctkfCgdQZo4I4prUdWfyZVo/uTpyWRhhNxN8uPwNEdaA7qOfnKyQidpsK2XIjeowKWG1Me8Zk5PheoDUrqGFZxN+ZRyJ8yyaARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8393C1F000E9;
	Fri, 28 Aug 2026 03:12:21 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Hongliang Wang <wanghongliang@loongson.cn>
Subject: [PATCH V2 0/5] cpufreq: loongson3: Fix wrong behaviors on multi-node servers
Date: Fri, 28 Aug 2026 11:11:56 +0800
Message-ID: <20260828031201.1500767-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
nodes in one package and SMC mailboxes are also per-node. However, the
current driver has wrong behaviors on multi-node servers, including: id
field in smc_message is too narrow, mutex is not per-node, IOCSR read/
write can only perform on the current node, etc. This series fix all the
above problems.

V1 -> V2:
1. Fix typos and add Fixes tags.
2. Fix loongson3_cpufreq_get() return values.
3. Use nid_to_addrbase() rather than hard code.
4. Guard some code with CONFIG_SMP to avoid build errors.

Hongliang Wang & Huacai Chen (5):
  cpufreq: loongson3: Make this drvier depend on MACH_LOONGSON64
  cpufreq: loongson3: Adjust the width of id and val in smc_message
  cpufreq: loongson3: Replace per-package mutex with per-node
  cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
  cpufreq: loongson3: Replace IOCSR read/write with MMIO ones

Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/Kconfig             |  1 +
 drivers/cpufreq/loongson3_cpufreq.c | 72 ++++++++++++++++++++++++-------------
 2 files changed, 48 insertions(+), 25 deletions(-)
---
2.27.0

