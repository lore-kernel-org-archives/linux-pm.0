From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 4/9] sched: cpufreq: extend irq work to support fast switches
Date: Wed, 29 Mar 2017 23:25:23 +0200
Message-ID: <7941583.LZOQImzPvq@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <9d2ff35af95f5accb40d3447e6ff5970c0ba405e.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9d2ff35af95f5accb40d3447e6ff5970c0ba405e.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 09, 2017 05:15:14 PM Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> In preparation for schedutil receiving sched cpufreq callbacks for
> remote CPUs, extend the irq work in schedutil to support policies with
> fast switching enabled in addition to policies using the slow path.
> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> [ vk: minor code updates ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This should be merged with the [6/9].

As is, it requires me to look at two patches at the same time to make sense out
of it.

Thanks,
Rafael
