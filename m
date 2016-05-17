From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Fix coupled state parameter in cpuidle_enter()
Date: Tue, 17 May 2016 16:55:35 +0200
Message-ID: <573B30E7.6040802@linaro.org>
References: <1463496840-2858-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463496840-2858-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: gregory.clement@free-electrons.com, linux-pm@vger.kernel.org, linux@armlinux.org.uk, paul.burton@imgtec.com, stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/17/2016 04:54 PM, Daniel Lezcano wrote:
> The commit 0b89e9aa2856 rightfully fixed a regression by letting the couple
> idle state framework to handle local interrupt enabling when the cpu is
> exiting an idle state.
>
> The current code check if the idle state is a coupled one and, if so, it will
> let the couple code to enable the interrupt. This way, it can decrement the
> ready-count before handling the interrupts. This mechanism prevents the other
> cpus to wait for a cpu which is handling interrupts.
>
> But the check is done against the state index returned by the back end driver
> 'enter' functions which could be different from the initial index passed as
> parameter to the cpuidle_enter_state() function.
>
>   entered_state = target_state->enter(dev, drv, index);
>
>   [ ... ]
>
>   if (!cpuidle_state_is_coupled(drv, entered_state))
> 	local_irq_enable();
>
>   [ ... ]
>
> If the 'index' is referring to a coupled idle state but the 'entered_state'
> is *not* coupled, then the interrupts are enabled again. All cpus blocked on
> the sync barrier may busy loop longer if the cpu has interrupts to handle
> before decrementing the ready-count. Thus consuming more energy than saving.
>
> Fixes: 0b89e9aa2856 "cpuidle: delay enabling interrupts until all coupled CPUs leave idle"
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

I don't have a board available with a driver doing couple idle state, so 
I wasn't able to test this patch.

   -- Daniel
