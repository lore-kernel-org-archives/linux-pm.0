From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Tue, 19 Dec 2017 08:42:37 +0530
Message-ID: <20171219031237.GM19815@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan>
 <20171218045945.GG19815@vireshk-i7>
 <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
 <20171218115943.GL19815@vireshk-i7>
 <20171218121453.GH19821@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42103 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936042AbdLSDMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 22:12:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id q67so795634pga.9
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 19:12:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171218121453.GH19821@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-12-17, 12:14, Patrick Bellasi wrote:
> For example, swithing from:
> 
>  - void (*func)(struct update_util_data *data, u64 time,
>  -              unsigned int flags))
>  + void (*func)(struct update_util_data *data, u64 time,
>  +              unsigned int flags, bool set))
> 
> Where the additional boolean is actually used to define which
> operation we wanna perform on the flags?

The code will eventually have the same complexity or ugliness in both
the cases. I would like to start with another flag for now and see if
people prefer another parameter.

-- 
viresh
