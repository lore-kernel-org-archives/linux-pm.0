From: Pavel Machek <pavel@ucw.cz>
Subject: Re: selective wakeups
Date: Tue, 3 Feb 2015 13:14:37 +0100
Message-ID: <20150203121437.GA26492@amd>
References: <54D09AC7.5080503@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33513 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbbBCMOk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 07:14:40 -0500
Content-Disposition: inline
In-Reply-To: <54D09AC7.5080503@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Derek Basehore <dbasehore@google.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi!

> I'm looking at how to support wakeup sources that resume a subset of the
> suspended devices. The goal is for the machine to be able to wakeup the
> CPU but not the display or sound card when the wakeup source isn't
> user-initiated, such as RTC or a network card (we can call it automatic
> resume).
> 
> http://www.chromium.org/chromium-os/packages/power_manager/suspend-and-resume#TOC-Dark-Resume

> My first idea is for userspace to be able to configure via sysfs which
> devices aren't going to be resumed when a given wakeup source fires.
> We'll also need a way to resume the display and sound card if there's
> user interaction when the system has resumed automatically.

Well.. the web page describes quite different use case.

Anyway... right solution would be not to resume devices that were
runtime-suspended, no? With that, additional sysfs tweaks should not
be needed?

For the "periodically wakeup from S3 to prevent battery
draining".. Some machines (Sharp Zaurus) already do similar tricks
directly from kernel, and you may want to do the same. Battery
completely draining when in S3 is quite bad situation, and preventing
it even without userspace support would be good.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
