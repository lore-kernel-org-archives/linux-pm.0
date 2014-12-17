From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Wed, 17 Dec 2014 17:12:43 -0500
Message-ID: <CAJvTdKn71M8edzdereUnDTESxJTpgdLXZjFAULO=aQTA0wnpdA@mail.gmail.com>
References: <20141211081438.GA2885@intel-desktop>
	<CAJvTdKmCwJTWE4t9YuWn+OLxG5EWZDXo5LZ1Bxq45ECiOvQmsA@mail.gmail.com>
	<20141216102444.GA16158@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:47924 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaLQWMo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 17:12:44 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so7559677yho.33
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 14:12:43 -0800 (PST)
In-Reply-To: <20141216102444.GA16158@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

>> policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
>
> But we know the transition latency of this system. Why should we
> claim it as "unknown"? The sfi_freq_table_entry has latency
> field - does it not make irrelevant then?

I wrote the SFI spec.
If I did it again, I would not include the latency field in the FREQ table,
because Linux does not need it.

>> ondemand will compare this to TRANSITION_LATENCY_LIMIT (10 * 1000 * 1000)
>> and since -1 is less than 10,000,000; it will be happy.
>>
>> > +       for (i = 0; i < num_freq_table_entries; i++) {
>> > +               /* detect transition latency */
>> > +               if ((sfi_cpufreq_array[i].latency * 1000) >
>> > +                   policy->cpuinfo.transition_latency)
>> > +                       policy->cpuinfo.transition_latency =
>> > +                               sfi_cpufreq_array[i].latency * 1000;
>>
>> delete above 5 lines.  every SFI system will have latency
>> plenty lower than that required by ondemand governor.

There is effectively no customer for the information being provided,
as there are only two possible outcomes:

1. The largest value in the table is < 10ms, and ondemand loads
2. The largest value in the table is > 10ms and ondemand fails to load.
#1 is how it should always work on all known SFI platforms.
#2 is a firmware bug.

Well, we can do #1 with 1 line, and at the same time eliminate
exposure to firmware bugs in #2.
Less is more, the choice is simple.

thanks,
Len Brown, Intel Open Source Technology Center
