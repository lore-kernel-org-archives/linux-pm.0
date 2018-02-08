From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v6 3/3] irqchip/gic-v3-its: add ability to resend MAPC on
 resume
Date: Thu, 8 Feb 2018 10:02:04 -0800
Message-ID: <20180208180203.GD106856@ban.mtv.corp.google.com>
References: <20180208023648.89124-1-dbasehore@chromium.org>
 <20180208023648.89124-4-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35357 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbeBHSCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Feb 2018 13:02:07 -0500
Received: by mail-io0-f194.google.com with SMTP id m11so6714135iob.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2018 10:02:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180208023648.89124-4-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, marc.zyngier@arm.com

On Wed, Feb 07, 2018 at 06:36:48PM -0800, Derek Basehore wrote:
> This adds functionality to resend the MAPC command to an ITS node on
> resume. If the ITS is powered down during suspend and the collections
> are not backed by memory, the ITS will lose that state. This just sets
> up the known state for the collections after the ITS is restored.
> 
> This is enabled via the reset-on-suspend flag in the DTS. It only runs
> for collections stored in the ITS itself.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 86 +++++++++++++++++++++-----------------
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 49 insertions(+), 38 deletions(-)

For the very little it's worth:

Reviewed-by: Brian Norris <briannorris@chromium.org>
