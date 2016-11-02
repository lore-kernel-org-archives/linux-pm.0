From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 0/4] PXA cpufreq conversion to clock API
Date: Wed, 02 Nov 2016 22:49:41 +0100
Message-ID: <87d1idzh56.fsf@belgarion.home>
References: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
        <20161102044503.GC10786@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:25023 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755744AbcKBVtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2016 17:49:45 -0400
In-Reply-To: <20161102044503.GC10786@vireshk-i7> (Viresh Kumar's message of
        "Wed, 2 Nov 2016 10:15:03 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael J Wysocki <rjw@rjwysocki.net>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 31-10-16, 20:54, Robert Jarzmik wrote:
>> Hi,
>> 
>> This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
>> API, next iteration.
>> 
>> The first 3 patches are review and merge material :
>>  - patch 1/4 for Viresh and Rafael
>>  - patches 2/4 and 3/4 for me
>> 
>> The 4th on is for review but not merge, as the clock changes must be fully
>> reviewed and go in first as a prequisite
>> 
>> Since previous iteration, 2 and 3 were amended per Viresh's suggestion.
>> 
>> Robert Jarzmik (4):
>>   cpufreq: pxa: use generic platdev driver for device-tree
>>   ARM: dts: pxa: add pxa25x cpu operating points
>>   ARM: dts: pxa: add pxa27x cpu operating points
>>   cpufreq: pxa: convert to clock API
>> 
>>  arch/arm/boot/dts/pxa25x.dtsi        |  25 +++++
>>  arch/arm/boot/dts/pxa27x.dtsi        |  40 ++++++++
>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>  drivers/cpufreq/pxa2xx-cpufreq.c     | 191 +++++++----------------------------
>>  4 files changed, 106 insertions(+), 152 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Ok, thanks Viresh.

Would you or Rafael take patch 1/4 "cpufreq: pxa: use generic platdev driver for
device-tree" through your tree please ?

I'll take patches 2 and 3 through my tree, and we'll wait for clock patches to
hit clock tree before I ask patch 4/4 to be applied.

Cheers.

-- 
Robert
