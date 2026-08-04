Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B662448BAD;
	Tue,  4 Aug 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833568; cv=none; b=VK/AQSvX+V0RivO0jyanKNPhXj7lrvQXr2RQINWUGCxwgxitqgSlbUVufArhIGgs+cmMfefGCjyPS/WvDZ3TGGLjOCi2kW0AYqj0lGcUZMqok4C4Pv3NjvkQg7tBqfSIBTjNh3iUzATlQlK2URjh97tR+MeC+7hyMgT2LznvE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833568; c=relaxed/simple;
	bh=T6WrYwOFgo7uir84I860jvWFTY1NsxtKbeCSQrfTUzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/ROMXntWPYnx7ORO0XSv0txLi/9M/KVjG2moAk2RBKugxd0+tuVGX7El+ki7OjrYzJQZBxZoiLwKRa8utU6NGvPCfgws/bFdeworq8LoGSqBmXdymSHbTupKlaY+BeFVoFGgt5hqp2dDlwin5YCyWQIAd8C0KuvDQ98X3hXJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3D373IeE; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3D373IeE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=A/jdcaBBgknzhCHuIBEvx8ULZjSPbz8GcSgbt+mMKt8=;
	b=3D373IeEF2+M5teynoBOwn7LgrA9Po3tdKZxTrUWlA6B+w2KEnC7iyEira05xFg7h15VAok0G
	xK+V9HVAar2N7hGpZSljDB0MRsLT9s0xErlQHq1PXtBqjYQIRd2kK8nYLKVKGkvSb9rs/9eUm+P
	Mg0rtgiSSJ0G0XVq+HDTokI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hDnB76Tmzz1K96s;
	Tue,  4 Aug 2026 16:43:11 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 63A394056C;
	Tue,  4 Aug 2026 16:52:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 4 Aug 2026 16:52:40 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [RFC][PATCH v2 0/8] ACPI: CPPC: Resource Priority Register support and sysfs interface
Date: Tue, 4 Aug 2026 16:50:34 +0800
Message-ID: <20260804085042.4118193-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Changelog:

v2:
 - Patch 1: Revert changes to the CPC_SUPPORTED() macro.

v1:
 - Link: https://lore.kernel.org/all/20260717024502.3520445-1-zhenglifeng1@huawei.com/

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

 drivers/acpi/cppc_acpi.c       | 715 +++++++++++++++++++++++++++------
 drivers/cpufreq/cppc_cpufreq.c | 270 +++++++++++++
 include/acpi/cppc_acpi.h       |  60 +++
 3 files changed, 917 insertions(+), 128 deletions(-)

-- 
2.33.0

