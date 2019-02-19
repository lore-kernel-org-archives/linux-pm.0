From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] cpufreq: Assorted cleanups related to cpufreq_set_policy()
Date: Wed, 20 Feb 2019 00:21:34 +0100
Message-ID: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

There are a few things related to cpufreq_set_policy() and cpufreq_update_policy()
that increase the level of confusion thereof quite unnecessarily, so this series
attempts to clean them up.  Please refer to the patch changelogs for details.

Please let me know if you see any problems with these patches.

Thanks,
Rafael
