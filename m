From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Preventing PM from suspending device
Date: Thu, 12 Jan 2017 00:19:48 +0100
Message-ID: <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
References: <20170109172247.GI29854@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37786 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757284AbdAKXTv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 18:19:51 -0500
Received: by mail-wm0-f43.google.com with SMTP id c206so893453wme.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2017 15:19:50 -0800 (PST)
In-Reply-To: <20170109172247.GI29854@bigcity.dyn.berto.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On 9 January 2017 at 18:22, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> Hi Ulf and Linux PM,
>
> I have a question regarding if a driver can signal to the PM core that
> it should not be suspended from its struct dev_pm_ops suspend callback.

No. The driver/subsystem needs to deal this.

>
> My use-case is the sh_eth driver which I have added Wake-on-Lan support
> to, see [1]. In this driver I need to prevent the PM core to disable the
> module clock to the device if WoL is enabled. Currently I call
> clk_enable()/clk_disable() from the suspend/resume callbacks to modify
> the usage count of the clock to prevent the clock from being switched
> off by PM. This do not feel like the best solution to my problem.

I am not sure I get this. Is someone else than the driver performing
clk gateing/un-gating of the same clock?

>
> Is there a more generic way to let PM know that I'm fine with the system
> being suspended and I have suspended as much as I can but I'm a wake up s=
ource
> so could please not switch of my clock and power domain?

Seems like a quite common issue, but before we go into more details,
are you using genpd as the power domain? If not, what?

>
> 1. https://marc.info/?l=3Dlinux-pm&m=3D148397620011501&w=3D2
>
> --
> Regards,
> Niklas S=C3=B6derlund

Kind regards
Uffe
