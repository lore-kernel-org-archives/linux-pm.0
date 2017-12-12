From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Ask for help on governor
Date: Tue, 12 Dec 2017 17:51:25 +0100
Message-ID: <CAJZ5v0iXsPgVcyBdvEG8EWRo8bCiD2wbywBG6Rbfh7jqRBPujg@mail.gmail.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:45191 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbdLLQv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 11:51:26 -0500
Received: by mail-ot0-f175.google.com with SMTP id 103so18337275otj.12
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 08:51:26 -0800 (PST)
In-Reply-To: <000801d37364$d48f6ed0$7dae4c70$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Andy Tang <andy.tang@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Tue, Dec 12, 2017 at 5:18 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2017.12.11 23:31 Viresh Kumar wrote:
>> On 12-12-17, 02:46, Andy Tang wrote:
>>> Hi,
>>>
>>> I run into a question that conservative governor can't work while ondemand governor works well.
>>> When cpu load gets higher, if ondemand governor is used, cpu frequency can get higher and higher.
>>> But if I use conservative governor, cpu frequency stays on lowest frequency no matter what cpu load is.
>>>
>>> This issue was found on kernel 4.14.0, on kernel 4.9 kernel. It acts well.
>>
>> You mean to say that the problem exists on 4.14 but not on 4.9?
>>
>> Strange, as we haven't seen any such reports from anyone else.
>
> Well, it is easy enough for us to check.
> Indeed, it is broken in kernel 4.14-rc1, but O.K. in kernel 4.13.
> It remains broken in kernel 4.15-rc1 (I am not on -rc3 yet).
>
> Because it was easier for me to do so, I used intel_cpufreq (i.e. intel_pstate in passive mode).
>
>>
>>> I think it may related to cpufreq framework, not driver itself. Could you guys give me some clues on how to debug it?
>>> I don't expect a direct answer; any suggestions are welcome.
>>
>> Please provide output of below:
>>
>> grep . /sys/devices/system/cpu/cpufreq/policy*/*
>>
>> And then you may need to bisect the problem as well by going to kernel version
>> in between 4.9 and 4.14.
>
> @Andy: Have you started bisecting the kernel yet? I suppose I could if you haven't,
> or if you do not know how.

There is only one commit touching conservative in 4.14:

2d045036322c cpufreq: governor: Drop min_sampling_rate

Maybe try to revert this one?
