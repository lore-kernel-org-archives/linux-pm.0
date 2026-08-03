Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5F36B067;
	Mon,  3 Aug 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751381; cv=none; b=i/OiIoS1XrWxYxgpoPrVWWetCXbU+de9HT4ndb81RQXeOW9FGHJlSUI5W7uwiEsTIz6Wam2RbQViwCE2qivM/4UpV3n/sIo5JmdPd9+ztrbMUknCI4gTJ9KAsdnjYnY6WRlbmRmBLXgrdcEGbxRL/KHWPe75h9KUnkPBDvPVjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751381; c=relaxed/simple;
	bh=nJ9QWCi/tJmF9Pq2ORqEtY5V8jGQpOuqrz5rNcgEs1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEkZ6JsW550kncrsXzH4pLFyHjHMX8DUVOsAP70OdSRQW5rrg+pssc+biIFZ+2ofJ1SyW12C8i8EvHhne8ZjtmvqKnySs0Gf4TuTH6T5PxKFifEfkPna4mhjdleOi0fjZrcxPECxIIyZ52OLM9CSs6t4F3MDjiHtzSzTr1CChsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GxCHASjE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GxCHASjE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1128143D;
	Mon,  3 Aug 2026 03:02:53 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF6163F66F;
	Mon,  3 Aug 2026 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785751377; bh=nJ9QWCi/tJmF9Pq2ORqEtY5V8jGQpOuqrz5rNcgEs1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxCHASjERhwg3n9lUBA3VJ3DbHDSRY+7VzcqlwjmFdvgSC8zDYXf7u2tnUjvjB/9I
	 2EOytqgMxNA6V7Gsoo3xrUCQZvsetOAMzBH1Gi7MbgFN4AqKodoAJDWjwcUhDLIlYq
	 JTRUSKkjdHg1n3KTfNGZcYwuzBJuvp09ui7vdaUw=
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
	zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v3 0/3] ACPI: CPPC: Avoid Desired Performance reads on ACPI 6.6+
Date: Mon,  3 Aug 2026 11:02:48 +0100
Message-Id: <cover.1785749175.git.christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729100245.2628302-1-christian.loehle@arm.com>
References: <20260729100245.2628302-1-christian.loehle@arm.com>
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

Changes since v2:
- Fall back to the cached OSPM request when reading Desired Performance
  returns zero as suggested by Sumit Gupta.
- Pick up Reviewed-by tags from Zhongqiu Han for patches 2 and 3.
- Rebase onto v7.2-rc6

Christian Loehle (3):
  ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
  ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
  ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()

 drivers/acpi/cppc_acpi.c       | 36 +++++++++++++++++++++-------------
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 2 files changed, 23 insertions(+), 15 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.34.1
