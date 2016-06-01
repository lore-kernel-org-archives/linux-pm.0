From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/2] cpufreq: Use sorted frequency tables
Date: Wed,  1 Jun 2016 16:09:53 +0530
Message-ID: <cover.1464777376.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34929 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750697AbcFAKj7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 06:39:59 -0400
Received: by mail-pf0-f169.google.com with SMTP id g64so13011577pfb.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 03:39:59 -0700 (PDT)
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
has to be efficient first.

OTOH, even for traditional governors without a fast-switch path, it
would be much better to be able to traverse this table quickly.

The ideal solution would be to keep a single *sorted* freq-table in
struct cpufreq_policy. But there are few dependencies due to which it
can't be done today (Hint: cpufreq drivers are abusing the 'index'
passed to them, to refer to multiple arrays).

And so for now, lets create a separate table local to the cpufreq-core
*only*.

This modifies the existing API cpufreq_frequency_table_target() to use
the sorted table.

Lightly tested on Exynos board, frequencies were getting selected as
expected.

V1->V2:
- This optimizes cpufreq_frequency_table_target() instead of new APIs.
- Is rebased over bleeding-edge + following cleanup series.
  [PATCH 0/8] cpufreq: cleanups and reorganization

--
viresh

Viresh Kumar (2):
  cpufreq: Store sorted frequency table
  cpufreq: Optimize cpufreq_frequency_table_target()

 drivers/cpufreq/acpi-cpufreq.c    |  15 +--
 drivers/cpufreq/cpufreq.c         |  23 ++--
 drivers/cpufreq/freq_table.c      | 247 ++++++++++++++++++++++++++------------
 drivers/cpufreq/s3c24xx-cpufreq.c |  13 +-
 include/linux/cpufreq.h           |  23 +++-
 5 files changed, 220 insertions(+), 101 deletions(-)

-- 
2.7.1.410.g6faf27b

