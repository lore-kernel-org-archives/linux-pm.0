From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] bcm2835: Add Raspberry Pi CPU frequency control to the
 device tree
Date: Tue, 20 Oct 2015 21:00:18 -0600
Message-ID: <5626FFC2.4060102@wwwdotorg.org>
References: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36578 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbJUDAU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 23:00:20 -0400
In-Reply-To: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-rpi-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org

On 10/11/2015 01:46 PM, Lubomir Rintel wrote:
> This adds a device tree binding for Broadcom BCM2834 CPU frequency control
> driven via Raspberry Pi VideoCore 4 firmware interface.

Oh I see; that DT binding was sent as a separate patch rather than part
of the series...

DT bindings patches need to be sent to the people/lists in the following
MAINTAINERS entry:

OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
M:      Rob Herring <robh+dt@kernel.org>
M:      Pawel Moll <pawel.moll@arm.com>
M:      Mark Rutland <mark.rutland@arm.com>
M:      Ian Campbell <ijc+devicetree@hellion.org.uk>
M:      Kumar Gala <galak@codeaurora.org>
L:      devicetree@vger.kernel.org

> diff --git a/Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt
> new file mode 100644
> index 0000000..eb126d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/raspberrypi,bcm2835-cpufreq.txt
> @@ -0,0 +1,13 @@
> +Raspberry Pi Broadcom BCM2835 CPU frequency control
> +
> +Required properties:
> +
> +- compatible : should be "raspberrypi,bcm2835-cpufreq"
> +- firmware : the Raspberry Pi firmware node

It'd be best practice to mention the filename of the binding that
defines the firmware. For example:

- firmware : phandle of the Raspberry Pi firmware node, as defined in
  .././arm/bcm/raspberrypi,bcm2835-firmware.txt.

That said, I'm not convinced cpufreq scaling should rely on the firmware
directly, but instead should use the clock API to manipulate the clock.
