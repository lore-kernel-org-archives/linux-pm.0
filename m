From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v2 0/3] Broadcom AVS CPUfreq driver
Date: Mon, 3 Oct 2016 08:59:01 +0530
Message-ID: <20161003032901.GA4664@vireshk-i7>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475272561-8446-1-git-send-email-mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30-09-16, 14:55, Markus Mayer wrote:
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

My fault really. I wanted to review it earlier but couldn't :(

I should be doing it this week though.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
