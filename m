From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/3] show energy consumption info in perf tool
Date: Thu, 26 May 2011 16:34:15 +0800
Message-ID: <1306398855.2207.156.camel__29477.7381619953$1306399560$gmane$org@rui>
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
To: LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
Cc: acme@redhat.com, mingo@elte.hu, a.p.zijlstra@chello.nl, ming.m.lin@intel.com
List-Id: linux-pm@vger.kernel.org


Introduce four new perf software events
PERF_COUNT_SW_PKG_ENERGY
PERF_COUNT_SW_CORE_ENERGY
PERF_COUNT_SW_UNCORE_ENERGY
and
PERF_COUNT_SW_DRAM_ENERGY

To use it, users can run
perf stat -e pkg-energy foo
to get the package energy consumption when running foo.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/perf/design.txt          |    4 ++++
 tools/perf/util/parse-events.c |    8 ++++++++
 2 files changed, 12 insertions(+)

Index: linux-2.6/tools/perf/design.txt
===================================================================
--- linux-2.6.orig/tools/perf/design.txt
+++ linux-2.6/tools/perf/design.txt
@@ -139,6 +139,10 @@ enum sw_event_ids {
 	PERF_COUNT_SW_PAGE_FAULTS_MAJ	= 6,
 	PERF_COUNT_SW_ALIGNMENT_FAULTS	= 7,
 	PERF_COUNT_SW_EMULATION_FAULTS	= 8,
+	PERF_COUNT_SW_PKG_ENERGY	= 9,
+	PERF_COUNT_SW_CORE_ENERGY	= 10,
+	PERF_COUNT_SW_UNCORE_ENERGY	= 11,
+	PERF_COUNT_SW_DRAM_ENERGY	= 12,
 };
 
 Counters of the type PERF_TYPE_TRACEPOINT are available when the ftrace event
Index: linux-2.6/tools/perf/util/parse-events.c
===================================================================
--- linux-2.6.orig/tools/perf/util/parse-events.c
+++ linux-2.6/tools/perf/util/parse-events.c
@@ -50,6 +50,10 @@ static struct event_symbol event_symbols
   { CSW(CPU_MIGRATIONS),		"cpu-migrations",		"migrations"		},
   { CSW(ALIGNMENT_FAULTS),		"alignment-faults",		""			},
   { CSW(EMULATION_FAULTS),		"emulation-faults",		""			},
+  { CSW(PKG_ENERGY),			"pkg-energy",			""			},
+  { CSW(CORE_ENERGY),			"core-energy",			""			},
+  { CSW(UNCORE_ENERGY),			"uncore-energy",		""			},
+  { CSW(DRAM_ENERGY),			"dram-energy",			""			},
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
@@ -82,6 +86,10 @@ static const char *sw_event_names[PERF_C
 	"major-faults",
 	"alignment-faults",
 	"emulation-faults",
+	"package-energy-consumption",
+	"core-energy-consumption",
+	"uncore-energy-consumption",
+	"dram-energy-consumption",
 };
 
 #define MAX_ALIASES 8
