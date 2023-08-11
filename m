Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24CDC41513
	for <linux-pm@archiver.kernel.org>; Fri, 11 Aug 2023 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHKSIq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjHKSIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 14:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E396120;
        Fri, 11 Aug 2023 11:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B06FD67738;
        Fri, 11 Aug 2023 18:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEE9C433C8;
        Fri, 11 Aug 2023 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691777325;
        bh=nykOx0q7IcLGQ3gVamLqc1TS8Yf99XePB0KsPKtU35s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHmkd0ltasOMFoKuZ1K3Pe1ihDbpPzZIlfUxre5OUengRtVUSyM88n2pUQJDG0yQ4
         ShCi/JoYNzd+Q7Feq1oMTHBH/jR8z5obYWc5+4tlj1P71FiMIXjt4WC4i1HYeJm5MO
         ExDjt5/NrTzdYagckKtOV3XSKtR4/whjv5O4sRLiEds/3XZEzswmrll50TdPOSlw7E
         0NwV1jeQNkaBKIg4HERKjT7M3eEqZrgP9uvpRFwEUqnVr8EGghIHR+aqbgiI07ermC
         SdnkAnKz4l7J5DoIoOKGKD+NXeYMp2Loo02bjsbY25WlLP2+1w7EE4ZF5J7pDhiH4E
         4ZJHQ3x+Mz9LQ==
Received: (nullmailer pid 3721810 invoked by uid 1000);
        Fri, 11 Aug 2023 18:08:43 -0000
Date:   Fri, 11 Aug 2023 12:08:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: Add pm8916 LBC
Message-ID: <169177732213.3721461.11354242625128529075.robh@kernel.org>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
 <20230731-pm8916-bms-lbc-v2-2-82a4ebb39c16@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-pm8916-bms-lbc-v2-2-82a4ebb39c16@trvn.ru>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 31 Jul 2023 22:06:25 +0500, Nikita Travkin wrote:
> Qualcomm Linear Battery Charger is a CC/CV charger block in PM8916 PMIC.
> Document it's DT binding.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> v2: List all interrupts (Conor)
> ---
>  .../bindings/power/supply/qcom,pm8916-lbc.yaml     | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

