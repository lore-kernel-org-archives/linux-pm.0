From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC/RFT 5/6] i2c: qup: Get rid of clock handling as its done
 using runtime callbacks
Date: Mon, 27 Apr 2015 08:06:39 +0530
Message-ID: <553DA0B7.8090900@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org> <1429778744-13352-6-git-send-email-rnayak@codeaurora.org> <70706FC9-46A8-4A34-9E11-558ECD23EDE2@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57625 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbbD0Cgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2015 22:36:44 -0400
In-Reply-To: <70706FC9-46A8-4A34-9E11-558ECD23EDE2@mm-sol.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi Ivan,

On 04/25/2015 12:31 PM, Ivan T. Ivanov wrote:
> Hi Rajendra,
>
>> On Apr 23, 2015, at 11:45 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> Remove all clock handling from the driver as this is not handled from
>> within platform runtime callbacks.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>> drivers/i2c/busses/i2c-qup.c | 74 ++++++++++----------------------------------
>> 1 file changed, 16 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
>> index fdcbdab..465a2b2 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -104,7 +104,6 @@ struct qup_i2c_dev {
>> 	void __iomem		*base;
>> 	int			irq;
>> 	struct clk		*clk;
>> -	struct clk		*pclk;
>> 	struct i2c_adapter	adap;
>>
>> 	int			clk_ctl;
>> @@ -532,24 +531,6 @@ static struct i2c_adapter_quirks qup_i2c_quirks = {
>> 	.max_read_len = QUP_READ_LIMIT,
>> };
>>
>> -static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
>> -{
>> -	clk_prepare_enable(qup->clk);
>> -	clk_prepare_enable(qup->pclk);
>> -}
>> -
>> -static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>> -{
>> -	u32 config;
>> -
>> -	qup_i2c_change_state(qup, QUP_RESET_STATE);
>> -	clk_disable_unprepare(qup->clk);
>> -	config = readl(qup->base + QUP_CONFIG);
>> -	config |= QUP_CLOCK_AUTO_GATE;
>> -	writel(config, qup->base + QUP_CONFIG);
>> -	clk_disable_unprepare(qup->pclk);
>> -}
>> -
>> static int qup_i2c_probe(struct platform_device *pdev)
>> {
>> 	static const int blk_sizes[] = {4, 16, 32};
>> @@ -596,13 +577,10 @@ static int qup_i2c_probe(struct platform_device *pdev)
>> 		return PTR_ERR(qup->clk);
>> 	}
>>
>> -	qup->pclk = devm_clk_get(qup->dev, "iface");
>> -	if (IS_ERR(qup->pclk)) {
>> -		dev_err(qup->dev, "Could not get iface clock\n");
>> -		return PTR_ERR(qup->pclk);
>> -	}
>> -
>> -	qup_i2c_enable_clocks(qup);
>> +	pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
>> +	pm_runtime_use_autosuspend(qup->dev);
>> +	pm_runtime_enable(qup->dev);
>> +	pm_runtime_get_sync(qup->dev);
>>
>> 	/*
>> 	 * Bootloaders might leave a pending interrupt on certain QUP's,
>> @@ -673,22 +651,15 @@ static int qup_i2c_probe(struct platform_device *pdev)
>> 	qup->adap.dev.of_node = pdev->dev.of_node;
>> 	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
>>
>> -	pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
>> -	pm_runtime_use_autosuspend(qup->dev);
>> -	pm_runtime_set_active(qup->dev);
>> -	pm_runtime_enable(qup->dev);
>> -
>> 	ret = i2c_add_adapter(&qup->adap);
>> 	if (ret)
>> -		goto fail_runtime;
>> +		goto fail;
>>
>> 	return 0;
>>
>> -fail_runtime:
>> +fail:
>> 	pm_runtime_disable(qup->dev);
>> 	pm_runtime_set_suspended(qup->dev);
>> -fail:
>> -	qup_i2c_disable_clocks(qup);
>> 	return ret;
>> }
>
>
> Same thing like in MMC driver. Clocks should be explicitly
> enabled because CONFIG_PM could be off.

Like I responded on the mmc driver patch thread [1], pm_clk_notify()
already takes care of enabling all clocks (during driver bind) in
case CONFIG_PM is disabled.

[1] http://www.spinics.net/lists/arm-kernel/msg413898.html

regards,
Rajendra
