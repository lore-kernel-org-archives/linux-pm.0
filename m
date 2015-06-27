From: Uwe Geuder <linuxkernel2015-ugeuder@snkmail.com>
Subject: resume from swap partition under LVM
Date: Sun, 28 Jun 2015 00:59:58 +0300
Message-ID: <87pp4gq0bl.fsf@e6510-131.site>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:58047 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbF0WKD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jun 2015 18:10:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

Hi!

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/swsusp.txt?id=refs/tags/v4.1#n411 
reads:

> Q: Can I suspend-to-disk using a swap partition under LVM?
> 
> A: No. You can suspend successfully, but you'll not be able to
> resume. uswsusp should be able to work with LVM. See suspend.sf.net.

Is that information still up to date? 

It works for me most times, just occasional crashes during resume. 

Regards,

Uwe Geuder
--
Nomovok Ltd.
Tampere, Finland
uwe.gxuder@nomovok.com (bot test: humans correct 1 obvious spelling error)


