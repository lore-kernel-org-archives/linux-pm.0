Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271782F90E0;
	Fri, 17 Jul 2026 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256421; cv=none; b=NbE9xCHnXnr3j7+Cp3Mv9p9wmzveVHWPZAOJ3SCOm2ffhLDtdYDnbZtmTuUll7r4xewtBv0pnAwI+oAbfhiBcXiXvdKxGd7YaGxjUR/dVmSO19p4pNj1CgmLrJdaj7Xqy6gFhVfPUruzKfxvvJTkuQDnMLUGxM6tWi1jwV+KPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256421; c=relaxed/simple;
	bh=+gwv/YdXtyyuBCvt8mKVABm4jTBGmrYVmrdRCjc2Y4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=flFhzSlNGeot91VpqOdr9KwaEOdFILHDG+CAMBWvp6gvq3AhpQqBmrfA4mbAxZweEw56yMd/Et8tsdEI9GHoINXDe9bIYoguis/tbxGA4mCrkEdO6nuopDUPIx/3NGYAbBgIbFFV8ckFE2CQ4shkLZbpGw1bW1QWFxFFRYMWlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qSdUmurI; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qSdUmurI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=taOEHieoAmnmZe92hrNPclFpwDHjy1cJ8iio6ST/EAs=;
	b=qSdUmurIrQFeZ9KUi89ruciNvfqVFE0KSVLNNkAmn/cBoxGeCFJu4RhfkW3kmDkVDu/NbVs7S
	ai1lxHO9qUBC5QUmZzLidYP/Plh+F33arvrD/hkfD9gCMmL1yukfnmw6XqLXA5/epbsJ8l4d7wP
	1uui03JkHSHHos8NdNOw19A=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h1YwY58CHzcZy9;
	Fri, 17 Jul 2026 10:37:33 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id D38ED4058C;
	Fri, 17 Jul 2026 10:46:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 10:46:52 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 0/8] ACPI: CPPC: Resource Priority Register support and sysfs interface
Date: Fri, 17 Jul 2026 10:44:54 +0800
Message-ID: <20260717024502.3520445-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100001.china.huawei.com (7.202.181.215)

This series implements support for the CPPC v4 Resource Priority Register
mechanism defined in ACPI 6.6, Section 8.4.6.1.2.7, and exposes it to
userspace via sysfs.

Resource Priority allows OSPM to control the relative priority among
processors for shared resources.  The controlled resource types include
processor boost, throttle, L2 cache, L3 cache, and memory bandwidth.
Each Resource Priority group consists of:

  - CONTROLLED_RESOURCES: which resource types the group affects
  - ENABLE_VALUE / ENABLE_REGISTER: enable/disable the group
  - PRIORITY_COUNT / PRIORITY_REGISTER: read/write the priority level

The patch series is organized in three parts:

  - patches 1-4 extend the CPPC data structures and _CPC parser to handle
    Package-type entries and parse Resource Priority sub-packages into
    structured descriptors.

  - patches 5-7 refactor existing register I/O helpers to support direct
    register access and add accessor functions for Resource Priority
    attributes (enable, priority count, priority value).

  - patch 8 creates a "resource_priority" sysfs hierarchy under each
    cpufreq policy to expose the Resource Priority attributes to userspace.

---

RFC: sysfs placement

The sysfs interface is currently placed under /sys/devices/system/cpu/cpufreq/
(i.e. the cpufreq policy directory). I am unsure whether this is the best
location and would appreciate reviewer feedback.

The concern is that Resource Priority covers resource types beyond CPU
frequency control:

  - PROCESSOR_BOOST, PROCESSOR_THROTTLE -- clearly CPU-frequency related
  - L2_CACHE, L3_CACHE -- cache partitioning, not frequency
  - MEMORY_BANDWIDTH -- memory QoS, not frequency

Placing the attributes under cpufreq makes sense for boost/throttle but
feels semantically wrong for cache and memory bandwidth resources.

I would appreciate feedback on whether cpufreq is the right home for
this interface, or whether a different location would be more appropriate.

Lifeng Zheng (8):
  ACPI: CPPC: Prepare cpc_register_resource for Package-type entries
  ACPI: CPPC: Refactor element parsing into parse_cpc_element()
  ACPI: CPPC: Refactor resource cleanup into free_reg_resource()
  ACPI: CPPC: Parse Resource Priority Register entries from _CPC package
  ACPI: CPPC: Store optional flag in cpc_register_resource
  ACPI: CPPC: Factor out cpc_read_reg() and cpc_write_reg()
  ACPI: CPPC: Add Resource Priority accessors
  cpufreq: cppc: Expose Resource Priority attributes via sysfs

 drivers/acpi/cppc_acpi.c       | 729 +++++++++++++++++++++++++++------
 drivers/cpufreq/cppc_cpufreq.c | 270 ++++++++++++
 include/acpi/cppc_acpi.h       |  60 +++
 3 files changed, 927 insertions(+), 132 deletions(-)

-- 
2.33.0

