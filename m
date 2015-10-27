From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 7/7] arm64: Juno: declare idle-state cluster-sleep-0 as genpd state
Date: Tue, 27 Oct 2015 18:40:56 +0100
Message-ID: <1445967656-28292-8-git-send-email-mtitinger+renesas@baylibre.com>
References: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33987 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965629AbbJ0Rlf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:41:35 -0400
Received: by wikq8 with SMTP id q8so222779668wik.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 10:41:34 -0700 (PDT)
In-Reply-To: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <20151019205825.GA82426@linaro.org>
References: <20151019205825.GA82426@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

Using Juno to exercise the code that prepares for OS-initiated idle-state
handling, using genpd platform callbacks. In opposition to platform-
initiated mode as currently with pcsi/ATF.

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 0a72c07..f42d5f9 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -163,11 +163,13 @@
 		a57_pd: a57_pd@ {
 			compatible = "arm,cpu-pd";
 			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		a53_pd: a53_pd@ {
 			compatible = "arm,cpu-pd";
 			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
 
-- 
1.9.1

