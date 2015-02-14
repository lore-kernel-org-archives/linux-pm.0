From: Zhang Rui <rui.zhang@intel.com>
Subject: battery drains after shutdown
Date: Sat, 14 Feb 2015 15:38:24 +0800
Message-ID: <1423899504.11560.128.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33404 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbbBNHi3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 14 Feb 2015 02:38:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: bryanh@giraffe-data.com
Cc: user.anti-spam@maison.homelinux.net, Linux PM list <linux-pm@vger.kernel.org>

Hi, Bryan,

I've got a bug report that battery drains after shutdown.
https://bugzilla.kernel.org/show_bug.cgi?id=47811

The problem is that
1. Battery drains after shutdown
2. setting HWCLOCKACCESS=no in /etc/default/hwclock, which bypasses
the /sbin/hwclock --systohc  operation during shutdown, solves the
issue 
3. setting HWCLOCKACCESS=no, but enable RTC wakeup explicitly, the
battery drains similar power
4. I did a google search and found that there are some pages mentioned
that /sbin/hwclock --systohc may enables RTC wakeup unexpectedly.

So do you have any idea about this problem?

BTW, it would be great if you have an account in bugzilla.kernel.org.

thanks,
rui

