From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [RESEND PATCH v2 0/3] Broadcom AVS CPUfreq driver
Date: Fri, 7 Oct 2016 16:22:09 -0700
Message-ID: <CAGt4E5tj_e8R3x+3Fce5_aBYF1mRf+WhOADa5bZOKEu=RvR18Q@mail.gmail.com>
References: <1475882406-1992-1-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35765 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbcJGXWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 19:22:11 -0400
Received: by mail-ua0-f171.google.com with SMTP id u68so56252106uau.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2016 16:22:10 -0700 (PDT)
In-Reply-To: <1475882406-1992-1-git-send-email-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

My apologies. Please ignore this e-mail. Proper series coming up shortly.

Regards,
-Markus

On 7 October 2016 at 16:20, Markus Mayer <mmayer@broadcom.com> wrote:
> This series contains the CPUfreq driver for Broadcom SoCs that use "AVS
> Firmware" for voltage and frequency scaling. All voltage and frequency
> transitions are performed by the firmware and are therefore hidden from
> Linux.
>
> The driver provides a standard CPUfreq interface to other kernel
> components and to userland on the one hand and communicates with the
> AVS co-processor on the other.
>
> Communication between the two processors is via shared mailbox
> registers and interrupts (ARM -> AVS to tell the firmware that there is
> a command to process and AVS -> ARM to tell the driver that a command
> finished executing).
>
> lkml.org seems to be down for me. Here are patchwork links to the original
> series:
>
> https://patchwork.kernel.org/patch/9278119/
> https://patchwork.kernel.org/patch/9278121/
> https://patchwork.kernel.org/patch/9278127/
>
> Changes from v1:
>     - renamed binding document
>     - rewrote the introduction of the binding document
>     - created a new driver documentation file that contains Linux specific
>       information that was previously part of the binding document
>     - renamed the driver (and related config options) to include a reference
>       to "STB", since this implementation is primarily intended for use on
>       set-top boxes
>     - improved comments
>     - updated function __map_region()
>     - updated struct private_data
>     - added code to unmap memory regions in the error and exit paths
>     - added new sysfs property to report frequency directly from the
>       co-processor register
>
> Markus Mayer (3):
>   dt: cpufreq: brcm: New binding document for brcmstb-avs-cpufreq
>   cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs
>   cpufreq: brcmstb-avs-cpufreq: add debugfs support
>
>  Documentation/cpu-freq/brcmstb-avs-cpufreq.txt     |   27 +
>  .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |   77 ++
>  MAINTAINERS                                        |    9 +
>  drivers/cpufreq/Kconfig.arm                        |   10 +
>  drivers/cpufreq/Makefile                           |    1 +
>  drivers/cpufreq/brcmstb-avs-cpufreq.c              | 1026 ++++++++++++++++++++
>  6 files changed, 1150 insertions(+)
>  create mode 100644 Documentation/cpu-freq/brcmstb-avs-cpufreq.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
>  create mode 100644 drivers/cpufreq/brcmstb-avs-cpufreq.c
>
> --
> 2.7.4
>
