From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to
 the parent device
Date: Thu, 21 Dec 2017 02:39:19 +0100
Message-ID: <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org> <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34878 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757298AbdLUBjU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 20:39:20 -0500
In-Reply-To: <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Wed, Dec 20, 2017 at 3:09 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The runtime PM deployment in the phy core is deployed using the phy core
> device, which is created by the phy core and assigned as a child device of
> the phy provider device.
>
> The behaviour around the runtime PM deployment cause some issues during
> system suspend, in cases when the phy provider device is put into a low
> power state via a call to the pm_runtime_force_suspend() helper, as is the
> case for a Renesas SoC, which has its phy provider device attached to the
> generic PM domain.
>
> In more detail, the problem in this case is that pm_runtime_force_suspend()
> expects the child device of the provider device, which is the phy core
> device, to be runtime suspended, else a WARN splat will be printed
> (correctly) when runtime PM gets re-enabled at system resume.

So we are now trying to work around issues with
pm_runtime_force_suspend().  Lovely. :-/

> In the current scenario, even if a call to phy_power_off() triggers it to
> invoke pm_runtime_put() during system suspend, the phy core device doesn't
> get runtime suspended, because this is prevented in the system suspend
> phases by the PM core.
>
> To solve this problem, let's move the runtime PM deployment from the phy
> core device to the phy provider device, as this provides the similar
> behaviour. Changing this makes it redundant to enable runtime PM for the
> phy core device, so let's avoid doing that.

I'm not really convinced that this approach is the best one to be honest.

I'll have a deeper look at this in the next few days, stay tuned.

Thanks,
Rafael
