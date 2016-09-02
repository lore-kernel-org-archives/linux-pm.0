From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 2/8] power: add power sequence library
Date: Fri, 2 Sep 2016 09:29:57 +0800
Message-ID: <20160902012957.GC11262@shlinux2>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <1471252398-957-3-git-send-email-peter.chen@nxp.com>
 <4a08d6f8-1c6a-fa1b-0dfe-657afa4e8a90@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4a08d6f8-1c6a-fa1b-0dfe-657afa4e8a90@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, stillcompiling@gmail.com, p.zabel@pengutronix.de, festevam@gmail.com, mka@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 01, 2016 at 01:32:56PM +0530, Vaibhav Hiremath wrote:
> >+static void pwrseq_generic_put(struct pwrseq *pwrseq)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	int clk;
> >+
> >+	if (pwrseq_gen->gpiod_reset)
> >+		gpiod_put(pwrseq_gen->gpiod_reset);
> >+
> >+	for (clk = 0; clk < PWRSEQ_MAX_CLKS; clk++)
> >+		clk_put(pwrseq_gen->clks[clk]);
> >+}
> >+
> >+static void pwrseq_generic_off(struct pwrseq *pwrseq)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	int clk;
> >+
> >+	for (clk = PWRSEQ_MAX_CLKS - 1; clk >= 0; clk--)
> >+		clk_disable_unprepare(pwrseq_gen->clks[clk]);
> >+}
> >+
> >+static int pwrseq_generic_on(struct device_node *np, struct pwrseq *pwrseq)
> Ideally you shouldn't need device_node here at this stage.
> I expect to extract all the resource information in _get() itself.
> 

Agree, I will move reset-duration-us property handling to pwrseq_get.

> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	int clk, ret = 0;
> >+	struct gpio_desc *gpiod_reset = pwrseq_gen->gpiod_reset;
> >+
> >+	for (clk = 0; clk < PWRSEQ_MAX_CLKS && pwrseq_gen->clks[clk]; clk++) {
> >+		ret = clk_prepare_enable(pwrseq_gen->clks[clk]);
> >+		if (ret) {
> >+			pr_err("Can't enable clock on %s: %d\n",
> >+				np->full_name, ret);
> >+			goto err_disable_clks;
> >+		}
> >+	}
> >+
> >+	if (gpiod_reset) {
> >+		u32 duration_us = 50;
> Why initialize to 50 ??
> 

This active duration is default value, and should work for most of
devices. If your device needs longer, you can change it at dts.

> >+
> >+		of_property_read_u32(np, "reset-duration-us",
> >+				&duration_us);
> >+		if (duration_us <= 10)
> >+			udelay(10);
> >+		else
> >+			usleep_range(duration_us, duration_us + 100);
> >+		gpiod_set_value(gpiod_reset, 0);
> >+	}
> >+
> >+	return ret;
> >+
> >+err_disable_clks:
> >+	while (--clk >= 0)
> >+		clk_disable_unprepare(pwrseq_gen->clks[clk]);
> >+
> >+	return ret;
> >+}
> >+
> >+static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	enum of_gpio_flags flags;
> >+	int reset_gpio, clk, ret = 0;
> >+
> >+	for (clk = 0; clk < PWRSEQ_MAX_CLKS; clk++) {
> >+		pwrseq_gen->clks[clk] = of_clk_get(np, clk);
> >+		if (IS_ERR(pwrseq_gen->clks[clk])) {
> >+			ret = PTR_ERR(pwrseq_gen->clks[clk]);
> >+			if (ret == -EPROBE_DEFER)
> >+				goto err_put_clks;
> >+			pwrseq_gen->clks[clk] = NULL;
> >+			break;
> 
> Do we really want to continue here, even we failed to get the clock ?

Ok, if it is -ENOENT, I set clk as NULL, for other error cases, I go to
error path.

> 
> >+		}
> >+	}
> >+
> >+	reset_gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, &flags);
> >+	if (gpio_is_valid(reset_gpio)) {
> >+		unsigned long gpio_flags;
> >+
> >+		if (flags & OF_GPIO_ACTIVE_LOW)
> >+			gpio_flags = GPIOF_ACTIVE_LOW | GPIOF_OUT_INIT_LOW;
> >+		else
> >+			gpio_flags = GPIOF_OUT_INIT_HIGH;
> >+
> >+		ret = gpio_request_one(reset_gpio, gpio_flags,
> >+				"pwrseq-reset-gpios");
> >+		if (ret)
> >+			goto err_put_clks;
> >+
> >+		pwrseq_gen->gpiod_reset = gpio_to_desc(reset_gpio);
> >+	} else {
> >+		if (reset_gpio == -ENOENT)
> >+			return 0;
> 
> Why are we returning success here ?
> 

The property "reset-gpios" is optional, it can be nonexistent.

> >+
> >+		ret = reset_gpio;
> >+		pr_err("Failed to get reset gpio on %s, err = %d\n",
> >+				np->full_name, reset_gpio);
> >+		goto err_put_clks;
> >+	}
> >+
> >+	return ret;
> >+
> >+err_put_clks:
> >+	while (--clk >= 0)
> >+		clk_put(pwrseq_gen->clks[clk]);
> >+	return ret;
> >+}
> >+
> >+struct pwrseq *pwrseq_alloc_generic(void)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen;
> >+
> >+	pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> >+	if (!pwrseq_gen)
> >+		return ERR_PTR(-ENOMEM);
> >+
> >+	pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> >+	pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> >+	pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> >+	pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> >+	pwrseq_gen->pwrseq.free = pwrseq_generic_free;
> >+
> >+	return &pwrseq_gen->pwrseq;
> >+}
> >+EXPORT_SYMBOL_GPL(pwrseq_alloc_generic);
> 
> With recent discussion on postcore_initcall, we probably can merge
> _get() and _alloc() fns.
> 

