From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3/resend 3/4] drivers: bus: Add Simple Power-Managed Bus DT Bindings
Date: Thu, 22 Jan 2015 14:42:08 -0800
Message-ID: <7hvbjy30an.fsf@deeprootsystems.com>
References: <1421919253-4784-1-git-send-email-geert+renesas@glider.be>
	<1421919253-4784-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34730 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbbAVWmP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jan 2015 17:42:15 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so1834754pab.12
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2015 14:42:14 -0800 (PST)
In-Reply-To: <1421919253-4784-4-git-send-email-geert+renesas@glider.be> (Geert
	Uytterhoeven's message of "Thu, 22 Jan 2015 10:34:12 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> v3:
>   - Add Tested-by,
>   - Document required properties inherited from "simple-bus",
>   - Document required "reg" property for "renesas,bsc",
>   - Move "ranges" before "reg" in the example,
>
> v2:
>   - New.
> ---
>  .../devicetree/bindings/bus/simple-pm-bus.txt      | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
>
> diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
> new file mode 100644
> index 0000000000000000..d03abf7fd8e3997a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
> @@ -0,0 +1,52 @@
> +Simple Power-Managed Bus
> +========================
> +
> +A Simple Power-Managed Bus is a transparent bus that doesn't need a real
> +driver, as it's typically initialized by the boot loader.
> +
> +However, its bus controller is part of a PM domain, or under the control of a
> +functional clock.  Hence, the bus controller's PM domain and/or clock must be
> +enabled for child devices connected to the bus (either on-SoC or externally)
> +to function.
> +
> +
> +Generic compatible values and properties
> +----------------------------------------
> +
> +Required properties:
> +  - compatible: Must be at least one of the vendor-specific compatible values
> +		from a vendor-specific section below, and "simple-bus" as a
> +		fallback.

What happened to the idea of using something like "simple-pm-bus"?

There's nothing vendor-specific in the driver at all, so the
vendor-specific binding seem like clutter to me and will result in
continuing to add vendor-specific compatibles without any
vendor-specific code.

Kevin
