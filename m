From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
Date: Thu, 08 Oct 2015 12:43:14 +0530
Message-ID: <5616178A.6000202@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org> <1444280468-17159-5-git-send-email-rnayak@codeaurora.org> <20151008060557.GD26883@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48153 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbbJHHNX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 03:13:23 -0400
In-Reply-To: <20151008060557.GD26883@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com



On 10/08/2015 11:35 AM, Stephen Boyd wrote:
> On 10/08, Rajendra Nayak wrote:
>> @@ -3520,11 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>>  	if (IS_ERR(clk))
>>  		return PTR_ERR(clk);
>>  
>> -	return qcom_cc_probe(pdev, match->data);
>> +	ret = qcom_cc_probe(pdev, match->data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	tsens = platform_device_register_data(&pdev->dev, "qcom-tsens", -1,
>> +					      NULL, 0);
>> +	if (IS_ERR(tsens)) {
>> +		qcom_cc_remove(pdev);
>> +		return PTR_ERR(tsens);
>> +	}
>> +	platform_set_drvdata(pdev, tsens);
> 
> We just blew away the pointer that qcom_cc_probe() stores.

Oops, I seem to have completely overlooked that.

> 
>> +
>> +	return 0;
>>  }
>>  
>>  static int gcc_msm8960_remove(struct platform_device *pdev)
>>  {
>> +	struct platform_device *tsens = platform_get_drvdata(pdev);
>> +
>> +	platform_device_unregister(tsens);
>>  	qcom_cc_remove(pdev);
> 
> So now we've leaked the reset controller.
> 
> I suppose the simplest solution is to get the drvdata pointer
> after qcom_cc_probe(), allocate a container structure to hold
> that as a void * plus the tsens device, i.e.
> 
> 	struct container {
> 		void *data;
> 		struct platform_device *tsens;
> 	};
> 	
> and then set the drvdata to that. And finally undo all that and
> restore the drvdata pointer on remove.
> 
> I've also been considering putting some devm stuff inside
> qcom_cc_probe() itself so that in the normal case you don't even
> need to call qcom_cc_remove(), it just gets done automatically.
> That would open up the possibility for drivers to use the drvdata
> member as they wish.

I'll test with the patch you just sent.

> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
