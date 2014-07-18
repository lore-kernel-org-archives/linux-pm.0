From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v3] PM / devfreq: Add possible_frequencies device attribute
Date: Thu, 17 Jul 2014 20:32:54 -0700
Message-ID: <53C89566.9020505@codeaurora.org>
References: <725805840.101171405558256488.JavaMail.weblogic@epmlwas01c>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:56661 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbaGRDcz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 23:32:55 -0400
In-Reply-To: <725805840.101171405558256488.JavaMail.weblogic@epmlwas01c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 07/16/2014 05:50 PM, MyungJoo Ham wrote:
> On Wed, Jul 16, 2014 at 12:01 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
>> Some devices use freq_table instead of OPP. For those devices, the
>> available_frequencies sysfs file shows up empty. So, add a
>> possible_frequencies attribute/syfs file that list all the possible
>> frequencies.
>>
>> For devices that use OPP, the output of this file will match
>> available_frequencies. It may change in the future to show all OPP
>> frequencies -- even the disabled ones.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> 
> Hi,
> 
> 
> Please add a documentation entry for this new ABI having a little justification and usage included.

Will do.

> 
> Plus, I am considering to move trans_stat along with this entry to somewhere such as .../stat/*
> (you don't need to take care of this.)

Ok.

> 
> Besides, as OPP seems becoming the standard as imagined when devfreq development started,
> soon, devfreq may require OPP unless the devfreq device has continuous frequencies.

I agree. Only one caveat with OPP is that if a device isn't using OPP to
do any voltage scaling, then it forces a voltage column with 0s. Also,
even if we make OPP mandatory, we'll still want trans_stats that
currently seem to depend on freq_table being populated. I was actually
planning on sending out more patches later that'll do a lot of stuff
automatically for devices with OPP. Like creating freq_table, etc.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
