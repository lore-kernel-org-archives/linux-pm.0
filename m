From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: Manage proper runtime PM state in clk_change_rate()
Date: Tue, 5 Dec 2017 15:26:46 -0800
Message-ID: <20171205232646.GA4283@codeaurora.org>
References: <CGME20171130121511eucas1p1832c1f6e5bc9e263860e40478efca132@eucas1p1.samsung.com>
 <20171130121451.6710-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130121451.6710-1-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 11/30, Marek Szyprowski wrote:
> clk_change_rate() propagates rate change down to all its children. Such
> operation requires managing proper runtime PM state of each child, what
> was missing. Add needed calls to clk_pm_runtime*() to ensure that
> set_rate() clock callback is called on runtime active clock.
> 
> This fixes following issue found on Exynos5433 TM2 board with devfreq
> enabled:
> 
> Synchronous External Abort: synchronous external abort (0x96000210) at 0xffffff80093f5600
> Internal error: : 96000210 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 5 Comm: kworker/u16:0 Not tainted 4.15.0-rc1-next-20171129+ #4
> Hardware name: Samsung TM2 board (DT)
> Workqueue: devfreq_wq devfreq_monitor
> task: ffffffc0ca96b600 task.stack: ffffff80093a8000
> pstate: a0000085 (NzCv daIf -PAN -UAO)
> pc : clk_divider_set_rate+0x54/0x118
> lr : clk_divider_set_rate+0x44/0x118
> ...
> Process kworker/u16:0 (pid: 5, stack limit = 0xffffff80093a8000)
> Call trace:
>  clk_divider_set_rate+0x54/0x118
>  clk_change_rate+0xfc/0x4e0
>  clk_change_rate+0x1f0/0x4e0
>  clk_change_rate+0x1f0/0x4e0
>  clk_change_rate+0x1f0/0x4e0
>  clk_core_set_rate_nolock+0x138/0x148
>  clk_set_rate+0x28/0x50
>  exynos_bus_passive_target+0x6c/0x11c
>  update_devfreq_passive+0x58/0xb4
>  devfreq_passive_notifier_call+0x50/0x5c
>  notifier_call_chain+0x4c/0x88
>  __srcu_notifier_call_chain+0x54/0x80
>  srcu_notifier_call_chain+0x14/0x1c
>  update_devfreq+0x100/0x1b4
>  devfreq_monitor+0x2c/0x88
>  process_one_work+0x148/0x3d8
>  worker_thread+0x13c/0x3f8
>  kthread+0x100/0x12c
>  ret_from_fork+0x10/0x18
> 
> Reported-by: Chanwoo Choi <cw00.choi@samsung.com>
> Fixes: 9a34b45397e5 ("clk: Add support for runtime PM")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
