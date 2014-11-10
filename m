From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Mon, 10 Nov 2014 16:06:19 +0100
Message-ID: <5331397.OQCQmJO78C@wuerfel>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com> <1415631557-22897-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61731 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbaKJPGx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 10:06:53 -0500
In-Reply-To: <1415631557-22897-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, khilman@linaro.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Monday 10 November 2014 16:59:16 Grygorii Strashko wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/ti,keystone-powerdomain.txt
> @@ -0,0 +1,31 @@
> +* TI Keystone 2 Generic PM Controller
> +
> +The TI Keystone 2 Generic PM Controller is responsible for Clock gating
> +for each controlled IP module.
> +
> +Required properties:
> +- compatible: Should be "ti,keystone-powerdomain"
> +- #power-domain-cells: Should be 0, see below:
> +
> +The PM Controller node is a PM domain as documented in
> +Documentation/devicetree/bindings/power/power_domain.txt.
> +
> +Example:
> +
> +       pm_controller: pm-controller {
> +               compatible = "ti,keystone-powerdomain";
> +               #power-domain-cells = <0>;
> +       };
> +
> +       netcp: netcp@2090000 {
> +               reg = <0x2620110 0x8>;
> +               reg-names = "efuse";
> +               ...
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               power-domains = <&pm_controller>;
> +
> +               clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
> +               dma-coherent;
> +       }

I don't get it. What keystone specific about a "ti,keystone-powerdomain"
device? It seems that the device has no registers whatsoever and the
driver doesn't really do anything that relates to the platform.

	Arnd
