From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 01/11] opp: Create a directory for opp bindings
Date: Mon, 27 Jul 2015 10:32:31 +0530
Message-ID: <f03c244df5f698e720bf961f64a61ac9daee717d.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35274 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbbG0FDV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 01:03:21 -0400
Received: by pabkd10 with SMTP id kd10so45114111pab.2
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 22:03:20 -0700 (PDT)
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

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

