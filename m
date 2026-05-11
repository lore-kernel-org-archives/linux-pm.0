Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD333BFE33;
	Mon, 11 May 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507760; cv=none; b=qsW6KsAO4Yy4Hw9HI5zrynVH1v8Ow++3Ej5QXLcTRWTLjM96TBkfdTYpREPFrawlLrBNSoefAPmFnpcVe5A/Kocjp7qT8MQGi+azlbjZWnR31xpNlmw3FFskgQL2GHszV9lApFQviU1tPYCGvzO2DEuvir7AFgdsdqrbf8ceI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507760; c=relaxed/simple;
	bh=tLjsS8snRKgNQ1oRnQ5Dl55EGHmV44bCAQASdTaY2dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0IVIDBkcp2TWdr2iKD/1tQgpJtCxI3s448dqmdB+Xcy/zU8LnI+2UoBKDKLP8CqH9xKGuHTtsONRmbEhge2jLx+PMZDcL7hU7NyFxxyNAmM3lX9l7edlxRXMhzdnE+kyc1EJq9ZWtgDbibZQJcXYCmpjv1GevXs9Mo4SW5AjlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BYhtBlAf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BYhtBlAf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 136F616F3;
	Mon, 11 May 2026 06:55:50 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.34.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06C0B3F85F;
	Mon, 11 May 2026 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778507755; bh=tLjsS8snRKgNQ1oRnQ5Dl55EGHmV44bCAQASdTaY2dA=;
	h=From:To:Cc:Subject:Date:From;
	b=BYhtBlAf9rXV1MQXnIgP2r1PIuIVz0Xe/qHW1Ig1xh/UFKux/fcPsHWmSAUSs2iLv
	 mlF1hMxPEvfl4qw63vaxGTuK/WyuKsAlz2d9X0UtP3PIXHVj4emGe9vnDxQuFWl0p3
	 db72m8kUr6T1D0gQbWuM4Ot1ZsR241du/a989etg=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/4] cpufreq: Set policy->min and max as real QoS constraints
Date: Mon, 11 May 2026 15:55:27 +0200
Message-ID: <20260511135538.522653-1-pierre.gondois@arm.com>
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

v2:
- Split the patch in multiple steps
- Replace min/max -> min_freq/max_freq
- Add references to commit 521223d8b3ec ("cpufreq: Fix initialization
  of min and max frequency QoS requests") to explain the intent
  of the patch
- Update documentation (cpu-drivers.rst)
- Set default policy->min/max values before the call to
  blocking_notifier_call_chain()
- Create a new cpufreq_policy_init_qos() function to put all
  the QoS and policy->min/max logic inside.
- Didn't add Sumit's reviewed-by as the patches changed a bit.
v1:
https://lore.kernel.org/lkml/20260423084731.1090384-1-pierre.gondois@arm.com/#t

Pierre Gondois (4):
  cpufreq: Extract cpufreq_policy_init_qos() function
  cpufreq: Set default policy->min/max values for all drivers
  cpufreq: Remove driver default policy->min/max init
  cpufreq: Use policy->min/max init as QoS request

 Documentation/cpu-freq/cpu-drivers.rst | 10 +++-
 drivers/cpufreq/amd-pstate.c           | 14 +++---
 drivers/cpufreq/cppc_cpufreq.c         |  5 +-
 drivers/cpufreq/cpufreq-nforce2.c      |  4 +-
 drivers/cpufreq/cpufreq.c              | 68 ++++++++++++++++++--------
 drivers/cpufreq/freq_table.c           |  7 ++-
 drivers/cpufreq/gx-suspmod.c           |  2 +-
 drivers/cpufreq/intel_pstate.c         |  3 --
 drivers/cpufreq/pcc-cpufreq.c          | 10 ++--
 drivers/cpufreq/pxa3xx-cpufreq.c       |  5 +-
 drivers/cpufreq/sh-cpufreq.c           |  6 +--
 drivers/cpufreq/virtual-cpufreq.c      |  5 +-
 12 files changed, 78 insertions(+), 61 deletions(-)

--
2.43.0
