From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Implement userspace RAPL bits in cpupower
Date: Fri, 05 Jun 2015 19:33:54 -0700
Message-ID: <55725C12.2040604@linux.intel.com>
References: <1499120.6h7ZWas8bA@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11664 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbbFFCeA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Jun 2015 22:34:00 -0400
In-Reply-To: <1499120.6h7ZWas8bA@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, jacob.jun.pan@linux.intel.com


On 06/05/2015 07:39 AM, Thomas Renninger wrote:
> Hi,
Hi,
> I'd like to ask whether there already exist userspace bits
> for the powercap/rapl drivers?
This is used in user space for Android for power saver mode and Linux 
thermal daemon,.
Also there is a powermeter at 
https://github.com/spandruvada/rapl_power_meter

>
> Afaik there is some "read-only"/monitor code in turbostat,
> but it is not intended to add any modifying code in there?
>
> I would like to avoid yet another (Intel) CPU specific
> userspace tool, like:
> tools/power/x86/x86_energy_perf_policy
> tools/power/x86/turbostat
>
> and it would be great if userspace bits could be added to
> cpupower utility
> tools/power/cpupower
> I searched for rapl and powercap in the MAINTAINERS list,
> but there wasn't any match. Is there a candidate (Jacob?) who
> might be the right one or who volunteers for this?
This is maintained by Rafael. Jacob and me are the authors/developers 
for power capping and RAPL drivers.

Thanks,
Srinivas
> Thanks for any hints and any discussion input,
>
>        Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

