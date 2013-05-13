From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Kobject_uevent in cpufreq.c
Date: Mon, 13 May 2013 11:31:57 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59C8D667@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63059 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933Ab3EMLcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2013 07:32:02 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linux PM list (linux-pm@vger.kernel.org)" <linux-pm@vger.kernel.org>
Cc: "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

Hi,

I am observing an UEvent issue in cpufreq.c. 
The cpufreq_add_dev() function is called whenever a core is 'onlined'.
we expect the kobject_uevent() method in cpufreq_add_dev() to
send an UEvent with KOBJ_ADD as the action parameter.

But this call fails because of the 'filter function' inside kobject_uevent_env
inside lib/kobject_uevent.c. The ->filter points to 'dev_uevent_filter' in
drivers/base/core.c, where the check for 'device_ktype' fails.

Error message:
kobject: 'cpufreq' (e5bbf290): kobject_uevent_env:
filter function caused the event to drop!

As far as I can see, we need a kset, and associated filter function
inside cpufreq.c to get this working. Is this the right way to go ?
Any other easy/correct ways to get it working ? Please advise.

Thanks,
Durga
