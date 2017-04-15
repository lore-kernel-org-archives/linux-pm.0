From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent
 transition delays
Date: Fri, 14 Apr 2017 19:23:46 -0700
Message-ID: <CAJWu+opFKUS4WSqZu0iG_0W5ou8sry-9YYx6L1sSuvzvH2s-ag@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2407280.n9qVSLCrF5@aspire.rjw.lan>
 <71055380.gdY33coAtF@aspire.rjw.lan> <2817661.LjrBZf7NNr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34271 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbdDOCXr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 22:23:47 -0400
Received: by mail-vk0-f43.google.com with SMTP id n73so208929vke.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 19:23:47 -0700 (PDT)
In-Reply-To: <2817661.LjrBZf7NNr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Brendan Jackman <brendan.jackman@arm.com>

On Fri, Apr 14, 2017 at 3:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, April 11, 2017 12:20:41 AM Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make the schedutil governor take the initial (default) value of the
>> rate_limit_us sysfs attribute from the (new) transition_delay_us
>> policy parameter (to be set by the scaling driver).
>>
>> That will allow scaling drivers to make schedutil use smaller default
>> values of rate_limit_us and reduce the default average time interval
>> between consecutive frequency changes.
>>
>> Make intel_pstate set transition_delay_us to 500.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> This is a replacement for https://patchwork.kernel.org/patch/9671831/
>
> Any concerns about this one?

Looks good to me.

Thanks,
Joel
