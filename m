From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] power: sbs-manager: Add interrupt support and
 battery detect gpios
Date: Wed, 27 Jul 2016 09:46:09 -0500
Message-ID: <20160727144609.GA12462@rob-hp-laptop>
References: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
 <1469433003-68564-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34332 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbcG0OqN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2016 10:46:13 -0400
Content-Disposition: inline
In-Reply-To: <1469433003-68564-2-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: mark.rutland@arm.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, karl-heinz@schneider-inet.de, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Jul 25, 2016 at 03:50:03PM +0800, Phil Reid wrote:
> This patch added irq support for the SMBALERT pin and notification of
> the battery removal / insertion. The sbs manager would typically be
> used with the corresponding sbs-battery driver that currently uses a
> gpio input for battery presence and interrupt. To remain compatible with
> that existing driver this patch implements GPIO inputs with interrupt
> support. IRQ masking is performed in software as the hardware does not
> support masking of notifications from each battery.
> In addition a power_supply change notification is generated for the sbs
> manager device when the AC present flag is changed.
> Tested with LTC1760 and dual sbs compatible batteries.

Please don't submit a binding and immediately turn around and add to it. 
While that is often preferred for drivers or kernel features, bindings 
should be complete as possible and not evolve. Combine this with your 
previous patch add sbs-mgr if that hasn't been accepted yet.

IMO, the sbs-bat should just be a interrupt and making it and this 
binding a GPIO is overkill. Since batteries nodes using this will be 
new, there's no reason the driver can't be updated to support 
interrupts.

Also, I'm not even convinced you need the sbs-mgr to be an 
interrupt-controller. Is this anything more that just wire-OR'ed 
interrupt lines which can be handled as shared irq? Does reading 
SBSM_CMD_BATSYSSTATE have a side effect for example?

Rob
