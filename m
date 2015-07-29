From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 02/16] PM / OPP: Create a directory for opp bindings
Date: Wed, 29 Jul 2015 16:22:57 +0530
Message-ID: <4dfe565ff17766b7df127d475d84958e96fdab1b.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34288 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbbG2Kxf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 06:53:35 -0400
Received: by pacan13 with SMTP id an13so4025261pac.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 03:53:34 -0700 (PDT)
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

Cc: Rob Herring <rob.herring@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/{ => opp}/opp.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp/opp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/opp.txt
rename to Documentation/devicetree/bindings/power/opp/opp.txt
-- 
2.4.0

