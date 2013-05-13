From: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Subject: S3, SMP non boot cpus and
 /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Mon, 13 May 2013 13:01:40 +0000
Message-ID: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13680 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab3EMNBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2013 09:01:45 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjkw@sisk.pl>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Rafael,

I came across that little odd behavior in "Suspend to RAM" :
 1) I do a "chmod audio:audio /sys/devices/system/cpu1/cpufreq/scaling_max_freq (I know, stupid, but it's for the example)
 2) I do a "echo mem > /sys/power/state"
 3) I resume the kernel
     => here the permissions of /sys/devices/system/cpu1/cpufreq/scaling_max_freq have turned back to root:root

OK, fair well, I add a UDEV rule which does a "chown audio:audio /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq" upon udev event "online, /sys/...".
And here it becomes interesting :
 - the udev event "offline" or "online" never comes with the "Suspend to RAM" testcase
 - but the same udev event comes when I manually do a "echo 0 > /sys/devices/system/cpu/cpu1/online"

So my question is : is it intended behavior that no udev offline/online event happens on S3 for non-boot CPUs, or is it something I should try to fix ?

Cheers.

--
Robert

PS: I have a rather old kernel (3.4), so forgive me if the question is outdated ...
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

