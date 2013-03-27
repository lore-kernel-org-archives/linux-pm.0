From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/4] cpufreq: governor: Implement per policy instances
 of governors
Date: Wed, 27 Mar 2013 20:07:15 +0530
Message-ID: <CAKohponLA=LJbUmrrw2oLPKTm9ekrkGGWsZgC+4ik9nBW3pAWw@mail.gmail.com>
References: <cover.1362381470.git.viresh.kumar@linaro.org>
	<0823a96fea2d8284b7d83cee390dd5973fdaaa94.1362381470.git.viresh.kumar@linaro.org>
	<CAKohponTZ29BX6CrUvFMy9RXV==0wRFu4C-W1xd6t1RmLASTvQ@mail.gmail.com>
	<2565053.YP0dCLmaW9@vostro.rjw.lan>
	<20130326152059.GA1698@jshin-Toonie>
	<CAKohpons4Tr8F2RuRGCxbOFmJaK9YbAafV-3v6=cijRupe2hUA@mail.gmail.com>
	<20130326194832.GB24945@jshin-Toonie>
	<CAKohpomaTLPZjxcTGKo2mmcqgPvqQVsj1778X1u2rbb3wV+phA@mail.gmail.com>
	<CAKohpo=A4BBecmepsYSqHYrJg5n9WE-QB3ssvb_dOBZYXuB-eg@mail.gmail.com>
	<CAKohpok6PsvmixDUEoWMTCOWxOPH9vfeJwee0VcQJ-=JGib7VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62918 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3C0OhQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 10:37:16 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so8211298obb.17
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 07:37:16 -0700 (PDT)
In-Reply-To: <CAKohpok6PsvmixDUEoWMTCOWxOPH9vfeJwee0VcQJ-=JGib7VA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Arvind Chauhan <Arvind.Chauhan@arm.com>

On 27 March 2013 17:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27 March 2013 15:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> I am still stuck at a issue, which i am not able to fix.
>> - cat of */cpufreq/ondemand/** isn't showing anything on console, but all
>>   pointers are correctly set and i can see the right values with printk()
>
> The culprit is the part where i changed prototypes of all show/store functions.
> I am still trying to understand how that part works, and will fix it soon.

It seems i have broken some other stuff too with this patch:

commit 63173d01761a442ac5a7c73de996acbe9b0b3da7
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Feb 6 15:37:37 2013 +0530

    cpufreq: Get rid of "struct global_attr"

    We don't need to keep two structures for file attributes, global_attr and
    freq_attr. Lets use freq_attr only for cpufreq core and drivers.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |  9 ++++-----
 drivers/cpufreq/intel_pstate.c | 20 ++++++++++----------
 include/linux/cpufreq.h        | 16 ----------------

Atleast both acpi-cpufreq and intel_pstate (including cpufreq as a whole). :(

And i don't want to post any more fixups now.. they are huge and will create
more confusion..

Rather i will send next version of my patchset and ask Rafael to drop earlier
patches.

Will cc you, please try them at your end.

--
viresh
