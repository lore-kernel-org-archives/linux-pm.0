From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq regression due to dceff5c "cpufreq: fix serialization
 issues with freq change notifiers"
Date: Thu, 12 Sep 2013 05:56:38 +0530
Message-ID: <CAKohpomqKgQumyEHQuuZ+SUHHULkJaAj5pgw1TFLVLsZzba_2Q@mail.gmail.com>
References: <5230ECB4.2090306@wwwdotorg.org>
	<13389782.ui3WXEBqQV@vostro.rjw.lan>
	<5230F46B.7070006@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48620 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab3ILA0j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 20:26:39 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so9989094oah.25
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 17:26:39 -0700 (PDT)
In-Reply-To: <5230F46B.7070006@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 September 2013 04:23, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/11/2013 04:51 PM, Rafael J. Wysocki wrote:
>> On Wednesday, September 11, 2013 04:20:36 PM Stephen Warren wrote:
>>> One of the test cases I run (not often enough, hence I just noticed this
>>> late) is the following, to make sure our cpufreq driver is present, and
>>> adjusting the CPU clock as expected:
>>>
>>> # echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ;
>>> sleep 1 ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ;
>>> echo 216000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq  ;
>>> sleep 1 ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
>>>
>>> which prints the following when it works:
>>>
>>> 1000000
>>> 216000
>>>
>>> In next-20130909, that doesn't work, but instead prints:
>>>
>>> 216000
>>> 216000
>>>
>>> I've also seen the following during git bisect:
>>>
>>> 608000
>>> 608000
>>>
>>> ... and perhaps other unexpected sets of values.
>>
>> Can you please test the current linux-next?  I've reverted the commit that
>> dceff5c attempted to fix, so the output should be correct now.
>
> Yes, indeed next-20130911 works fine. Thanks, and sorry for the noise.

For the record this is where this problem is getting discussed:

https://lkml.org/lkml/2013/9/9/270
