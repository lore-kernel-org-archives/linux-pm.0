From: Matthew Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Mon, 13 Jan 2014 11:01:36 -0800
Message-ID: <52D43810.6030801@nvidia.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <52D4095C.205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46009 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbaAMTBx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jan 2014 14:01:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1W2mlj-0006ZG-Jk
	for linux-pm@vger.kernel.org; Mon, 13 Jan 2014 20:01:51 +0100
Received: from searspoint.nvidia.com ([216.228.112.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2014 20:01:51 +0100
Received: from mlongnecker by searspoint.nvidia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2014 20:01:51 +0100
In-Reply-To: <52D4095C.205@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org

On 1/13/2014 7:42 AM, Eduardo Valentin wrote:
>> This serie can support to turn governor for thermal zone in
>> run time.
>
> Can you please explain why this is needed? Are you facing troubles with
> current way to switch governors? If yes, can you please report them?
>

....

>> Adds thermal_update_governor() function, so the thermal platform
>> driver can use it to update governor.
>
> Here I cannot see why the platform driver would need to update a
> governor, instead of a zone. Platform drivers are not supposed to be
> aware of governors. For updating a zone we already have an API for that,
> please check documentation.
>

I think we have a miscommunication. The purpose of 
thermal_update_governor is to *switch* governors at runtime (from within 
the kernel).

Wei has used the term "update" in the sense of switch rather than 
"update" in the sense used by thermal_zone_device_update.

Eduardo, what is your recommended technique for setting the governor of 
a thermal zone device created via device tree?

thanks,
Matt

