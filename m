From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq: intel_pstate: Locking and limits fix-ups
Date: Fri, 30 Dec 2016 15:54:30 +0100
Message-ID: <5344750.TOCWYON8QY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series fixes a couple of possible locking issues and limits synchronization
in intel pstate.

[1/3] Add locking to intel_pstate_resume().
[2/3] Add locking to intel_cpufreq_verify_policy().
[3/3] Always keep all limits settings in sync.

Thanks,
Rafael
