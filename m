From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: CPPC: Correct desired_perf calculation
Date: Thu, 13 Oct 2016 23:12:09 +0200
Message-ID: <CAJZ5v0jiRwgRherPXDQoV8kCdDZrW-1sv4p92vs6zJiwn7f4tQ@mail.gmail.com>
References: <1476380015-21001-1-git-send-email-hotran@apm.com> <b027d9b7-67c5-68e7-d412-1f22edef34cc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34895 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756854AbcJMVML (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 17:12:11 -0400
In-Reply-To: <b027d9b7-67c5-68e7-d412-1f22edef34cc@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: Hoan Tran <hotran@apm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Al Stone <ahs3@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lho@apm.com, Duc Dang <dhdang@apm.com>, Christopher Covington <cov@codeaurora.org>

On Thu, Oct 13, 2016 at 9:37 PM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> On 10/13/2016 11:33 AM, Hoan Tran wrote:
>> The desired_perf is an abstract performance number. Its value should
>> be in the range of [lowest perf, highest perf] of CPPC.
>> The correct calculation is
>>   desired_perf = freq * cppc_highest_perf / cppc_dmi_max_khz
>>
>> And cppc_cpufreq_set_target() returns if desired_perf is exactly
>> the same with the old perf.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
> Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>
>
> Hi Rafael,
> Can you please pick this one for 4.9, as it is bug fix?

Sure, I will queue it up.

Thanks,
Rafael
