From: Michael Karcher <Michael.Karcher@fu-berlin.de>
Subject: Re: power management regression in linux 3.10?
Date: Tue, 04 Jun 2013 03:08:48 +0200
Message-ID: <1370308128.6305.3.camel@localhost>
References: <1370282175.18020.4.camel@localhost>
	 <1426816.yLxoxJJ6NX@vostro.rjw.lan> <51ACF071.702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53290 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758848Ab3FCXIH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 19:08:07 -0400
In-Reply-To: <51ACF071.702@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>

Am Montag, den 03.06.2013, 12:37 -0700 schrieb Dirk Brandewie:
> On 06/03/2013 12:34 PM, Rafael J. Wysocki wrote:
> > On Monday, June 03, 2013 07:56:15 PM Michael Karcher wrote:
> >> Hello,
> > Yes, please try with CONFIG_NO_HZ_IDLE and see if you can reproduce the
> > problem.
Instead of doing that, I successfully applied Dirk's suggestion. Is
CONFIG_NO_HZ + CONFIG_NO_HZ_IDLE worth testing?

> > Does your system use intel_idle?  You've set that in .config, but can you check
> > what dmesg says, please?
No, intel_idle complains it doesn't support my CPU family.

> Unset CONFIG_NO_HZ it is setting CONFIG_CPU_IDLE_GOV_MENU which with 
> CONFIG_NO_HZ_FULL set is confusing intel_pstate.  I am still trying to
> figure out what the root cause is commit 5811d996 seems to be implicated.
Unsetting CONFIG_NO_HZ helped. Now CPU0 is using C states again.

> --Dirk
Regards,
  Michael Karcher

