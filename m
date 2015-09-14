From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 02/16] PM / OPP: Add 'opp-microvolt-triplets' binding
Date: Mon, 14 Sep 2015 15:30:29 -0500
Message-ID: <55F72E65.6000205@kernel.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <254dd353453a495bb0921fa23e430428484f36fa.1441972771.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34953 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbINUab (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 16:30:31 -0400
In-Reply-To: <254dd353453a495bb0921fa23e430428484f36fa.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, lee.jones@linaro.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 09/11/2015 07:01 AM, Viresh Kumar wrote:
> If 'opp-microvolt' is used to specify values for multiple regulators,
> then we need this additional information to know if the values passed
> should be treated as <target> or <target min max>.

Can't you determine this implicitly from # of cells / # of regulators
being either 1 or 3?

> 
> This is because, DT doesn't differentiate between these two styles:
> 
> prop = <x>, <y>, <z>;
> prop = <x y z>;
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 8759bc4783ed..719603b87353 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -76,6 +76,16 @@ This describes the OPPs belonging to a device. This node can have following
>    present here is important, as that should match the order in which values are
>    present in 'opp-microvolt' and 'opp-microamp' properties.
>  
> +- opp-microvolt-triplets: This is a required property, only if multiple supplies
> +  are available for the device. Otherwise it is ignored.
> +
> +  'opp-microvolt' can be present in two forms: <target> or <target min max>, per
> +  power-supply. 'opp-microvolt-triplets' property is used to find the form in
> +  which 'opp-microvolt' is present.
> +
> +  If present, then 'opp-microvolt' must be present in <target min max> form,
> +  else in <target> form.

This implies that bindings currently with triplets are wrong since they
will be missing opp-microvolt-triplets.

Rob
