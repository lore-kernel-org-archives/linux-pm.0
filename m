From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] cpufreq: governors: Solve the ABBA lockups
Date: Wed, 3 Feb 2016 17:07:35 +0530
Message-ID: <20160203113735.GC3469@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <CAJZ5v0gcpZWOoY407cKZJgPfbhutbry8hE-mEyzXKx6+tqCgLQ@mail.gmail.com>
 <20160203022234.GM31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160203022234.GM31828@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03-02-16, 07:52, Viresh Kumar wrote:
> > My overall impression here is that the code changes make sense.  Some
> > details need to be improved (like the concurrent ->store for governor
> > tunables pointed out by Juri). 

The next version is ready with some improvements, will send it once
you are done with this thread.

-- 
viresh
