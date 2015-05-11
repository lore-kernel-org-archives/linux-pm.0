From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] PM / Domains: Minimize latencies by not delaying
 save/restore
Date: Mon, 11 May 2015 15:41:03 +0100
Message-ID: <20150511144103.GG2067@n2100.arm.linux.org.uk>
References: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:37213 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbbEKOlU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 10:41:20 -0400
Content-Disposition: inline
In-Reply-To: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Lina Iyer <lina.iyer@linaro.org>

On Mon, May 11, 2015 at 03:24:33PM +0200, Ulf Hansson wrote:
> This patch actually address two issues which exists due to the current
> policy of how genpd deals with devices' ->runtime_suspend|resume()
> callbacks.
> 
> The two issues are described below.
> 
> Issue 1) A thundering herd problem with latencies issues:
> 
> Currently genpd delays to walk the hierarchy of ->runtime_suspend()
> callbacks for a device, until all devices in a PM domain becomes
> inactive.
> 
> Support for fine grained PM is instead handled via the gpd_dev_ops'
> ->stop|start() callbacks. The ->stop() callback is invoked immediately
> when genpd's ->runtime_suspend() callback is called at the PM domain
> level.

These two paragraphs seem to be contradictory.  I think the first is
telling me that genpd waits until all devices have become inactive
before walking the hierarchy of ->runtime_suspend callbacks[*] for a
device.  As this waits for all devices to become inactivate, this is
not fine grained.  The second paragraph tells me that genpd's ->stop
method is called from the genpd's ->runtime_suspend(), but this is
fine grained... that's confusing.  As I'm not sure what you're trying
to say here, maybe it'd help if you replaced "->runtime_suspend()
callback" with the actual function name so the two ->runtime_suspend()
references don't get confused.  IOW, pm_genpd_runtime_suspend.

Second point here is that "->runtime_suspend callbacks for a device".
Why plural?  Can a single device have more than one runtime_suspend
callback?  My understanding is that a struct device can have up to one
struct device_driver, and there will be one dev_pm_ops available for
use, which may come from one of several sources (device driver, bus
type, device class, etc.)

> When genpd realizes that all devices have become inactive within the PM
> domain, it starts the power off sequence.
> 
> Those devices that were re-activated since the last powered off
> sequence, needs to be given the opportunity to have their register
> context saved. That means walking the hierarchy of the devices'
> ->runtime_suspend() callbacks.

There's, no, need, for, a, comma, there.  It's just confusing and makes
it harder to read.

> Though, genpd first need to invoke the ->start() callbacks, else
> drivers/subsystems won't be able to save their devices' register
> context.

Can we please have the above worded a little clearer?  How does this
relate to the previous paragraphs?  This description makes it unclear
at what point this action is required.  Is this talking about the point
where a device is being re-activated, or are we still talking about
the powering down sequence mentioned three paragraphs above?

> After invoking the ->start() and then ->runtime_suspend() callback,
> genpd again needs to invoke the ->stop() callback. A sequence which
> is repeated for each of the re-activated devices within the PM domain,
> during the power off sequence.

Hang on, if the ->stop() callback was already called because of a
genpd's ->runtime_suspend() method being called, but which
->runtime_suspend are we talking about here.  Confused.

> This leads to a suboptimal power off sequence, both from the
> perspective that the ->start|stop() callback needs to be invoked but
> also because all operations are serialized. It simply causes a
> thundering herd problem and gives latency issues.
> 
> To elaborate on the latency issues, let's follow the below scenario.
> 
> 	* Device [A] and [B] lives in the same generic PM domain.
> 
> 	* Device [A] has been re-activated and has recently also become
> 	inactive, which means genpd has invoked the ->stop() callback
> 	for it and started the power off sequence.

I'm not sure what "also" has to do with anything here.  What action is
"also" referring to?  Maybe this is sufficient:

	* Device [A] has recently become inactive, causing genpd to
	invoke the PM domain's stop() method, which starts the power
	off sequence via pm_genpd_poweroff().

(That's another thing... providing actual function names in the
description allow people to refer to the code and follow your
problem description.)

> 	* Then someone calls pm_runtime_get_sync() for the inactive
> 	device [B]. The ongoing power off sequence should thus be
> 	aborted as soon as possible.
> 
> 	* In this scenario the actual PM domain hasn't yet been powered
> 	off, but instead the power off sequence calls
> 	__pm_genpd_save_device() for device [A].
> 
> 	* In parallel genpd's ->runtime_resume() callback at the PM
> 	domain level is invoked for device [B]. It notifies the power
> 	off sequence to abort, which needs confirmation to be able to
> 	continue.
> 
> 	* Unfortunate, aborting the power off sequence won't be
> 	confirmed until device [A] has been powered off through
> 	__pm_genpd_save_device().
> 
> In this scenario, device [B] will be waiting for device [A] to complete
> ->start(), ->runtime_suspend() and ->stop(), which are invoked from
> __pm_genpd_save_device(). In other words, device [B]'s
> ->runtime_resume() latency will be extended with device [A]'s time to
> complete power off.
> 
> To move this reasoning a step further, it means all devices within the
> same generic PM domain suffers from an increased ->runtime_resume()
> latency. Moreover, that extended latency comes from the device with the
> slowest power off sequence.
> 
> This behavior in genpd, is a consequence from that the power off
> sequence needs to protect itself by using locks and states. Therefore
> can an abort only be confirmed in between calls to
> __pm_genpd_save_device().

Really, this English needs to be improved... I'm not sure I follow what
you're trying to say in this mail thus far, and the above paragraph makes
very little sense, and like previous ones, is gramatically wrong - there
should be no comma between "genpd" and "is", but it is generally accepted
that a comma always follows "Therefore".  "can an abort" makes zero sense,
maybe you meant "Therefore, an abort can only be..."

I'm giving up at this point... a description which can't be understood is
useless, sorry.

Please try again.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
