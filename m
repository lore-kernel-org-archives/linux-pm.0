From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 12/12] Documentation: thermal docbook: introduce governor chapter
Date: Mon,  9 Feb 2015 17:34:13 -0400
Message-ID: <1423517653-11359-13-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

In this patch we add a chapter in the thermal docbook to
describe the existing governors. The chapter contains
one section per governor.

Each governor description includes the respective code documentation.
Each governor section contains a description of the governor
logic.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 Documentation/DocBook/thermal.tmpl | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBook/thermal.tmpl
index d6ebbea..cf1a198 100644
--- a/Documentation/DocBook/thermal.tmpl
+++ b/Documentation/DocBook/thermal.tmpl
@@ -212,6 +212,73 @@
 			</glossary>
 		</sect1>
 	</chapter>
+
+	<chapter id="governors">
+		<title>Thermal Governors</title>
+		<para>
+		</para>
+
+		<sect1 id="step_wise">
+			<title>step_wise Thermal Governor</title>
+			<para>Step Wise uses the trend of the thermal zone to
+			throttle. If the thermal zone is 'heating up' this
+			throttles all the cooling devices associated with the
+			zone and its particular trip point, by one step. If the
+			zone is 'cooling down' it brings back the performance
+			of the devices by one step.
+			</para>
+!Idrivers/thermal/step_wise.c
+!Pdrivers/thermal/step_wise.c Algorithm
+		</sect1>
+		<sect1 id="fair_share">
+			<title>fair_share Thermal Governor</title>
+			<para>Fair Share Governor uses three parameters to
+			calculate the new throttle state of the cooling devices
+			associated with the given zone.  Parameters used for
+			Throttling:
+			</para>
+			<itemizedlist mark='opencircle'>
+				<listitem>P1. max_state: Maximum throttle state
+				exposed by the cooling device.</listitem>
+				<listitem>P2. weight[i]/100:</listitem>
+				<listitem>How 'effective' the 'i'th device is,
+				in cooling the given zone.</listitem>
+				<listitem>P3.
+				cur_trip_level/max_no_of_trips:</listitem>
+			</itemizedlist>
+			<para>This describes the extent to which the devices
+			should be throttled. We do not want to throttle too
+			much when we trip a lower temperature, whereas the
+			throttling is at full swing if we trip critical levels.
+			Heavily assumes the trip points are in ascending order
+			new_state of cooling device = P3 * P2 * P1.
+			</para>
+!Idrivers/thermal/fair_share.c
+		</sect1>
+		<sect1 id="bang_bang">
+			<title>bang_bang Thermal Governor</title>
+			<para>The Bang Bang Governor has a two point regulation
+			logic, deliver cooling state depending on the previous
+			state shown in this diagram: </para>
+			<para>If the fan is not running and temperature exceeds
+			trip_temp, the fan gets turned on. In case the fan is
+			running, temperature must fall below (trip_temp - hyst)
+			so that the fan gets turned off again.
+			</para>
+!Idrivers/thermal/gov_bang_bang.c
+		</sect1>
+		<sect1 id="user_space">
+			<title>user_space Thermal Governor</title>
+			<para> The User Space governor is outside the Kernel.
+			The Thermal Framework hands off the entire control to
+			userland if the User Space governor is assigned to a
+			thermal zone. A KOBJ_CHANGE UEvent notification is sent
+			to userland whenever a governor needs to take an
+			action.
+			</para>
+!Idrivers/thermal/user_space.c
+		</sect1>
+	</chapter>
 	<chapter id="api">
 	<title>Thermal Device Driver Writer API reference</title>
 		<para> This Chapter contains an API reference for Thermal driver writers.
-- 
2.1.3
