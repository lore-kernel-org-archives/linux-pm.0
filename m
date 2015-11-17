From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/3] devicetree: bindings: Add optional
 dynamic-power-coefficient property
Date: Tue, 17 Nov 2015 10:06:32 +0530
Message-ID: <CAOh2x==3i-ksVOArpGJFVBH9jQspB4gN5u-uVi2XbT0HK5AoAQ@mail.gmail.com>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
	<1447702225-13323-2-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36821 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbKQEgd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 23:36:33 -0500
In-Reply-To: <1447702225-13323-2-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, dawei.chien@mediatek.com, Javi Merino <javi.merino@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Nov 17, 2015 at 1:00 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> The dynamic power consumption of a device is proportional to the
> square of voltage (V) and the clock frequency (f). It can be expressed as
>
> Pdyn = dynamic-power-coefficient * V^2 * f.
>
> The coefficient represents the running time dynamic power consumption in
> units of mw/MHz/uVolt^2 and can be used in the above formula to
> calculate the dynamic power in mW.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 3a07a87..6aca64f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -242,6 +242,23 @@ nodes to be present and contain the properties described below.
>                 Definition: Specifies the syscon node controlling the cpu core
>                             power domains.
>
> +       - dynamic-power-coefficient
> +               Usage: optional
> +               Value type: <prop-encoded-array>
> +               Definition: A u32 value that represents the running time dynamic
> +                           power coefficient in units of mW/MHz/uVolt^2. The
> +                           coefficient can either be calculated from power
> +                           measurements or derived by analysis.
> +
> +                           The dynamic power consumption of the CPU  is
> +                           proportional to the square of the Voltage (V) and
> +                           the clock frequency (f). The coefficient is used to
> +                           calculate the dynamic power as below -
> +
> +                           Pdyn = dynamic-power-coefficient * V^2 * f
> +
> +                           where voltage is in uV, frequency is in MHz.
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>
>         cpus {

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
