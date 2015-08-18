From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Tue, 18 Aug 2015 10:02:18 +0200
Message-ID: <20150818080218.GA17017@amd>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com>
 <20150817101115.GA27204@gmail.com>
 <20150817132726.GA11047@amd>
 <55D2972C.3030709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58582 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbHRICW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 04:02:22 -0400
Content-Disposition: inline
In-Reply-To: <55D2972C.3030709@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> >>>A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> >
> >Access denied :-(
> >
> Might need to register for accessing.
> >
> >What HW is this on?
> >
> Intel Braswell and Broadwell, detail for Broadwell:
> Platform: MayanCity
> Processor: 2x BROADWELL BDX_EP A0 QHPR
> Chipset: Wellsburg B1 QR7E

So it is desktop board?

> >Doing this unconditionally is asking for trouble. Blacklist entry with
> >affected BIOS info might be acceptable, but...
> >
> you mean a quirk here(accroding to dmi info ,etc)?

Yes, please.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
