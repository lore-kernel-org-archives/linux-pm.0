From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] drivers: cpuidle: assign enter_freeze to same as enter
 callback function
Date: Tue, 15 Nov 2016 14:20:21 +0000
Message-ID: <e79767a7-03be-2073-b78e-3ec8d29d5f8a@arm.com>
References: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com>
 <1478787873-18180-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478787873-18180-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andy Gross <andy.gross@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 10/11/16 14:24, Sudeep Holla wrote:
> enter_freeze() callback is expected atleast to do the same as enter()
> but it has to guarantee that interrupts aren't enabled at any point
> in its execution, as the tick is frozen.
>
> CPUs execute ->enter_freeze with the local tick or entire timekeeping
> suspended, so it must not re-enable interrupts at any point (even
> temporarily) or attempt to change states of clock event devices.
>
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs
> (i.e. woken up only on IRQs from "wakeup sources")
>
> We can reuse the same code for both the enter() and enter_freeze()
> callbacks as along as they don't re-enable interrupts. Only "coupled"
> cpuidle mechanism enables interrupts and doing that with timekeeping
> suspended is generally not safe.
>
> Since this generic DT based idle driver doesn't support "coupled"
> states, it is safe to assume that the interrupts are not re-enabled.
>
> This patch assign enter_freeze to same as enter callback function which
> helps to save power without any intermittent spurious wakeups from
> suspend-to-idle.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpuidle/dt_idle_states.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> v1->v2:
> 	- Dropped checking and using only states with CPUIDLE_FLAG_TIMER_STOP
> 	  enabled.
>

Can you pick up this patch directly if there are no concerns ?

-- 
Regards,
Sudeep
