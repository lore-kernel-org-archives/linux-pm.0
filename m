From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq: governor: Data structure rearrangement
Date: Sun, 07 Feb 2016 16:22:49 +0100
Message-ID: <2998470.K7oslgfuja@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58722 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753902AbcBGPYH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 10:24:07 -0500
In-Reply-To: <9008098.QDD8C89zDx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

Hi,

This was part of my recent cleanup series
(http://marc.info/?l=linux-pm&m=145463901630950&w=4), but Viresh had a good
point about the patch doing too much and possibly going too far, so I've
reworked it into a series of three smaller patches and dropped some more
aggressive changes.

[1/3] simplifies cpufreq_governor_limits() to access the policy via its
      argument directly.
[2/3] rearranges the data structures so policy->governor_data points to the
      struct policy_dbs corresponding to that policy and the latter points
      to a struct dbs_data.
[3/3] makes the initialization and cleanup of struct cpu_dbs_info more
      symmetrical.

Patches are on top of my bleeding-edge branch (and there is a separate
pm-cpufreq-test branch with cpufreq patches only in case someone wants/needs
to test those alone).

Thanks,
Rafael

