From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] cpufreq: schedutil: move slow path from workqueue to SCHED_FIFO task
Date: Tue, 15 Nov 2016 13:53:19 +0530
Message-ID: <cover.1479197311.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

If slow path frequency changes are conducted in a SCHED_OTHER context
then they may be delayed for some amount of time, including
indefinitely, when real time or deadline activity is taking place.

Move the slow path to a real time kernel thread using the kthread worker
infrastructure. In the future the thread should be made SCHED_DEADLINE.
The RT priority is arbitrarily set to 50 for now.

This was tested with Hackbench on ARM Exynos, dual core A15 platform and
no regressions were seen. The third patch has more details on it.

This work was started by Steve Muckle, where he used a simple kthread
instead of kthread-worker and that wasn't sufficient as some guarantees
weren't met.

I was wondering if the same should be done for ondemand/conservative
governors as well ?

V1->V2:
- first patch is new based on Peter's suggestions.
- fixed indented label
- Moved kthread creation/destruction into separate routines
- Used MACRO instead of magic number '50'
- minor formatting, commenting and improved commit logs

--
viresh

Viresh Kumar (4):
  cpufreq: schedutil: Avoid indented labels
  cpufreq: schedutil: enable fast switch earlier
  cpufreq: schedutil: move slow path from workqueue to SCHED_FIFO task
  cpufreq: schedutil: irq-work and mutex are only used in slow path

 kernel/sched/cpufreq_schedutil.c | 119 ++++++++++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 20 deletions(-)

-- 
2.7.1.410.g6faf27b
