From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Tue, 27 Jan 2015 18:18:59 -0700
Message-ID: <20150128011859.GA680@linaro.org>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
 <20150127160311.GB504@linaro.org>
 <003301d03a95$266efb50$734cf1f0$@codeaurora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003301d03a95$266efb50$734cf1f0$@codeaurora.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Narendran Rajan <nrajan@codeaurora.com>
Cc: 'Narendran Rajan' <nrajan@codeaurora.org>, 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <edubezval@gmail.com>, 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Siddartha Mohanadoss' <smohanad@codeaurora.org>, 'Stephen Boyd' <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 27 2015 at 17:55 -0700, Narendran Rajan wrote:
>
>> -----Original Message-----
>> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
>> owner@vger.kernel.org] On Behalf Of Lina Iyer
>> Sent: Tuesday, January 27, 2015 8:03 AM
>> To: Narendran Rajan
>> Cc: Zhang Rui; Eduardo Valentin; Linux ARM MSM; Linux PM; Siddartha
>> Mohanadoss; Stephen Boyd
>> Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
>>
>> On Mon, Jan 26 2015 at 21:10 -0700, Narendran Rajan wrote:
>> >TSENS supports reading temperature from multiple thermal sensors
>> >present in QCOM SOCs.
>> >TSENS HW is enabled only when the main sensor is requested.
>> >The TSENS block is disabled if the main senors is disabled irrespective
>> >of any other sensors that are being enabled.
>> >TSENS driver supports configurable threshold for temperature monitoring
>> >in which case it can generate an interrupt when specific thresholds are
>> >reached
>> >
>> >Based on code by Siddartha Mohanadoss and Stephen Boyd.
>> >
>> >Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
>> >Cc: Stephen Boyd <sboyd@codeaurora.org>
>> >Signed-off-by: Narendran Rajan  <nrajan@codeaurora.org>
>> >---

[...]
>> >+	regmap_field_update_bits(status,
>> >+			TSENS_UPPER_STATUS_CLR |
>> TSENS_LOWER_STATUS_CLR, mask);
>>
>> Can TSENS IRQ fire before this write?
>
>Yes it can as per document, let me run further experiments and update.
>
If the IRQ fires before this work-fn() is complete, schedule_work() would not
reschedule. 

>> >+}
>> >+
>> >+static irqreturn_t tsens_isr(int irq, void *data) {
>> >+	schedule_work(data);
>>
>> You probably want to reduce the latency of interrupt notifications here.
>> If the kernel wq gets loaded up, your IRQ handling would suffer as well.
>
>Good point.  Thx. Let me run further experiments on interrupt firing to
>confirm the behavior on interrupt frequency and load.
>PS: By default thermal framework uses a polling mode and default thresholds
>set are very high.
>
Yes, sure. But thermal ramps are better handled immediately. IRQs are
the most preferred on production devices.

>>
>> >+	return IRQ_HANDLED;
>> >+}
>> >+

[...]
> >+static struct of_device_id tsens_match_table[] = {
>> >+	{.compatible = "qcom,ipq806x-tsens"},
>> >+	{},
>> >+};
>> >+
>> >+MODULE_DEVICE_TABLE(of, tsens_match_table);
>> >+
>> >+static struct platform_driver tsens_driver = {
>> >+	.probe = tsens_probe,
>> >+	.remove = tsens_remove,
>> >+	.driver = {
>> >+		.of_match_table = tsens_match_table,
>> >+		.name = "tsens8960-thermal",
>>
>> Curious, why specifically 8960?
>
>I guess your point is why not tsens-thermal ?
>There are different versions of tsens controller used within QCOM SoCs.
>May need a different driver for newer versions of this controller.
>Picked 8960 as I guess this was the earliest chip where this controller was
>used.

It would be nice if you keep this generic, as it will be applicable to a
slew of QCOM SoC's. I havent seen it change much in the past few SoCs.
You could also use the compatible flag for any small revisional changes.

>
>>
>> >+		.owner = THIS_MODULE,
>> >+#ifdef CONFIG_PM
>> >+		.pm	= &tsens_pm_ops,
>> >+#endif
>> >+	},
>> >+};
>> >+module_platform_driver(tsens_driver);
>> >+
>> >+MODULE_LICENSE("GPL v2");
>> >+MODULE_DESCRIPTION("Temperature Sensor driver");
>> >+MODULE_ALIAS("platform:tsens8960-tm");
>> >--
>> >Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc.
>> >is a member of the Code Aurora Forum, a Linux Foundation Collaborative
>> >Project
>> >
>> >--
>> >To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> >the body of a message to majordomo@vger.kernel.org More majordomo
>> info
>> >at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
>in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>--Naren
>
