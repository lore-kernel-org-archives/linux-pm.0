From: Thomas Renninger <trenn@suse.de>
Subject: Implement userspace RAPL bits in cpupower
Date: Fri, 05 Jun 2015 16:39:16 +0200
Message-ID: <1499120.6h7ZWas8bA@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbFEOjS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Jun 2015 10:39:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, jacob.jun.pan@linux.intel.com

Hi,

I'd like to ask whether there already exist userspace bits
for the powercap/rapl drivers?

Afaik there is some "read-only"/monitor code in turbostat,
but it is not intended to add any modifying code in there?

I would like to avoid yet another (Intel) CPU specific
userspace tool, like:
tools/power/x86/x86_energy_perf_policy
tools/power/x86/turbostat

and it would be great if userspace bits could be added to
cpupower utility
tools/power/cpupower

I searched for rapl and powercap in the MAINTAINERS list,
but there wasn't any match. Is there a candidate (Jacob?) who
might be the right one or who volunteers for this?

Thanks for any hints and any discussion input,

      Thomas
