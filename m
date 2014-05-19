From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v2] PM / devfreq: Use freq_table for available_frequencies
Date: Mon, 19 May 2014 16:01:28 -0700
Message-ID: <537A8D48.7020201@codeaurora.org>
References: <30733097.432311399543337408.JavaMail.weblogic@epv6ml09>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <30733097.432311399543337408.JavaMail.weblogic@epv6ml09>
Sender: linux-arm-msm-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 05/08/2014 03:02 AM, MyungJoo Ham wrote:
>> On 04/29/2014 01:00 PM, Saravana Kannan wrote:
>>> On 04/27/2014 06:41 PM, MyungJoo Ham wrote:
>>>> You are hereby changing the semmantics of the original
>>>> available_frequencies node.
>>>>
>>>> When a frequency/voltage pair has been disabled (opp_disable), probably
>>>> by opp_disable(), the frequency is no more "available".
>>>> However, when the driver author supplied freq_table as well as OPP
>>>> in order to see the statistics, the node will behave differently.
>>>>
>>>> Please do not affect the current users as long as it does not give
>>>> additional benefit or fix a bug.
>>>
>>> I was actually trying to stick with the semantics as it was documented.
>>> The documentation for this file says it'll show frequencies that are not
>>> allowed by the current min/max settings either. To me, an OPP disable
>>> seems similar to some frequencies "disabled" by min/max settings.
>>>
>>> Giving preference to OPP is not a hard change to do, but it seems to go
>>> againsts the documented semantics.
>>>
>>> Thoughts?
>>
>> I'll send out another patch like you wanted -- with OPP being given
>> preference over freq_table when listing frequencies.
>>
>> But I would still like to hear your thoughts. As of today, there's no
>> clean way to get the complete list of available frequencies that would
>> give a consistent output irrespective of the temporary limits/conditions
>> imposed by thermal, current limiting, etc. The round about way is to cat
>> trans_stat and parse the frequencies from that.
>>
>> That's why I was trying to give preference to freq_table.
>>
>> Thanks,
>> Saravana
> 
> The node, available_frequencies, was suggested before freq_table concept.
> At that time, available_frequencies was supposed to show the list of
> available OPP lists for those who use OPP for devfreq device, excluding
> those disabled by OPP. (OPP lists are external to devfreq and devfreq's
> min/max are internal to devfreq)
> 
> Locally, this node has been used to debug the behavior of a devfreq device.
> With min/max nodes, we know the range while we cannot (easily at shell)
> see which OPP points are available at the moment, where we have been able
> to use available_frequencies.
> 
> We do not want to lose such capavility as long as we do not have OPP sysfs
> automatically assigned to any OPP lists. If I remember correctly, we don't
> have it, yet.
> 
> 
> A. I want to minimize semantics changes in sysfs. Adding another without
> interfering with previous usage is ok.
> B. (more importantly) I don't want to lose the debugging capabilities.
> 

Thanks for the response MyungJoo. Makes sense. I was also discussing
this internally and was considering a "possible_frequencies" similar to
available vs possible CPUs.

I'll make such a patch for that and send it out. In that case, I'll
probably leave "available_frequencies" alone.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
