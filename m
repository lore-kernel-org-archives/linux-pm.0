From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Tue, 27 Sep 2016 02:21:34 +0200
Message-ID: <CAJZ5v0hzRCqsE-Wg4aTPPF_+=o+io_P8M-D4_pu5qpDxaXAy5A@mail.gmail.com>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan> <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan> <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <CAJZ5v0iEchM2ye==020gLj2bZc3ddCFa29jQZh6c+9X+OhfcoQ@mail.gmail.com>
 <594f5012-5157-bfdd-f715-bea8caa824c3@lwfinger.net> <CAJZ5v0g++0JaPUEaQy54_fcA5tv5TuNZw+5mbmo47OY-dD8HoQ@mail.gmail.com>
 <e42f36f7-5bf4-fdc4-12a7-a2d6a645e82e@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34499 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755474AbcI0AVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 20:21:37 -0400
In-Reply-To: <e42f36f7-5bf4-fdc4-12a7-a2d6a645e82e@lwfinger.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, Sep 27, 2016 at 1:53 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> On 09/26/2016 05:16 PM, Rafael J. Wysocki wrote:
>>
>> On Tue, Sep 27, 2016 at 12:09 AM, Larry Finger
>
> <Larry.Finger@lwfinger.net> wrote:
>>
>>
>> Maybe it's better to try diagnose the problem instead of spending more
>> time on bisection.
>
>
> In my original post, I asked for such help, but nothing until today. I had
> no idea what to check, but now I have a better idea.
>
>> I'd like to know whether or not 4.7 was definitely good, though.
>
>
> I never saw this problem with 4.7, but given the difficulty in triggering
> the problem, my tests may not have been definitive.
>>
>>
>>> If it is one of them, it may be a while before I dare call this one
>>> "good".
>>> In one respect, that is good as I will be traveling tomorrow and
>>> Wednesday.
>>
>>
>> What does "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver" say?
>
>
> intel_pstate

You probably don't need to worry about all of the cpufreq changes in
4.8-rc, then.  Only a few of them affect intel_pstate and I don't see
how any of them may lead to the observed symptoms.

First off, if you have a reproducer, please run it on 4.7 and see if
you can trigger the issue in there.

Second, it would be good to have a look at the output from the
cpu_frequency and pstate_sample tracepoints around when the issue
triggers.  The pstate_sample one would be more interesting.

But for both we need a reproducer anyway.

It also would be good to rule out the thermal throttling (as per the
Srinivas' comments).

For now, please tell me what's in
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq

Thanks,
Rafael
