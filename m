From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 01/13] clk: qcom: Add support for GDSCs
Date: Thu, 23 Jul 2015 11:04:14 -0700
Message-ID: <55B12C9E.6070208@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-2-git-send-email-rnayak@codeaurora.org> <55B03495.8050902@codeaurora.org> <55B0AF34.2000706@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55B0AF34.2000706@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 07/23/2015 02:09 AM, Stanimir Varbanov wrote:
> <snip>
>
>>
>> +
>> +void gdsc_unregister(struct device *dev)
>> +{
>> +    of_genpd_del_provider(dev->of_node);
>> +}
>> EXPORT_SYMBOL?
> Stephen, gdsc_register/unregister are internal to the qcom clk driver
> why to export them?
>

Ah, I thought this was being called from outside the clk-qcom.ko module. 
As long as we don't call them from a SoC specific driver then it should 
be ok to leave them unexported. Perhaps we should remove the export on 
qcom_find_freq() too?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
