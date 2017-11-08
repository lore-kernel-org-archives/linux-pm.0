From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Wed, 8 Nov 2017 08:26:01 -0800
Message-ID: <001d01d358ae$46756990$d3603cb0$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> CCuzeI4ZRt1L5CCv4eEEwJ
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:59989 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbdKHQ0H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Nov 2017 11:26:07 -0500
In-Reply-To: CCuzeI4ZRt1L5CCv4eEEwJ
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: =?UTF-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>, 'Yu Chen' <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>

Hi Thomas,

Thanks for your follow up and detailed information.
I have continued to work on this during these 2+ weeks,
but was unable to get to the root cause.

On 2017.11.07 15:04 Thomas Ilsche wrote:

> thanks to your detailed description I was able to reproduce and track down the
> issue on one of our systems with a similar processor. The effect is similar, the
> core stays in a shallow sleep state for too long.
> This is also amplified on a system with little background noise where a core
> can stay in C0 for seconds.

Agreed.

> But the cause / trigger is different.

Agreed.

> By my observation with many perf probes,
> the next timer is preventing a deep sleep, also overriding the anti-poll
> mechanism.

Agreed, but haven't been able to figure out why. Yu's e-mail on this point
is very interesting.

> This immediate (usually 1-3 us) timer can be both tick_sched_timer and
> watchdog_timer_fn. The timers actually do happen and run, however poll_idle
> directly resumes after the interrupt - there is no need_resched(). The menu
> governor assumes that a timer will trigger another menu_select, but it does not.
> Neither does our fallback timer - so the mitigation.

Agreed.

> I made a hack[1] to stop poll_idle after timer_expires which prevents the issue
> in my tests.

I did a similar test with the same results. In my case I just used an old
proposed patch from Rik van Riel [2] (well, rebased to current).

However, I still wanted to understand why this issue occurs in the first
place, because and as far as could tell, it shouldn't.
This is where I got stuck.

...[snip]...

... Doug

[2] https://marc.info/?l=linux-pm&m=145834176720176&w=2
