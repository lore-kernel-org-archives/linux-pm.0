From: Phil Reid <preid@electromag.com.au>
Subject: RFI: devm_power_supply_register and sys/class name
Date: Thu, 9 Jun 2016 17:39:00 +0800
Message-ID: <44d06e13-714a-c91a-6d7c-1aaa83758e7f@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:42981 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751560AbcFIJjE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 05:39:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

G'day All,

I'm implementing a driver for a sbs manager chip (ltc1760) and running into a problem.
This is a dual smart battery charger ic.

Our hard has two of these connected via a i2c / smbus mux.

One registering the second device with devm_power_supply_register  I am getting a warning
in regards duplicate sysfs entries.
The first device creates this entry
/sys/class/power_supply/sbs-manager/

The second device also creates the same entry.

This name appears to come from power_supply_desc .name field.

Which needs to exists for the lifetime of the driver.
So I'm assuming I need to allocate local memory for this struct in the
driver and set a unique name.

Is this the correct way to go or should devm_power_supply_register be made more
flexible to ensure unique names?

Or have I missed something obvious (most likely this case I think)?


-- 
Regards
Phil Reid

