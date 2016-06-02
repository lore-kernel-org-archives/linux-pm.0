From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Thu, 2 Jun 2016 20:53:38 +0100
Message-ID: <20160602205338.4a16760a@lxorguk.ukuu.org.uk>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
	<1464842009-21789-6-git-send-email-dbasehore@chromium.org>
	<20160602092505.GQ3206@twins.programming.kicks-ass.net>
	<20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
	<CAGAzgspC49xNXPsV-WCT-xqVJGfNGeHkhYYLfZSTfBtjddVm8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35640 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbcFBTyQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 15:54:16 -0400
In-Reply-To: <CAGAzgspC49xNXPsV-WCT-xqVJGfNGeHkhYYLfZSTfBtjddVm8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

> How would this spuriously trigger during boot? This code is only run
> during freeze. If there's some issue with not entering S0ix before a
> module or firmware is loaded, it's better to not use suspend to idle
> until those are in place.

Ok yes you are correct it's not likely to trigger during boot (although
if you close the lid during boot...)

> I'm not familiar with the ISH driver. How does it prevent entry into
> S0ix? I would argue that you don't want to use suspend to idle on a
> Skylake system that can't enter S0ix and instead use suspend to RAM.

Several IP blocks on the systems do their own power management if present
and enabled by the firmware. If they do not have drivers loaded then you
will not be able to enter some power states. Thus you'll now get warnings
if you try to freeze such a system and those warnings are not themselves
terribly helpful to a user.

It's a good debug feature, but it doesn't belong anywhere but debug menus
and off by default. If you want to ship it enabled in ChromeOS for
product fine, but I don't think it belongs on for everywhere and
everything.

Alan
