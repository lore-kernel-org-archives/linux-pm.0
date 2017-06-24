From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4 v2] x86: use common aperfmperf_khz_on_cpu() to
 calculate KHz using APERF/MPERF
Date: Sat, 24 Jun 2017 14:03:41 +0200
Message-ID: <CAJZ5v0j2m-tQz0CkrX9uPiNbivkXhiF-orEGqRAAa-euUqXqNQ@mail.gmail.com>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org>
 <7c8784a63cdab6ff5ff7756060be6a77f5fe5915.1498280509.git.len.brown@intel.com> <alpine.DEB.2.20.1706241052050.1941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:32814 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdFXMDm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 08:03:42 -0400
In-Reply-To: <alpine.DEB.2.20.1706241052050.1941@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Sat, Jun 24, 2017 at 10:56 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 23 Jun 2017, Len Brown wrote:
>> This x86 native method to calculate MHz returns a meaningful result
>> no matter if P-states are controlled by hardware or firmware
>> and/or if the Linux cpufreq sub-system is or is-not installed.
>>
>> When this routine is invoked more frequently, the measurement
>> interval becomes shorter.  However, the code limits re-computation
>> to 10ms intervals so that average frequency remains meaningful.
>>
>> Discerning users are encouraged to take advantage of
>> the turbostat(8) utility, which can gracefully handle
>> concurrent measurement intervals of arbitrary length.
>>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
> Raphael, please take the whole lot through the cpufreq tree.

I will, thanks!

Rafael
