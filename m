From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] MAINTAINERS: Add bug tracking system location entry for cpufreq
Date: Wed, 30 Nov 2016 02:31:02 +0100
Message-ID: <1749629.bXnquB1jqi@aspire.rjw.lan>
References: <1768401.hlc2LWNWsP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1768401.hlc2LWNWsP@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The kernel Bugzilla is used for tracking cpufreq bugs, so document
that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -3349,6 +3349,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
+B:	https://bugzilla.kernel.org
 F:	Documentation/cpu-freq/
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
