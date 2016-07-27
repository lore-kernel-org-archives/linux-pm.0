From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH 1/1] power: sbs-manager: Add interrupt support and
 battery detect gpios
Date: Wed, 27 Jul 2016 23:08:27 +0200
Message-ID: <1469653707.27666.22.camel@amnesix>
References: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
	 <1469433003-68564-2-git-send-email-preid@electromag.com.au>
	 <20160727144609.GA12462@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:55323 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbcG0VIn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2016 17:08:43 -0400
In-Reply-To: <20160727144609.GA12462@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Phil Reid <preid@electromag.com.au>, mark.rutland@arm.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Am Mittwoch, den 27.07.2016, 09:46 -0500 schrieb Rob Herring:
> On Mon, Jul 25, 2016 at 03:50:03PM +0800, Phil Reid wrote:
> > This patch added irq support for the SMBALERT pin and notification of
> > the battery removal / insertion. The sbs manager would typically be
> > used with the corresponding sbs-battery driver that currently uses a
> > gpio input for battery presence and interrupt. To remain compatible with
> > that existing driver this patch implements GPIO inputs with interrupt
> > support. IRQ masking is performed in software as the hardware does not
> > support masking of notifications from each battery.
> > In addition a power_supply change notification is generated for the sbs
> > manager device when the AC present flag is changed.
> > Tested with LTC1760 and dual sbs compatible batteries.
> 
> Please don't submit a binding and immediately turn around and add to it. 
> While that is often preferred for drivers or kernel features, bindings 
> should be complete as possible and not evolve. Combine this with your 
> previous patch add sbs-mgr if that hasn't been accepted yet.
> 
> IMO, the sbs-bat should just be a interrupt and making it and this 
> binding a GPIO is overkill. Since batteries nodes using this will be 
> new, there's no reason the driver can't be updated to support 
> interrupts.
> 
> Also, I'm not even convinced you need the sbs-mgr to be an 
> interrupt-controller. Is this anything more that just wire-OR'ed 
> interrupt lines which can be handled as shared irq? Does reading 
> SBSM_CMD_BATSYSSTATE have a side effect for example?
Yes, according to the Datasheed it clears SMBALERT#.
> 
> Rob
SMBALERT is electrically an active low line which is pulled down by one
or more devices needing attention, isn't it? The I2C host driver or some
other instance need to implement support for it, the device driver may
register some sort of handler function (e.g by implementing struct
i2c_driver.alert function)

That's my understanding of the SMBALERT.

I once tried to implement the alert function and see if it get's called.
It didn't. At that point I didn't investigate further.

So, do I miss something or is that part incomplete/broken? I can only
find lm90 and ipmi_ssif which implement the callback.
-- 
Karl-Heinz


