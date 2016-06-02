From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Enable PPC enforcement for servers"
Date: Fri, 3 Jun 2016 00:33:06 +0200
Message-ID: <CAJZ5v0hBiAZ3VZ=TrZcBJfEKPnZXwa4o7T6r=RHf83E90P915w@mail.gmail.com>
References: <1464828117-6534-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<2942391.Y8jFCPZgiC@vostro.rjw.lan>
	<1464905121.3970.67.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38405 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbcFBWdI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 18:33:08 -0400
Received: by mail-wm0-f42.google.com with SMTP id a20so84505892wma.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 15:33:06 -0700 (PDT)
In-Reply-To: <1464905121.3970.67.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Jun 3, 2016 at 12:05 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-06-03 at 00:00 +0200, Rafael J. Wysocki wrote:
>> On Wednesday, June 01, 2016 05:41:57 PM Srinivas Pandruvada wrote:
>> >
>> > This change reverts
>> > 'commit 2b3ec7650584 ("cpufreq: intel_pstate: Enable PPC
>> > enforcement for
>> > servers")'
>> >
>> > Intel P State uses max P-State as the max turbo P-State. This max
>> > P-State
>> > can be limited by ACPI _PSS table entry 0. After
>> > 'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC
>> > limits")''
>> > the _PSS table entry[0] will be used to cap max performance for
>> > enterprise and performance server by default.
>> >
>> > Even though this is correct processing, but when the performance
>> > results
>> > are compared with the version before the above commit, then
>> > obviously the
>> > results will be worse, if the _PSS table entry 0 is not the max
>> > turbo
>> > P-State.
>> >
>> > So to minimize impact on performance, this revert will disable the
>> > default
>> > enforcement of ACPI _PSS and ACPI _PPC. So this feature can only
>> > only be
>> > explicitly activated by kernel command line
>> > intel_pstate=support_acpi_ppc
>> >
>> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
>> > .com>
>> Thanks for the revert, but I'm wondering if we can explore one more
>> option.
>>
>> Namely, if _PSS doesn't contain the turbo state, but we know the
>> turbo range is
>> there from the CPU, we can still use it and interpret _PPC for the
>> max state as
>> a permission to go into the turbo range.
>>
>> What do you think?
> Looks like a good idea. I will experiment. What is your deadline for
> -rc2 fixes?
> It will give me more time to experiment and test.

That need not be -rc2 as far as I'm concerned.  Reverts are the last
resort IMO, so please take your time.
