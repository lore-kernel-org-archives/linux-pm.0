From: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Mon, 23 Feb 2015 01:38:45 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B732756CCF@PGSMSX105.gar.corp.intel.com>
References: <1423673509-11195-1-git-send-email-boon.leong.ong@intel.com>
 <1423673509-11195-2-git-send-email-boon.leong.ong@intel.com>
 <AF233D1473C1364ABD51D28909A1B1B73274624E@PGSMSX105.gar.corp.intel.com>
 <F54AEECA5E2B9541821D670476DAE19C2B8AB1FC@PGSMSX102.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2886 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbbBWBit convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 20:38:49 -0500
In-Reply-To: <F54AEECA5E2B9541821D670476DAE19C2B8AB1FC@PGSMSX102.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <pure.logic@nexus-software.ie>

>Just to bring out for discussion, do you think we should put a "safety range"
>for reporting out the critical trip temperature value (mean the value from
>register minus 1 or 2 degree)?
>
>Just wondering if this is needed for the software to have the sufficient
>shutdown time before the HW make a hard power cut off when the
>critical trip point is reached.

I assume that the suggestion is meant for the case where thermal register is
not locked by BIOS. It is not a bad idea to have some protection against
wrong configuration on critical trip point by user.
Looking through the data-sheet in Quark, I could not find an recommended
temperature. So, I propose that we use the same value set by BIOS today
- 105C as the maximum. 

>> +static struct soc_sensor_entry *alloc_soc_dts(void)
>> +{
>> +	struct soc_sensor_entry *aux_entry;
>> +	int err;
>> +	u32 out;
>> +	int wr_mask;
>> +
>> +	aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
>
>Wondering is it possible to use the resource-managed functions (for e.g.
>devm_kzalloc())? This could help the driver looks more neat and clean
>where the resource-managed framework will help you take care all the
>kfree().
>
>Understand that the flow here is to call the thermal_zone_device_register()
>function after this aux_entry allocation.
>
>But thinking would it also working if change the flow to call
>thermal_zone_device_register() function 1st to obtain the
>thermal_zone_device
>then later on perform devm_kzalloc() and assign it back to devdata.
>
Ok, it is worth exploring on this devm_kzalloc() for neatness. 
Thanks!
