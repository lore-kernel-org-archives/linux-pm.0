From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Mon, 18 Dec 2017 19:18:21 -0800
Message-ID: <CAJWu+ooGRedM_w6xBwhb+ype0SMmM8w-uEjjpzaTWmp-GueZDg@mail.gmail.com>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan> <20171218045945.GG19815@vireshk-i7>
 <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
 <20171218115943.GL19815@vireshk-i7> <20171218121453.GH19821@e110439-lin> <20171219031237.GM19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36910 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934850AbdLSDSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 22:18:23 -0500
Received: by mail-io0-f194.google.com with SMTP id d16so12063444iob.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 19:18:23 -0800 (PST)
In-Reply-To: <20171219031237.GM19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Viresh,

On Mon, Dec 18, 2017 at 7:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-12-17, 12:14, Patrick Bellasi wrote:
>> For example, swithing from:
>>
>>  - void (*func)(struct update_util_data *data, u64 time,
>>  -              unsigned int flags))
>>  + void (*func)(struct update_util_data *data, u64 time,
>>  +              unsigned int flags, bool set))
>>
>> Where the additional boolean is actually used to define which
>> operation we wanna perform on the flags?
>
> The code will eventually have the same complexity or ugliness in both
> the cases. I would like to start with another flag for now and see if
> people prefer another parameter.

Though I think that will solve Rafael's concern of polluting the flags
for something schedutil specific. I also feel adding extra callback
parameter is cleaner than 2 new clear flags.

Thanks,

- Joel
