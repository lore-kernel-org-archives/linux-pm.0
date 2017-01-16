From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 0/6] BQ24190 charger fixes
Date: Mon, 16 Jan 2017 11:42:06 -0800
Message-ID: <CAKvHMgS2ukV6-R7wzPQ+=0N7GaLbHZHBoYBdax7MTLrVYu9gHA@mail.gmail.com>
References: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
 <20170116173044.GA27262@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33349 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdAPTmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 14:42:08 -0500
Received: by mail-io0-f196.google.com with SMTP id 101so13599327iom.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 11:42:07 -0800 (PST)
In-Reply-To: <20170116173044.GA27262@animalcreek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Greer <mgreer@animalcreek.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Mon, Jan 16, 2017 at 9:30 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> On Sun, Jan 15, 2017 at 10:05:26PM -0800, Liam Breck wrote:
>> Changes in v2:
>>
>> #1 reorders:            Fix irq triggering to IRQF_TRIGGER_FALLING
>> #2 factors out part of: Call power_supply_changed() only for relevant component
>> #3 replaces:            Call enable_irq() only at the end of probe()
>> #4 reorders:            Call power_supply_changed() only for relevant component
>> #5 unscrambles:         Don't read fault register outside irq_handle_thread()
>> #6 factors out part of: Don't read fault register outside irq_handle_thread()
>>
>> These are dropped; Tony will resubmit them in new patchset:
>>   Check the interrupt status on resume
>>   Use PM runtime autosuspend
>
> Hi Liam - a couple notes:
> - please include the full original text from v1 with the text above
>   added to it;
> - please thread the emails like you did with v1

Hi Mark. There was no v1 0/n preamble. It would have read:

"v1: Misc fixes, tested on a custom OMAP3 board."
