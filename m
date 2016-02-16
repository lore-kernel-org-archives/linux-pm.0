From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
 different kernel version
Date: Tue, 16 Feb 2016 21:15:57 +0100
Message-ID: <20160216201557.GA6526@amd>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42375 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbcBPUQA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 15:16:00 -0500
Content-Disposition: inline
In-Reply-To: <1455637767-31561-16-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Tue 2016-02-16 15:49:27, James Morse wrote:
> Resuming using a different kernel version is fragile, while there are
> sufficient details in the hibernate arch-header to perform the restore,
> changes in the boot process can have a long-lasting impact on the system.
> In particular, if the EFI stub causes more memory to be allocated, the
> amount of memory left for linux is reduced. If we are lucky, this will
> cause restore to fail with the message:

Well, this does not close the door completely. 4.6-rc0 is going to be
very different from 4.6-rc1. Better solution would be to increase
version every time EFI stub changes, or maybe record ammount of memory
reserved for EFI.

Best regards,
									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