At postcore_initcall, I plan to allocate individual pwrseq library, and
add it to pwrseq list. The consumer tries to get the resources.

Peter

> Thanks,
> Vaibhav
> >diff --git a/include/linux/power/pwrseq.h b/include/linux/power/pwrseq.h
> >new file mode 100644
> >index 0000000..ebb2280
> >--- /dev/null
> >+++ b/include/linux/power/pwrseq.h
> >@@ -0,0 +1,47 @@
> >+#ifndef __LINUX_PWRSEQ_H
> >+#define __LINUX_PWRSEQ_H
> >+
> >+#include <linux/of.h>
> >+
> >+#define PWRSEQ_MAX_CLKS		3
> >+
> >+struct pwrseq {
> >+	char *name;
> >+	struct list_head node;
> >+	int (*get)(struct device_node *np, struct pwrseq *p);
> >+	int (*on)(struct device_node *np, struct pwrseq *p);
> >+	void (*off)(struct pwrseq *p);
> >+	void (*put)(struct pwrseq *p);
> >+	void (*free)(struct pwrseq *p);
> >+};
> >+
> >+#if IS_ENABLED(CONFIG_POWER_SEQUENCE)
> >+int pwrseq_get(struct device_node *np, struct pwrseq *p);
> >+int pwrseq_on(struct device_node *np, struct pwrseq *p);
> >+void pwrseq_off(struct pwrseq *p);
> >+void pwrseq_put(struct pwrseq *p);
> >+void pwrseq_free(struct pwrseq *p);
> >+#else
> >+static inline int pwrseq_get(struct device_node *np, struct pwrseq *p)
> >+{
> >+	return 0;
> >+}
> >+static inline int pwrseq_on(struct device_node *np, struct pwrseq *p)
> >+{
> >+	return 0;
> >+}
> >+static inline void pwrseq_off(struct pwrseq *p) {}
> >+static inline void pwrseq_put(struct pwrseq *p) {}
> >+static inline void pwrseq_free(struct pwrseq *p) {}
> >+#endif /* CONFIG_POWER_SEQUENCE */
> >+
> >+#if IS_ENABLED(CONFIG_PWRSEQ_GENERIC)
> >+struct pwrseq *pwrseq_alloc_generic(void);
> >+#else
> >+static inline struct pwrseq *pwrseq_alloc_generic(void)
> >+{
> >+	return NULL;
> >+}
> >+#endif /* CONFIG_PWRSEQ_GENERIC */
> >+
> >+#endif  /* __LINUX_PWRSEQ_H */
> 
> -- 
> Thanks,
> Vaibhav
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
