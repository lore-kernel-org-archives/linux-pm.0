From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Tue, 20 May 2014 09:32:34 -0500
Message-ID: <537B6782.5080505@ti.com>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de> <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51043 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbaETOcs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 May 2014 10:32:48 -0400
In-Reply-To: <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 05/20/2014 09:27 AM, Lucas Stach wrote:
> Following the introduction of voltage ranges into OPP
> we need a way to encode them in the device tree in a
> similar fashion to the non-ranged versions.
> 
> To keep compatibility with old DTs the parsing function
> is changed to understand both versions.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 23 ++++++++++++++++++
>  drivers/base/power/opp.c                        | 31 ++++++++++++++++++-------
>  2 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5033fc..5b520ff321f5 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -10,6 +10,16 @@ Properties:
>  	freq: clock frequency in kHz
>  	vol: voltage in microvolt
>  
> +or
> +
> +- operating-points-range: An array of 4-tuple items, each item consisting
> +  of a frequency and a related voltage range in the following form:
> +  <freq min-vol-uV nom-vol-uV max-vol-uV>
> +	freq: clock frequency in kHz
> +	min-vol-uV: absolute minimum required voltage for this frequency
> +	nom-vol-uV: nominal voltage for this frequency
> +	max-vol-uV: absolute maximum allowed voltage for this frequency

And, Why cant we function at min-volt-uV? because PMIC cannot support
it? then why add voltage tolerance? This is not clear in the dt
description.



> +
>  Examples:
>  
>  cpu@0 {
> @@ -23,3 +33,16 @@ cpu@0 {
>  		198000  850000
>  	>;
>  };
> +
> +cpu@0 {
> +	compatible = "arm,cortex-a8";
> +	reg = <0x0>;
> +	operating-points-range = <
> +		/*  kHz min(uV) nom(uV) max(uV) */
> +		 166666  850000  900000 1400000
> +		 400000  900000  950000 1400000
> +		 800000 1050000 1100000 1400000
> +		1000000 1200000 1250000 1400000
> +		1200000 1300000 1350000 1400000
> +	>;
> +};

[...]

-- 
Regards,
Nishanth Menon
