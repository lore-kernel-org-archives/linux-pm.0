From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency
 driver
Date: Mon, 23 Feb 2015 08:44:18 +0900
Message-ID: <54EA69D2.7010706@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <54DFE797.1020008@math.uni-bielefeld.de> <54E4FD40.8020206@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64128 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbBVXoW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 18:44:22 -0500
In-reply-to: <54E4FD40.8020206@gmx.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <liquid.acid@gmx.net>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, myungjoo.ham@samsung.com, kgene@kernel.org, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

Hi Tobias,

First of all, thanks for your test.

On 02/19/2015 05:59 AM, Tobias Jakobi wrote:
> Hello again,
> 
> Tobias Jakobi wrote
>> I've tested the series on my Odroid-X2 (by adapting the TRATS2 changes),
>> and so far I haven't seen any issues. With the system being idle one can
>> see that the 'simple_ondemand' devfreq governor clocks down both memory
>> busses to the lowest state.
> 
> looks I was too hasty the last time. Actually this series breaks HDMI
> output for me (or at least with 'simple_ondemand' governor, haven't
> tried with performance yet).
> 
> I tried to run some simple application, but it hangs in uninterruptible
> sleep immediately, probably before the first page flip. Going to check
> this more thoroughly.
> 
> Maybe some parts of the hdmi subsystem don't like the lower clocks?

As you thought, when maintaining lower clock of memory bus frequency,
some issue related to multimedia feature will happen.

Separately, We have to check the miminum lower clock for working of multimedia feature.
and then multimedia or other IP have to request it to DVFS driver (memory busfreq driver).
But, latest mainline kernel currently has not some way to inform minimum clock to DVFS driver.

So, If you check the miminum clock for hdmi, I'll use this clock as minumu frequency of dvfs table.

Thanks,
Chanwoo Choi
