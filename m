From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] cpufreq: Cleanups and governor module removal race fix
Date: Thu, 23 Nov 2017 01:21:17 +0100
Message-ID: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This series contains cleanup patches related to governor management,
mostly for cpufreq_parse_governor(), and a fix for a governor module
removal race.

Thanks,
Rafael
