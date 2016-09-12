From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 5/7] PM / runtime: Flag to indicate PM sleep
 transitions in progress
Date: Mon, 12 Sep 2016 16:07:27 +0200
Message-ID: <20160912140727.GA591@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <3677187.4hCpDgWMoX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:34351 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756816AbcILOHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 10:07:13 -0400
Content-Disposition: inline
In-Reply-To: <3677187.4hCpDgWMoX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Thu, Sep 08, 2016 at 11:29:48PM +0200, Rafael J. Wysocki wrote:
> Introduce a new flag in struct dev_pm_info, pm_sleep_in_progress, to
> indicate that runtime PM has been disabled because of a PM sleep
> transition in progress.
[...]
> That will allow helpers like pm_runtime_get_sync() to be called
> during system sleep transitions without worrying about possible
> error codes they may return because runtime PM is disabled at
> that point.

I have a suspicion that this patch papers over the direct_complete bug
I reported Sep 10 and that the patch is unnecessary once that bug is
fixed.

AFAICS, runtime PM is only disabled in two places during the system
sleep process: In __device_suspend() for devices using direct_complete,
and __device_suspend_late() for all devices.

In both of these phases (dpm_suspend() and dpm_suspend_late()), the
device tree is walked bottom-up. Since we've reordered consumers to
the back of dpm_list, they will be treated *before* their suppliers.
Thus, runtime PM is disabled on the consumers first, and only later
on the suppliers.

Then how can it be that runtime PM is already disabled on the supplier?
The only scenario I can imagine is that the supplier chose to exercise
direct_complete, thus was pm_runtime_disabled() in the __device_suspend()
phase, and the consumer did *not* choose to exercise direct_complete and
later tried to runtime resume its suppliers and itself.

I assume this patch is a replacement for Marek's [v2 08/10].
@Marek, does this scenario match with what you witnessed?

Best regards,

Lukas
