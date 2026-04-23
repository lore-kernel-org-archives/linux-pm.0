Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1273115B8;
	Thu, 23 Apr 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934101; cv=none; b=vEbm4LughEKSdvK3xJ7exXuUo6fli4I4a8WyUTU0X2AmvlQY4lmZRczP2ArPoYLoi4mckd0/6iUPi0D1XopdaZtJD/j6Ot3Yr32KVM+Pj+vdoqna9MASXK9qHktSzmN29igw1Xq6ROyzmYdeFKwWe+0MOUNgc+tpVXowZIVo8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934101; c=relaxed/simple;
	bh=e1SdLAdsVr1xLDHNing9RvVHLhwf8Eerqal2H8gvBqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToyILoVErxkdalPzUtIu+FcYm5Ixj592skpHqUFdRIXawtOXVl9zjLfbLItSa4Iioz3SKPsykeQ1dnGPgq3pKFtc9tKizrv7K7olO92ZO7gapcS5e6m9kyGc014FqEfsoQjFGYNC+Ctffvm8pVlb6LdHAZJv1BX15pPJ/A66L5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YEHM5cEf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YEHM5cEf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8763F1BCB;
	Thu, 23 Apr 2026 01:48:12 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.63.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBBCC3F7B4;
	Thu, 23 Apr 2026 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776934098; bh=e1SdLAdsVr1xLDHNing9RvVHLhwf8Eerqal2H8gvBqM=;
	h=From:To:Cc:Subject:Date:From;
	b=YEHM5cEfZXF04ABP1kG2dcLNDUkmQNDjOGKMhGsdwPSQNDG0zUB8KBinw5FL16zIr
	 swNAD26VHuzbNDVDQ79UT+UNje7Ztv7APcr83BrH/CYaFJa+/m4ujdjnsCsggpYPmy
	 2QrM6NGktqqBzpNOeQQk6rUKR5isPUBCdBvE+EJg=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/1] cpufreq: Set policy->min and max as real QoS constraints
Date: Thu, 23 Apr 2026 10:47:27 +0200
Message-ID: <20260423084731.1090384-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is a follow-up from the serie:
- [PATCH v6 0/4] cpufreq: Introduce boost frequency QoS
https://lore.kernel.org/lkml/20260317101753.2284763-1-pierre.gondois@arm.com/

The patch was dropped from the serie to only focus on the boost/Qos
subject.

Pierre Gondois (1):
  cpufreq: Set policy->min and max as real QoS constraints

 drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
 drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
 drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
 drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
 drivers/cpufreq/freq_table.c      |  7 +++----
 drivers/cpufreq/gx-suspmod.c      |  9 +++++----
 drivers/cpufreq/intel_pstate.c    |  3 ---
 drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
 drivers/cpufreq/sh-cpufreq.c      |  4 ++--
 drivers/cpufreq/virtual-cpufreq.c |  5 +----
 11 files changed, 51 insertions(+), 39 deletions(-)

--
2.43.0
