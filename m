Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF73A63F2;
	Mon,  3 Aug 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789344; cv=none; b=WtSCCR7RjmttlrbrGEUJR8Tomn/cL+FTJwE+W43A5bfUu7TE/FrDPN6KDObz2qYLQe52cAGhLpld8Mx4Ci96jCUZlOXSZ7QFi677yGCwi/ahNkZT+m/ddHcMSE6UN26iogivheBtdyYSzJhAav5439Nn3e+zjZ8m2jTArLOkXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789344; c=relaxed/simple;
	bh=JvSBp13jnQjcAidQhpvGtkw8zNsjMGnkRorhMkon/qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qZzC9DXcftB0zQkd474gDt7zOX7dmiWhjfizs/tTv+dPaqUop0n7nyjiUJe88Lrl/h3zrRta996liZzz2zbXS0ZIHkGzSXRae2T1zcJNnLxoa24cn876AOok1VNyODJ1o9UqGoG+Pg6/+pjg0f/7CuM38JLRh7ltlnNYhungHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Da/xpt+T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Da/xpt+T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778CE143D;
	Mon,  3 Aug 2026 13:35:36 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 441B83F632;
	Mon,  3 Aug 2026 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785789340; bh=JvSBp13jnQjcAidQhpvGtkw8zNsjMGnkRorhMkon/qs=;
	h=From:To:Cc:Subject:Date:From;
	b=Da/xpt+TypGKLNW75aX01jCFCkxt+QvofFc6x5N/EJlHj+YoSCdZPAjgS/0NN94Tm
	 4bxLf8nNVcBTyH4vLiH+foPO1z7iwYrPOkBOxdlD9nAYGcL1y9L77PwI0d2x6fbvSP
	 Aver02RYov3LZAoKhm0JvmHb9RmpRMGC+d2Pf8Ec=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/3] ACPI: CPPC: Avoid Desired Performance reads on _CPC 4+
Date: Mon,  3 Aug 2026 21:35:28 +0100
Message-Id: <20260803203531.1268651-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.6 introduced _CPC revision 4 which changed the attribute of
Desired Performance from Read/Write to Write.

cppc-cpufreq reads Desired Performance when feedback counters cannot
provide a usable sample because some older platforms repurpose the
register to report actual delivered performance. Preserve that workaround
on systems reporting an older _CPC revision, but do not attempt the read
on _CPC revision 4 or later, where firmware no longer promises a readable
value and cppc-cpufreq can fall back to its cached OSPM request instead.

cppc_get_perf() also reads Desired Performance while populating the
control values used during cppc-cpufreq initialization. Its only in-tree
caller overwrites that value with highest_perf before the controls are
first written, so the value is never consumed.

Patches 1 and 2 provide minimal, backportable fixes for the two read
paths. Patch 3 simplifies the mainline API by no longer reading
Desired Performance through cppc_get_perf() on any ACPI revision.

Changes since v3:
Detect on _CPC revision not ACPI version (Rafael)

Christian Loehle (3):
  ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
  ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
  ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()

 drivers/acpi/cppc_acpi.c       | 36 ++++++++++++++++++++++------------
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 2 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.34.1

