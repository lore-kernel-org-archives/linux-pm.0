From: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Wed, 25 Feb 2015 15:47:16 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B73275A46D@PGSMSX105.gar.corp.intel.com>
References: <1423673509-11195-1-git-send-email-boon.leong.ong@intel.com>
 <1423673509-11195-2-git-send-email-boon.leong.ong@intel.com>
 <AF233D1473C1364ABD51D28909A1B1B73274624E@PGSMSX105.gar.corp.intel.com>
 <F54AEECA5E2B9541821D670476DAE19C2B8AB1FC@PGSMSX102.gar.corp.intel.com>
 <AF233D1473C1364ABD51D28909A1B1B732756CCF@PGSMSX105.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3962 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358AbbBYPrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 10:47:33 -0500
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B732756CCF@PGSMSX105.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, "Ong, Boon Leong" <boon.leong.ong@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Ong, Boon Leong
>Sent: Monday, February 23, 2015 9:39 AM
>To: Kweh, Hock Leong; Zhang, Rui; edubezval@gmail.com
>Cc: linux-pm@vger.kernel.org; LKML; Bryan O'Donoghue
>Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
>

>>> +static struct soc_sensor_entry *alloc_soc_dts(void)
>>> +{
>>> +	struct soc_sensor_entry *aux_entry;
>>> +	int err;
>>> +	u32 out;
>>> +	int wr_mask;
>>> +
>>> +	aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
>>
>>Wondering is it possible to use the resource-managed functions (for e.g.
>>devm_kzalloc())? This could help the driver looks more neat and clean
>>where the resource-managed framework will help you take care all the
>>kfree().
>>
>>Understand that the flow here is to call the thermal_zone_device_register()
>>function after this aux_entry allocation.
>>
>>But thinking would it also working if change the flow to call
>>thermal_zone_device_register() function 1st to obtain the
>>thermal_zone_device
>>then later on perform devm_kzalloc() and assign it back to devdata.
>>
>Ok, it is worth exploring on this devm_kzalloc() for neatness.

I give it a thought again and I think that devm_kzalloc() is only useful
if the thermal driver is platform driver. So, for Quark thermal driver, 
this will not be useful. So, the existing kzalloc() method is sufficient.


