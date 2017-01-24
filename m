From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Tue, 24 Jan 2017 11:56:33 -0800
Message-ID: <CAKvHMgS9ZxE2qxDqeAVRJFzerjkJV=io58aQjtU51j=kFzbYtw@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting> <20170122222212.27086-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32959 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdAXT4e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 14:56:34 -0500
In-Reply-To: <20170122222212.27086-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam@networkimprov.net> wrote:
> I think Matt meant the following :-)
>
> Note: nominal-microvolt is not the correct term for termination voltage.
> Changed to termination-microvolt
> ---
>
> Documentation on battery properties that can be defined for
> fine tuning fuel gauge state machines.
>
> From: Matt Ranostay <matt@ranostay.consulting>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>
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


Two more battery characteristics should be included. Battery chargers
need them (for instance, BQ24190).

- precharge-microamps: maximum charge current during precharge
  phase (typically 20% of battery capacity)

- termination-microamps: a charge cycle terminates when the
  battery voltage is above recharge threshold, and the current is below
  this setting (typically 10% of battery capacity)

Perhaps termination-microvolt should be called terminal-microvolt or
similar to avoid confusion.

Sebastian, did you want to include the other fields from your example?

        /* Nokia BL-5J */
        nominal-microvolt = <3700000>;
        chemistry-type = <POWER_SUPPLY_LI_ION>;
