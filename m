From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq: Boost cleanup
Date: Sun, 27 Dec 2015 00:21:14 +0100
Message-ID: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46624 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751578AbbLZW5U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Dec 2015 17:57:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Hi,

This series cleans up a few things related to the boost sysfs attribute
used by cpufreq.

[1/3] - Make local function static.
[2/3] - Simplify boost-related code in acpi-cpufreq.
[3/3] - Simplify boost-related core code.

Thanks,
Rafael

