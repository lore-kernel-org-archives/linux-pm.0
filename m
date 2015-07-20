From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ia64: remove redundant freq_table of
 acpi_cpufreq_data
Date: Mon, 20 Jul 2015 15:22:45 +0530
Message-ID: <20150720095245.GE8502@linux>
References: <55AC93B6.7030305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35901 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbGTJwt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 05:52:49 -0400
Received: by pdjr16 with SMTP id r16so101384956pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2015 02:52:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55AC93B6.7030305@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On 20-07-15, 14:22, Pan Xinhui wrote:
> From: Pan Xinhui <xinhuix.pan@intel.com>
> 
> freq_table is now stored as policy->freq_table, so drop the redundant
> freq_table from struct cpufreq_acpi_io.
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
