From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] MAINTAINERS: Add Jacob Pan as a new intel_idle maintainer
Date: Wed, 30 Nov 2016 02:33:07 +0100
Message-ID: <13103232.E6GcmyrfK8@aspire.rjw.lan>
References: <1768401.hlc2LWNWsP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1768401.hlc2LWNWsP@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The intel_idle driver is going to be maintained by Jacob Pan now, so
update MAINTAINERS accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -6299,6 +6299,7 @@ S:	Maintained
 F:	drivers/platform/x86/intel-vbtn.c
 
 INTEL IDLE DRIVER
+M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
 M:	Len Brown <lenb@kernel.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git

