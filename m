From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Tue, 1 Mar 2016 07:46:52 +0530
Message-ID: <20160301021652.GW2791@vireshk-i7>
References: <20151016054226.GQ19018@linux>
 <1456344052.8680.208.camel@linux.intel.com>
 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
 <1456357073.3860.21.camel@linux.intel.com>
 <20160225032700.GA2822@vireshk-i7>
 <1456423672.17628.9.camel@linux.intel.com>
 <20160226015718.GA2639@vireshk-i7>
 <1456518098.17628.92.camel@linux.intel.com>
 <20160229031601.GI5823@vireshk-i7>
 <1456765892.21069.18.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34629 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcCACQ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 21:16:56 -0500
Received: by mail-pf0-f174.google.com with SMTP id 4so24672618pfd.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 18:16:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456765892.21069.18.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 29-02-16, 09:11, Srinivas Pandruvada wrote:
> This depends on ACPI configuration, so not guaranteed to have one cpu
> per policy. Since this is not guaranteed, I can't change mode to Read
> only on some as after I set the cpufreq_driver->attr, the other call to
> init may change the mode before the actual attribute creation.
> So safe bet is to implement like boost for all CPUs and fail on read
> for some CPUs, where this is not present. If this becomes a problem,
> then we can revisit.

Perhaps don't look at it on per-cpu basis, but rather per-policy basis
(as the files are going to be shared).

So, maybe just create the attribute always and return errors by
default. Once ->init() is called and you know if a CPU supports it or
not, toggle some internal flag to allow read/write to those sysfs
files.

-- 
viresh
