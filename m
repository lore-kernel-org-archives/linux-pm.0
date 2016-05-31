From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Tue, 31 May 2016 17:06:01 +0530
Message-ID: <cover.1464694144.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35522 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcEaLgI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 07:36:08 -0400
Received: by mail-pf0-f182.google.com with SMTP id g64so74095745pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 04:36:07 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, smuckle@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

This work in inspired by some of the concerns raised by Steve in one of
his patchset.

Currently, the cpufreq drivers aren't required to provide a sorted list
of frequencies to the cpufreq-core and so traversing that list match a
target frequency is very inefficient.

This is not bearable by, for example, the fast-switch path of schedutil
governor and so we have moved the traversing logic local to the
acpi-cpufreq driver for now. That is better handled in the core, but it
has to be efficient.

OTOH, even for traditional governors without a fast-switch path, it
would be much better to be able to traverse this table quickly.

The ideal solution would be to keep a single freq-table in struct
cpufreq_policy, that will be sorted as well. But there are few
dependencies due to which it can't be done today (Hint: cpufreq drivers
are abusing the 'index' passed to them, to refer to multiple arrays).

And so for now, lets create a separate table local to the cpufreq-core
only.

To use that, another API cpufreq_find_target_index() is created as well
and few users are migrated to it.

Lightly tested on Exynos board, frequencies were getting selected as
expected.

--
viresh

Viresh Kumar (2):
  cpufreq: Store sorted frequency table
  cpufreq: Implement cpufreq_find_target_index() to traverse sorted list

 drivers/cpufreq/acpi-cpufreq.c |  18 ++--
 drivers/cpufreq/cpufreq.c      |  48 ++++++-----
 drivers/cpufreq/freq_table.c   | 191 +++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h        |   7 ++
 4 files changed, 231 insertions(+), 33 deletions(-)

-- 
2.7.1.410.g6faf27b

