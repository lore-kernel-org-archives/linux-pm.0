From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 09/11] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
Date: Tue, 12 May 2015 08:32:12 +0530
Message-ID: <55516D34.1000501@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org> <1429017137-20218-10-git-send-email-rnayak@codeaurora.org> <554249AF.6070909@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <554249AF.6070909@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: sboyd@codeaurora.org, mturquette@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

[]
>>
>> +static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
>> +{
>> +	int ret;
>> +	struct gdsc *sc = domain_to_gdsc(domain);
>> +	char **con_id;
>> +
>> +	if (!sc->con_ids[0])
>> +		return 0;
>
> Did you test this on your side? It panic kernel badly cause the flexible
> array is not initialised.
>
> Could you revisit the above check. Or you could add below initialisation
> for every gdsc structure in gcc-xxx.c files.

Hey, that does seem like a problem. Not sure how I did not end up
seeing it. I'll fix it up, thanks.

>
> static struct gdsc venus_gdsc = {
> 	.gdscr = 0x4c018,
> 	.pd = {
> 		.name = "venus",
> 	},
> 	.con_ids = { NULL },
> };
>
>
>> +
>> +	ret = pm_clk_create(dev);
>> +	if (ret) {
>> +		dev_err(dev, "pm_clk_create failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (con_id = sc->con_ids; *con_id; con_id++) {
>> +		ret = pm_clk_add(dev, *con_id);
>> +		if (ret) {
>> +			dev_err(dev, "pm_clk_add failed %d\n", ret);
>> +			goto fail;
>> +		}
>> +	}
>> +	return 0;
>> +fail:
>> +	pm_clk_destroy(dev);
>> +	return ret;
>> +};
>> +
>
> <snip>
>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
