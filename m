From: Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: [PATCH v2 2/2] cpufreq: qoriq: rename the driver
Date: Fri, 21 Nov 2014 17:18:38 +0800
Message-ID: <1416561518-24835-2-git-send-email-Yuantian.Tang@freescale.com>
References: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:29540
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754740AbaKUJUD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Nov 2014 04:20:03 -0500
In-Reply-To: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, r64188@freescale.com, Tang Yuantian <Yuantian.Tang@freescale.com>

This driver works on all QorIQ platforms which include
ARM-based cores and PPC-based cores.
Rename it in order to represent better.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v2:
	- use -C -M options when format-patch

 drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} (100%)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
similarity index 100%
rename from drivers/cpufreq/ppc-corenet-cpufreq.c
rename to drivers/cpufreq/qoriq-cpufreq.c
-- 
2.1.0.27.g96db324

