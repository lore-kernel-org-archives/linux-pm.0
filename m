From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Tue, 12 Dec 2017 08:18:19 -0800
Message-ID: <000801d37364$d48f6ed0$7dae4c70$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> Of1qe6hVbC2CsOf1seMkbL
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:36316 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdLLQSY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Dec 2017 11:18:24 -0500
In-Reply-To: Of1qe6hVbC2CsOf1seMkbL
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Andy Tang' <andy.tang@nxp.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On 2017.12.11 23:31 Viresh Kumar wrote:
> On 12-12-17, 02:46, Andy Tang wrote:
>> Hi,
>> 
>> I run into a question that conservative governor can't work while ondemand governor works well.
>> When cpu load gets higher, if ondemand governor is used, cpu frequency can get higher and higher.
>> But if I use conservative governor, cpu frequency stays on lowest frequency no matter what cpu load is.
>> 
>> This issue was found on kernel 4.14.0, on kernel 4.9 kernel. It acts well.
>
> You mean to say that the problem exists on 4.14 but not on 4.9?
>
> Strange, as we haven't seen any such reports from anyone else.

Well, it is easy enough for us to check.
Indeed, it is broken in kernel 4.14-rc1, but O.K. in kernel 4.13.
It remains broken in kernel 4.15-rc1 (I am not on -rc3 yet).

Because it was easier for me to do so, I used intel_cpufreq (i.e. intel_pstate in passive mode).

>
>> I think it may related to cpufreq framework, not driver itself. Could you guys give me some clues on how to debug it?
>> I don't expect a direct answer; any suggestions are welcome.
>
> Please provide output of below:
>
> grep . /sys/devices/system/cpu/cpufreq/policy*/*
>
> And then you may need to bisect the problem as well by going to kernel version
> in between 4.9 and 4.14.

@Andy: Have you started bisecting the kernel yet? I suppose I could if you haven't,
or if you do not know how.

... Doug
