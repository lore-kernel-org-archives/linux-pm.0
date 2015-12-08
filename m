From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work
 with timers
Date: Tue, 8 Dec 2015 19:00:36 +0530
Message-ID: <20151208133036.GB3692@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <3999637.u4UiK7zxOR@vostro.rjw.lan>
 <20151208065622.GZ3294@ubuntu>
 <7208072.lZriMRM1aD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7208072.lZriMRM1aD@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-12-15, 14:18, Rafael J. Wysocki wrote:
> Well, if the timer function runs on all CPUs at the same time, they all
> can see skip_work > 1 and none of them will queue the work.

You are talking about code after my patch, right?

Will will all of them see it > 1? At least one of them will see it 0
and queue the work, unless the governor is stopped completely.

> You are right, I've overlooked that race (but then it is rather easy to
> overlook).

Yeah, we (at least I) took a long time to understand that this was the
real problem we always had and so fixed it recently.

-- 
viresh
