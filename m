Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9682C4167D
	for <linux-pm@archiver.kernel.org>; Tue,  7 Nov 2023 03:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjKGDvK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 6 Nov 2023 22:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjKGDvK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2023 22:51:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F3D47;
        Mon,  6 Nov 2023 19:51:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC68CC433C8;
        Tue,  7 Nov 2023 03:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699329067;
        bh=+X/hKJ32hWOaYLZj2LTvR6+JnyM9c+DOTeGM5OWPGd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mISH3v7+T+GCIROhQKnt36obHCbBRgrPkPS4NNc53prAZ9MQ94P06ipdtp3U/ZZRW
         nQ/KQcYeWhmoQGV7eZi6DLG1ezyNHN13mqUsx5e0NTdDP/Z4CIkdpAwXZs+edy9fzH
         Nl7pzb+nMQPGEDX8bxlCZ+XyQ8ArVG0z5Nh8bsQh7emOfD5x8GqfX9k59moV4MduaQ
         ptc/Xplz8EwviVZdaHPZosg34pyHWeiopFrj99l9pgsMZSEVSeiwMPoVxwvLWnSjSy
         XQaXpaYdHgoqEt3lILVcdM4WZdgvazTVmxDw+hWblh3jqsfgiQAooh1RSo6+zi7AFB
         jE8zVpiTm+RUw==
Date:   Mon, 6 Nov 2023 19:55:07 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <6mgpjpdfsswww7mqqtub45afjz6mjyqfkigji3zsy73qwnq57u@rlstudlwkddn>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20230905-caleb-qmi_cooling-v1-2-5aa39d4164a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905-caleb-qmi_cooling-v1-2-5aa39d4164a7@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 29, 2023 at 05:16:18PM +0100, Caleb Connolly wrote:
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> +definitions:
> +  tmd:
> +    type: object
> +    description: |

No need to preserve formatting (which is what '|' denotes).

> +      A single Thermal Mitigation Device exposed by a remote subsystem.
> +    properties:
> +      label:
> +        maxItems: 1
> +      "#cooling-cells":
> +        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
> +
> +    required:
> +      - label
> +      - "#cooling-cells"
> +
> +    additionalProperties: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qmi-cooling-modem
> +      - qcom,qmi-cooling-adsp
> +      - qcom,qmi-cooling-cdsp
> +      - qcom,qmi-cooling-slpi
> +
> +  vdd:
> +    $ref: "#/definitions/tmd"
> +    description:
> +      Restrict primary rail minimum voltage to "nominal" setting.

Isn't this one of the "heating" thermal mitigations? (I.e. something
being tripped when the temperature goes below some level) Which afaik
the framework doesn't support still?

Regards,
Bjorn
