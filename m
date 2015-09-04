From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Sat, 5 Sep 2015 00:26:08 +0200
Message-ID: <CAJZ5v0iqX+Sh6rDNKW+Nm2hNnEnC7uvzhZ6ta9Qxc3Rs2CZPJg@mail.gmail.com>
References: <001401d0e691$302127b0$90637710$@net>
	<3237049.urJsZkC6Rf@vostro.rjw.lan>
	<20150904144241.GJ29194@linux>
	<000701d0e741$5933c580$0b9b5080$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36778 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760655AbbIDW0J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 18:26:09 -0400
Received: by wibz8 with SMTP id z8so30417344wib.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 15:26:08 -0700 (PDT)
In-Reply-To: <000701d0e741$5933c580$0b9b5080$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Saravana Kannan <skannan@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Sep 4, 2015 at 8:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2015.09.04 07:43 Viresh Kumar wrote:
>> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
>>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
>>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
>>>> CPU offline (7 in my case), the system will not suspend.
>
>> I wanted to give him some patch to debug it a bit more, but couldn't
>> do that whole day.
>
>> @Doug: Can you please enable DEBUG for cpufreq with this:
>>
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 9fde14544ead..c09945aa7f17 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -1,3 +1,4 @@
>> +subdir-ccflags-y  := -DDEBUG
>> # CPUfreq core
>> obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>>
>>
>> And give us the outputs of both successful and unsuccessful logs?
>
> Edited /var/log/kern.log attached (might get stripped for
> on-list e-mail deliveries)

Hmm.

I suspect that your user space does something that fails during the pm-suspend.

Instead of invoking the pm-suspend command, can you simply do (as root)

# echo mem > /sys/power/state

and see if that behaves in the same way?

Thanks,
Rafael
