From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Synchronize sysfs limits
Date: Mon, 14 Nov 2016 23:11:39 +0100
Message-ID: <CAJZ5v0jUD7iDC6zY8USgDw=Z_0+nDnS-7DMCXLKxGSsG+Wz-BA@mail.gmail.com>
References: <1478909495-57026-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0j8CQk8tbxsCA_R0M2RJ4u58UexQkb7Waq4qRYQdRcw1A@mail.gmail.com> <1479161257.6544.33.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34505 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933656AbcKNWLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 17:11:41 -0500
Received: by mail-qk0-f194.google.com with SMTP id 124so13612610qkh.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2016 14:11:40 -0800 (PST)
In-Reply-To: <1479161257.6544.33.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Mon, Nov 14, 2016 at 11:07 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2016-11-14 at 02:04 +0100, Rafael J. Wysocki wrote:
>> On Sat, Nov 12, 2016 at 1:11 AM, Srinivas Pandruvada
>>
> [...]
>> +       get_online_cpus();
>> > +       for_each_online_cpu(cpu) {
>> > +               if (all_cpu_data[cpu])
>> > +                       cpufreq_update_policy(cpu);
>>
>> cpufreq_update_policy() calls cpufreq_cpu_get() to get the policy
>> anyway which does the requisite policy existence check (although it
>> is
>> a bit racy now, but that's a bug in there that we should not have to
>> work around here), so it should be sufficient to do this
>> for_each_possible_cpu() without additional locking.
>>
> I will change in the next patch set.

Wait, wait, there's a better way I think, but I'll need to send a
patch to explain what I mean. :-)  Will do that shortly.

Thanks,
Rafael
