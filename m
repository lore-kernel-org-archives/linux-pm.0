From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Fri, 16 Oct 2015 11:12:26 +0530
Message-ID: <20151016054226.GQ19018@linux>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20151007172343.GE4557@linux>
 <4807388.hTIoZIhGRk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33395 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbJPFmd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 01:42:33 -0400
Received: by pabrc13 with SMTP id rc13so109957034pab.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 22:42:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4807388.hTIoZIhGRk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 16-10-15, 00:45, Rafael J. Wysocki wrote:
> We're talking about a continuous range above the base frequency here.

Ick. No it can't be reused for the continuous range stuff.

-- 
viresh
