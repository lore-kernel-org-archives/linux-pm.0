From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/3] Broadcom STB AVS CPUfreq driver
Date: Mon, 14 Nov 2016 01:32:44 +0100
Message-ID: <5500544.cjuLUPfCfM@vostro.rjw.lan>
References: <20161027210536.98988-1-code@mmayer.net> <CAGt4E5siDGgE=s1gZc80RSjDTptAhCm6ecrrw_4NpJwmrnU-CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46931 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751418AbcKNAZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:25:12 -0500
In-Reply-To: <CAGt4E5siDGgE=s1gZc80RSjDTptAhCm6ecrrw_4NpJwmrnU-CA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Markus Mayer <code@mmayer.net>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, November 04, 2016 10:00:19 AM Markus Mayer wrote:
> On 27 October 2016 at 14:05, Markus Mayer <code@mmayer.net> wrote:
> > From: Markus Mayer <mmayer@broadcom.com>
> >
> > This series contains the CPUfreq driver for Broadcom SoCs that use "AVS
> > Firmware" for voltage and frequency scaling. All voltage and frequency
> > transitions are performed by the firmware and are therefore hidden from
> > Linux.
> >
> > The driver provides a standard CPUfreq interface to other kernel
> > components and to userland on the one hand and communicates with the
> > AVS co-processor on the other.
> >
> > Communication between the two processors is via shared mailbox
> > registers and interrupts (ARM -> AVS to tell the firmware that there is
> > a command to process and AVS -> ARM to tell the driver that a command
> > finished executing).
> 
> Viresh, Rafael, are you ready to take this series? Rob gave his Ack
> for the DT binding.

Applied.

Thanks,
Rafael

