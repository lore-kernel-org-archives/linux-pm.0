Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6459CC7EE29
	for <linux-pm@archiver.kernel.org>; Fri,  9 Jun 2023 15:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbjFIP4t (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbjFIP4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 11:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8A3592;
        Fri,  9 Jun 2023 08:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 954D365989;
        Fri,  9 Jun 2023 15:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41BBC4339C;
        Fri,  9 Jun 2023 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686326205;
        bh=cbOUcv/Kjw3M3BgO41zgP0vrwo+GlrVWwdBfg2GhhWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjEITgrbl4CHQjztjvf9iYiowKGRY7OemjBM7YiwlhjF1RsdPTAl8gWoEy2jQYa7F
         B8DDbrjO31vZJEfDzYvC/Uj6JcjN/2KNcPt9PKrgn1HX6v7inF1i5Ua8lt0df+rDHh
         OAD/eEYCq8udl+CbmufOgorWT/eKPkovmh1w4eDECw82Q3nl6AHZzzKfBToElDc7+F
         +QXiOjT9Zo+Pv1AGMnwat7dY6u1uMOiQuBOMFfDlwfY51Z8o+23Dy3E+LCxlutKJsg
         CpnSy05PAghz8MuH3zlFu7Duausju96SDAQVW6khPISkzJS+T1ReqWrIe3KKaPwXjm
         it92eRKgYihlw==
Date:   Fri, 9 Jun 2023 21:26:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, robimarko@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75
 compatible
Message-ID: <20230609155635.GF6847@thinkpad>
References: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686311438-24177-5-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686311438-24177-5-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 09, 2023 at 05:20:37PM +0530, Rohit Agarwal wrote:
> Add compatible for EPSS CPUFREQ-HW on SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index a6b3bb8..866ed2d 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -36,6 +36,7 @@ properties:
>                - qcom,sa8775p-cpufreq-epss
>                - qcom,sc7280-cpufreq-epss
>                - qcom,sc8280xp-cpufreq-epss
> +              - qcom,sdx75-cpufreq-epss
>                - qcom,sm6375-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss
>                - qcom,sm8350-cpufreq-epss
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
