From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: ia64: Fix a memory leak in acpi_cpufreq_cpu_exit
Date: Thu, 23 Jul 2015 23:05:08 +0200
Message-ID: <3681547.ai2R4bf4Nm@vostro.rjw.lan>
References: <55AC9424.1070304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61076 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753507AbbGWUiT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:38:19 -0400
In-Reply-To: <55AC9424.1070304@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On Monday, July 20, 2015 02:24:36 PM Pan Xinhui wrote:
> From: Pan Xinhui <xinhuix.pan@intel.com>
> 
> freq_table should be alloced in ->init and freed in ->exit. However it
> does not be freed. Fix this memory leak in acpi_cpufreq_cpu_exit.
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
