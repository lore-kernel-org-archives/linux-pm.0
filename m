From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: thermal: sysfs: lock tz when access sustainable power properties
Date: Thu, 2 Jun 2016 17:47:00 +0300
Message-ID: <20160602144700.GA19095@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23862 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcFBOrS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 10:47:18 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org

Hello Eduardo Valentin,

This is a semi-automatic email about new static checker warnings.

The patch 58601ec845aa: "thermal: sysfs: lock tz when access 
sustainable power properties" from May 30, 2016, leads to the 
following Smatch complaint:

drivers/thermal/thermal_sysfs.c:376 sustainable_power_show()
	 warn: variable dereferenced before check 'tz->tzp' (see line 373)

drivers/thermal/thermal_sysfs.c
   372		mutex_lock(&tz->lock);
   373		sustainable_power = tz->tzp->sustainable_power;
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
New dereference.

   374		mutex_unlock(&tz->lock);
   375	
   376		if (tz->tzp)
                    ^^^^^^^
Old code assumed this could be NULL.

   377			return sprintf(buf, "%u\n", sustainable_power);
   378		else

regards,
dan carpenter
