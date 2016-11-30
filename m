From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] MAINTAINERS: Add bug tracking system location entries for cpuidle
Date: Wed, 30 Nov 2016 02:32:17 +0100
Message-ID: <7223534.Grk4thc3lm@aspire.rjw.lan>
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

The kernel Bugzilla is used for tracking bugs in the cpuidle core and
intel_idle, so document that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -3389,6 +3389,7 @@ M:	Daniel Lezcano <daniel.lezcano@linaro
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+B:	https://bugzilla.kernel.org
 F:	drivers/cpuidle/*
 F:	include/linux/cpuidle.h
 
@@ -6301,6 +6302,7 @@ INTEL IDLE DRIVER
 M:	Len Brown <lenb@kernel.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
+B:	https://bugzilla.kernel.org
 S:	Supported
 F:	drivers/idle/intel_idle.c
 
