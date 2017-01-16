From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/6] BQ24190 charger fixes
Date: Mon, 16 Jan 2017 09:21:11 -0800
Message-ID: <20170116172111.GA7399@atomide.com>
References: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:57730 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdAPRVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Jan 2017 12:21:20 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

* Liam Breck <liam@networkimprov.net> [170115 22:06]:
> Changes in v2:
> 
> #1 reorders:            Fix irq triggering to IRQF_TRIGGER_FALLING
> #2 factors out part of: Call power_supply_changed() only for relevant component
> #3 replaces:            Call enable_irq() only at the end of probe()
> #4 reorders:            Call power_supply_changed() only for relevant component
> #5 unscrambles:         Don't read fault register outside irq_handle_thread()
> #6 factors out part of: Don't read fault register outside irq_handle_thread()

All look good to me thanks:

Acked-by: Tony Lindgren <tony@atomide.com>

> These are dropped; Tony will resubmit them in new patchset:
>   Check the interrupt status on resume
>   Use PM runtime autosuspend

Yes I'll repost those after no more comments on these.

Regards,

Tony
