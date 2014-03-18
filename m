From: Pavel Machek <pavel@ucw.cz>
Subject: Re: No suspend to RAM support
Date: Tue, 18 Mar 2014 10:59:45 +0100
Message-ID: <20140318095945.GA11429@amd.pavel.ucw.cz>
References: <20140317205302.GA14066@sucs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51701 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbaCRJ7r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 05:59:47 -0400
Content-Disposition: inline
In-Reply-To: <20140317205302.GA14066@sucs.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi!

> I have an (old) Athlon II Neo N36L but I've noticed that with the 3.2
> Debian stable kernel only disk is present in /sys/power/state so
> suspend to RAM can't be used (but hibernating and resuming work fine).
> 
> The machine seemingly supports S5 ACPI so I'm guessing there's a reason
> suspend has been disabled but does anyone know what it is?
> 
> The same issue happens with the 3.11 kernel on a Fedora LiveCD. dmesg
> below:

Has suspend-to-RAM ever worked on that machine? If BIOS does not
support it, there's little we can do...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
