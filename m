From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH RFC 2/3] thermal: dove: convert to a thermal OF sensor
 device
Date: Sat, 1 Apr 2017 09:15:12 -0700
Message-ID: <20170401161510.GA18500@localhost.localdomain>
References: <E1cn8qH-0002v6-SE@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32878 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdDAQPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 12:15:17 -0400
Content-Disposition: inline
In-Reply-To: <E1cn8qH-0002v6-SE@rmk-PC.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Russell,

On Sun, Mar 12, 2017 at 07:07:45PM +0000, Russell King wrote:
> Convert the dove thermal infrastructure to an OF sensor device, and add
> the thermal zones for the SoC, with a critical trip point of 120°C.
> This allows us to specify thermal zones and couple them to cooling
> devices in DT.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/boot/dts/dove.dtsi    | 17 +++++++++++++++++
>  drivers/thermal/dove_thermal.c | 33 +++++++++++++++++++++++++--------

I have no opposition to these changes. The only request, to avoid
conflicts, is to split the patch into driver and DTS changes. We have
been pushing these separately. DTS changes go via the arch tree. Drivers
changes goes via Rui/me.

You can add my:
Acked-by: Eduardo Valentin <edubezval@gmail.com>

On the DTSI patch.
