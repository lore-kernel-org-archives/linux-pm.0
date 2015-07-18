From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] ACPI / cpufreq: ACPI processor driver and ACPI
 cpufreq driver cleanups
Date: Sat, 18 Jul 2015 11:34:46 +0530
Message-ID: <20150718060446.GB11802@linux>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33978 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbGRGEv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jul 2015 02:04:51 -0400
Received: by pdbbh15 with SMTP id bh15so26516054pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2015 23:04:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Xinhui <xinhuix.pan@intel.com>

On 18-07-15, 03:13, Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches clean up a couple of things in the ACPI processor
> driver and the ACPI cpufreq driver:
> 
> [1/2] Drop the unused first argument of acpi_processor_unregister_performance().
> [2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.
> 
> Both patches on top of the current linux-next branch of the linux-pm.git tree.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
