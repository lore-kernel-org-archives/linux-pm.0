From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/2] of: thermal: Fix inconsitency between cooling-*-state
 and cooling-*-level
Date: Fri, 25 Sep 2015 13:33:15 -0500
Message-ID: <CAL_JsqKGk1v1FJ8De8L+UoMUC=T04SYK+WqHz6rZEYipiPYnqA@mail.gmail.com>
References: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com> <1441711249-11434-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36463 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbbIYSdf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 14:33:35 -0400
In-Reply-To: <1441711249-11434-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Tue, Sep 8, 2015 at 6:20 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> The device trees in the kernel as well as the binding description in
> Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt use the
> cooling-{min,max}-level property.
>
> Fix the inconsistency with the binding description in
> Documentation/devicetree/bindings/thermal/thermal.txt by changing
> cooling-*-state properties to cooling-*-level.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>

Both patches applied. Thanks.

Rob

> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 8a49362..8320186 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -55,16 +55,16 @@ of heat dissipation). For example a fan's cooling states correspond to
>  the different fan speeds possible. Cooling states are referred to by
>  single unsigned integers, where larger numbers mean greater heat
>  dissipation. The precise set of cooling states associated with a device
> -(as referred to be the cooling-min-state and cooling-max-state
> +(as referred to by the cooling-min-level and cooling-max-level
>  properties) should be defined in a particular device's binding.
>  For more examples of cooling devices, refer to the example sections below.
>
>  Required properties:
> -- cooling-min-state:   An integer indicating the smallest
> +- cooling-min-level:   An integer indicating the smallest
>    Type: unsigned       cooling state accepted. Typically 0.
>    Size: one cell
>
> -- cooling-max-state:   An integer indicating the largest
> +- cooling-max-level:   An integer indicating the largest
>    Type: unsigned       cooling state accepted.
>    Size: one cell
>
> @@ -225,8 +225,8 @@ cpus {
>                         396000  950000
>                         198000  850000
>                 >;
> -               cooling-min-state = <0>;
> -               cooling-max-state = <3>;
> +               cooling-min-level = <0>;
> +               cooling-max-level = <3>;
>                 #cooling-cells = <2>; /* min followed by max */
>         };
>         ...
> @@ -240,8 +240,8 @@ cpus {
>          */
>         fan0: fan@0x48 {
>                 ...
> -               cooling-min-state = <0>;
> -               cooling-max-state = <9>;
> +               cooling-min-level = <0>;
> +               cooling-max-level = <9>;
>                 #cooling-cells = <2>; /* min followed by max */
>         };
>  };
> --
> 2.5.0
>
