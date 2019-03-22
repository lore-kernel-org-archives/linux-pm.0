From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Auto-promotion logic for cpuidle states
Date: Fri, 22 Mar 2019 13:08:49 +0530
Message-ID: <6131c0d7-bb2f-04fb-9700-4c6655a1c56e@linux.vnet.ibm.com>
References: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

Please ignore this set as this is incomplete. I have resent the patches.

--Abhishek

On 03/22/2019 11:55 AM, Abhishek Goel wrote:
> Currently, the cpuidle governors (menu/ladder) determine what idle state a
> idling CPU should enter into based on heuristics that depend on the idle
> history on that CPU. Given that no predictive heuristic is perfect, there
> are cases where the governor predicts a shallow idle state, hoping that
> the CPU will be busy soon. However, if no new workload is scheduled on
> that CPU in the near future, the CPU will end up in the shallow state.
>
> Motivation
> ----------
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-core
> can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.
>
> Experiment
> ----------
> Without this patch -
> It was seen that for a idle system, a cpu may remain in stop0_lite for few
> seconds and then directly goes to a deeper state such as stop2.
>
> With this patch -
> A cpu will not remain in stop0_lite for more than the residency of next
> available state, and thus it will go to a deeper state in conservative
> fashion. Using this, we may spent even less than 20 milliseconds if
> susbsequent stop states are enabled. In the worst case, we may end up
> spending more than a second, as was the case without this patch. The
> worst case will occur in the scenario when no other shallow states are
> enbaled, and only deep states are available for auto-promotion.
>
> Abhishek Goel (2):
>    cpuidle : auto-promotion for cpuidle states
>    cpuidle : Add auto-promotion flag to cpuidle flags
>
>   arch/powerpc/include/asm/opal-api.h |  1 +
>   drivers/cpuidle/Kconfig             |  4 ++++
>   drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
>   drivers/cpuidle/cpuidle.c           |  3 ---
>   4 files changed, 16 insertions(+), 5 deletions(-)
>
