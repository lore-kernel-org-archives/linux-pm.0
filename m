From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 0/2] __cpuhp_setup_state() returns positive value for dynamic state
Date: Thu, 15 Dec 2016 10:00:56 -0500
Message-ID: <1481814058-4799-1-git-send-email-boris.ostrovsky@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, bigeasy@linutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org

The first patch corrects description of __cpuhp_setup_state()'s possible
return values and the second fixes a bug (which causes Xen guests to crash).

As a follow-up question for the first patch --- should we allow calling
__cpuhp_setup_state() with state in [CPUHP_AP_ONLINE_DYN + 1 .. CPUHP_AP_ONLINE_DYN_END]
range?

Boris Ostrovsky (2):
  cpu/hotplug: Clarify description of __cpuhp_setup_state() return
    value
  cpufreq: Remove cpu hotplug callbacks only if they were initialized

 drivers/cpufreq/acpi-cpufreq.c |    2 +-
 kernel/cpu.c                   |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)
