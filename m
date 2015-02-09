From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 07/12] Documentation: thermal docbook: introduce API reference chapter
Date: Mon,  9 Feb 2015 17:34:08 -0400
Message-ID: <1423517653-11359-8-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

In this patch we add a chapter to contain the API reference
for the thermal framework. For now, we list the documented
functions from thermal core, cpu cooling, and of thermal.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 Documentation/DocBook/thermal.tmpl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBook/thermal.tmpl
index 66efed3..d6ebbea 100644
--- a/Documentation/DocBook/thermal.tmpl
+++ b/Documentation/DocBook/thermal.tmpl
@@ -212,4 +212,13 @@
 			</glossary>
 		</sect1>
 	</chapter>
+	<chapter id="api">
+	<title>Thermal Device Driver Writer API reference</title>
+		<para> This Chapter contains an API reference for Thermal driver writers.
+		</para>
+!Iinclude/linux/thermal.h
+!Edrivers/thermal/thermal_core.c
+!Edrivers/thermal/cpu_cooling.c
+!Edrivers/thermal/of-thermal.c
+	</chapter>
 </book>
-- 
2.1.3
