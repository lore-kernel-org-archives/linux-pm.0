From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [v2] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Thu, 17 Sep 2015 07:40:27 +0200
Message-ID: <20150917054027.GC6665@amd>
References: <1441101816-24567-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54629 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbIQFkd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 01:40:33 -0400
Content-Disposition: inline
In-Reply-To: <1441101816-24567-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, mingo@redhat.com, yinghai@kernel.org, joeyli.kernel@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> PM: Image mismatch: memory size
> 
> This is also because BIOS provides different e820 memory map before/after
> hibernation, and linux regards it as invalid process and refuses to
> resume, in order to protect against data corruption. However,
> this check might be too strict, consider the following scenario:

Well... yes, the check is strict, but why is BIOS doing that? Can you
fix it instead?

> The hibernating system has a smaller memory capacity than
> the resuming system, and the former memory region is a subset of the
> latter, it should be allowed to resume. Here is a case for this
> situation:
> 
> before hibernation:
> 
> BIOS-e820: [mem 0x0000000020200000-0x0000000077517fff] usable
> BIOS-e820: [mem 0x0000000077518000-0x0000000077567fff] reserved
> Memory: 3871356K/4058428K available (7595K kernel code, 1202K rwdata,
> 3492K rodata, 1400K init, 1308K bss, 187072K reserved, 0K cma-reserved)
> 
> after hibernation:
> BIOS-e820: [mem 0x0000000020200000-0x000000007753ffff] usable
> BIOS-e820: [mem 0x0000000077540000-0x0000000077567fff] reserved
> Memory: 3871516K/4058588K available (7595K kernel code, 1202K rwdata,
> 3492K rodata, 1400K init, 1308K bss, 187072K reserved, 0K cma-reserved)
> 
> According to above data, the number of present_pages has increased by
> 40(thus 160K), linux will terminate the resuming process. But since
> [0x0000000020200000-0x0000000077517fff] is a subset of
> [0x0000000020200000-0x000000007753ffff], we should let system
> resume.

Ok, complex, but will work. But what happens in the opposite case? On
the next boot, bios gets you 160K less....

Can you do echo powerdown > /sys/power/disk to work around this?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
