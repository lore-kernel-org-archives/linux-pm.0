From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 0/6] BQ24190 charger fixes
Date: Mon, 16 Jan 2017 10:30:44 -0700
Message-ID: <20170116173044.GA27262@animalcreek.com>
References: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52371 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750827AbdAPRaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 12:30:46 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Sun, Jan 15, 2017 at 10:05:26PM -0800, Liam Breck wrote:
> Changes in v2:
> 
> #1 reorders:            Fix irq triggering to IRQF_TRIGGER_FALLING
> #2 factors out part of: Call power_supply_changed() only for relevant component
> #3 replaces:            Call enable_irq() only at the end of probe()
> #4 reorders:            Call power_supply_changed() only for relevant component
> #5 unscrambles:         Don't read fault register outside irq_handle_thread()
> #6 factors out part of: Don't read fault register outside irq_handle_thread()
> 
> These are dropped; Tony will resubmit them in new patchset:
>   Check the interrupt status on resume
>   Use PM runtime autosuspend

Hi Liam - a couple notes:
- please include the full original text from v1 with the text above
  added to it;
- please thread the emails like you did with v1

Thanks,

Mark
--
