From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date: Fri, 11 Jan 2019 11:41:45 +0100
Message-ID: <1742153.atePz3IjTa@aspire.rjw.lan>
References: <20190109104236.6532-1-quentin.perret@arm.com> <20190109105945.GA18034@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109105945.GA18034@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <quentin.perret@arm.com>
Cc: viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, qais.yousef@arm.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 9, 2019 11:59:45 AM CET Sudeep Holla wrote:
> On Wed, Jan 09, 2019 at 10:42:36AM +0000, Quentin Perret wrote:
> > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > frequency changes to provide scale-invariant load-tracking signals to
> > the scheduler. However, in the slow path, it does so while specifying
> > the current and max frequencies in different units, hence resulting in a
> > broken freq_scale factor.
> > 
> > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > frequency table.
> > 
> > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > message protocol")
> 
> Good find.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks!
