From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/3] Broadcom STB AVS CPUfreq driver
Date: Thu, 13 Oct 2016 11:15:06 +0530
Message-ID: <20161013054506.GB2991@vireshk-i7>
References: <1476310376-32699-1-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36129 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755377AbcJMFp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 01:45:29 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so29708997pfk.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 22:45:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476310376-32699-1-git-send-email-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12-10-16, 15:12, Markus Mayer wrote:
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
> Changes from v3:
>     - moved code from brcm_avs_cpufreq_exit() into brcm_avs_cpufreq_remove()
>     - removed brcm_avs_cpufreq_exit() altogether

For the entire series:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
