From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH v8 24/26] drivers: firmware: psci: Deal with CPU hotplug
 when using OSI mode
Date: Tue, 20 Nov 2018 01:20:48 +0530
Message-ID: <9bf3713b-df00-03b3-d235-7549565382c7@codeaurora.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-25-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620172226.15012-25-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

Got one issue in hotplug path where of_genpd_detach_cpu calls 
dev_pm_qos_remove_notifier which can be sleeping as per below call 
stack. I think it should be applicable for current patch as well right? 
Please let me know what am I missing? why didn't you see this issue with 
this patch?


[ 8103.221387] BUG: sleeping function called from invalid context at 
/mnt/host/source/src/third_party/kernel/v4.14/kernel/locking/mutex.c:238
[ 8103.221455] in_atomic(): 1, irqs_disabled(): 128, pid: 11, name: 
migration/0
[ 8103.221487] Preemption disabled at:
[ 8103.221529] [<ffffff800814dfb0>] cpu_stopper_thread+0x98/0x118
[ 8103.221600] ------------[ cut here ]------------
[ 8103.221636] kernel BUG at 
/mnt/host/source/src/third_party/kernel/v4.14/kernel/sched/core.c:6102!
[ 8103.221678] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[ 8103.222396] CPU: 0 PID: 11 Comm: migration/0 Tainted: G        W 
  4.14.72 #1
[ 8103.222428] Hardware name: Google Cheza (rev1) (DT)
[ 8103.222460] task: ffffffc0f842d580 task.stack: ffffff8009c18000
[ 8103.222504] PC is at ___might_sleep+0x138/0x140
[ 8103.222542] LR is at ___might_sleep+0x138/0x140
[ 8103.222577] pc : [<ffffff80080d8f04>] lr : [<ffffff80080d8f04>] 
pstate: 60c001c9
[ 8103.222605] sp : ffffff8009c1bb40
….
[ 8103.223924] [<ffffff80080d8f04>] ___might_sleep+0x138/0x140
[ 8103.223965] [<ffffff80080d8d98>] __might_sleep+0x4c/0x80
[ 8103.224009] [<ffffff80088e4258>] mutex_lock+0x28/0x60
[ 8103.224054] [<ffffff800850fa2c>] dev_pm_qos_remove_notifier+0x1c/0x54
[ 8103.224097] [<ffffff8008517814>] genpd_remove_device+0x3c/0x10c
[ 8103.224140] [<ffffff800851949c>] genpd_dev_pm_detach+0x48/0x108
[ 8103.224183] [<ffffff80085193e0>] of_genpd_detach_cpu+0x48/0xbc
[ 8103.224227] [<ffffff80083edea4>] cpu_pd_dying+0x28/0x38
[ 8103.224268] [<ffffff80080ab2c0>] cpuhp_invoke_callback+0x254/0x5f0
[ 8103.224308] [<ffffff80080acdec>] take_cpu_down+0x60/0x9c
[ 8103.224346] [<ffffff800814d898>] multi_cpu_stop+0xac/0x104
[ 8103.224385] [<ffffff800814dfb8>] cpu_stopper_thread+0xa0/0x118
[ 8103.224427] [<ffffff80080cff74>] smpboot_thread_fn+0x19c/0x278
[ 8103.224472] [<ffffff80080cc0c4>] kthread+0x120/0x130
[ 8103.224513] [<ffffff8008084608>] ret_from_fork+0x10/0x18

Thanks,
Raju

On 6/20/2018 10:52 PM, Ulf Hansson wrote:
> To deal with CPU hotplug when OSI mode is used, the CPU device needs to be
> detached from its PM domain (genpd) when putting it offline, otherwise the
> CPU becomes considered as being in use from genpd and runtime PM point of
> view. Obviously, then we also need to re-attach the CPU device when bring
> the CPU back online, so let's do this.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/firmware/psci/psci.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 700e0e995871..e649673d71f0 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -190,6 +190,10 @@ static int psci_cpu_off(u32 state)
>   	int err;
>   	u32 fn;
>   
> +	/* If running OSI mode, detach the CPU device from its PM domain. */
> +	if (psci_osi_mode_enabled)
> +		of_genpd_detach_cpu(smp_processor_id());
> +
>   	fn = psci_function_id[PSCI_FN_CPU_OFF];
>   	err = invoke_psci_fn(fn, state, 0, 0);
>   	return psci_to_linux_errno(err);
> @@ -204,6 +208,10 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>   	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
>   	/* Clear the domain state to start fresh. */
>   	psci_set_domain_state(0);
> +
> +	if (!err && psci_osi_mode_enabled)
> +		of_genpd_attach_cpu(cpuid);
> +
>   	return psci_to_linux_errno(err);
>   }
>   
> 
