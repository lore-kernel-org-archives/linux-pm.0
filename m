From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v2] PM / devfreq: Use freq_table for available_frequencies
Date: Mon, 05 May 2014 11:18:35 -0700
Message-ID: <5367D5FB.2080305@codeaurora.org>
References: <4324793.197151398649314597.JavaMail.weblogic@epv6ml10> <536004E9.1010300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <536004E9.1010300@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/29/2014 01:00 PM, Saravana Kannan wrote:
> On 04/27/2014 06:41 PM, MyungJoo Ham wrote:
>> You are hereby changing the semmantics of the original
>> available_frequencies node.
>>
>> When a frequency/voltage pair has been disabled (opp_disable), probably
>> by opp_disable(), the frequency is no more "available".
>> However, when the driver author supplied freq_table as well as OPP
>> in order to see the statistics, the node will behave differently.
>>
>> Please do not affect the current users as long as it does not give
>> additional benefit or fix a bug.
> 
> I was actually trying to stick with the semantics as it was documented.
> The documentation for this file says it'll show frequencies that are not
> allowed by the current min/max settings either. To me, an OPP disable
> seems similar to some frequencies "disabled" by min/max settings.
> 
> Giving preference to OPP is not a hard change to do, but it seems to go
> againsts the documented semantics.
> 
> Thoughts?

I'll send out another patch like you wanted -- with OPP being given
preference over freq_table when listing frequencies.

But I would still like to hear your thoughts. As of today, there's no
clean way to get the complete list of available frequencies that would
give a consistent output irrespective of the temporary limits/conditions
imposed by thermal, current limiting, etc. The round about way is to cat
trans_stat and parse the frequencies from that.

That's why I was trying to give preference to freq_table.

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
