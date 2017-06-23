From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Fri, 23 Jun 2017 13:59:11 -0700
Message-ID: <20170623205911.GA143883@google.com>
References: <20170517225634.GA11404@google.com>
 <20170527021900.GA119873@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170527021900.GA119873@google.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

This reverts commit 88bb94216f59e10802aaf78c858a4146085faf18.

It introduced a new CONFIG_DEBUG_ATOMIC_SLEEP warning in v4.12-rc1:

[ 7226.716713] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
[ 7226.716716] in_atomic(): 0, irqs_disabled(): 0, pid: 1708, name: bash
[ 7226.716722] CPU: 1 PID: 1708 Comm: bash Not tainted 4.12.0-rc6+ #1213
[ 7226.716724] Hardware name: Google Kevin (DT)
[ 7226.716726] Call trace:
[ 7226.716738] [<ffffff8008089928>] dump_backtrace+0x0/0x24c
[ 7226.716743] [<ffffff8008089b94>] show_stack+0x20/0x28
[ 7226.716749] [<ffffff8008371370>] dump_stack+0x90/0xb0
[ 7226.716755] [<ffffff80080cd2a0>] ___might_sleep+0x10c/0x124
[ 7226.716760] [<ffffff80080cd330>] __might_sleep+0x78/0x88
[ 7226.716765] [<ffffff800879e210>] mutex_lock+0x2c/0x64
[ 7226.716771] [<ffffff80083ad678>] rockchip_irq_bus_lock+0x30/0x3c
[ 7226.716777] [<ffffff80080f6d40>] __irq_get_desc_lock+0x78/0x98
[ 7226.716782] [<ffffff80080f7e6c>] irq_set_irq_wake+0x44/0x12c
[ 7226.716787] [<ffffff8008486e18>] dev_pm_arm_wake_irq+0x4c/0x58
[ 7226.716792] [<ffffff800848b80c>] device_wakeup_arm_wake_irqs+0x3c/0x58
[ 7226.716796] [<ffffff80084896fc>] dpm_suspend_noirq+0xf8/0x3a0
[ 7226.716800] [<ffffff80080f1384>] suspend_devices_and_enter+0x1a4/0x9a8
[ 7226.716803] [<ffffff80080f21ec>] pm_suspend+0x664/0x6a4
[ 7226.716807] [<ffffff80080f04d8>] state_store+0xd4/0xf8
...

It was reported on -rc1, and it's still not fixed in -rc6, so it should
just be reverted.

Cc: John Keeping <john@metanate.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

+ Thomas, in case he has thoughts

Subject was "[4.12 REGRESSION] pinctrl: rockchip: sleeping function
called from atomic context"

On Fri, May 26, 2017 at 07:19:00PM -0700, Brian Norris wrote:
> Any thoughts? Revert the offending patch? I can spend a little more time
> next week trying to debug what's actually going on if needed.
> 
> On Wed, May 17, 2017 at 03:56:34PM -0700, Brian Norris wrote:

> > The thing is, the documentation (and apparent design) suggest that
> > calling sleeping functions from ->irq_bus_lock() is perfectly valid. I'm
> > not 100% following the ___might_sleep() logic, but is this complaining
> > because of the RCU read locking in device_wakeup_arm_wake_irqs()? I have
> > CONFIG_PREEMPT_RCU and CONFIG_PREEMPT enabled, FWIW.

I've seen no reply that indicates anyone wants to fix the patch.

 drivers/pinctrl/pinctrl-rockchip.c | 44 ++++----------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index f141aa0430b1..9dd981ddbb17 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -143,9 +143,6 @@ struct rockchip_drv {
  * @gpio_chip: gpiolib chip
  * @grange: gpio range
  * @slock: spinlock for the gpio bank
- * @irq_lock: bus lock for irq chip
- * @new_irqs: newly configured irqs which must be muxed as GPIOs in
- *	irq_bus_sync_unlock()
  */
 struct rockchip_pin_bank {
 	void __iomem			*reg_base;
@@ -168,8 +165,6 @@ struct rockchip_pin_bank {
 	struct pinctrl_gpio_range	grange;
 	raw_spinlock_t			slock;
 	u32				toggle_edge_mode;
-	struct mutex			irq_lock;
-	u32				new_irqs;
 };
 
 #define PIN_BANK(id, pins, label)			\
@@ -2134,12 +2129,11 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	int ret;
 
 	/* make sure the pin is configured as gpio input */
-	ret = rockchip_verify_mux(bank, d->hwirq, RK_FUNC_GPIO);
+	ret = rockchip_set_mux(bank, d->hwirq, RK_FUNC_GPIO);
 	if (ret < 0)
 		return ret;
 
-	bank->new_irqs |= mask;
-
+	clk_enable(bank->clk);
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
@@ -2197,6 +2191,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	default:
 		irq_gc_unlock(gc);
 		raw_spin_unlock_irqrestore(&bank->slock, flags);
+		clk_disable(bank->clk);
 		return -EINVAL;
 	}
 
@@ -2205,6 +2200,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 
 	irq_gc_unlock(gc);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+	clk_disable(bank->clk);
 
 	return 0;
 }
@@ -2248,34 +2244,6 @@ static void rockchip_irq_disable(struct irq_data *d)
 	clk_disable(bank->clk);
 }
 
-static void rockchip_irq_bus_lock(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank = gc->private;
-
-	clk_enable(bank->clk);
-	mutex_lock(&bank->irq_lock);
-}
-
-static void rockchip_irq_bus_sync_unlock(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank = gc->private;
-
-	while (bank->new_irqs) {
-		unsigned int irq = __ffs(bank->new_irqs);
-		int ret;
-
-		ret = rockchip_set_mux(bank, irq, RK_FUNC_GPIO);
-		WARN_ON(ret < 0);
-
-		bank->new_irqs &= ~BIT(irq);
-	}
-
-	mutex_unlock(&bank->irq_lock);
-	clk_disable(bank->clk);
-}
-
 static int rockchip_interrupts_register(struct platform_device *pdev,
 						struct rockchip_pinctrl *info)
 {
@@ -2342,9 +2310,6 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
 		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
 		gc->chip_types[0].chip.irq_set_type = rockchip_irq_set_type;
-		gc->chip_types[0].chip.irq_bus_lock = rockchip_irq_bus_lock;
-		gc->chip_types[0].chip.irq_bus_sync_unlock =
-						rockchip_irq_bus_sync_unlock;
 		gc->wake_enabled = IRQ_MSK(bank->nr_pins);
 
 		irq_set_chained_handler_and_data(bank->irq,
@@ -2518,7 +2483,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 		int bank_pins = 0;
 
 		raw_spin_lock_init(&bank->slock);
-		mutex_init(&bank->irq_lock);
 		bank->drvdata = d;
 		bank->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += bank->nr_pins;
-- 
2.13.1.611.g7e3b11ae1-goog

