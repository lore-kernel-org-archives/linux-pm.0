From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2] power/reset: zx: Register restart handler
Date: Tue, 14 Jul 2015 09:42:39 +0800
Message-ID: <CABymUCPmXH2VhU-rtpuq2eavbb1oAzAk_6gXqSPBJCvPcF5ZrA@mail.gmail.com>
References: <1436171730-21175-1-git-send-email-jun.nie@linaro.org>
	<20150713120019.GB9128@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34007 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbGNBmk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 21:42:40 -0400
Received: by lbbzr7 with SMTP id zr7so9470003lbb.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2015 18:42:39 -0700 (PDT)
In-Reply-To: <20150713120019.GB9128@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Jason Liu <jason.liu@linaro.org>

2015-07-13 20:00 GMT+08:00 Sebastian Reichel <sre@kernel.org>:
> Hi,
>
> On Mon, Jul 06, 2015 at 04:35:30PM +0800, Jun Nie wrote:
>> Register with kernel restart handler instead of setting arm_pm_restart
>> directly.
>>
>> [...]
>>
>> +static void __iomem *base;
>> +static void __iomem *pcu_base;
>> +
>> +static int zx_restart_handler(struct notifier_block *this,
>> +                           unsigned long mode, void *cmd)
>> +{
>> +     writel_relaxed(1, base + 0xb0);
>> +     writel_relaxed(1, pcu_base + 0x34);
>> +
>> +     while (1)
>> +             cpu_do_idle();
>
> mdelay(some_time);
> pr_emerg("Unable to restart system\n");

I do not think these code can be executed as reset will happen after
register writing and while loop will stop any further code execution.
Please point out issue if any.

>
>> +
>> +     return NOTIFY_DONE;
>> +}
>> +
>>
>> [...]
>>
>> +static int zx_reboot_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     int err;
>> +
>> +     base = of_iomap(np, 0);
>> +     if (!base) {
>> +             WARN(1, "failed to map base address");
>> +             return -ENODEV;
>> +     }
>> +
>> +     np = of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
>> +     pcu_base = of_iomap(np, 0);
>> +     if (!pcu_base) {
>> +             iounmap(base);
>> +             WARN(1, "failed to map pcu_base address");
>> +             return -ENODEV;
>> +     }
>> +
>> +     err = register_restart_handler(&zx_restart_nb);
>> +     if (err)
>> +             dev_err(&pdev->dev, "Register restart handler failed(err=%d)\n",
>> +                     err);
>> +
>> +     return err;
>> +}
>> +
>> +static const struct of_device_id zx_reboot_of_match[] = {
>> +     { .compatible = "zte,sysctrl" },
>> +     {}
>> +};
>
> Where's the DT Binding Documentation?
DT document is in Documentation/devicetree/bindings/arm/zte.txt

>
>> [...]
>
> -- Sebastian
