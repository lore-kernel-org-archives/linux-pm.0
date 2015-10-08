From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 0/2] crash on reading cpufreq sysfs
Date: Thu, 8 Oct 2015 02:17:06 +0200
Message-ID: <CAJZ5v0j0=WKGoERT_uJjs=gkAiDuR2_RdTOTObHx9up-vzLZuQ@mail.gmail.com>
References: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1543959.r5bbusBA6I@vostro.rjw.lan>
	<1444261800.7437.7.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34874 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbbJHARI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 20:17:08 -0400
Received: by lbwr8 with SMTP id r8so29058615lbw.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 17:17:06 -0700 (PDT)
In-Reply-To: <1444261800.7437.7.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Oct 8, 2015 at 1:50 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2015-10-08 at 00:50 +0200, Rafael J. Wysocki wrote:
>> On Wednesday, October 07, 2015 01:50:42 PM Srinivas Pandruvada wrote:
>> > Fixes for crash on reading cpufreq sysfs for offline cpus
>> >
>> > v1
>> > Fix commit discription on Patch 1/2. Included Acks from Viresh.
>> > It has both patches, even though only one patch has change.
>> >
>> > v0
>> > two patches: one for acp-cpufreq and one for cpufreq core
>> >
>> > Srinivas Pandruvada (2):
>> >   cpufreq: acpi_cpufreq: prevent crash on reading freqdomain_cpus
>> >   cpufreq: prevent lockup on reading scaling_available_frequencies
>>
>> Both applied, but they look like -stable material to me.
>>
> I tested in 4.1 kernels, since on offline, cpufreq folder is not
> available there is no issue.
> For 4.2 kernels the I didn't see crash fixed by cpufreq core patch (cat
> scaling_available_frequencies), but the "cat freqdomain_cpus" still
> causes crash. So we need to apply cpufreq:acpi-cpufreq patch only. So
> one patch is applicable for stable tree.

So [1/2] should go into 4.2.y and [2/2] fixes a regression introduced
in this cycle, right?

Thanks,
Rafael
