From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 31 Mar 2016 14:18:33 +0200
Message-ID: <CAJZ5v0icQyGd1UFeKP0kMa_TFXZCutT2+ttMFkErvsKwf=V6UQ@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<6666532.7ULg06hQ7e@vostro.rjw.lan>
	<145931680.Kk1xSBT0Ro@vostro.rjw.lan>
	<20160331121245.GI3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160331121245.GI3408@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 31, 2016 at 2:12 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Ingo reminded me that the schedutil governor is part of the scheduler
> proper and can access scheduler data because of that.
>
> This allows us to remove the util and max arguments since only the
> schedutil governor will use those, which leads to some further text
> reduction:
>
>   43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.pre
>   42907    1226      24   44157    ac7d defconfig-build/kernel/sched/fair.o.post
>
> Of course, we get more text in schedutil in return, but the below also
> shows how we can benefit from not being tied to those two parameters by
> doing a very coarse deadline reservation.

OK

Do you want this to go into the series or be folded into the schedutil
patch or on top  of it?
