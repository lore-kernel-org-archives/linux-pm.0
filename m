From: Pavel Machek <pavel@ucw.cz>
Subject: Mess in the /sysfs: class/power_supply
Date: Sat, 31 Jan 2015 22:39:19 +0100
Message-ID: <20150131213919.GA16133@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58724 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878AbbAaVjX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jan 2015 16:39:23 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org

Hi!

So we have multiple values in one sysfs file:

root@n900:/sys/class/power_supply# cat bq24150a-0/registers
0x00=0x50
0x01=0xc8
0x02=0x8e
0x03=0x4b
0x04=0x99

(should this go to debugfs somewhere?)

Unobvious and undocumented entries:

root@n900:/sys/class/power_supply# cat bq24150a-0/boost_status
0
pavel@duo:/data/l/linux-n900$ grep -ri boost_status Documentation/
pavel@duo:/data/l/linux-n900$ grep -ri termination_current Documentation/
pavel@duo:/data/l/linux-n900$ grep -ri current_now Documentation/
pavel@duo:/data/l/linux-n900$ grep -ri time_to_empty_avg Documentation/
pavel@duo:/data/l/linux-n900$


And different units in different parts of tree:

(these are mA)

root@n900:/sys/class/power_supply# cat bq24150a-0/current_limit
1800
root@n900:/sys/class/power_supply# cat bq24150a-0/termination_current
100

(and this is in uA)

root@n900:/sys/class/power_supply# cat bq27200-0/current_now
12138

(I believe uA is right, so it is bq24150a that should be fixed....?)

Ok, of course questions are: do we need to do something with it? If
so, what?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
