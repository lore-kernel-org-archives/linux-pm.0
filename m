From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/3] clk: keystone: Add sci-clk driver support
Date: Wed, 31 Aug 2016 21:35:52 +0300
Message-ID: <c1a66f45-fa81-8137-4d9b-73e84141f67f@ti.com>
References: <20160820003342.13599-1-nm@ti.com>
 <20160820003342.13599-4-nm@ti.com> <20160824083415.GA6502@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824083415.GA6502@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

Thanks for comments, inlined replies below.

On 24/08/16 11:34, Stephen Boyd wrote:
> On 08/19, Nishanth Menon wrote:
>>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index e2d9bd760c84..d1724999be78 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -179,6 +179,19 @@ config COMMON_CLK_NXP
>>  	---help---
>>  	  Support for clock providers on NXP platforms.
>>
>> +if COMMON_CLK_KEYSTONE
>
> Why not depends on COMMON_CLK_KEYSTONE? Or make the tristate have
> an if COMMON_CLK_KEYSTONE after it? So far an if <CONFIG> hasn't
> happened in this file. And is anything inside
> drivers/clk/keystone used by this driver? Maybe this if statement
> can just be dropped entirely and then the keystone/Makefile
> updated?

Yea will fix that.

>
>> +
>> +config TI_SCI_CLK
>> +	tristate "TI System Control Interface clock drivers"
>> +	depends on TI_SCI_PROTOCOL || COMPILE_TEST
>> +	default y
>
> default TI_SCI_PROTOCOL?

That too.

