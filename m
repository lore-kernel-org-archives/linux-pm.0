From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] PM: Hide OPP configuration when SoCs do not
	provide an implementation
Date: Tue,  9 Nov 2010 18:24:16 +0000
Message-ID: <1289327056-27950-1-git-send-email-broonie__29020.5488483936$1289327281$gmane$org@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@lists.linux-foundation.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

Since the OPP API is only useful with an appropraite SoC-specific
implementation there is no point in offering the ability to enable
the API on general systems. Provide an ARCH_HAS OPP Kconfig symbol
which masks out the option unless selected by an implementation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/power/opp.txt |    3 +++
 kernel/power/Kconfig        |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
index 44d87ad..cd44558 100644
--- a/Documentation/power/opp.txt
+++ b/Documentation/power/opp.txt
@@ -37,6 +37,9 @@ Typical usage of the OPP library is as follows:
 SoC framework	-> modifies on required cases certain OPPs	-> OPP layer
 		-> queries to search/retrieve information	->
 
+Architectures that provide a SoC framework for OPP should select ARCH_HAS_OPP
+to make the OPP layer available.
+
 OPP layer expects each domain to be represented by a unique device pointer. SoC
 framework registers a set of initial OPPs per device with the OPP layer. This
 list is expected to be an optimally small number typically around 5 per device.
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 29bff61..a5aff3e 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -246,9 +246,13 @@ config PM_OPS
 	depends on PM_SLEEP || PM_RUNTIME
 	default y
 
+config ARCH_HAS_OPP
+	bool
+
 config PM_OPP
 	bool "Operating Performance Point (OPP) Layer library"
 	depends on PM
+	depends on ARCH_HAS_OPP
 	---help---
 	  SOCs have a standard set of tuples consisting of frequency and
 	  voltage pairs that the device will support per voltage domain. This
-- 
1.7.1
