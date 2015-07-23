From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
Date: Thu, 23 Jul 2015 14:05:48 +0530
Message-ID: <55B0A764.6010708@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-5-git-send-email-rnayak@codeaurora.org> <55B03D65.8040207@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38692 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbGWIfz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 04:35:55 -0400
In-Reply-To: <55B03D65.8040207@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

[]..

>> +
>> +#ifndef CONFIG_PM
>> +static void enable_clock(struct device *dev, const char *con_id)
>> +{
>> +    struct clk *clk;
>> +
>> +    clk = clk_get(dev, con_id);
>> +    if (!IS_ERR(clk)) {
>> +        clk_prepare_enable(clk);
>> +        clk_put(clk);
>> +    }
>> +}
>> +
>> +static void disable_clock(struct device *dev, const char *con_id)
>> +{
>> +    struct clk *clk;
>> +
>> +    clk = clk_get(dev, con_id);
>> +    if (!IS_ERR(clk)) {
>> +        clk_disable_unprepare(clk);
>> +        clk_put(clk);
>> +    }
>> +}
>
> Is there a reason why this whole patch isn't generic code? I recall some
> discussion but I forgot now and there isn't any mention of why this
> isn't generic code in the commit text.

If by generic code, you mean using PM clocks, then this thread should
give some context..
http://www.spinics.net/lists/arm-kernel/msg414072.html
