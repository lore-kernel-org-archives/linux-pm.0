Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E1C25B43
	for <linux-pm@archiver.kernel.org>; Sat, 21 Oct 2023 15:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjJUPy7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 21 Oct 2023 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjJUPy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Oct 2023 11:54:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B746135;
        Sat, 21 Oct 2023 08:54:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F759C433CC;
        Sat, 21 Oct 2023 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697903696;
        bh=1bu3MCjIkx+otYnQ2hvbT/mKimxS2JrZesCYfq3VZ6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ki5PYrfm9HXYE2av5kjqSAhc7zkGeSNaaYuaASezSeIMthuMXm1s5qxdkSY9dkVIH
         mOtUJKpsDEfWbVqV5Cap8N2GXRtvUljJvmhwkvRkhF3ci1K4YXFNkCFbWTs7XrjGdP
         ukclQ4pJZVtd9Sous+mCJpIuTTawOLgXZGVMBeq6HW9h2okkDarzPtd763Fqhre3Ej
         AU5PfID8SLhic2CSGDu+fI7kSyBiN1RY5yH9lQk2WnklMJgDUChIawH3hGlXm+JPV/
         jjVqs1nMH1GXTcwAIQg0g0F+a9Zg8VGVFO2o2hYAVx9tGuHaqUxstnPLyNIa9cZpG8
         /ieyR2QB5jYMw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] Fix up icc clock rate calculation on some platforms
Date:   Sat, 21 Oct 2023 08:58:32 -0700
Message-ID: <169790390707.1690547.12470863359480060239.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 25 Aug 2023 17:38:22 +0200, Konrad Dybcio wrote:
> Certain platforms require that some buses (or individual nodes) make
> some additional changes to the clock rate formula, throwing in some
> magic, Qualcomm-defined coefficients, to account for "inefficiencies".
> 
> Add the framework for it and utilize it on a couple SoCs.
> 
> 
> [...]

Applied, thanks!

[10/10] clk: qcom: smd-rpm: Move CPUSS_GNoC clock to interconnect
        commit: 76ca22bd3d95cfb5113206894abbc80de6ceb1fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
