From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Fix DT example
Date: Tue, 25 Apr 2017 10:01:07 +0200
Message-ID: <CAPDyKFpOKnU=d901=rV_=FgB3BzzXvZGpHBpVPbPkUymMns=Pw@mail.gmail.com>
References: <533b52e0ea175bf6bb893370c7f8c0309aae235a.1493104411.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33865 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176305AbdDYIBJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 04:01:09 -0400
Received: by mail-qk0-f170.google.com with SMTP id y63so108323230qkd.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 01:01:08 -0700 (PDT)
In-Reply-To: <533b52e0ea175bf6bb893370c7f8c0309aae235a.1493104411.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 25 April 2017 at 09:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The power-domain provider's #power-domain-cells field is set to 0 and
> yet the children is using an index to point the power domain. Fix it by
> removing the index field.
>
> Fixes: 70bb510e4279 ("dt/bindings / PM/Domains: Update binding for PM domain idle states")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 940707d095cc..14bd9e945ff6 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -81,7 +81,7 @@ domain provided by the 'parent' power controller.
>         child: power-controller@12341000 {
>                 compatible = "foo,power-controller";
>                 reg = <0x12341000 0x1000>;
> -               power-domains = <&parent 0>;
> +               power-domains = <&parent>;
>                 #power-domain-cells = <0>;
>                 domain-idle-states = <&DOMAIN_PWR_DN>;
>         };
> --
> 2.12.0.432.g71c3a4f4ba37
>
