Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6A542EF2;
	Tue, 22 Sep 2026 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081030; cv=none; b=ek3mavLZgCs7speEoc4u8Bofz0VGKOD0+NDV4O+rE8Nj7+J9ZYnZ8p8a5EDdmTgfq8iTGZ71pEaOWCm5g4Qvgyi4ijUvI9g/sd7ft63XCz5qT68y7/0rrZF94E0hoiqys2n4qhv+gsPPd6DUKIBTMzWIEb5pQww+K/igL91ok8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081030; c=relaxed/simple;
	bh=gzCsz+SnDPGloWskezHtX2a5TcZGKEaHW8efwsxAwRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=unV8ZFgs1Lx5ISftosK9pYzJflWOxjLQ/vUn2o1INodyG33BnLDXTPhWlOOONRlrOTqzW7iD7FoO8UxdvoAcYzlvpENbmRVs0be3lrk6XyjxrUwbyFGKWuCfPdVchNm1g5petxejWvbtuxRNtiYFAKaTDMprDiKzdVnq0Duwr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xBWhAHOp; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xBWhAHOp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=89lkpAhKk+Q47Br0JON/IAfdr9J7zh/QLtYMmazm4as=;
	b=xBWhAHOpgsxYsw3NN6KmZbS/2kV69Dxa56R2RU8AH+nMpBOoxlz7m6hry9Y2CeV0ccFJ4Wi3a
	03weYe7sTgDF6mQNiT6a1S7NkbgP9m1k6MdILc4LOeq9jA1vVv53DP2uDZdIk0a4wfoEfsexx+4
	cYlQDkW8Bl4FNx1dmI8TRH8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hpzxG1YQKzpStW;
	Tue, 22 Sep 2026 20:31:46 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 9803C4056D;
	Tue, 22 Sep 2026 20:43:42 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 20:43:41 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 0/8] ACPI: CPPC: Resource Priority Register support and sysfs interface
Date: Tue, 22 Sep 2026 20:41:13 +0800
Message-ID: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100001.china.huawei.com (7.202.181.215)

This series implements support for the CPPC v4 Resource Priority Register
mechanism defined in ACPI 6.6, Section 8.4.6.1.2.7, and exposes it to
userspace via sysfs.

Resource Priority allows OSPM to control the relative priority among
processors for shared resources. OSPM can utilize these sysfs interfaces
to configure resource priorities, allowing resources to be preferentially
allocated to more important tasks.

The controlled resource types include processor boost, throttle, L2 cache,
L3 cache, and memory bandwidth.  Each Resource Priority group consists of:

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
v4:
 - Patch 7: Set *num_resources to 0 when controlled resources number
   invalid in cppc_get_resource_priority_resources(), therefore, the caller
   will not read the unassigned `resources` pointer.
 - Patch 8: Remove kfree() from the error path of
   cppc_create_res_prio_sysfs() because cppc_res_prio_release() will do it.

v3:
 - Patch 2: Add the (i - 2) == RESOURCE_PRIORITY condition back to ensure
   the new code behaves the same as the original.
 - Patch 4: Assign -ENODATA to ret when an unexpected ACPI_TYPE_PACKAGE
   appears.
 - Patch 5: Initialize the `optional` field of the remaining cpc_regs to
   true so that they are treated as unsupported.
 - Patch 8: Call cppc_cpufreq_cpu_fie_exit() and set perf to lowest_perf
   when cppc_create_res_prio_sysfs() fails. Call kobject_put() and kfree()
   when kobject_init_and_add() fails in cppc_create_res_prio_sysfs().
 - Link: https://lore.kernel.org/all/20260812015217.74598-1-zhenglifeng1@huawei.com/

v2:
 - Patch 1: Revert changes to the CPC_SUPPORTED() macro.
 - Link: https://lore.kernel.org/all/20260804085042.4118193-1-zhenglifeng1@huawei.com/

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

 drivers/acpi/cppc_acpi.c       | 719 +++++++++++++++++++++++++++------
 drivers/cpufreq/cppc_cpufreq.c | 281 ++++++++++++-
 include/acpi/cppc_acpi.h       |  60 +++
 3 files changed, 930 insertions(+), 130 deletions(-)

-- 
2.33.0

