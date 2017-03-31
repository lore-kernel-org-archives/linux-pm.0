From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH V2 2/2] thermal: broadcom: add Northstar thermal driver
Date: Fri, 31 Mar 2017 09:08:44 +0200
Message-ID: <e5958192-1ea9-3269-0576-e114231c21a0@gmail.com>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170323223045.15786-1-zajec5@gmail.com>
 <20170323223045.15786-2-zajec5@gmail.com>
 <20170331031554.GA3161@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36286 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbdCaHIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 03:08:48 -0400
In-Reply-To: <20170331031554.GA3161@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Jon Mason <jon.mason@broadcom.com>

Thanks for your review!

On 03/31/2017 05:15 AM, Eduardo Valentin wrote:
> On Thu, Mar 23, 2017 at 11:30:45PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Northstar is a SoC family commonly used in home routers. This commit
>> adds a driver for checking CPU temperature. As Northstar Plus seems to
>> also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
>>
>
> Can you please educate me on how different this driver is from
> https://patchwork.kernel.org/patch/9619579/
>
> ?

This is a different hardware block. Northstar and BCM283x are totally different
SoCs. Northstar is mostly used in home routers, BCM283x mostly in Rasperry Pi.


>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 776b34396144..008e173ec825 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -392,6 +392,11 @@ config MTK_THERMAL
>>  	  Enable this option if you want to have support for thermal management
>>  	  controller present in Mediatek SoCs
>>
>> +menu "Broadcom thermal drivers"
>> +depends on ARCH_BCM || COMPILE_TEST
>
> Does the above dependency also work for other BCM chips?

I believe so. If there ever appears a driver in drivers/thermal/broadcom/ that
can't be freely compiled with COMPILE_TEST, it can just have a proper
dependency.
