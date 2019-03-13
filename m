From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v5] PM / devfreq: Restart previous governor if new
 governor fails to start
Date: Wed, 13 Mar 2019 11:31:01 +0530
Message-ID: <2b78582a74ae7a17ed2f27187f3f32f4@codeaurora.org>
References: <20190311100630.12952-1-sibis@codeaurora.org>
 <CGME20190311100759epcas5p41fc634cd67a99b39cd25c4129e489c4c@epcms1p2>
 <20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 2019-03-12 12:47, MyungJoo Ham wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>> 
>> If the new governor fails to start, switch back to old governor so 
>> that the
>> devfreq state is not left in some weird limbo.
>> 
>> [Mjungjoo: assume fatal on revert failure and set df->governor to 
>> NULL]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> I'll modify WARN->ERROR for the case when it's fatal:

Sure, thanks.

> 
>> +		if (ret) {
>> +			dev_warn(dev,
>> +				 "%s: reverting to Governor %s failed (%d)\n",
>> +				 __func__, df->governor_name, ret);
>> +			df->governor = NULL;
>> +		}
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> 
>> ---
>> V5:
>> * assume fatal on revert failure and set df->governor to NULL
>> 
>> V4:
>> * Removed prev_governor check.
>> 
>> V3:
>> * Fix NULL deref for real this time.
>> * Addressed some style preferences.
>> 
>> V2:
>> * Fixed typo in commit text
>> * Fixed potential NULL deref
>> 
>> drivers/devfreq/devfreq.c | 16 ++++++++++++++--
>> 1 file changed, 14 insertions(+), 2 deletions(-)
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
