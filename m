Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05FF3FB06E;
	Wed, 29 Jul 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319378; cv=none; b=FZuBGIARpR9y0y7bObznU4qK7NjC0bcss3hLssQ7e3bzN0GL1qlBU//z0/9LDrhtyJwVrzl8gd0H1BavlEvBrQi+S+zpwd4Xw1YDqlTC5ZmoUf2M5RiAy8QCjaY3wK0bQTaXq04vhObW5MGu3/v9LwABAq6RVHlGtwfC4Vwa3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319378; c=relaxed/simple;
	bh=jId0pM3TxW2O6iH23U+jLZaMRVBPrdkJKgxpRvS1aek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nmu2ArBM/JTuPL2jc5mqhpVtX6FPHL08xvK/AvJ6hr+Fc14RMye/I1jpOvQWX0z25aQC+BcuoPTftgTWzLepzEN75+61XgsCAHQ/fc7Lougg3r915xhMPb5au9m0Qw0egRcykSaB6LfzpZnfGQA7doWUQkMthiwAMssvuSkcLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fn0M2vdZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fn0M2vdZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E9815A1;
	Wed, 29 Jul 2026 03:02:51 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E30F73F86F;
	Wed, 29 Jul 2026 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785319375; bh=jId0pM3TxW2O6iH23U+jLZaMRVBPrdkJKgxpRvS1aek=;
	h=From:To:Cc:Subject:Date:From;
	b=fn0M2vdZspmNpPsdBAxuAbHmumJF2H5urGwjgoffW269xCaCx87eA+rRvQHarhLcI
	 eWu8ODweNA3To+fTkBVGo3dhb88y8RD/E1XnTfm7LozZa+gsFunhRHIxCl6HrqFSHb
	 +w9PBUFNvdPfH7d9hXb3EHtWaJ8v4KNtD6r873pk=
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
Subject: [PATCHv2 0/3] ACPI: CPPC: Avoid Desired Performance reads on ACPI 6.6+
Date: Wed, 29 Jul 2026 11:02:42 +0100
Message-Id: <20260729100245.2628302-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.6 changed the Optional Attribute of Desired Performance from
Read/Write to Write.

cppc-cpufreq reads Desired Performance when feedback counters cannot
provide a usable sample because some older platforms repurpose the
register to report actual delivered performance. Preserve that workaround
on systems reporting an older ACPI revision, but do not attempt the read
on ACPI 6.6 or later, where firmware no longer promises a readable value
and cppc-cpufreq can fall back to its cached OSPM request instead.

cppc_get_perf() also reads Desired Performance while populating the
control values used during cppc-cpufreq initialization. Its only in-tree
caller overwrites that value with highest_perf before the controls are
first written, so the value is never consumed.

Patches 1 and 2 provide minimal, backportable fixes for the two read
paths. Patch 3 simplifies the mainline API by no longer reading
Desired Performance through cppc_get_perf() on any ACPI revision.

Changes since v1:
- Mask the FADT minor revision's errata-generation bits.
- Add patch 2 as fix to also avoid reading Desired Performance from
cppc_get_perf(), as suggested by Zhongqiu Han.
- Add patch 3 to change the API as there's currently no in-tree use
of Desired Performance in cppc_get_perf()

Christian Loehle (3):
  ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
  ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
  ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()

 drivers/acpi/cppc_acpi.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

-- 
2.34.1
