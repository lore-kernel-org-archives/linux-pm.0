From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 0/2] Thermal: cpufreq cooling fix
Date: Mon, 11 Mar 2013 23:33:11 +0800
Message-ID: <1363015993-8113-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5756 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958Ab3CKPdS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 11:33:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

cpufreq cooling uses different frequencies as different cooling states.

But the per_cpu cpufreq_frequency_table may contain duplicate,
invalid entries, and it may be in either ascending or descending order.
And currently, code for parsing the per_cpu cpufreq_frequency_table
is used in several places and inconsistent.

To fix this,
New code is introduce in Patch 1/2, which contains the logic
of parsing per_cpu cpufreq_frequency_table, and this piece of
code can be used to:
1. get the maximum cooling states
2. translate cpu frequency to cooling state
3. translate cooling state to cpu frequency

Patch 2/2 converts exynos_thermal driver to use the new code
introduced in Patch 1/2.

History:
V3: fix wrong return value of get_cpu_frequency().
    fix wrong return value of get_property() when property equals GET_MAXL.

V2: remove cpu cooling table to avoid extra memory allocation.

V1: introduce code to convert per_cpu cpufreq_frequency_table
    to clean cpu cooling table (no invalid entry,
    no duplicate entry, in descending order).

I just run build test here. It would be great that some of you
can test it on exynos.
any comments?

thanks,
rui
