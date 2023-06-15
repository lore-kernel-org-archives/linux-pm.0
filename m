Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D5EB64D9
	for <linux-pm@archiver.kernel.org>; Thu, 15 Jun 2023 08:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbjFOIpy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 15 Jun 2023 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbjFOIpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2023 04:45:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0C9F35A5;
        Thu, 15 Jun 2023 01:44:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2061FB;
        Thu, 15 Jun 2023 01:45:19 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2CA3F71E;
        Thu, 15 Jun 2023 01:44:33 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:44:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
Message-ID: <20230615084430.boamsz56kqqi3n6h@bogus>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607124628.157465-10-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> The protocol@13 node is describing the performance scaling option for the
> ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> performance scaling is in many cases not limited to switching a clock's
> frequency.
> 
> Therefore, let's extend the binding so the interface can be modelled as a
> generic "performance domain" too. The common way to describe this, is to
> use the "power-domain" bindings, so let's use that.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..cff9d1e4cea1 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -145,8 +145,8 @@ properties:
>        '#clock-cells':
>          const: 1
>  
> -    required:
> -      - '#clock-cells'

I am yet to look at the patches, just looked at this binding changes for now.

Won't this break compatibility with existing DTBs. IMO, this is strict
no no, you can't drop #clock-cells. I wanted to add performance-domains
here as alternative but decided to not as I knew you were working on this.

-- 
Regards,
Sudeep
