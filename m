Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BAB364E88;
	Tue, 17 Mar 2026 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742713; cv=none; b=jkb1Y0l4Suh+B5mV96ojk/m/ua5clEt9IGJDmeL8GOksD+EL+77uO1pGM9uenChTOsdcCgrlGP7o5TRDaOLLXMbbWrQaQywYqidoxVuadOXlpHgPJuDPELKZLu2zB1ZoEHr6Ua0ber4mloJ5UgwiFgkUORVVQeALdb7hf16l3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742713; c=relaxed/simple;
	bh=u6+i37hDT+5A0RUdAM0Au62et5n1kjSlA7ET/g24UA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Myfq0tHgjMB1pd9c79LN7IR9hrElbUa7RsMssFoZdtMKtiAMr2sf/kKHdYIYiCn/bBDqXL88qFEiaTdM7jFvwDA4Itourd3ph92+TLsAcYw/KOlzDOwt1h1edclGCgbJk8gwh8UEdDkvFHtvpfyCcNS4Wn58LqFqnimZNpS9+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B12B1476;
	Tue, 17 Mar 2026 03:18:25 -0700 (PDT)
Received: from e135073.home (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CACD93F7BD;
	Tue, 17 Mar 2026 03:18:27 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 0/4] cpufreq: Introduce boost frequency QoS
Date: Tue, 17 Mar 2026 11:17:41 +0100
Message-ID: <20260317101753.2284763-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Power Management Quality of Service (PM QoS) allows to
aggregate constraints from multiple entities. It is currently
used to manage the min/max frequency of a given policy.

Frequency constraints can come from:
- Thermal framework: acpi_thermal_cpufreq_init()
- Firmware: _PPC objects: acpi_processor_ppc_init()
- User: by setting policyX/scaling_[min|max]_freq
The minimum of the max frequency constraints is used to compute
the resulting maximum allowed frequency.

When enabling boost frequencies, the same frequency request object
(policy->max_freq_req) as to handle requests from users is used.
As a result, when setting:
- scaling_max_freq
- boost
The last sysfs file used overwrites the request from the other
sysfs file.

To avoid this:
1. Create a per-policy boost_freq_req to save the boost
constraints instead of overwriting the last scaling_max_freq
constraint.

2. policy_set_boost() calls the cpufreq set_boost callback.
Update the newly added boost_freq_req request from there:
- whenever boost is toggled
- to cover all possible paths

3. In the existing set_boost() callbacks:
- Don't update policy->max as this is done through the qos notifier
  cpufreq_notifier_max() which calls cpufreq_set_policy().
- Remove freq_qos_update_request() calls as the qos request is now
  done in policy_set_boost() and updates the new boost_freq_req

This patch-set additionally does:
- if a driver .init() callback sets policy->min and policy->max,
  these values are used are min/max_freq_req QoS constraints
- Remove policy->min and policy->max initialization in .init()
  callback if the value is identical to cpuinfo.min/max_freq
- RFC: allow decreasing cpuinfo.max_freq when using freq_table.

------------

E.g.:
On a Juno with available frequencies: 600.000, 1.000.000
Boost frequencies: 1.200.000
Using the cppc-cpufreq driver.

---
Without the patches:
# ## Init state
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

# echo 700000 > scaling_max_freq
scaling_max_freq:700000
cpuinfo_max_freq:1000000

# echo 1 > ../boost
scaling_max_freq:1200000
cpuinfo_max_freq:1200000

# echo 800000 > scaling_max_freq
scaling_max_freq:800000
cpuinfo_max_freq:1200000

# echo 0 > ../boost
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

---
With the patches:
# ## Init
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

# echo 700000 > scaling_max_freq
scaling_max_freq:700000
cpuinfo_max_freq:1000000

# echo 1 > ../boost
scaling_max_freq:700000
cpuinfo_max_freq:1200000

# echo 800000 > scaling_max_freq
scaling_max_freq:800000
cpuinfo_max_freq:1200000

# echo 0 > ../boost
scaling_max_freq:800000
cpuinfo_max_freq:1000000

With the patches, the maximum scaling frequency requested is
conserved even though boosting is enabled/disabled.

---

Note:
It seems that there is a confusion in the cpufreq framework between:
- the min/max frequency requested by the user
- the min/max frequency constraint applied when selecting a frequency.

E.g:
A.
$ echo XXX > scaling_max_freq
updates the max_freq_req QoS request.

B.
$ cat scaling_max_freq
shows the content of policy->max, which is the not representing
the value of the max_freq_req QoS request.

C.
Whenever policy->max is accessed in the cpufreq framework,
the aggregation of all the requests on the maximum frequency should
be used instead.

cpufreq_set_policy() aggregates min/max constraints and
writes the resulting value in policy->min/max. These values
are then used in the cpufreq drivers.

Creating a clear distinction would be doable but quite invasive.
This patchset focuses on handling the boost frequency QoS request
first and should not change the current behaviour of policy->min
and max.

---

v1: https://lore.kernel.org/all/20251204101344.192678-1-pierre.gondois@arm.com/#t
v2: https://lore.kernel.org/all/20251208105933.1369125-1-pierre.gondois@arm.com/#t
Changes:
- Fixed error path
- Integrated [PATCH 1/4] Revert "cpufreq: Fix re-boost issue after hotplugging a CPU"
  to another patch
v3:
Changes:
- Fixed error path
- Extracted the revert of:
  "cpufreq: Fix re-boost issue after hotplugging a CPU"
  for clarity purpose
- Set cpuinfo.max_freq as a max_freq_req QoS constraint by default
New patches:
- "cpufreq: Allow decreasing cpuinfo.max_freq"
- "cpufreq: Set policy->min and max as QoS constraints"
v4:
- Correct reported issues
v5:
- Corrections
v6:
- Folded patches:
  - cpufreq: Centralize boost freq QoS requests
  - cpufreq: Update .set_boost() callbacks to rely on boost_freq_req
  inside:
  - cpufreq: Add boost_freq_req QoS request
- Simplified allocation handling of boost_freq_req
- Removed unnecessary bits

Pierre Gondois (4):
  cpufreq: Remove per-CPU QoS constraint
  cpufreq: Add boost_freq_req QoS request
  cpufreq: Set policy->min and max as real QoS constraints
  cpufreq/freq_table: Allow decreasing cpuinfo.max_freq

 drivers/cpufreq/amd-pstate.c      | 26 ++++++-----
 drivers/cpufreq/cppc_cpufreq.c    | 21 ++++-----
 drivers/cpufreq/cpufreq-nforce2.c |  4 +-
 drivers/cpufreq/cpufreq.c         | 71 +++++++++++++++++++++++--------
 drivers/cpufreq/freq_table.c      | 14 ++----
 drivers/cpufreq/gx-suspmod.c      |  9 ++--
 drivers/cpufreq/intel_pstate.c    |  3 --
 drivers/cpufreq/pcc-cpufreq.c     |  8 ++--
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 +-
 drivers/cpufreq/sh-cpufreq.c      |  7 +--
 drivers/cpufreq/virtual-cpufreq.c |  5 +--
 include/linux/cpufreq.h           |  1 +
 12 files changed, 97 insertions(+), 76 deletions(-)

--
2.43.0
