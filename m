From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 3 Mar 2016 15:21:07 +0100
Message-ID: <20160303142107.GA10948@gmail.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36232 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbcCCOVM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 09:21:12 -0500
Content-Disposition: inline
In-Reply-To: <1456190570-4475-4-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>


* Steve Muckle <steve.muckle@linaro.org> wrote:

> From: Michael Turquette <mturquette@baylibre.com>
> 
> Scheduler-driven CPU frequency selection hopes to exploit both
> per-task and global information in the scheduler to improve frequency
> selection policy, achieving lower power consumption, improved
> responsiveness/performance, and less reliance on heuristics and
> tunables. For further discussion on the motivation of this integration
> see [0].
> 
> This patch implements a shim layer between the Linux scheduler and the
> cpufreq subsystem. The interface accepts capacity requests from the
> CFS, RT and deadline sched classes. The requests from each sched class
> are summed on each CPU with a margin applied to the CFS and RT
> capacity requests to provide some headroom. Deadline requests are
> expected to be precise enough given their nature to not require
> headroom. The maximum total capacity request for a CPU in a frequency
> domain drives the requested frequency for that domain.
> 
> Policy is determined by both the sched classes and this shim layer.
> 
> Note that this algorithm is event-driven. There is no polling loop to
> check cpu idle time nor any other method which is unsynchronized with
> the scheduler, aside from an optional throttling mechanism.
> 
> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
> code and test results, and to Ricky Liang <jcliang@chromium.org>
> for initialization and static key inc/dec fixes.
> 
> [0] http://article.gmane.org/gmane.linux.kernel/1499836
> 
> [smuckle@linaro.org: various additions and fixes, revised commit text]
> 
> CC: Ricky Liang <jcliang@chromium.org>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  drivers/cpufreq/Kconfig      |  21 ++
>  include/linux/cpufreq.h      |   3 +
>  include/linux/sched.h        |   8 +
>  kernel/sched/Makefile        |   1 +
>  kernel/sched/cpufreq_sched.c | 459 +++++++++++++++++++++++++++++++++++++++++++

Please rename this to kernel/sched/cpufreq.c - no need to say 'sched' twice! :-)

>  kernel/sched/sched.h         |  51 +++++
>  6 files changed, 543 insertions(+)
>  create mode 100644 kernel/sched/cpufreq_sched.c

So I really like how you push all high level code into kernel/sched/cpufreq.c and 
use the cpufreq drivers only for actual low level frequency switching.

It would be nice to converge this code with the code from Rafael:

   [PATCH 0/6] cpufreq: schedutil governor

i.e. use scheduler internal metrics within the scheduler, and create a clear 
interface between low level cpufreq drivers and the cpufreq code living in the 
scheduler.

Thanks,

	Ingo
