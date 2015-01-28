From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v10 0/7] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
Date: Wed, 28 Jan 2015 10:01:27 +0900
Message-ID: <54C834E7.8060203@samsung.com>
References: <2091672023.141961422352757659.JavaMail.weblogic@epmlwas08c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31687 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbbA1BBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 20:01:30 -0500
In-reply-to: <2091672023.141961422352757659.JavaMail.weblogic@epmlwas08c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?7J207IOB67Cw?= <sangbae90.lee@samsung.com>, =?UTF-8?B?64yA7J24?= =?UTF-8?B?6riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Dear Kukjin,

Could you please pick remaining patches (patch4-patch7)?

On 01/27/2015 06:59 PM, MyungJoo Ham wrote:
>>  This patchset add new devfreq_event class to provide raw data to determine
>> current utilization of device  which is used for devfreq governor.
>>
>> The following description explains the feature of two kind of devfreq class:
>> - devfreq class (existing)
>>  : devfreq consumer device use raw data from devfreq_event device for
>>    determining proper current system state and change voltage/frequency
>>    dynamically using various governors.
>> - devfreq_event class (new)
>>  : Provide measured raw data to devfreq device for governor
> 
> Merged in my local git repo (1/7 to 3/7 as those three are in /drivers/devfreq).
> 
> However, the admin requires me to setup the firewall again, so please wait
> another day for the merged patches to show up in external network
> (git.kernel.org) and to make a pull-request for Rafael.
> (waiting firewall execption approvals from the admin)

Dear Myungjoo,

Thanks for your apply.

Best Regards,
Chanwoo Choi

