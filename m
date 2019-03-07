From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Thu, 7 Mar 2019 11:49:55 +0000
Message-ID: <20190307114952.u6lb5jtyombsnl7z@queper01-lin>
References: <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
 <20190305173746.p32xolcpueudlzwn@queper01-lin>
 <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
 <20190307110256.padefvq4e52ly3nm@queper01-lin>
 <20190307112344.GC32477@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307112344.GC32477@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 07 Mar 2019 at 12:23:44 (+0100), Peter Zijlstra wrote:
> Ah, but remember; with the latest patch the iowait_boost is scaled on
> max. So in order to hit that 300, you first have to hit 1024.

Argh ! Right ... So yeah, my whole point about big.little platforms was
totally wrong :(

/me goes back to sleep
