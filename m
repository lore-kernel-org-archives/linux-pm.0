From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Rewrite devfreq_update_status() to fix
 multiple bugs
Date: Tue, 04 Mar 2014 12:25:24 -0800
Message-ID: <531636B4.1060202@codeaurora.org>
References: <8984550.302431393927576253.JavaMail.weblogic@epv6ml05>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8984550.302431393927576253.JavaMail.weblogic@epv6ml05>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 03/04/2014 02:06 AM, MyungJoo Ham wrote:
>> The current devfreq_update_status() has the following bugs:
>> - If previous frequency doesn't have a valid level, it does an out of bounds
>>    access into the trans_table and causes memory corruption.
>> - When the new frequency doesn't have a valid level, the time spent in the
>>    new frequency is counted towards the next valid frequency switch instead of
>>    being ignored.
>> - The time spent on the previous frequency is added to the new frequency's
>>    stats instead of the previous frequency's stats.
>>
>> This patch fixes all of this.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> 
> Merged.
> 
> It appears to be Greg's LTS material as well.
> 

Thanks!

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
