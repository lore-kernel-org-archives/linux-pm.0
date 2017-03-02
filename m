From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq: intel_pstate: Fixes related to the passive mode
Date: Thu, 02 Mar 2017 23:20:20 +0100
Message-ID: <1573986.gdsgdO0VUn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This series fixes some passive mode behavior related to limits and the
cpu_frequency tracepoint.

It depends on https://patchwork.kernel.org/patch/9594447/ (which is in
linux-next already), but it doesn't depend on the other series I posted
yesterday (https://patchwork.kernel.org/patch/9597147/ ,
https://patchwork.kernel.org/patch/9597145/,
https://patchwork.kernel.org/patch/9597137/).

All three patches in this series are reasonably straightforward and should
not be controversial.  Also they should affect the passive mode only.

Thanks,
Rafael
