Return-Path: <SRS0=knII=5K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDABC54FCF
	for <linux-pm@archiver.kernel.org>; Wed, 25 Mar 2020 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFAD2073E
	for <linux-pm@archiver.kernel.org>; Wed, 25 Mar 2020 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iK5q0pYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCYPo6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:44:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38663 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbgCYPo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 11:44:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so2975755ljh.5
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXD0NIbBQHX+z9/5Cn5kHqlwTwqxUoD/Q190EABWTDY=;
        b=iK5q0pYAem2IC9HXIUCtWiUmOAneNwO6eapMhrlo9VLWa65nib3Eh+CzYBy8hLhorL
         sJ4Ms9eG4HklmPaumOYkym3iEypfey3ioMh+Mc6r/X19Mg1orDDY+UGlORpAE8tku7Nh
         7gpopkJi24jMwYndQtn+iUf5ezVwgYYcdQSeIBhFo8isbCYnJrJ//SIkfBE8NVQuGkeE
         FZBlZH1Vf1AvT+2gJKE8uCmSZ594hEBMXA9G2KD/ZO5I7JRV/XFxF+OZjkP0q9edpq3+
         Wm9FPFp5/Z+Ok9ICmPaZcJrNO3u4h+skHjnxo25GXnJpos3CSOSMUP2WU+ep05IltdLY
         GYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXD0NIbBQHX+z9/5Cn5kHqlwTwqxUoD/Q190EABWTDY=;
        b=hCDyDHcYRiQuRgOXJPTjxVu+q7ZpwyldOmA+mOofD2HzJRmQ22Un943CE0eE/O9RNU
         tj2doOMajoAvpzBxRCQQaxEqUWQ0FjIqgDwsNJPd8OfwGJlzwfL8DoTNudmHbAI3atLM
         dv27+6F6qHfWiGZzAg6uZ5kZabrbAJK6zdsrUzdOe9AmMOmc2Dp7wamzsEB71P+8Unoo
         5oFv4SnEfPRXLrzh9X5eejJ1JR6Xz+mQRV/R/wEDaH00WbqHa0uR5wt/bPU43AW5jjDp
         WegMkf7b3tbW1LfM6W6qXIORPNIcvHf6IPx0WAFvLL2jAKVI6fvl90Yj6UfLpVMP4VK6
         nCHQ==
X-Gm-Message-State: ANhLgQ0nUDJS9mmEQyK3zVJFRitsri0Ui2F7eZZbpd6cf2Ccu33c57IO
        rApPcpVvb9ma8AsTsglY0h9+gVovC/ayJ/IgfOPAMg==
X-Google-Smtp-Source: ADFU+vv1RzjW7k7FmbN6HbpO06Hw8i+AT0m5YUev5QnYHDYHVSTJXBwOqWeX+HKNht/1FR17wexRpRGTCquA6m7QabQ=
X-Received: by 2002:a2e:90c4:: with SMTP id o4mr2215674ljg.287.1585151095466;
 Wed, 25 Mar 2020 08:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200324180513.3882-1-robh@kernel.org> <20200324180513.3882-2-robh@kernel.org>
In-Reply-To: <20200324180513.3882-2-robh@kernel.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 25 Mar 2020 21:14:44 +0530
Message-ID: <CAP245DVwuaDdTvymeGteoKcJj_+TyuEWnmY+GRtA2qnBKqhMsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Set 'additionalProperties:
 false'
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 11:35 PM Rob Herring <robh@kernel.org> wrote:
>
> Ensure the node only contains the properties listed in the schema by
> setting 'additionalProperties: false'. Doing this requires reworking the
> interrupt properties schemas so that they are defined in the main
> 'properties' section.


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Fixes: a877e768f655 ("dt-bindings: thermal: tsens: Convert over to a yaml schema")
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 28 ++++++++++++-------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 7a38d2116059..3492447e42e9 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -46,6 +46,18 @@ properties:
>        - description: TM registers
>        - description: SROT registers
>
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: Combined interrupt if upper or lower threshold crossed
> +      - description: Interrupt if critical threshold crossed
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: uplow
> +      - const: critical
> +
>    nvmem-cells:
>      minItems: 1
>      maxItems: 2
> @@ -88,22 +100,16 @@ allOf:
>      then:
>        properties:
>          interrupts:
> -          items:
> -            - description: Combined interrupt if upper or lower threshold crossed
> +          maxItems: 1
>          interrupt-names:
> -          items:
> -            - const: uplow
> +          maxItems: 1
>
>      else:
>        properties:
>          interrupts:
> -          items:
> -            - description: Combined interrupt if upper or lower threshold crossed
> -            - description: Interrupt if critical threshold crossed
> +          minItems: 2
>          interrupt-names:
> -          items:
> -            - const: uplow
> -            - const: critical
> +          minItems: 2
>
>  required:
>    - compatible
> @@ -113,6 +119,8 @@ required:
>    - interrupt-names
>    - "#thermal-sensor-cells"
>
> +additionalProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> --
> 2.20.1
>