>
>> +	help
>> +	  This adds the clock driver support over TI System Control Interface.
>> +	  If you wish to use clock resources from the PMMC firmware, say Y.
>> +	  Otherwise, say N.
>> +
>> +endif # COMMON_CLK_KEYSTONE
>> +
>>  config COMMON_CLK_PALMAS
>>  	tristate "Clock driver for TI Palmas devices"
>>  	depends on MFD_PALMAS
>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>> new file mode 100644
>> index 000000000000..6c43e097e6d6
>> --- /dev/null
>> +++ b/drivers/clk/keystone/sci-clk.c
>> @@ -0,0 +1,539 @@
>> +/*
>> + * SCI Clock driver for keystone based devices
>> + *
>> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Tero Kristo <t-kristo@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include <linux/clk.h>
>
> Is this include used?

Yes, it seems I get a compile fail if this is not included:

   CC      drivers/clk/keystone/sci-clk.o
drivers/clk/keystone/sci-clk.c: In function 'ti_sci_clk_parse_flags':
drivers/clk/keystone/sci-clk.c:444:3: error: implicit declaration of 
function 'of_clk_get_from_provider' [-Werror=implicit-function-declaration]
    clk = of_clk_get_from_provider(&clkspec);

However, as there is the new API for clk_hw xlate, not sure if this is 
needed once I convert the driver to use that. Will check.

>
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/ti/ti_sci_protocol.h>
>> +
>> +#define SCI_CLK_SSC_ENABLE		BIT(0)
>> +#define SCI_CLK_ALLOW_FREQ_CHANGE	BIT(1)
>> +#define SCI_CLK_INPUT_TERMINATION	BIT(2)
>> +
>> +/**
>> + * struct sci_clk_provider - TI SCI clock provider representation
>> + * @sci:    Handle to the System Control Interface protocol handler
>> + * @ops:    Pointer to the SCI ops to be used by the clocks
>> + * @dev:    Device pointer for the clock provider
>> + * @clocks: List of all registered clocks
>> + * @lock:   Mutex for locking access to the @clocks list
>> + */
>> +struct sci_clk_provider {
>> +	const struct ti_sci_handle *sci;
>> +	const struct ti_sci_clk_ops *ops;
>> +	struct device *dev;
>> +	struct list_head clocks;
>> +	struct mutex lock; /* Protects access to the @clocks list */
>> +};
>> +
>> +/**
>> + * struct sci_clk - TI SCI clock representation
>> + * @hw:		 Hardware clock cookie for common clock framework
>> + * @dev_id:	 Device index
>> + * @clk_id:	 Clock index
>> + * @node:	 Clocks list link
>> + * @provider:	 Master clock provider
>> + * @flags:	 Flags for the clock
>> + */
>> +struct sci_clk {
>> +	struct clk_hw hw;
>> +	u16 dev_id;
>> +	u8 clk_id;
>> +	struct list_head node;
>> +	struct sci_clk_provider *provider;
>> +	u8 flags;
>> +};
>> +
>> +#define to_sci_clk(_hw) container_of(_hw, struct sci_clk, hw)
>> +
>> +/**
>> + * sci_clk_prepare - Prepare (enable) a TI SCI clock
>> + * @hw: clock to prepare
>> + *
>> + * Prepares a clock to be actively used. Returns the SCI protocol status.
>> + */
>> +static int sci_clk_prepare(struct clk_hw *hw)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	bool enable_ssc = clk->flags & SCI_CLK_SSC_ENABLE;
>> +	bool allow_freq_change = clk->flags & SCI_CLK_ALLOW_FREQ_CHANGE;
>> +	bool input_termination = clk->flags & SCI_CLK_INPUT_TERMINATION;
>> +
>> +	return clk->provider->ops->get_clock(clk->provider->sci, clk->dev_id,
>> +					     clk->clk_id, enable_ssc,
>> +					     allow_freq_change,
>> +					     input_termination);
>> +}
>> +
>> +/**
>> + * sci_clk_unprepare - Un-prepares (disables) a TI SCI clock
>> + * @hw: clock to unprepare
>> + *
>> + * Un-prepares a clock from active state.
>> + */
>> +static void sci_clk_unprepare(struct clk_hw *hw)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	int ret;
>> +
>> +	ret = clk->provider->ops->put_clock(clk->provider->sci, clk->dev_id,
>> +					    clk->clk_id);
>> +	if (ret)
>> +		dev_err(clk->provider->dev,
>> +			"unprepare failed for dev=%d, clk=%d, ret=%d\n",
>> +			clk->dev_id, clk->clk_id, ret);
>> +}
>> +
>> +/**
>> + * sci_clk_is_prepared - Check if a TI SCI clock is prepared or not
>> + * @hw: clock to check status for
>> + *
>> + * Checks if a clock is prepared (enabled) in hardware. Returns non-zero
>> + * value if clock is enabled, zero otherwise.
>> + */
>> +static int sci_clk_is_prepared(struct clk_hw *hw)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	bool req_state, current_state;
>> +	int ret;
>> +
>> +	ret = clk->provider->ops->is_on(clk->provider->sci, clk->dev_id,
>> +					clk->clk_id, &req_state,
>> +					&current_state);
>> +	if (ret) {
>> +		dev_err(clk->provider->dev,
>> +			"prepare failed for dev=%d, clk=%d, ret=%d\n",
>
> s/prepare/is_prepared/ ?

Will fix.

>
>> +			clk->dev_id, clk->clk_id, ret);
>> +		return 0;
>> +	}
>> +
>> +	return req_state;
>> +}
>> +
>> +/**
>> + * sci_clk_recalc_rate - Get clock rate for a TI SCI clock
>> + * @hw: clock to get rate for
>> + * @parent_rate: parent rate provided by common clock framework, not used
>> + *
>> + * Gets the current clock rate of a TI SCI clock. Returns the current
>> + * clock rate, or zero in failure.
>> + */
>> +static unsigned long sci_clk_recalc_rate(struct clk_hw *hw,
>> +					 unsigned long parent_rate)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	u64 freq;
>> +	int ret;
>> +
>> +	ret = clk->provider->ops->get_freq(clk->provider->sci, clk->dev_id,
>> +					   clk->clk_id, &freq);
>> +	if (ret) {
>> +		dev_err(clk->provider->dev,
>> +			"recalc-rate failed for dev=%d, clk=%d, ret=%d\n",
>> +			clk->dev_id, clk->clk_id, ret);
>> +		return 0;
>> +	}
>> +
>> +	return (u32)freq;
>> +}
>> +
>> +/**
>> + * sci_clk_determine_rate - Determines a clock rate a clock can be set to
>> + * @hw: clock to change rate for
>> + * @req: requested rate configuration for the clock
>> + *
>> + * Determines a suitable clock rate and parent for a TI SCI clock.
>> + * The parent handling is un-used, as generally the parent clock rates
>> + * are not known by the kernel; instead these are internally handled
>> + * by the firmware. Returns the new clock rate that can be set for the
>> + * clock, or 0 in failure.
>> + */
>> +static int sci_clk_determine_rate(struct clk_hw *hw,
>> +				  struct clk_rate_request *req)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	u64 new_rate;
>> +	int ret;
>> +
>> +	ret = clk->provider->ops->get_best_match_freq(clk->provider->sci,
>> +						      clk->dev_id,
>> +						      clk->clk_id,
>> +						      req->min_rate,
>> +						      req->rate,
>> +						      req->max_rate,
>> +						      &new_rate);
>> +	if (ret) {
>> +		dev_err(clk->provider->dev,
>> +			"determine-rate failed for dev=%d, clk=%d, ret=%d\n",
>> +			clk->dev_id, clk->clk_id, ret);
>> +		return 0;
>> +	}
>> +
>> +	return (int)new_rate;
>
> determine rate should return a negative number on failure and 0
> on success. The actual rate that was found should go into
> req->rate. This looks broken.

