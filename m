Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49679C433EF
	for <linux-pm@archiver.kernel.org>; Thu, 19 May 2022 12:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiESMoL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 May 2022 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiESMoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C630BA994
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:09 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/gT2Ezr7rYPRGdUgGO+U7BnxMmjGUDJuW0PzcbeB7w=;
        b=iOyQhxuDbN1xBW3Lw67N4mEZLDp0ZsUepGUxpkwGXcD+i83PJBB96qv2KAMMk0L8LV63Hb
        H8JRqKs3mIkQ+6YOP1GLL1adbhmTmNvkozdbib6SgiIbsczOXJej2aPyYdj/z68tF/G5UN
        4MrOJUVwefoZN+0OsLPBHBdN0yf11oHSv2o5edzHn1b20SR9ghVwb47xbIB7U/3YflfJFW
        hBfQ0p1TIuogYAhjArf5Sk6Jk01fowfXmKd3zLw0LIClQGUZSEm1bP8CCnsS+KVP6XZf+c
        fdSIDwctkCvF5x9GMxAlk2HPpqrLEFtij0WYQUUXM09tHEssEmwKpqawxMLdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/gT2Ezr7rYPRGdUgGO+U7BnxMmjGUDJuW0PzcbeB7w=;
        b=3kQ+QXau0CXsVNpVqw2FgNaZVOCuktF9Qen99wXnXpUgxNJH3D1AQlo5FvDac/81wdD3T+
        Sc5Uurlb6bIcurAQ==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: tsens: Add sc8280xp compatible
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220503153436.960184-1-bjorn.andersson@linaro.org>
References: <20220503153436.960184-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <165296424660.4207.2143791276806936542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     30988d3b31b1e8972f202e93574978927b5c9d06
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//30988d3b31b1e8972f202e93574978927b5c9d06
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Tue, 03 May 2022 08:34:36 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

dt-bindings: thermal: tsens: Add sc8280xp compatible

The Qualcomm SC8280XP platform has three instances of the tsens block,
add a compatible for these instances.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220503153436.960184-1-bjorn.andersson@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 43510b8..a24baf9 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -50,6 +50,7 @@ properties:
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens
+              - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
