From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 3/4] thermal: rcar: Add missing clock handling
Date: Wed, 08 Jan 2014 12:20:00 +0000
Message-ID: <52CD4270.3010907@codethink.co.uk>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org> <1389121036-3555-4-git-send-email-geert@linux-m68k.org> <20140107205719.GL20094@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140107205719.GL20094@book.gsilab.sittig.org>
Sender: linux-sh-owner@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/01/14 20:57, Gerhard Sittig wrote:
> On Tue, Jan 07, 2014 at 19:57 +0100, Geert Uytterhoeven wrote:
>>
>> @@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>   	spin_lock_init(&common->lock);
>>   	common->dev = dev;
>>
>> +	common->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(common->clk)) {
>> +		dev_err(&pdev->dev, "cannot get clock\n");
>> +		return PTR_ERR(common->clk);
>> +	}
>> +
>> +	ret = clk_prepare(common->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "unable to prepare clock\n");
>> +		return ret;
>> +	}
>> +
>> +	clk_enable(common->clk);
>> +
>>   	pm_runtime_enable(dev);
>>   	pm_runtime_get_sync(dev);
>
> clk_enable() can fail, too, so you should check its return value

Also, if you enable the pm-runtime then the device clock is actually
handled by the common pm-clock framework.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
