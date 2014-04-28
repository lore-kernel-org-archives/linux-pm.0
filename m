From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Mon, 28 Apr 2014 12:28:19 +0200
Message-ID: <20140428102819.GG27561@twins.programming.kicks-ass.net>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org>
 <535911DC.9050109@linaro.org>
 <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com>
 <2713863.BLQTYQm2Oa@vostro.rjw.lan>
 <20140425132055.GC11096@twins.programming.kicks-ass.net>
 <535A94E3.5080004@linaro.org>
 <20140425184327.GH26782@laptop.programming.kicks-ass.net>
 <535E28D0.7050502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <535E28D0.7050502@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Kucheria <amit.kucheria@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 28, 2014 at 12:09:20PM +0200, Daniel Lezcano wrote:
> I agree a numerical value is not flexible. But it sounds weird to put a
> scheduler option in the sysfs and maybe more options will follow.
> 
> I am wondering if we shouldn't create a new cgroup for 'energy' and put
> everything in there. So we will have more flexibility for extension and we
> will be able to create a group of tasks for performance and a group of tasks
> for energy saving.
> 
> Does it make sense ?

The old knobs used to live here:

-What:          /sys/devices/system/cpu/sched_mc_power_savings
-               /sys/devices/system/cpu/sched_smt_power_savings

Not entirely sure that's a fine place, but it has precedent.
