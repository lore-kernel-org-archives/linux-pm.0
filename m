From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 00/16] cpufreq: intel_pstate: Cleanups and optimizations
Date: Tue, 28 Mar 2017 00:01:55 +0200
Message-ID: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48783 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752780AbdC0Wnz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 18:43:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

Hi,

This patch series cleans up the code in intel_pstate somewhat and makes some
changes targeted at reducing overhead.

Patches [1-9/16] are cleanups mostly getting rid of unnecessary stuff.

Patches [10-11/16] make changes to reduce the overhead of utilization update
callbacks used in the active mode.

Patches [12-16/16] make more cleanups on top of that.

Refer to the changelogs for details.

The series is based on the linux-next branch of the linux-pm.git tree.

Thanks,
Rafael
