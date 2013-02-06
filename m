From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/5] Thermal: cpu cooling fix
Date: Wed,  6 Feb 2013 12:30:01 +0800
Message-ID: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab3BFEaL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 23:30:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

the per_cpu cpufreq_frequency_table contains all the frequency entries
which are reported by platform code.
But this table is not clean enough because it may contain invalid,
duplicate entries, and it may be in either descending or asceding order.

converting between cpu frequency and cooling state using this table
in cpufreq cooling code is painful as each cooling state of
cpu cooling device must have a valid and unique frequency.

thus cpu cooling table is introduced in this patch set.
CPU cooling table is a table that
1. each entry represents a cpu cooling state,
   aka, a different cpu frequency.
2. no invalid entry in this table
3. no duplicate entry in this table
4. the frequency of all the entries are in descending order, aka,
   table[0] equals maximum frequency and cooling state 0.

And this is the table we are using inside cpufreq cooling generic code.

Besides, all the cpufreq cooling users, e.g. exynos, should touch
neither per_cpu cpufreq_frequency_table nor the cpu cooling table.
it should invoke cpufreq cooling API to do cooling_state/frequency
transition.

I just run build test here. It would be great that some of you
can test it on exynos.
any comments?

thanks,
rui
