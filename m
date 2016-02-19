From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/12] cpufreq: governor: Close dbs_data update race condition
Date: Fri, 19 Feb 2016 03:34:09 +0100
Message-ID: <CAJZ5v0gbraK-dwsxeAmE-GUxWnoS=5EdOOCKecptDpFPFpKBfA@mail.gmail.com>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
	<1592265.QLnTJA45ZD@vostro.rjw.lan>
	<20160218052409.GG2610@vireshk-i7>
	<CAJZ5v0jFP5hdcomAw1GcMgVAhw1mnwpZ3vdM7vN59SFkiug_YA@mail.gmail.com>
	<20160219022721.GA16983@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36069 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946891AbcBSCeL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 21:34:11 -0500
In-Reply-To: <20160219022721.GA16983@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Feb 19, 2016 at 3:27 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-02-16, 17:20, Rafael J. Wysocki wrote:
>> On Thu, Feb 18, 2016 at 6:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 18-02-16, 02:19, Rafael J. Wysocki wrote:
>
>> >> @@ -112,7 +112,7 @@ static ssize_t governor_store(struct kob
>> >>
>> >>       mutex_lock(&dbs_data->mutex);
>> >>
>> >> -     if (gattr->store)
>> >> +     if (dbs_data->usage_count && gattr->store)
>> >
>> > That's not gonna be enough. The above lock doesn't guarantee
>> > protection with any such races.
>
> Oops, I completely misread it. Really sorry about that.
>
> But now that I have read the code again, I wonder why we need this protection at
> all. The first thing we do after decrementing the usage_count counter, is we put
> the kobject. Which will ensure that the sysfs files are all gone. So, what is
> the race we are trying to fix then?

The ->store() callbacks for different attributes may do silly stuff
like walking all CPUs in the system and updating per-CPU data for
them.  If the dbs_data the callback has been called for is going away,
this is pointless at best and may be actually harmful depending on
what the callback is really doing.

Thanks,
Rafael
