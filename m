From: Lukas Wunner <lukas@wunner.de>
Subject: Re: Question on 1d9174fbc55e (pm_runtime_force_suspend/resume)
Date: Sun, 7 May 2017 11:33:59 +0200
Message-ID: <20170507093359.GA20284@wunner.de>
References: <20170507091327.GA20263@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:32795 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755325AbdEGWaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2017 18:30:01 -0400
Content-Disposition: inline
In-Reply-To: <20170507091327.GA20263@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Ulf,

On Sun, May 07, 2017 at 11:13:27AM +0200, Lukas Wunner wrote:
> I'm trying (and failing) to understand your commit 1d9174fbc55e ("PM /
> Runtime: Defer resuming of the device in pm_runtime_force_resume()")
> and was hoping that you could give me a clue:
> 
> You're acquiring a runtime PM ref on the parent when a device is force-
> suspended and releasing it when it's force-resumed.  Moreover you're only
> doing this if the device was runtime active upon force-suspend.
> 
> What is the purpose of this?

After some more digging, it seems acquiring a runtime PM ref on the parent
was added in v3 of your patch to try to fix an issue reported by Geert:

https://patchwork.kernel.org/patch/9375061/

	Changes in v3:
	- Updated to take care of parent-child relations.
	  This patch has earlier been sent standalone, but also as a part
	  of series. In the end it turned out the solution needed some
	  improvement to take care of parent-child relations, as reported
	  by Geert [1].
	  Geert, I would really appreciate if you could help out testing
	  to make sure the reported issue is fixed.
	  [1] https://patches.linaro.org/patch/67940/

However Geert responded that the change in v3 does *not* fix the issue:

	  Unfortunately it doesn't help. Still fails on both
	  r8a73a4/ape6evm and sh73a0/kzm9g.

I then turned out that the issue reported by Geert required an entirely
different fix to an Ethernet driver:

	  Rafael, this one is ready to be queued. Unless there are other
	  objections.
	  The problems that was reported by Geert for this change, has
	  been taken care of. Those are fixed by the patch for the
	  smsc911x ethernet driver [1], which you queued a while ago.
	  [1] https://www.spinics.net/lists/netdev/msg401339.html

Could it be that maybe, just maybe, the code to acquire a runtime PM ref
on the parent is entirely unnecessary and ended up in mainline by mistake?

Thanks,

Lukas
