From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH] devfreq: do not ignore errors during store min, max
 frequency
Date: Thu, 27 Apr 2017 12:04:15 +0100
Message-ID: <f02c5605-be71-79da-a33d-75e2d041029b@arm.com>
References: <1493281427-8671-1-git-send-email-lukasz.luba@arm.com>
 <CGME20170427082416epcas3p3b9aeb23978707b164b4d4a46156d1216@epcms1p5>
 <20170427083057epcms1p5f916dda5e9fe0275a915963b96dc28d5@epcms1p5>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968407AbdD0LES (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Apr 2017 07:04:18 -0400
In-Reply-To: <20170427083057epcms1p5f916dda5e9fe0275a915963b96dc28d5@epcms1p5>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi MyungJoo,

On 27/04/17 09:30, MyungJoo Ham wrote:
>> This patch adds functionality to make sure when a call to set a new
>> max or min frequency is possible.
>> If storing the new value was not possible, restore previous one
>> and forward the error value.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> It is based on v4.11-rc8.
>>
>>  drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> ...
>
>> +	ret = devfreq_get_freq_level(df, value);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "Storing min freq failed with (%d) error\n", ret);
>> +		goto unlock;
>> +	}
>> +
>
> This is not good.
>
> For a device that supports [ 100, 400, 800, 1000 ] MHz,
> saying "min = 200 Mhz" or "max = 600 MHz" shouldn't be prohibited.
>
> Those functions are to express lower bound and upper bound, not to
> designate the exact operating frequencies.

Would it be possible to convince you to store a
'posible/valid frequency' (from OPP) in that value?
Governors (like simpleondemand) and drivers use it with the flags.
It would be useful for thermal subsystem. It could have the max/min for 
the devfreq device.

I could prepare a patch which sets the freq from OPP respecting
rounding up/down based on 'devfreq_recommended_opp()'.

Regards,
Lukasz
