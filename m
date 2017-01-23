From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/8] devicetree: property-units: add mWh and mAh units
Date: Mon, 23 Jan 2017 11:50:18 -0600
Message-ID: <20170123175018.kja7jizc3l7zorcr@rob-hp-laptop>
References: <20170122071404.9654-1-matt@ranostay.consulting>
 <20170122071404.9654-2-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33827 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWRuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2017 12:50:21 -0500
Content-Disposition: inline
In-Reply-To: <20170122071404.9654-2-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, tony@atomide.com

On Sat, Jan 21, 2017 at 11:13:57PM -0800, Matt Ranostay wrote:
> Add entries for microwatt-hours and microamp-hours to property
> units.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>

Please add acks when posting new versions. You're missing Sebastian's 
and mine.

> ---
>  Documentation/devicetree/bindings/property-units.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index 12278d79f6c0..5e8d220cc2b6 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -25,8 +25,10 @@ Distance
>  Electricity
>  ----------------------------------------
>  -microamp	: micro amps
> +-microamp-hours : micro amp hours
>  -ohms		: Ohms
>  -micro-ohms	: micro Ohms
> +-microwatt-hours: micro Watt hours
>  -microvolt	: micro volts
>  
>  Temperature
> -- 
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
