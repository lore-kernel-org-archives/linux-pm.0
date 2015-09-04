From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 4 Sep 2015 16:05:23 -0700
Message-ID: <000e01d0e766$2f07dfb0$8d179f10$@net>
References: <001401d0e691$302127b0$90637710$@net>	<3237049.urJsZkC6Rf@vostro.rjw.lan>	<20150904144241.GJ29194@linux>	<000701d0e741$5933c580$0b9b5080$@net> <CAJZ5v0iqX+Sh6rDNKW+Nm2hNnEnC7uvzhZ6ta9Qxc3Rs2CZPJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:49317 "EHLO cmta18.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934105AbbIDXF2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 19:05:28 -0400
In-Reply-To: <CAJZ5v0iqX+Sh6rDNKW+Nm2hNnEnC7uvzhZ6ta9Qxc3Rs2CZPJg@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On 2015.09.04 15:26 Rafael J. Wysocki wrote:
> On Fri, Sep 4, 2015 at 8:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2015.09.04 07:43 Viresh Kumar wrote:
>>> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
>>>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
>>>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
>>>>> CPU offline (7 in my case), the system will not suspend.
>
>>> @Doug: Can you please enable DEBUG for cpufreq with this:
>>>
>>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>>> index 9fde14544ead..c09945aa7f17 100644
>>> --- a/drivers/cpufreq/Makefile
>>> +++ b/drivers/cpufreq/Makefile
>>> @@ -1,3 +1,4 @@
>>> +subdir-ccflags-y  := -DDEBUG
>>> # CPUfreq core
>>> obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>>>
>>>
>>> And give us the outputs of both successful and unsuccessful logs?
>>
>> Edited /var/log/kern.log attached (might get stripped for
>> on-list e-mail deliveries)

> Hmm.
> I suspect that your user space does something that fails during the pm-suspend.

Are you saying that the patch might be O.K., but reveals
and issue with pm-suspend that was always there?

> Instead of invoking the pm-suspend command, can you simply do (as root)
> # echo mem > /sys/power/state
> and see if that behaves in the same way?

With CPU 7 offline, that method seems to suspend just fine.
I did not check any other scenarios.


