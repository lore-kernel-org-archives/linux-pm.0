From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Mon, 21 Oct 2013 17:38:58 +0100
Message-ID: <526558A2.5050900@gmail.com>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch> <1382186261-14482-2-git-send-email-andrew@lunn.ch> <52650523.80400@gmail.com> <20131021154239.GB23593@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:60972 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab3JUQjn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 12:39:43 -0400
Received: by mail-bk0-f48.google.com with SMTP id my13so829019bkb.7
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 09:39:42 -0700 (PDT)
In-Reply-To: <20131021154239.GB23593@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On 10/21/2013 04:42 PM, Andrew Lunn wrote:
>>> +	if (freqs.old != freqs.new) {
>>> +		local_irq_disable();
>>> +
>>> +		/* Mask IRQ and FIQ to CPU */
>>> +		cr = readl(priv.pmu_cr);
>>> +		cr |= MASK_IRQ | MASK_FIQ;
>>> +		writel(cr, priv.pmu_cr);
>>> +
>>> +		/* Set/Clear the CPU_SLOW_EN bit */
>>> +		reg = readl_relaxed(priv.dfs + DFS_CR);
>>> +		reg &= ~L2_RATIO_MASK;
>>> +
>>> +		switch (state) {
>>> +		case STATE_CPU_FREQ:
>>> +			reg |= priv.xpratio;
>>> +			reg &= ~CPU_SLOW_EN;
>>> +			break;
>>> +		case STATE_DDR_FREQ:
>>> +			reg |= (priv.dpratio | CPU_SLOW_EN);
>>
>> Does slow mode really (only) depend on the value written into CPUL2CR?
>> Dove FS isn't that chatty about it and I cannot really test right now.
>> But reading it, I think there is two CPU PLL to {L2,DDR} ratios that you
>> can switch between by (de-)asserting CPU_SLOW_EN.
>
> The lack of details in the datasheet was very annoying. I spent many
> evenings looking at a frozen up cubox. In the end i had to risk eye
> cancer and look at the Marvell vendor code. It always sets these
> values on each transition, and it even calculated one of the ratios
> each time the frequency changed. I never actually tried setting them
> once and then leaving them alone. Worth a try once i have the hardware
> available.

I actually just tried it and realized that both xpratio and dpratio are
equal (=4). And I wonder that not setting l2 ratio hangs it, while not
setting ddr ratio is fine. Anyway, without proper documentation IMHO
your approach is as fine as it can get. We can have a closer look at
it, when we both have time/tools/space available.

>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	priv.dfs = devm_ioremap_resource(&pdev->dev, res);
>>> +	if (IS_ERR(priv.dfs))
>>> +		return PTR_ERR(priv.dfs);
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +	priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
>>> +	if (IS_ERR(priv.pmu_cr))
>>
>> Cleanup path for most of the resources here and below is kind of
>> missing.
>
> Well, i'm using devm_ioremap_resources().  The cleanup for that should
> happen automagically. And platform_get_resource() is just a lookup
> function.

True. But e.g. on the clock errors, you do not drop node or clk. No
clk_disable_unprepare on irq failures or if cpufreq_register_driver
fails.

>> Also, maybe give names to the different areas and not depend
>> on ordering?
>
> Actually, they already have names, but you probably have not go to
> that patch yet. So swapping to platform_get_resource_byname() would be
> simple.

I did flip over the non-DT resources and now (finally) realized, that
there is no specific DT node (You told me at least twice before).

Currently, I don't see why cpufreq shouldn't get its own node as this
adds dependency to legacy code we are trying to get rid of. But as you
already said, let's wait for summit results on DT future.

BTW, have another look at the resource names and remove the ':' (or
add it to all).

See you soon,

Sebastian

