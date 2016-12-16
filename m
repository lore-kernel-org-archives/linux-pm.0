From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Fri, 16 Dec 2016 10:55:27 +0000
Message-ID: <68dfd1ae-ab31-c063-5bd6-bc16a62a6dcd@nvidia.com>
References: <1481881440-13464-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18186 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbcLPLEB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2016 06:04:01 -0500
In-Reply-To: <1481881440-13464-1-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


On 16/12/16 09:44, Peter Rosin wrote:
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
>  Documentation/devicetree/bindings/power/supply/ti,bq24735.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Hi!
> 
> v3 -> v4 changes:
> - improve the bindings text in the spirit of remarks from Jon Hunter
> 
> (There were no v1 nor v2, I made a mistake and started from v3 this time.)
> 
> This patch is the result of this discussion:
> http://marc.info/?t=148152531800002
> 
> I don't like how it changes the one thing that is seems correct, but
> what to do?
> 
> Cheers,
> peda
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> index 3bf55757ceec..c95e16e2dc56 100644
> --- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> +++ b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> @@ -8,8 +8,10 @@ Optional properties :
>   - interrupts : Specify the interrupt to be used to trigger when the AC
>     adapter is either plugged in or removed.
>   - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapter
> -   presence. This is a Host GPIO that is configured as an input and
> -   connected to the bq24735.
> +   status. This is a Host GPIO that is configured as an input and connected
> +   to the ACOK pin on the bq24735. Note: for backwards compatibility reasons,
> +   the GPIO must be active on AC adapter absence despite ACOK being active
> +   (high) on AC adapter presence.
>   - ti,charge-current : Used to control and set the charging current. This value
>     must be between 128mA and 8.128A with a 64mA step resolution. The POR value
>     is 0x0000h. This number is in mA (e.g. 8192), see spec for more information

Thanks.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
