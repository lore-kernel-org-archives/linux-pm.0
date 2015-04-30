From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Thu, 30 Apr 2015 17:38:00 +0530
Message-ID: <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34746 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbD3MIS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 08:08:18 -0400
Received: by pdbqa5 with SMTP id qa5so58856398pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 05:08:17 -0700 (PDT)
In-Reply-To: <cover.1430394884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

On some platforms (Like Qualcomm's SoCs), it is not decided until
runtime on what OPPs to use. The OPP tables can be fixed at compile
time, but which table to use is found out only after reading some efuses
(sort of an eeprom) and knowing characteristics of the SoC.

To support such platform we need to pass multiple OPP tables per device
and hardware should be able to choose one and only one table out of
those.

Update OPP-v2 bindings to support that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 3b67a5c8d965..07959903ec32 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -14,6 +14,9 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP descriptor in their DT node. The OPP core will use this phandle
 to find the operating points for the device.
 
+Devices may want to choose OPP tables at runtime and so can provide a list of
+phandles here. But only *one* of them should be chosen at runtime.
+
 
 * OPP Descriptor Node
 
@@ -28,6 +31,8 @@ This describes the OPPs belonging to a device. This node can have following
   reference an OPP.
 
 Optional properties:
+- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
+  table is supplied in "operating-points-v2" property of device.
 - shared-opp: Indicates that device nodes using this OPP descriptor's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
-- 
2.3.0.rc0.44.ga94655d

