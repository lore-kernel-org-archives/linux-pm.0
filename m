From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no PM_RUNTIME
Date: Mon, 10 Nov 2014 19:35:39 +0100
Message-ID: <CAPDyKFp+cZa6PrAwQHbQE4xEzmRKBwN5J_uRByOdM0h8yoV2vg@mail.gmail.com>
References: <CAPDyKFpCx9XZu7xWt+koY-iLmiX4+XPu+2hGow2hrz3AR8Cb=A@mail.gmail.com>
	<Pine.LNX.4.44L0.1411101133100.5793-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33227 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbaKJSfm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 13:35:42 -0500
Received: by mail-qg0-f53.google.com with SMTP id z107so5870703qgd.40
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 10:35:41 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1411101133100.5793-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 10 November 2014 17:36, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 10 Nov 2014, Ulf Hansson wrote:
>
>> > To me, this sounds like a good reason to avoid using
>> > force_runtime_suspend().  In fact, it sounds like a good reason to
>> > avoid relying on the runtime PM mechanism to handle non-runtime-PM
>> > things (like a system suspend callback).  If CONFIG_PM_RUNTIME isn't
>> > enabled then the runtime PM stack simply should not be used.
>>
>> There are an important advantage of using the pm_runtime_force_suspend() here.
>>
>> For the driver to handle clock gating at system PM suspend, it first
>> needs to bring the device into full power, through
>> pm_runtime_get_sync(). Otherwise it's not safe to gate the clock,
>> since it may already be gated.
>
> That's fine, but it has nothing to do with pm_runtime_force_suspend().
>
> Besides, if the real question is whether or not to gate the clock (or
> in other words, has the clock already been gated), why not just store a
> "clock_is_gated" flag somewhere?

You could do that, but it's easier to not.

You will need to update the runtime PM status and disable runtime PM
anyway, done by the API.

Kind regards
Uffe
