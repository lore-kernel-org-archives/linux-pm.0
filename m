From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 17 Oct 2014 08:09:31 -0400
Message-ID: <544106FB.1000105@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com> <5437C12D.1070803@redhat.com> <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com> <5437C535.3070707@redhat.com> <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com> <5437C778.4040108@redhat.com> <1412942496.13463.28.camel@x200t> <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com> <1412947425.13463.37.camel@x200t> <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com> <1412949926.13463.47.camel@x200t> <CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com> <543D0C43.3070701@redhat.com> <CAKohpon9Gec8++oKjq7Hcr4rdgQ1=c+qhCB+f5tuz7Ni=aPuWg@
 mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbaJQMJv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Oct 2014 08:09:51 -0400
In-Reply-To: <CAKohpon9Gec8++oKjq7Hcr4rdgQ1=c+qhCB+f5tuz7Ni=aPuWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/16/2014 06:57 AM, Viresh Kumar wrote:
> On 14 October 2014 17:12, Prarit Bhargava <prarit@redhat.com> wrote:
>> I've been running both my test and Robert's test for about 5 mins.  In Robert's
>> case I don't see any problems ... in my case I do occasionally get a system
>> panic because of the sysfs access race I described in the other thread (cpu 1
>> holds a sysfs file open, while cpu 2 changes the governor ...)
> 
> Can you give me the exact script? I wasn't able to reproduce it.


#!/bin/bash

i=0
while [ True ]; do
        i=$((i+1))
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
        echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
        echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
        echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
        if [ $((i % 100)) = 0 ]; then
                echo $i
        fi
done


P.
