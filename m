Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEB471436;
	Tue, 18 Aug 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056792; cv=none; b=RolEDRiIlkN5gAfl57p67rTKECo898Nm07+Z6LODWcfWdwhUY6Eb6bdFGl8aF59B7rRp18yBlb4t1vN+pbkDhyGXVLgq2+oH9SI6qRvrKy0hU4cBr2XYcD2hRfOoRAXmIDXYADt2w3PbhFyi2wNx21/DKAMp2uYHMN/aSWJHRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056792; c=relaxed/simple;
	bh=S8Nzg2YjMxj5r0btJyi2FSislzOyAiA/4eyLk/lfbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJIYqPlNe93tKMO4e5FS/AJOGkGbSzH4su8LODx6I99OGu3wQBKL5WwMkVyc4eclXGsC1Ka7SZTboiwqMkEeq020cTj6ohE650gvNvzn/1wPiqy0/gsJ5M7dCIZ0pllh3kKgbRoiWAhmhxfx5gu9YzkHdpU4fiBQXCY5+K3faqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A521F000E9;
	Tue, 18 Aug 2026 12:39:39 +0000 (UTC)
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
Subject: [PATCH 0/5] cpufreq: loongson3: Fix wrong behaviors on multi-node servers
Date: Tue, 18 Aug 2026 20:39:16 +0800
Message-ID: <20260818123921.3600606-1-chenhuacai@loongson.cn>
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
 drivers/cpufreq/loongson3_cpufreq.c | 67 ++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 24 deletions(-)
---
2.27.0

