From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 00/14] cpufreq: intel_pstate: Fixes, cleanups and optimizations
Date: Sun, 12 Mar 2017 18:11:49 +0100
Message-ID: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series fixes a couple of bugs in intel_pstate, cleans up the code in
it somewhat and makes some changes targeted at overhead reductions.

Patch [1/14] is a regression fix, patch [2/14] can be regarded as a fix too,

Patches [3-9/14] are cleanups mostly getting rid of unnecessary stuff.

Patches [10-11/14] make changes to reduce the overhead of utilization update
callbacks used in the active mode.

Patches [12-14/14] make more cleanups on top of that.

Refer to the changelogs for details.

Thanks,
Rafael
