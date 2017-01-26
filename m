From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Wed, 25 Jan 2017 22:19:29 -0800
Message-ID: <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting> <20170122222212.27086-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:32890 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdAZGTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2017 01:19:30 -0500
In-Reply-To: <20170122222212.27086-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam@networkimprov.net> wrote:

> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 000000000000..398b4d622883
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,34 @@
> +Battery Characteristics
> +
> +Required Properties:
> + - compatible: Must be "fixed-battery"
> +
> +Optional Properties:
> + - termination-microvolt: dead battery voltage
> + - design-microwatt-hours: battery design energy
> + - design-microamp-hours: battery design capacity

Also I suspect the members of struct power_supply_battery_info should
use the same names as appear in dts:

+struct power_supply_battery_info {
+  int design_microwatt_hours;
+  int design_microamp_hours;
+  int termination_microvolt;
etc
