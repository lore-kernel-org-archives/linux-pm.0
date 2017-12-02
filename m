From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Sat, 2 Dec 2017 13:56:47 +0100
Message-ID: <17b7bd4f-6b4d-2561-8895-f1dd32f9a171@tu-dresden.de>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
 <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net>
 <002c01d35d0f$8b0416f0$a10c44d0$@net> <000a01d3654a$c4996990$4dcc3cb0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout6.zih.tu-dresden.de ([141.30.67.75]:52587 "EHLO
        mailout6.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751692AbdLBM4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Dec 2017 07:56:52 -0500
In-Reply-To: <000a01d3654a$c4996990$4dcc3cb0$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Len Brown' <lenb@kernel.org>
Cc: 'Yu Chen' <yu.c.chen@intel.com>, =?UTF-8?Q?'Marcus_H=c3=a4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=c3=b6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org

Doug,

thank you so much for the detailed performance investigation! I think the
results are consistent with my expectations.

> @All: I am just trying to get some baseline data here, I am not suggesting
> either patch is in a final form. For my idle state 0 patch (further below)
> I seek help to move the concept to a real robust patch.

I would also like to help towards a joint patch that addresses both aspects.
It seems we need to figure out two key questions on which I would like to
get feedback from the experienced folks, particularly @Len Brown to make
sure the patch can be merged:

1) Regarding C1+ issues
The suggestion to keep the scheduling ticks running instead of using an
additional fallback timer seems very reasonable. But how can we achieve that
across the different software layers, particularly given that the tick-timer
is disabled early in the outer idle-loop in do_idle, whereas the decision is
made later in the governor?

2) Regarding C0 / poll_idle
What is a suitable abort criterion for the idle loop? We discussed
interrupt counts / tick_nohz_get_sleep_length / tick_sched->idle_expires



> @Yu: among other things, off-list you asked for some benchmark data. See below.
> 
> @Thomas: I did several phoronix tests with a kernel with both your patch,
> for idle states deeper than 0, and my patch, specific to idle state 0.
> Every test was done with a stock 4.14 kernel and a patched kernel with:
> The Thomas part disabled; The default Thomas setting of 10000 uSec
> timeout; A Thomas setting of 1000 uSec timeout; Idle states 0,1,2,3
> disabled (my system max is state 4). I have yet to find a good phoronix
> test to demonstrate the idle states deeper than 0 improvements. There was
> never a degradation (other than already listed below) due to your patch.

I assume the benchmarks normally fully utilize at least one CPU. In that
case I would not expect a noticeable energy / performance difference.
The large differences in power consumption we observe in the original
scenario are due to package C-states - which are prevented by the active
core in the phoronix tests. The deep C-State powernightmares we noticed
are inherently difficult to benchmark / show a high variability and lots
of factors can influence the trigger pattern. That's why we used the
synthetic code to generate quantitative numbers, while showing that they
do occur in principle on production systems.

Best,
Thomas