Yea it seems broken, I wonder how we haven't seen any issues with this 
in testing.... Apparently positive return values from this are 
interpreted as success. Having a quick look at clk.c seems to confirm this.

Anyway, will fix.

>
>> +}
>> +
>> +/**
>> + * sci_clk_set_rate - Set rate for a TI SCI clock
>> + * @hw: clock to change rate for
>> + * @rate: target rate for the clock
>> + * @parent_rate: rate of the clock parent, not used for TI SCI clocks
>> + *
>> + * Sets a clock frequency for a TI SCI clock. Returns the TI SCI
>> + * protocol status.
>> + */
>> +static int sci_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			    unsigned long parent_rate)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	u64 freq = rate;
>
> We can't just pass rate three times?

I believe we can, will fix.

>
>> +
>> +	return clk->provider->ops->set_freq(clk->provider->sci, clk->dev_id,
>> +					    clk->clk_id, freq, freq, freq);
>> +}
>> +
>> +/**
>> + * sci_clk_get_parent - Get the current parent of a TI SCI clock
>> + * @hw: clock to get parent for
>> + *
>> + * Returns the index of the currently selected parent for a TI SCI clock.
>> + */
>> +static u8 sci_clk_get_parent(struct clk_hw *hw)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +	u8 parent_id;
>> +	int ret;
>> +
>> +	ret = clk->provider->ops->get_parent(clk->provider->sci, clk->dev_id,
>> +					     clk->clk_id, &parent_id);
>> +	if (ret) {
>> +		dev_err(clk->provider->dev,
>> +			"get-parent failed for dev=%d, clk=%d, ret=%d\n",
>> +			clk->dev_id, clk->clk_id, ret);
>> +		return 0;
>> +	}
>> +
>> +	parent_id = parent_id - clk->clk_id - 1;
>> +
>> +	return parent_id;
>
> Why not just return parent_id - clk->clk_id - 1?

Yea will fix that. Looks like a remnant of debugging code (like many 
other mishaps in the driver actually.)

>
>> +}
>> +
>> +/**
>> + * sci_clk_set_parent - Set the parent of a TI SCI clock
>> + * @hw: clock to set parent for
>> + * @index: new parent index for the clock
>> + *
>> + * Sets the parent of a TI SCI clock. Return TI SCI protocol status.
>> + */
>> +static int sci_clk_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	struct sci_clk *clk = to_sci_clk(hw);
>> +
>> +	return clk->provider->ops->set_parent(clk->provider->sci, clk->dev_id,
>> +					      clk->clk_id,
>> +					      index + 1 + clk->clk_id);
>> +}
>> +
>> +static const struct clk_ops sci_clk_ops = {
>> +	.prepare = sci_clk_prepare,
>> +	.unprepare = sci_clk_unprepare,
>> +	.is_prepared = sci_clk_is_prepared,
>> +	.recalc_rate = sci_clk_recalc_rate,
>> +	.determine_rate = sci_clk_determine_rate,
>> +	.set_rate = sci_clk_set_rate,
>> +	.get_parent = sci_clk_get_parent,
>> +	.set_parent = sci_clk_set_parent,
>> +};
>> +
>> +/**
>> + * _sci_clk_get - Gets a handle for an SCI clock
>> + * @provider: Handle to SCI clock provider
>> + * @dev_id: device ID for the clock to register
>> + * @clk_id: clock ID for the clock to register
>> + * @parse_parents: indicator whether parents for this clock should be handled
>> + *
>> + * Gets a handle to an existing TI SCI clock, or builds a new clock
>> + * entry and registers it with the common clock framework. Called from
>> + * the common clock framework, when a corresponding of_clk_get call is
>> + * executed, or recursively from itself when parsing parent clocks.
>> + * Returns a pointer to the clock struct, or ERR_PTR value in failure.
>> + */
>
> Please move this driver to clk_hw_register() and friends. This on
> the fly clk generation is scary considering how we hold locks
> while the provider is asked to give us the pointer, so allocating
> and registering clks (basically reentering the CCF again) could
> lead to a locking nightmare. Best to avoid that.

