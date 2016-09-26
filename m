From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Tue, 27 Sep 2016 00:16:13 +0200
Message-ID: <CAJZ5v0g++0JaPUEaQy54_fcA5tv5TuNZw+5mbmo47OY-dD8HoQ@mail.gmail.com>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan> <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan> <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <CAJZ5v0iEchM2ye==020gLj2bZc3ddCFa29jQZh6c+9X+OhfcoQ@mail.gmail.com> <594f5012-5157-bfdd-f715-bea8caa824c3@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34150 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934582AbcIZWQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 18:16:16 -0400
In-Reply-To: <594f5012-5157-bfdd-f715-bea8caa824c3@lwfinger.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, Sep 27, 2016 at 12:09 AM, Larry Finger
<Larry.Finger@lwfinger.net> wrote:
> On 09/26/2016 04:37 PM, Rafael J. Wysocki wrote:
>>
>> On Mon, Sep 26, 2016 at 11:28 PM, Larry Finger
>> <Larry.Finger@lwfinger.net> wrote:
>>>
>>> On 09/26/2016 04:06 PM, Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Monday, September 26, 2016 11:15:45 AM Larry Finger wrote:

[cut]

>>>
>>> Mostly I use a KDE applet named "System load" and look at the "average
>>> clock", but the same info is also available in /proc/cpuinfo as "cpu
>>> MHz".
>>> When the bug triggers, the system gets very slow, and the cpu fan stops
>>> even
>>> though the cpu is still busy.
>>
>>
>> That sounds like thermal throttling kicking in.
>
>
> I think it is because the cpu is idling. If a thermal throttling is
> responsible, why would it not fail for 168 hours, and then fail in 2?
>
>> What's there under /sys/class/thermal/ on your system?
>
>
> It contains the following directories:
>
> cooling_device0  cooling_device1  cooling_device2  cooling_device3
> cooling_device4  thermal_zone0  thermal_zone1
>>
>>
>>> Commit f7816ad, which had run for 7 days without showing the bug, failed
>>> after about 2 hours today. All my testing since Sept. 9 has been wasted.
>>> Oh
>>> well, that's the way it goes!
>>
>>
>> Are you confident that the issue was not reproducible before 4.8-rc2?
>> In particular, what about 4.8-rc1?
>
>
> 4.8-rc1 is definitely bad. I am now testing commit 5539204. In the bisect
> visualization, there are a number of cpufreq commits before the test case.

Maybe it's better to try diagnose the problem instead of spending more
time on bisection.

I'd like to know whether or not 4.7 was definitely good, though.

> If it is one of them, it may be a while before I dare call this one "good".
> In one respect, that is good as I will be traveling tomorrow and Wednesday.

What does "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver" say?

Thanks,
Rafael
