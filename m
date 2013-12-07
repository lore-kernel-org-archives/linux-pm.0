From: Len Brown <lenb@kernel.org>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Sat, 7 Dec 2013 11:01:30 -0500
Message-ID: <CAJvTdKkQUKFhwswK64PDNgPOMxP4s2X1GYKzWLW0G6gWxhdWtA@mail.gmail.com>
References: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
	<1386405590.5673.96.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:40179 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab3LGQBc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2013 11:01:32 -0500
In-Reply-To: <1386405590.5673.96.camel@marge.simpson.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <bitbucket@online.de>
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

On Sat, Dec 7, 2013 at 3:39 AM, Mike Galbraith <bitbucket@online.de> wrote:
> On Sat, 2013-12-07 at 03:00 -0500, Len Brown wrote:
>
>> No, Linux-3.13-rc3 does not fix this issue, even though it contains
>> the following patch, claiming to address an issue with the commit above:
>>
>> commit ea8117478918a4734586d35ff530721b682425be
>> Author: Peter Zijlstra <peterz@infradead.org>
>> Date:   Wed Sep 11 12:43:13 2013 +0200
>>
>>     sched, idle: Fix the idle polling state logic
>>
>>     Mike reported that commit 7d1a9417 ("x86: Use generic idle loop")
>>     regressed several workloads and caused excessive reschedule
>>     interrupts.
>
> It fixes that, except for my Q6600 box.  Too bad mwait_idle() went away,
> beloved old box doesn't play hints game, so it continues to flog itself.

Hi Mike,
What C-states are available on your Q6600 box?
Is it running HALT only?
(if so, I would expect C1 MWAIT be about the same, if it still existed)

But I would expect the box to have deeper C-states than just C1, so...

Can you show me the output of
dmesg | grep idle
grep . /sys/devices/system/cpu/cpu0/cpuidle/*/*

Please elaborate on exactly what symptom you see.
Do you have a power meter?

thanks,
Len Brown, Intel Open Source Technology Center
