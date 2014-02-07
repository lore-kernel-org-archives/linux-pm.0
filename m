From: Thomas Abraham <ta.omasab@gmail.com>
Subject: [PATCH v2 0/2] Add device tree based lookup of boost mode frequency
Date: Fri,  7 Feb 2014 20:49:00 +0530
Message-ID: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41896 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaBGPTY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2014 10:19:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com

Changes since v1:
- Boost mode frequencies are specfied as a set of frequencies instead of
  specifying them as OPPs. Thanks to Nishanth, Lukasz and Rob for the
  feedback.

Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
support for CPU boost mode for CPUfreq drivers. To use the new boost
mode, CPUfreq drivers have to specify the boost mode frequency and
voltage within the CPUfreq driver, which is the case for Exynos4x12
CPUfreq driver.

But for CPUfreq drivers which obtain the OPPs from cpus node, this
patch series adds support to specify boost mode frequencies in the
cpu device tree node. This requirement came up when Lukasz pointed
out the regression caused by the Exynos CPUfreq driver consolidation
patches.

Thomas Abraham (2):
  PM / OPP: Allow boost frequency to be looked up from device tree
  Documentation: devicetree: Add boost-frequency binding to list boost mode frequency

 .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   11 +++++++
 drivers/base/power/opp.c                           |   34 +++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt

