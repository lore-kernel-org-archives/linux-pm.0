From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency
 selection
Date: Mon, 22 Feb 2016 17:33:16 -0800
Message-ID: <56CBB6DC.8030809@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 02/22/2016 05:22 PM, Steve Muckle wrote:
> Scheduler-driven CPU frequency selection hopes to exploit both
> per-task and global information in the scheduler to improve frequency
> selection policy and achieve lower power consumption, improved
> responsiveness/performance, and less reliance on heuristics and
> tunables. For further discussion of this integration see [0].
> 
> This patch series implements a cpufreq governor which collects CPU
> capacity requests from the fair, realtime, and deadline scheduling
> classes. The fair and realtime scheduling classes are modified to make
> these requests. The deadline class is not yet modified to make CPU
> capacity requests.

This RFC series does not attempt to address any of today's feedback
regarding simplifying the hooks in the scheduler - I'd like some more
time to ponder that. But I thought it important to get the latest
version of this out for discussion as soon as possible.

thanks,
Steve
