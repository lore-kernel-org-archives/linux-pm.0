From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/11] cpufreq: governor: ondemand/conservative data
 structures rework
Date: Thu, 4 Feb 2016 18:22:31 +0100
Message-ID: <CAJZ5v0j3X1SOp2eXc3T48_RhoBAo9Wk_LyAss7Ni381fHFiU7w@mail.gmail.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
	<20160204054049.GX3469@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33657 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbcBDRWd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 12:22:33 -0500
In-Reply-To: <20160204054049.GX3469@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Thu, Feb 4, 2016 at 6:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-02-16, 00:12, Rafael J. Wysocki wrote:
>> Hi,
>>
>> A few days ago I looked at the common code used by the ondemand and conservative
>> governors because of the deadlock issue that Viresh has addressed recently
>> (http://marc.info/?l=linux-pm&m=145450832814058&w=4) and it occurred to me
>> that the whole thing was really too tangled and might be made easier to follow
>> at least.  I started to work on this and ended up with the following series.
>>
>> I'm not really going to stop here, but first, I'd like to let everybody know
>> that this is happening and second, I'll need to rebase these patches on the
>> ones from Viresh (in the series linked above), but that may take some time
>> and I don't want to sit on them for all that long.
>>
>> Overall, I'd like the governor code to be cleaner and easier to follow, so we can
>> move at least some parts of governor work to utilization update callbacks (invoked
>> by the scheduler) or to at least to irq_work so as to reduce the usage of process
>> context in cpufreq to absolute minimum.  That's the plan for the future, but for
>> now this is just a major cleanup.
>>
>> [1/11] Clean up the way in which the default and fallback governors are set up.
>> [2/11] Use a common global mutex for dbs_data protection.
>> [3/11] Use common global pointer to dbs_data for system-wide governors.
>
> Hi Rafael,
>
> I have some very basic doubts on 2nd and 3rd patch, and so have
> stopped reviewing after that because there is too much dependency I
> believe on these two.
>
> I will review the rest, if my concerns on the earlier ones are
> incorrect.

Patch [3/11] is really incorrect (thanks for pointing the problem out
to me), but it also isn't essential, so I can drop it just fine I
think.

I don't see issues with the [2/11], though, apart from the changelog
being inaccurate which should be easy to fix.

Thanks,
Rafael
