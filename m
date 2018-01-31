From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
Date: Wed, 31 Jan 2018 10:33:55 +0100
Message-ID: <11334876-ef8c-58fa-5e32-ab8499eebd7e@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <CAKfTPtD-cUYoAJfhtuTr-E1=rttZvWxVv1Qv7b+Si4vSBy0JVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:40914 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbeAaJd7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jan 2018 04:33:59 -0500
Received: by mail-wm0-f53.google.com with SMTP id v123so6554647wmd.5
        for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2018 01:33:59 -0800 (PST)
In-Reply-To: <CAKfTPtD-cUYoAJfhtuTr-E1=rttZvWxVv1Qv7b+Si4vSBy0JVg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kevin Wangtao <kevin.wangtao@linaro.org>, Leo Yan <leo.yan@linaro.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On 31/01/2018 10:01, Vincent Guittot wrote:
> Hi Daniel,
> 
> On 23 January 2018 at 16:34, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ] (please trim :)

>> +               /*
>> +                * Each cooling device is per package. Each package
>> +                * has a set of cpus where the physical number is
>> +                * duplicate in the kernel namespace. We need a way to
>> +                * address the waitq[] and tsk[] arrays with index
>> +                * which are not Linux cpu numbered.
>> +                *
>> +                * One solution is to use the
>> +                * topology_core_id(cpu). Other solution is to use the
>> +                * modulo.
>> +                *
>> +                * eg. 2 x cluster - 4 cores.
>> +                *
>> +                * Physical numbering -> Linux numbering -> % nr_cpus
>> +                *
>> +                * Pkg0 - Cpu0 -> 0 -> 0
>> +                * Pkg0 - Cpu1 -> 1 -> 1
>> +                * Pkg0 - Cpu2 -> 2 -> 2
>> +                * Pkg0 - Cpu3 -> 3 -> 3
>> +                *
>> +                * Pkg1 - Cpu0 -> 4 -> 0
>> +                * Pkg1 - Cpu1 -> 5 -> 1
>> +                * Pkg1 - Cpu2 -> 6 -> 2
>> +                * Pkg1 - Cpu3 -> 7 -> 3
> 
> 
> I'm not sure that the assumption above for the CPU numbering is safe.
> Can't you use a per cpu structure to point to resources that are per
> cpu instead ? so you will not have to rely on CPU ordering

Can you elaborate ? I don't get the part with the percpu structure.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
