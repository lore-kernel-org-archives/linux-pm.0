From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Wed, 15 Mar 2017 05:08:05 -0700
Message-ID: <CAKvHMgSnyPPMEZ1o70Ed2oBHGcMho=-jjFhfXGn4t+2bdALEew@mail.gmail.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com> <20170315105537.22349-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33023 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdCOMIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 08:08:07 -0400
In-Reply-To: <20170315105537.22349-2-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, robh+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

I dropped most of the CCs, pls re-add anyone essential. Use Cc lines
in patch description to direct a patch to interested parties and
relevant lists. I don't want to see all 19 patches in this series.

On Wed, Mar 15, 2017 at 3:55 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds the constant-charge-current property to the list of optional
> properties of the battery.
>
> The constant charge current is critical for batteries as they can't
> handle all charge currents.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> v4:
>  - switch from constant-charge-current-microamp to constant-charge-microamp,

Must be constant-charge-current-microamp for the reasons discussed in
battery.txt - consistency with sysfs names.

Also applies to power_supply_core.c patch.

Rob: enum power_supply_property also lists constant-charge-voltage,
hence the -current


> added in v3
>
>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 0278617..9594e1e 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -7,6 +7,7 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - constant-charge-microamp: battery constant charge current
>
>  Because drivers surface properties in sysfs using names derived
>  from enum power_supply_property, e.g.
> @@ -30,6 +31,7 @@ Example:
>                 voltage-min-design-microvolt = <3200000>;
>                 energy-full-design-microwatt-hours = <5290000>;
>                 charge-full-design-microamp-hours = <1430000>;
> +               constant-charge-microamp = <300000>;
>         };
>
>         charger: charger@11 {
> --
> 2.9.3
>
