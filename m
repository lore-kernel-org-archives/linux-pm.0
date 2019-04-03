From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] admin-guide: pm: intel_epb: Add SPDX license tag and copyright notice
Date: Thu, 04 Apr 2019 00:08:18 +0200
Message-ID: <8068055.vE1LsT4ZeF@aspire.rjw.lan>
References: <4546107.fVFrecLk33@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4546107.fVFrecLk33@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an SPDX license tag and a copyright notice to the intel_epb.rst
file under Documentation/admin-quide/pm.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_epb.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/Documentation/admin-guide/pm/intel_epb.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_epb.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_epb.rst
@@ -1,7 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
 ======================================
 Intel Performance and Energy Bias Hint
 ======================================
 
+:Copyright: |copy| 2019 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+
+
 .. kernel-doc:: arch/x86/kernel/cpu/intel_epb.c
    :doc: overview
 
