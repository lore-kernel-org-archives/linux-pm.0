From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Fri, 16 Dec 2016 09:09:07 +0000
Message-ID: <a09d1357-995f-7603-8c40-6d5167a14c2a@nvidia.com>
References: <1481804479-8711-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14507 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934030AbcLPJJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2016 04:09:15 -0500
In-Reply-To: <1481804479-8711-1-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org


On 15/12/16 12:21, Peter Rosin wrote:
> The ACOK pin on the bq24735 is active-high, of course meaning that when
> AC is OK the pin is high. However, all Tegra dts files have incorrectly
> specified active-high even though the signal is inverted on the Tegra
> boards. This has worked since the Linux driver has also inverted the
> meaning of the GPIO. Fix this situation by simply specifying in the
> bindings what everybody else agrees on; that the ti,ac-detect-gpios is
> active on AC adapter absence.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
> 
> Hi!
> 
> This patch is the result of this discussion:
> http://marc.info/?t=148152531800002
> 
> I don't like how it changes the one thing that is seems correct, but
> what to do?
> 
> Cheers,
> Peter
> 
>  Documentation/devicetree/bindings/power/supply/ti,bq24735.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> index 3bf55757ceec..43d56c49455b 100644
> --- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> +++ b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> @@ -8,8 +8,9 @@ Optional properties :
>   - interrupts : Specify the interrupt to be used to trigger when the AC
>     adapter is either plugged in or removed.
>   - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapter
> -   presence. This is a Host GPIO that is configured as an input and
> -   connected to the bq24735.
> +   status. This is a Host GPIO that is configured as an input and
> +   connected to the bq24735, typically the ACOK pin (note: the GPIO should
> +   be active on AC adapter absence).
>   - ti,charge-current : Used to control and set the charging current. This value
>     must be between 128mA and 8.128A with a 64mA step resolution. The POR value
>     is 0x0000h. This number is in mA (e.g. 8192), see spec for more information

I don't think you need the 'typically' above, and I may have added ...

"the GPIO must be active on AC adapter absence despite the ACOK being
active-high on AC presence to be compatible with legacy boards".

... but otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
