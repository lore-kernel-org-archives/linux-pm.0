Return-Path: <SRS0=e3qT=5R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B15C43331
	for <linux-pm@archiver.kernel.org>; Wed,  1 Apr 2020 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824B62078B
	for <linux-pm@archiver.kernel.org>; Wed,  1 Apr 2020 12:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgDAM1D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:27:03 -0400
Received: from foss.arm.com ([217.140.110.172]:50510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgDAM1D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 08:27:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7B730E;
        Wed,  1 Apr 2020 05:27:03 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85E53F68F;
        Wed,  1 Apr 2020 05:27:00 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1585738725.git.amit.kucheria@linaro.org>
 <af3625a9cdf1a8f0e433d67e3d785b03aae7bc82.1585738725.git.amit.kucheria@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d4b8bf55-e240-6181-4976-880846cee413@arm.com>
Date:   Wed, 1 Apr 2020 13:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <af3625a9cdf1a8f0e433d67e3d785b03aae7bc82.1585738725.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

Apart from small mistake during probably copy-paste (please check
below), looks good.

On 4/1/20 12:15 PM, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The thermal-zone binding is a software abstraction to capture the
> properties of each zone - how often they should be checked, the
> temperature thresholds (trips) at which mitigation actions need to be
> taken and the level of mitigation needed at those thresholds.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v3:
>   - Clarify example by using cooling state numbers and a comment
>   - Restrict thermal-sensors to a single reference to reflect actual code
>     where there is a one-to-one mapping between sensors and thermal zones
>   - Add two optional properties that were missed in earlier submissions:
>     coefficients and sustainable-power
>   - Improve description of hysteresis and contribution properties
> 
>   .../bindings/thermal/thermal-zones.yaml       | 341 ++++++++++++++++++
>   1 file changed, 341 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> 

[snip]

> +                    cooling-maps {
> +                            map0 {
> +                                    trip = <&cpu0_alert0>;
> +                                    /* Corresponds to 1400MHz in OPP table */
> +                                    cooling-device = <&CPU0 3 3>, <&CPU1 3 3>,
> +                                                     <&CPU2 3 3>, <&CPU3 3 3>;
> +                            };
> +
> +                            map1 {
> +                                    trip = <&cpu0_alert1>;
> +                                    /* Corresponds to 1400MHz in OPP table */

s/1400MHz/1000MHz/
1400MHZ is used in map0 as <&CPUx 3 3>, here we have '5 5'.


> +                                    cooling-device = <&CPU0 5 5>, <&CPU1 5 5>,
> +                                                     <&CPU2 5 5>, <&CPU3 5 5>;
> +                            };
> +                    };
> +            };


Apart from that, looks good:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
