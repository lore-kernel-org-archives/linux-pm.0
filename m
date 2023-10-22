Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B22DC25B4B
	for <linux-pm@archiver.kernel.org>; Sun, 22 Oct 2023 16:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjJVQXx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 22 Oct 2023 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJVPqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2023 11:46:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5AFF3;
        Sun, 22 Oct 2023 08:46:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E39C433D9;
        Sun, 22 Oct 2023 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989573;
        bh=MgO5bjMvpO11GfjTzQbZpeaD/9DseAWTE89B2Y+hElw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PtzdmEYGtj1cFaaoEmaKgRC0lx+zqSu+Ia4BgCW2yxDArvcqTqroikivsf3akkOxE
         vgl8wkv88uZHy0HWPUn+5niaK9CeB3wIBa1xod7c4vX8w4zpQ+fuEwMK+ibAIqa8fO
         bJTE0+st8rKyJlW1p1ZbDWfFFnsDQRc2ULqmjq3YLCzSo8Gb2tntAMXN9nBhFAKODV
         6r58pWMFmzdyGxqwfc4G1PxyxmdTsfenVpupPitDkTETvEVAJc+Lo+juySxcoLDUQs
         oaT7Je3cFbA7ahS/Eb8WCCKISYy44G0jsqg5q4zkU3yIwj3M6s1c7tNQVAZnBlRXK8
         k8bYd1umtEDtw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] SDM670 CPU frequency scaling: dtschema fixes
Date:   Sun, 22 Oct 2023 08:50:20 -0700
Message-ID: <169798982274.271027.14966618047695117026.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230816230412.76862-6-mailingradian@gmail.com>
References: <20230816230412.76862-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 16 Aug 2023 19:04:14 -0400, Richard Acayan wrote:
> Changes since v1 (20230815223108.306018-5-mailingradian@gmail.com):
>  - add compatible to allOf area (2/3)
>  - change subject line (Acked-by tag retained) (1/3)
>  - add fixes tag (2/3)
> 
> This adds appropriate compatible strings to pass bindings checks.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sdm670: add specific cpufreq compatible
      commit: 032ff6a3b39addd54427844affaf21e1e80fabc2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
