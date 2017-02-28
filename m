From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: intel_pstate: Two fixes related to limis
Date: Tue, 28 Feb 2017 14:13:30 +0100
Message-ID: <2694426.SgxlQuL17D@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Both fix some utter confusion in the sysfs interface.

The first one makes intel_pstate_update_policies() end up with limits set to
the same value that it was set to initially.

The second one avoids reinitializing limits in intel_pstate_set_policy() when
the moon phase is right and the wind blows from a specific direction.

Thanks,
Rafael
