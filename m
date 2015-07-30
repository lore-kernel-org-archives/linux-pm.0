From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 resend] PM / OPP: Create a directory for opp bindings
Date: Thu, 30 Jul 2015 22:27:19 +0530
Message-ID: <29597667e2c8afdbf396c5fcc9269fb27794131c.1438274711.git.viresh.kumar@linaro.org>
References: <20150730165240.GF17794@linux>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34743 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbG3Q5t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 12:57:49 -0400
Received: by pdbbh15 with SMTP id bh15so27201847pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 09:57:48 -0700 (PDT)
In-Reply-To: <20150730165240.GF17794@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Resending to get cc list fixed, which isn't getting populated due to a
bug with get_maintainers.

 Documentation/devicetree/bindings/{power => opp}/opp.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{power => opp}/opp.txt (100%)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/opp.txt
rename to Documentation/devicetree/bindings/opp/opp.txt
-- 
2.4.0

