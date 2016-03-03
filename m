From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 13:37:59 -0800
Message-ID: <56D8AEB7.2050100@linaro.org>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAKfTPtAtF4Yax9RrwjqfPqpfhtUxYRb-PDj+B_sZehEfQgsSsQ@mail.gmail.com>
 <56D89952.1010606@linaro.org>
 <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33771 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbcCCViD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 16:38:03 -0500
Received: by mail-pa0-f53.google.com with SMTP id fl4so21669765pad.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 13:38:02 -0800 (PST)
In-Reply-To: <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>

On 03/03/2016 12:20 PM, Rafael J. Wysocki wrote:
>> Here is a comparison, with frequency invariance, of ondemand and
>> interactive with schedfreq and schedutil. The first two columns (run and
>> period) are omitted so the table will fit.
>>
>>         ondemand        interactive     schedfreq       schedutil
>> busy %  OR      OH      OR      OH      OR      OH      OR      OH
>> 1.00%   0       68.96%  0       100.04% 0       78.49%  0       95.86%
>> 1.00%   0       25.04%  0       22.59%  0       72.56%  0       71.61%
>> 10.00%  0       21.75%  0       63.08%  0       52.40%  0       41.78%
>> 10.00%  0       12.17%  0       14.41%  0       17.33%  0       47.96%
>> 10.00%  0       2.57%   0       2.17%   0       0.29%   0       26.03%
>> 18.18%  0       12.39%  0       9.39%   0       17.34%  0       31.61%
>> 19.82%  0       3.74%   0       3.42%   0       12.26%  0       29.46%
>> 40.00%  2       6.26%   1       12.23%  0       6.15%   0       12.93%
>> 40.00%  0       0.47%   0       0.05%   0       2.68%   2       14.08%
>> 40.00%  0       0.60%   0       0.50%   0       1.22%   0       11.58%
>> 55.56%  2       4.25%   5       5.97%   0       2.51%   0       7.70%
>> 55.56%  0       1.89%   0       0.04%   0       1.71%   6       8.06%
>> 55.56%  0       0.50%   0       0.47%   0       1.82%   5       6.94%
>> 75.00%  2       1.65%   1       0.46%   0       0.26%   56      3.59%
>> 75.00%  0       1.68%   0       0.05%   0       0.49%   21      3.94%
>> 75.00%  0       0.28%   0       0.23%   0       0.62%   4       4.41%
>>
>> Aside from the 2nd and 3rd tests schedutil is showing decreased
>> performance across the board. The fifth test is particularly bad.
> 
> I guess you mean performance in terms of the overhead?

Correct. This overhead metric describes how fast the workload completes,
with 0% equaling the perf governor and 100% equaling the powersave
governor. So it's a reflection of general performance using the
governor. It's called "overhead" I imagine (the metric predates my
involvement) as it is something introduced/caused by the policy of the
governor.

thanks,
Steve