Ok, so just converting the driver to use provider->get_hw should be 
enough? This seems to be a relatively new API in the CCF. Will look at that.

>
>> +static struct clk *_sci_clk_get(struct sci_clk_provider *provider,
>> +				u16 dev_id, u8 clk_id, bool parse_parents)
>> +{
>> +	struct clk_init_data init = { NULL };
>> +	struct clk *clk;
>> +	struct sci_clk *sci_clk = NULL;
>> +	char name[20];
>> +	char **parent_names = NULL;
>> +	int i;
>> +	int ret;
>> +
>> +	list_for_each_entry(sci_clk, &provider->clocks, node)
>> +		if (sci_clk->dev_id == dev_id && sci_clk->clk_id == clk_id)
>> +			return sci_clk->hw.clk;
>> +
>> +	sci_clk = devm_kzalloc(provider->dev, sizeof(*sci_clk), GFP_KERNEL);
>> +	if (!sci_clk) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	sci_clk->dev_id = dev_id;
>> +	sci_clk->clk_id = clk_id;
>> +	sci_clk->provider = provider;
>> +
>> +	if (parse_parents) {
>> +		ret = provider->ops->get_num_parents(provider->sci, dev_id,
>> +						     clk_id,
>> +						     &init.num_parents);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	snprintf(name, 20, "%s:%d:%d", dev_name(provider->dev), sci_clk->dev_id,
>> +		 sci_clk->clk_id);
>
> I hope we don't make dev_name() longer than 20 characters

Shall I just increase the size of the buffer and add a length check? 
Using kmalloc or something here seems overkill, as the name gets copied 
by CCF anyway.

>
>> +
>> +	init.name = name;
>> +
>> +	if (init.num_parents < 2)
>> +		init.num_parents = 0;
>> +
>> +	if (init.num_parents) {
>> +		parent_names = devm_kcalloc(provider->dev, init.num_parents,
>> +					    sizeof(char *), GFP_KERNEL);
>> +
>> +		if (!parent_names) {
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		for (i = 0; i < init.num_parents; i++) {
>> +			char *parent_name;
>> +
>> +			parent_name = devm_kzalloc(provider->dev, 20,
>> +						   GFP_KERNEL);
>> +			if (!parent_name) {
>> +				ret = -ENOMEM;
>> +				goto err;
>> +			}
>> +			snprintf(parent_name, 20, "%s:%d:%d",
>> +				 dev_name(provider->dev), sci_clk->dev_id,
>> +				 sci_clk->clk_id + 1 + i);
>> +			parent_names[i] = parent_name;
>> +
>> +			_sci_clk_get(provider, dev_id, clk_id + 1 + i, false);
>> +		}
>> +		init.parent_names = (const char * const *)parent_names;
>> +	}
>> +
>> +	init.ops = &sci_clk_ops;
>> +	sci_clk->hw.init = &init;
>> +
>> +	clk = devm_clk_register(provider->dev, &sci_clk->hw);
>> +
>> +	if (IS_ERR(clk)) {
>> +		ret = PTR_ERR(clk);
>> +		dev_err(provider->dev, "failed clk register with %d\n", ret);
>> +		goto err;
>> +	} else {
>> +		list_add(&sci_clk->node, &provider->clocks);
>> +	}
>> +
>> +	return clk;
>> +
>> +err:
>> +	if (parent_names) {
>> +		for (i = 0; i < init.num_parents; i++)
>> +			devm_kfree(provider->dev, parent_names[i]);
>> +
>> +		devm_kfree(provider->dev, parent_names);
>> +	}
>> +
>> +	devm_kfree(provider->dev, sci_clk);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +/**
>> + * sci_clk_get - Xlate function for getting clock handles
>> + * @clkspec: device tree clock specifier
>> + * @data: pointer to the clock provider
>> + *
>> + * Xlate function for retrieving clock TI SCI clock handles based on
>> + * device tree clock specifier. Called from the common clock framework,
>> + * when a corresponding of_clk_get call is executed. Returns a pointer
>> + * to the TI SCI clock struct, or ERR_PTR value in failure.
>> + */
>> +static struct clk *sci_clk_get(struct of_phandle_args *clkspec, void *data)
>> +{
>> +	struct sci_clk_provider *provider = data;
>> +	struct clk *clk;
>> +	u16 dev_id;
>> +	u8 clk_id;
>> +
>> +	if (clkspec->args_count != 2)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	mutex_lock(&provider->lock);
>> +
>> +	dev_id = clkspec->args[0];
>> +	clk_id = clkspec->args[1];
>> +
>> +	clk = _sci_clk_get(provider, dev_id, clk_id, true);
>> +
>> +	mutex_unlock(&provider->lock);
>> +
>> +	return clk;
>> +}
>> +
>> +static const struct of_device_id ti_sci_clk_of_match[] = {
>> +	{ .compatible = "ti,sci-clk" },
>> +	{ /* Sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ti_sci_clk_of_match);
>> +
>> +/**
>> + * ti_sci_clk_parse_flags - Helper function to parse clock flag arrays
>> + * @dev: clock provider device
>> + * @np: device node pointer for the clock provider
>> + * @list_name: property name containing the clocks list
>> + * @flag: flag to apply to the list of clocks
>> + *
>> + * Parses a DT list based on the provided data, and applies the flag value
>> + * for each of the clocks identified by the list. Return 0 for success,
>> + * negative error value for failure.
>> + */
>> +static int ti_sci_clk_parse_flags(struct device *dev, struct device_node *np,
>> +				  const char *list_name, u8 flag)
>> +{
>> +	int num_clks;
>> +	int i;
>> +
>> +	num_clks = of_count_phandle_with_args(np, list_name, "#clock-cells");
>> +
>> +	for (i = 0; i < num_clks; i++) {
>> +		struct of_phandle_args clkspec;
>> +		struct clk_hw *hw;
>> +		struct sci_clk *sci_clk;
>> +		struct clk *clk;
>> +		int ret;
>> +
>> +		ret = of_parse_phandle_with_args(np, list_name, "#clock-cells",
>> +						 i, &clkspec);
>
> Do we really need to parse the phandle and get a clk from the
> provider that is our own driver? We should be able to get a hw
> pointer by calling our xlate_hw function with the two cells
> instead and completely bypass generating a clk structure.

Will investigate this, but you are probably right. Generating the clk 
structure can be bypassed at least with transition to provider->get_hw.

>
>> +		if (ret) {
>> +			dev_err(dev, "Failed to parse %s[%d] = %d\n", list_name,
>> +				i, ret);
>> +			return ret;
>> +		}
>> +		clk = of_clk_get_from_provider(&clkspec);
>> +		if (IS_ERR(clk)) {
>> +			dev_err(dev, "clk_get failed for %s[%d] = %ld\n",
>> +				list_name, i, PTR_ERR(clk));
>> +			return PTR_ERR(clk);
>> +		}
>> +		hw = __clk_get_hw(clk);
>> +		sci_clk = to_sci_clk(hw);
>> +
>> +		sci_clk->flags |= flag;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ti_sci_clk_probe - Probe function for the TI SCI clock driver
>> + * @pdev: platform device pointer to be probed
>> + *
>> + * Probes the TI SCI clock device. Allocates a new clock provider
>> + * and registers this to the common clock framework. Also applies
>> + * any required flags to the identified clocks via clock lists
>> + * supplied from DT. Returns 0 for success, negative error value
>> + * for failure.
>> + */
>> +static int ti_sci_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct sci_clk_provider *provider;
>> +	const struct ti_sci_handle *handle;
>> +
>> +	if (!np) {
>> +		dev_err(dev, "OF data missing\n");
>> +		return -EINVAL;
>> +	}
>
> Is this ever true? Seems useless.

Probably not, the SoC this code is run on is always DT. Will drop this.

>
>> +
>> +	handle = devm_ti_sci_get_handle(dev);
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>> +
>> +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
>> +	if (!provider)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&provider->clocks);
>> +	mutex_init(&provider->lock);
>> +
>> +	provider->sci = handle;
>> +	provider->ops = &handle->ops.clk_ops;
>> +	provider->dev = dev;
>> +
>> +	of_clk_add_provider(np, sci_clk_get, provider);
>
> This could fail.

Yea, will add error handling.

>
>> +
>> +	ti_sci_clk_parse_flags(dev, np, "ti,ssc-clocks", SCI_CLK_SSC_ENABLE);
>> +	ti_sci_clk_parse_flags(dev, np, "ti,allow-freq-change-clocks",
>> +			       SCI_CLK_ALLOW_FREQ_CHANGE);
>> +	ti_sci_clk_parse_flags(dev, np, "ti,input-term-clocks",
>> +			       SCI_CLK_INPUT_TERMINATION);
>> +
>> +	dev_info(dev, "initialized.\n");
>
> debug noise?

True, will drop.

>
>> +
>> +	return 0;
>> +}
>> +
