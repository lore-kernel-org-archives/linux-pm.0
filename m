From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
Date: Mon, 04 Mar 2019 13:51:53 +0530
Message-ID: <946aa4e13aec4f84e6ae2d91e772fb1f@codeaurora.org>
References: <20181212135313.30268-1-sibis@codeaurora.org>
 <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p6>
 <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
 <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hey MyungJoo, Kyungmin
Did you get a chance to think about how you
want this fix implemented?

On 2019-02-19 10:42, Sibi Sankar wrote:
> Hey MyungJoo,
> 
> On 12/14/18 7:15 AM, MyungJoo Ham wrote:
>>> From: Saravana Kannan <skannan@codeaurora.org>
>>> 
>>> If the new governor fails to start, switch back to old governor so 
>>> that the
>>> devfreq state is not left in some weird limbo.
>>> 
>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> 
>> Hello,
>> 
>> In overall, the idea and the implementation looks good.
>> 
>> However, I have a question:
>> 
>> What if the following line fails?
>> 
>> +		df->governor->event_handler(df, DEVFREQ_GOV_START,
>> +					    NULL);
>> 
>> Don't we still need something to handle for such events?
> 
> The original discussion went as follows:
> governor_store is expected to be used only on cases
> where devfreq_add_device() succeeded i.e prev->governor
> is expected to be present and DEVFREQ_GOV_START is
> expected to succeed. Hence falling back to the previous
> governor seems like a sensible idea.
> 
> This would also prevent DEVFREQ_GOV_STOP from being called
> on a governor were DEVFREQ_GOV_START had failed which is
> ideal.
> 
> That being said DEVFREQ_GOV_START can still fail for the
> prev-governor due to some change in state of the system.
> Do you want to handle this case by clearing the state of
> governor rather than switching to previous governor?
> 
>> 
>> Cheers,
>> MyungJoo
>> 
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
