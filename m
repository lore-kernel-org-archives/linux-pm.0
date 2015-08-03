From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Mon, 3 Aug 2015 09:16:42 +0530
Message-ID: <20150803034642.GV899@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728225510.GB3159@codeaurora.org>
 <20150729081403.GH2284@x1>
 <20150729221526.GE3159@codeaurora.org>
 <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35900 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbbHCDqr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 23:46:47 -0400
Received: by pacgq8 with SMTP id gq8so14029418pac.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Aug 2015 20:46:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150731163715.GV3159@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robherring2@gmail.com>, Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31-07-15, 09:37, Stephen Boyd wrote:
> For qcom platforms, the frequency is almost always constant.
> There may be some tables where we have a couple higher
> frequencies than others because the speed bin is different.
> Otherwise the voltage/current is changing based on the silicon
> characteristics. So the biggest duplication is the frequency
> property.
> 
> As far as I know there isn't any algorithm to generate the
> voltage values. It's all hand tuned tables based on the silicon
> characterization, so we're left to store these tables in DT and
> pick the right one at runtime. With regards to the table
> explosion, on qcom platforms we haven't worried that we have ~40
> tables, but I'm not opposed to expressing it in a smaller set of
> nodes, tables, etc. if that's what's desired.
> 
> Do we need vendor specific properties for that though? Or do we
> need some sort of extended frequency/voltage properties that are
> arrays of values that we can index into based on some silicon
> characteristics? I like the name based approach because it's
> simple. Use this OPP table because it's called
> x-y-z-characteristics and be done. Cramming the tables into less
> lines may save us some typing and dtb space, but I'm not sure
> what else it does.

What about something like this:

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 0cb44dc21f97..bad7a8299b9c 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -74,6 +74,8 @@ This describes the OPPs belonging to a device. This node can have following
   reference an OPP.
 
 Optional properties:
+- opp-cuts: One or more strings, describing the versions of hardware the OPPs
+  can support.
 - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
@@ -100,6 +102,9 @@ properties.
   Entries for multiple regulators must be present in the same order as
   regulators are specified in device's DT node.
 
+  If used with 'opp-cuts', then the number of entries present here must match
+  the number of strings present in 'opp-cuts'.
+
 - opp-microamp: The maximum current drawn by the device in microamperes
   considering system specific parameters (such as transients, process, aging,
   maximum operating temperature range etc.) as necessary. This may be used to

-- 
viresh
