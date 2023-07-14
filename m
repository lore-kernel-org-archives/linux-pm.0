Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDDEB64DC
	for <linux-pm@archiver.kernel.org>; Fri, 14 Jul 2023 05:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjGNFau (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Jul 2023 01:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjGNFao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 01:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A0B2683;
        Thu, 13 Jul 2023 22:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96EC061B91;
        Fri, 14 Jul 2023 05:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B25C43395;
        Fri, 14 Jul 2023 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312643;
        bh=3neIBRMgcQIdTGXRmMgsboGgicFF7ol+XVWepa/uG2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+4jEB/dAmx6h/Vv60ZkxkDZNkKjv07DTZPhJPp0awCZaP699HMdxZ1abcDDQcGsW
         wPf8tHoR4mcQfenQzTCs0uDDPRtrUtrdQm96QpYmHbB2u04pikts+RFvBQqq4ln4L+
         VGwrDEHDtru9CfEqjloKHH96HKXyo4W7UM9bLmz90XgsHI8fY/fYOI/uzI1Cf3e1qm
         eAQvJHWpnInyEehG6Rr3+wXQo5Tsh01aAAOBDhi8m/l2B5sB60jyyySqrPa7zkOK/O
         AQt+vgpyQHexOEFvqI14Y+pZa7POoxG2wUvDo7J/s58QvHmsLfwZEBS6WYVEFYdkGa
         ZWrfEZYA1ie5w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 4/4] arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq
Date:   Thu, 13 Jul 2023 22:33:58 -0700
Message-ID: <168931284119.1538684.15045851319853728549.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230512001334.2983048-5-dmitry.baryshkov@linaro.org>
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org> <20230512001334.2983048-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 12 May 2023 03:13:34 +0300, Dmitry Baryshkov wrote:
> Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
> according to CPU frequencies.
> 
> 

Applied, thanks!

[4/4] arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq
      commit: 8bb8688c1d73f21f413e4ea2a37fbbb90997f2bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
