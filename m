From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: power management regression in linux 3.10?
Date: Mon, 03 Jun 2013 21:34:54 +0200
Message-ID: <1426816.yLxoxJJ6NX@vostro.rjw.lan>
References: <1370282175.18020.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57487 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833Ab3FCTZx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Jun 2013 15:25:53 -0400
In-Reply-To: <1370282175.18020.4.camel@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Karcher <Michael.Karcher@fu-berlin.de>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>

On Monday, June 03, 2013 07:56:15 PM Michael Karcher wrote:
> Hello,
> 
> I am using an IBM ThinkPad T60 (i915, Core 2 Duo T7200) and recently
> upgraded from a custom 3.7 kernel to a custom 3.10-rc4 kernel
> (v3.10-rc4-1-gc026d8e).
> After upgrading, I get around 17-20W power usage instead of 12-15W power
> usage as I had with 3.7. powertop show that CPU0 is in state POLL all of
> the idle time, while CPU1 correctly enters C3.
> 
> As this may be caused by my kernel configuration, I pastebinned
> my .config to http://pastebin.ca/2388457. Note that I am using
> CONFIG_NO_HZ_FULL, which might be nonstandard and actually not sensible
> for a standard single-user laptop system with GUI.
> 
> Do you want me to try something to debug the problem?

Yes, please try with CONFIG_NO_HZ_IDLE and see if you can reproduce the
problem.

Does your system use intel_idle?  You've set that in .config, but can you check
what dmesg says, please?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
