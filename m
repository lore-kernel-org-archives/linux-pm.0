From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] intel_pstate: delete scheduler hook in HWP mode
Date: Sat, 17 Jun 2017 02:09:20 +0200
Message-ID: <51646263.RzQfqm1Mfo@aspire.rjw.lan>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org> <8554c677900ad6bcb308f4afe1099aead3cfebd3.1496889051.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44162 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751774AbdFQAQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 20:16:31 -0400
In-Reply-To: <8554c677900ad6bcb308f4afe1099aead3cfebd3.1496889051.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, hpa@linux.intel.com, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wednesday, June 07, 2017 07:39:16 PM Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The cpufreqa/scaling_cur_freq sysfs attribute is now provided by
> the x86 cpufreq core on all modern x86 systems, including
> all systems supported by the intel_pstate driver.

Not sure what you mean by "x86 cpufreq core"?

Besides, I'd reorder this change with respect to patch [4/5] as this
eliminates the hook entirely and then the "performance"-related change
would only affect non-HWP.

Thanks,
Rafael
