From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 0/2] Thermal: cpufreq cooling fix
Date: Fri,  8 Feb 2013 15:12:07 +0800
Message-ID: <1360307529-5454-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3172 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759945Ab3BHHMN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Feb 2013 02:12:13 -0500
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
V2: remove cpu cooling table to avoid extra memory allocation.

V1: introduce code to convert per_cpu cpufreq_frequency_table
    to clean cpu cooling table (no invalid entry,
    no duplicate entry, in descending order).

I just run build test here. It would be great that some of you
can test it on exynos.
any comments?

thanks,
rui
