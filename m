From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] clk: Manage proper runtime PM state in
 clk_change_rate()
Date: Fri, 01 Dec 2017 10:41:33 +0900
Message-ID: <5A20B34D.7020108@samsung.com>
References: <CGME20171130121511eucas1p1832c1f6e5bc9e263860e40478efca132@eucas1p1.samsung.com>
        <20171130121451.6710-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <20171130121451.6710-1-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Dear all,

On 2017년 11월 30일 21:14, Marek Szyprowski wrote:
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
> For some unknown reason handling of this case was missing in the initial
> patch, which added runtime PM support for clock core. Even tests in
> linux-next did not revealed this issue. This patch finaly fixes it,
> as it is now easy to trigger it with v4.15-rc1.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> ---
>  drivers/clk/clk.c | 5 +++++
>  1 file changed, 5 insertions(+)

I tested it on Exynos5433-based TM2 with following test environment:
- Based on linux-next git with next-20171129 tag.
- Exynos5433 clock driver supports the runtime PM.
- Exynos5433-based TM2 board makes the connections between
  power-domain and clock controller/other device.
- Enable devfreq for memory bus frequency on TM2.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 647d056df88c..8a1860a36c77 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1564,6 +1564,9 @@ static void clk_change_rate(struct clk_core *core)
>  		best_parent_rate = core->parent->rate;
>  	}
>  
> +	if (clk_pm_runtime_get(core))
> +		return;
> +
>  	if (core->flags & CLK_SET_RATE_UNGATE) {
>  		unsigned long flags;
>  
> @@ -1634,6 +1637,8 @@ static void clk_change_rate(struct clk_core *core)
>  	/* handle the new child who might not be in core->children yet */
>  	if (core->new_child)
>  		clk_change_rate(core->new_child);
> +
> +	clk_pm_runtime_put(core);
>  }
>  
>  static int clk_core_set_rate_nolock(struct clk_core *core,
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
