From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Thu, 7 Jun 2018 10:32:29 +0200
Message-ID: <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 07, 2018 at 10:18:27AM +0200, Daniel Lezcano wrote:
> So IIUC, neither atomic or WRITE|READ_ONCE are necessary in this code
> because of the wake_up_process() barrier is enough, right ?

I didn't look hard enough; if there ever is a time where the loads and
stores happen concurrently, you need READ/WRITE_ONCE(). If there is no
concurrency on the variables, you don't need anything.

Neither atomic_read/set() nor REAd/WRITE_ONCE() will help with ordering,
which is what the wake_up_process() would provide here, different things
entirely.
