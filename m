From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: intel_pstate: Eliminate the PID controller
Date: Tue, 25 Jul 2017 00:10:04 +0200
Message-ID: <6183701.sLtcQDF8CA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52796 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753250AbdGXWUi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 18:20:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

Hi,

According to testing so far, the P-state selection based on the PID controller
in intel_pstate can be replaced with the P-state selection based on CPU load
with no considerable regressions *and* the PID-based P-state selection is
generally flaky and hard to manage, make intel_pstate use the P-state selection
based on CPU load for all categories of systems and eliminate the PID controller
along with all things related to it from the driver.

[1/2] is the actual elimination.
[2/2] is a simplification possible after [1/2].

Thanks,
Rafael
