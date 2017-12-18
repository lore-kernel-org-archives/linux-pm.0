From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to contain magic values
Date: Mon, 18 Dec 2017 15:51:30 +0530
Message-ID: <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43342 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932672AbdLRKVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 05:21:44 -0500
Received: by mail-pf0-f195.google.com with SMTP id e3so9479737pfi.10
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 02:21:44 -0800 (PST)
In-Reply-To: <cover.1513591822.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513591822.git.viresh.kumar@linaro.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, robh+dt@kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, sudeep.holla@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On some platforms the exact frequency or voltage may be hidden from the
OS by the firmware. Allow such configurations to pass magic values in
the "opp-hz" or the "opp-microvolt" properties, which should be
interpreted in a platform dependent way.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 4e4f30288c8b..00a3bdbd0f1f 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -167,6 +167,12 @@ properties.
   functioning of the current device at the current OPP (where this property is
   present).
 
+
+On some platforms the exact frequency or voltage may be hidden from the OS by
+the firmware and the "opp-hz" or the "opp-microvolt" properties may contain
+magic values that represent the frequency or voltage in a firmware dependent
+way, for example an index of an array in the firmware.
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
-- 
2.15.0.194.g9af6a3dea062
