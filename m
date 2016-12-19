From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 0/2] cpufreq: brcmstb-avs-cpufreq: properly retrieve P-state upon suspend
Date: Mon, 19 Dec 2016 12:10:26 -0800
Message-ID: <20161219201028.18885-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This fix is for 4.10.

The driver needs to save the proper P-state on suspend, so it'll resume at
the same speed.

We also add the P-state and the mode as returned by the AVS firmware GET_PMAP
command to the existing brcm_avs_pmap sysfs entry. This will make it easier
to diagnose any issues.

Markus Mayer (2):
  cpufreq: brcmstb-avs-cpufreq: extend sysfs entry brcm_avs_pmap
  cpufreq: brcmstb-avs-cpufreq: properly retrieve P-state upon suspend

 drivers/cpufreq/brcmstb-avs-cpufreq.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.7.4
