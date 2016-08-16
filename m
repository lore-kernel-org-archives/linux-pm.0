From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt: cpufreq: brcm: New binding document for
 brcm-avs-cpufreq
Date: Tue, 16 Aug 2016 08:16:39 -0500
Message-ID: <20160816131639.GA938@rob-hp-laptop>
References: <1471044331-2480-1-git-send-email-mmayer@broadcom.com>
 <1471044331-2480-2-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35492 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbcHPNQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 09:16:44 -0400
Content-Disposition: inline
In-Reply-To: <1471044331-2480-2-git-send-email-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Aug 12, 2016 at 04:25:29PM -0700, Markus Mayer wrote:
> Add the binding document for the new brcm-avs-cpufreq driver.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  .../bindings/cpufreq/brcm-avs-cpufreq.txt          | 84 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
> new file mode 100644
> index 0000000..707ebe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
> @@ -0,0 +1,84 @@
> +Broadcom AVS CPUfreq driver
> +===========================
> +
> +This driver provides voltage and frequency scaling on Broadcom SoCs using

Bindings describe h/w (or firmware interfaces) not drivers. CPUFreq is a 
Linux term. Please re-word.

> +the AVS firmware with DVFS support. The AVS firmware is running on its own
> +co-processor. The driver supports both uniprocessor (UP) and symmetric
> +multiprocessor (SMP) systems which share clock and voltage across all CPUs.
> +
> +Actual voltage and frequency scaling is done solely by the AVS firmware.
> +This driver does not change frequency or voltage itself. It provides a
> +standard CPUfreq interface to the rest of the kernel and to userland. It
> +interfaces with the AVS firmware to effect the requested changes and to
> +report back the current system status in a way that is expected by existing
> +tools.
> +
> +This driver requires two DT nodes. One node (brcm,avs-cpu-data-mem)
> +references the mailbox register used to communicate with the AVS CPU. The
> +second node (brcm,avs-cpu-l2-intr) is required to trigger an interrupt on
> +the AVS CPU. The interrupt tells the AVS CPU that it needs to process a
> +command sent to it by this driver. Interrupting the AVS CPU is mandatory for
> +commands to be processed.

The mailbox and interrupt to the AVS CPU are only for DVFS? 
