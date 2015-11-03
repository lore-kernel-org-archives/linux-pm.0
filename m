From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Tue, 3 Nov 2015 07:42:54 +0530
Message-ID: <20151103021254.GM3639@ubuntu>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030214907.GJ19782@codeaurora.org>
 <20151031021612.GU3716@ubuntu>
 <20151102192144.GQ19782@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151102192144.GQ19782@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 02-11-15, 11:21, Stephen Boyd wrote:
> Ah I see that after looking at the previous thread. Perhaps we
> can add such information into the documentation so that people
> aren't misled into thinking they're limited to 32 bits?

What about these changes:

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 96892057586a..b6ca2239838b 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -123,11 +123,15 @@ properties.
 - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
   the table should have this.
 
-- opp-supported-hw: User defined array containing a hierarchy of hardware
-  version numbers, supported by the OPP. For example: a platform with hierarchy
-  of three levels of versions (A, B and C), this field should be like <X Y Z>,
-  where X corresponds to Version hierarchy A, Y corresponds to version hierarchy
-  B and Z corresponds to version hierarchy C.
+- opp-supported-hw: This enables us to select only a subset of OPPs from the
+  larger OPP table, based on what version of the hardware we are running on. We
+  still can't have multiple nodes with the same opp-hz value in OPP table.
+
+  Its an user defined array containing a hierarchy of hardware version numbers,
+  supported by the OPP. For example: a platform with hierarchy of three levels
+  of versions (A, B and C), this field should be like <X Y Z>, where X
+  corresponds to Version hierarchy A, Y corresponds to version hierarchy B and Z
+  corresponds to version hierarchy C.
 
   Each level of hierarchy is represented by a 32 bit value, and so there can be
   only 32 different supported version per hierarchy. i.e. 1 bit per version. A
@@ -135,6 +139,10 @@ properties.
   level. And a value of 0x00000000 will disable the OPP completely, and so we
   never want that to happen.
 
+  If 32 values aren't sufficient for a version hierarchy, than that version
+  hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2> in the
+  above example, Z1 & Z2 refer to the version hierarchy Z.
+
 - status: Marks the node enabled/disabled.
 


-- 
viresh
