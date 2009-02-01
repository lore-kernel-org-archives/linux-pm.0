From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sun, 1 Feb 2009 13:27:44 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9A855@dlee02.ent.ti.com>
References: <200902011330.03579.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902011219170.27579-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902011219170.27579-100000@netrider.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Brian Swetland <swetland@google.com>, Nigel Cunningham <ncunningham@crca.org.au>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> Early-suspend seems to be a completely different matter.  In fact it
> isn't a suspend state at all, as far as I understand it.  It's more
> like what you get simply by doing a runtime suspend on some collection
> of devices.  I don't see that the kernel needs to treat it as a special
> state, and in might be possible to have a user program manage the whole
> thing -- provided the drivers in question implement runtime power
> management (as USB has done).

The bit of use I saw was a few devices were broken out from the global suspend chain (display and some input).  They were effetely controlled from user space activity timers. The 'early_suspend' was sequenced before the global suspend call. Effectively this created a partial idle state where some drivers were down and others up. Also, the drivers on early_suspend might resume with out a global suspend. They also were not registered on global chain.

The upside of this from my point of view was the drivers on early suspend chain were high latency drivers. If they were linked into the global suspend chain they would drive up cost of frequent suspend substantially (a 60Hz or slower LCD DMA re-sync on both directions is costly, more so for some slow SPI-GPS kind of device). One example might be some periodic task wakes up to check the battery level then re-sleeps. On the resume side you don't want to restart the display system to do this. Since it is on a separate early-suspend-chain it doesn't wake until a later re-activated user space issues the wake if it needs to be.

Personally I still like an on-demand architecture for kernel space where drivers are coming up and down independently per control and data flow.  But this is harder. Splitting suspend seems to be an ok tradeoff for this problem.  Anyway, they don't conflict, you just use fewer or no kernel wake locks.  The user space ones are still around to help control the wild west up there.

This kind of system suspend seems good for power optimization at the user input speed time scale (hundreds of mS). It probably is too heavy to get really good power for constant active mode power like an mp3. At the current time scale the best you could hope for is DVFS with this. Doing DPS (dynamic-power-switching) to shut down individual blocks during playback, this seems like it would be to slow unless you had groups of independent 'early_suspend' device chains.

A mix of cpuidle + wakelock-aggressive-system-suspend should provide decent coverage for power states.

Again, I'll defer to android experts.

Regards,
Richard W.
