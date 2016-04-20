From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Wed, 20 Apr 2016 08:48:41 +0800
Message-ID: <CANRm+Cy_KXSJqsgQ7BkxB8PrtQHUZ3VBmLr6MY3gno6_PVk8rA@mail.gmail.com>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
	<6087716.bi8vDPiZNy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32973 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbcDTAsm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 20:48:42 -0400
In-Reply-To: <6087716.bi8vDPiZNy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

2016-04-20 8:32 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Monday, April 18, 2016 01:51:24 PM Wanpeng Li wrote:
>> Sometimes update_curr() is called w/o tasks actually running, it is
>> captured by:
>>       u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>> We should not trigger cpufreq update in this case for rt/deadline
>> classes, and this patch fix it.
>>
>> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>
> The signed-off-by tag should agree with the From: header.  One way to achieve
> that is to add an extra From: line at the start of the changelog.

Thanks for the tip Rafael, just send out v2 to fix it.

Regards,
Wanpeng Li
