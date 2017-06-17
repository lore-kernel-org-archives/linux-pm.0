From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] intel_pstate: delete scheduler hook in HWP mode
Date: Fri, 16 Jun 2017 21:27:46 -0400
Message-ID: <CAJvTdK==SctxEJ_HQvLaK+LXhMQfq1teYWW41x3kM82Xj2OgqQ@mail.gmail.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
 <8554c677900ad6bcb308f4afe1099aead3cfebd3.1496889051.git.len.brown@intel.com> <51646263.RzQfqm1Mfo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36479 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbdFQB1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 21:27:47 -0400
In-Reply-To: <51646263.RzQfqm1Mfo@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, Jun 16, 2017 at 8:09 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 07, 2017 07:39:16 PM Len Brown wrote:
>> From: Len Brown <len.brown@intel.com>
>>
>> The cpufreqa/scaling_cur_freq sysfs attribute is now provided by
>> the x86 cpufreq core on all modern x86 systems, including
>> all systems supported by the intel_pstate driver.
>
> Not sure what you mean by "x86 cpufreq core"?

I refer to code that builds if (CONFIG_X86 && CONFIG_CPU_FREQ)

Since it was enough to provoke a comment form you, how about this wording?:

The cpufreq/scaling_cur_freq sysfs attribute is now provided by
shared x86 cpufreq code on modern x86 systems, including
all systems supported by the intel_pstate driver.

> Besides, I'd reorder this change with respect to patch [4/5] as this
> eliminates the hook entirely and then the "performance"-related change
> would only affect non-HWP.

I don't actually see a problem with either order,
but i'll send the refresh with the order you suggest.

thanks,
Len Brown, Intel Open Source Technology Center
