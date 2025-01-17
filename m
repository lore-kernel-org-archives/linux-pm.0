Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91E1FCF60;
	Fri, 17 Jan 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108909; cv=none; b=dHV7dInkhwh8Chh0jKxoB5OXHRWY853LK+Vi/gDZptkbwv7fJmxa4Ogh5UKMm2KWU0VayDNjVpDjD9HrlDNCP1NDwSKDhchnb06oX4DaF/vuWIzpGvCDGBVHgGhvmx+HNcH8a9RXXvW+bagX69ECm4+rNJOVwk3MAnNrFohxDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108909; c=relaxed/simple;
	bh=M9kHW8cHo0azarb3VGztkhmoPY9joUB7GTBhqrEmTPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QpY+5Rvzh/tRaowPmyo+BQ+q/9HmQBkEQXJ1VPxEE3SXK1kWpD7LORini6meYHAsPNkT+HNszjbbdCKH307yONq+H2ClHTZ2v2XM4/KT3iWZXQuG+jHV+ZbOTXLq5Ku+zSwQ8VGtQW5KCgm58QKEt9mAt1eEOIVGt4/WWoKHZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YZFrd2B51z1V4wH;
	Fri, 17 Jan 2025 18:11:45 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B2D7E140202;
	Fri, 17 Jan 2025 18:14:58 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 18:14:58 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v2 0/4] cpufreq: Fix some boost errors related to CPU online and offline.
Date: Fri, 17 Jan 2025 18:14:53 +0800
Message-ID: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

This patch series fix some boost errors related to CPU online and offline:

 - patch 1 fix an error that causes the CPU stay on base frequency after a
   specific operation

 - patch 2 introduce a more generic way to set default per-policy boost
   flag and fix a error that causes the per-policy boost flag remians true
   when cpufreq_driver boost disabled

 - patch 3 fix an error in cppc_cpufreq that causes the CPU stay on base
   frequency when boost flag is true

 - patch 4 remove the set_boost in acpi_cpufreq_cpu_init(), since it will
   be executed in cpufreq_online

Change since v1:
 - remove update of min_freq_req
 - optimize the conditions for executing set_boost in cpufreq_online
 - fix another error in cppc_cpufreq
 - remove set_boost in acpi_cpufreq_cpu_init()

Lifeng Zheng (4):
  cpufreq: Fix re-boost issue after hotplugging a cpu
  cpufreq: Introduce a more generic way to set default per-policy boost
    flag
  cpufreq: CPPC: Fix wrong max_freq in policy initialization
  cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()

 drivers/cpufreq/acpi-cpufreq.c |  5 -----
 drivers/cpufreq/cppc_cpufreq.c |  5 +++--
 drivers/cpufreq/cpufreq.c      | 20 ++++++++++++++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.33.0

