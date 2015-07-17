From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 0/2] thermal: Add generic devfreq cooling device
Date: Fri, 17 Jul 2015 16:16:40 +0900
Message-ID: <55A8ABD8.7000705@samsung.com>
References: <921188645.36001437115238708.JavaMail.weblogic@epmlwas08c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59408 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbGQHQn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 03:16:43 -0400
In-reply-to: <921188645.36001437115238708.JavaMail.weblogic@epmlwas08c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, =?UTF-8?B?6rmA6rWt7KeE?= <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Dear Myungjoo,

On 07/17/2015 03:40 PM, MyungJoo Ham wrote:
>>   
>>  This patchset introduce the generic devfreq cooling device for generic thermal
>> framework. The devfreq devices are used ad cooling device to reduce the
>> overheating temperature. This patch is based on drivers/thermal/cpu_cooling.c.
>> The devfreq cooling device can change the ragne of the frequency table of
>> devfreq device according to cooling level in device tree file.
> 
> Hi,
> 
> 
> 1. You've exported "update_devfreq()" in 1/2 and didn't use it anywhere.
> 2. If you've added "update_devfreq()" to notify devfreq driver when a new
>  max/min is defined, you'll need to add it at set_state, OR
>    You may do it with opp_enable()/opp_disable() function and let opp
>  notifiers do the homework for you. (no need to update_devfreq().

It is my mistake. The devfreq_set_cur_state() in patch2 use the update_devfreq()
to change the maximum frequency of devfreq device as following:

+       /* Set the limited frequency to maximum frequency of devfreq */
+       devfreq_dev->devfreq->max_freq = limited_freq;
+       update_devfreq(devfreq_dev->devfreq);

I'll resent v2 patch-set.

Thanks,
Chanwoo Choi
