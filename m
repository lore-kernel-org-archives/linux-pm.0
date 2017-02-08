From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 0/2] PM / Domains: Updates to IRQ safe PM domains
Date: Wed,  8 Feb 2017 08:34:49 -0800
Message-ID: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This follows the discussions at Linux Plumbers Conference on PM domains and
idle states. In the context of CPU hierarchy, the CPU's idle states may be
presented using the property domain-idle-states if the domain is considered as
the boundary that powers on/off an individual CPU.

To that effect, domain idle states may not be specified but not compatible with
what PM domains expects. Hence ignore the idle states that are not
"domain-idle-state" compatible.

The second patch covers the case, where the hierarchy of PM domains is not
powered off in the same context. Currently, a workqueue is scheduled to power
off the parent domains in the hierarchy. In case of CPU PM domains, this will
not work, since we are running with interrupts disabled. Hence for IRQ safe PM
domains, power off the parent domains in the same context as the caller.

I understand Ulf is working on some argument changes in the same area of
functions. Will work with him to resolve conflicts before the merge. This is
based on the tip of Rafel's next.

Thanks,
Lina


Lina Iyer (2):
  PM / Domains: Ignore domain-idle-states that are not compatible
  PM / Domains: Support in context powering off parent domain

 .../devicetree/bindings/power/power_domain.txt     |  4 ++-
 drivers/base/power/domain.c                        | 37 +++++++++++++++-------
 2 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.7.4
