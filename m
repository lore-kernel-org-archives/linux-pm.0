Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F0EB64DB
	for <linux-pm@archiver.kernel.org>; Tue, 13 Jun 2023 22:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbjFMW3J (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjFMW2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 18:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8D26A8;
        Tue, 13 Jun 2023 15:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A828463BAA;
        Tue, 13 Jun 2023 22:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5D1C433C0;
        Tue, 13 Jun 2023 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695255;
        bh=UtC7UcQ/hyUlLBdUbZmK4L7JcHDTE+ooivJIEWVvdVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h49pmsQsKYJfsGw5PAtl0HSY0l/4Am2otZYq5oSgl2/7LTDCQlgvsGBoeFWNA6pBi
         KkmreFSbMJ5YvmO3hTFOlAtLc9ow74JwbdhHOZMbzxRRZdIokQdicIAyrzYzE8W0He
         WBONsTU6veuNkDsmFdzFQohUf7h4RT6D6vBcuiRROp5gnTvBYw7FfM3205G6qC4fQU
         gr1JnhzeFX/NZQhuoP8zhl+82yjy6OGr5ruyaB8stoFCxCZ0v1JXm5Z7oqhcxRk3EB
         LJboTeOm836bff98ZO+XcBdyLXR0BP7uLOUQgzXz/BjnjMQJ0fzoBETofa39JDC4r1
         dAN98JsBf365w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robimarko@gmail.com, agross@kernel.org, tglx@linutronix.de,
        viresh.kumar@linaro.org, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        mani@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] Add devicetree support for SDX75 Modem and IDP
Date:   Tue, 13 Jun 2023 15:30:31 -0700
Message-Id: <168669542894.1315701.1987302610815486412.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 9 Jun 2023 17:20:33 +0530, Rohit Agarwal wrote:
> Changes in v4:
>  - Addressed some of the dt bindings check mentioned by Krzysztof.
> 
> Changes in v3:
>  - Clubbed all the dt node into a single patch as suggested by Krzysztof.
>  - Removed the applied patch.
>  - Addressed some comments from Konrad and Dmitry.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: arm: qcom: Document SDX75 platform and boards
      commit: f9a97656ace80c617df2d6003c815877c026a9e3
[5/5] arm64: dts: qcom: Add SDX75 platform and IDP board support
      commit: 9181bb939984f1ad4f958c2be3ea10fd67344165

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
