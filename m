From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 0/4] PM / Domains: DT bindings for domain idle states and doc updates
Date: Tue, 25 Oct 2016 08:26:35 -0700
Message-ID: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

This patchset adds the following on top of the patches [0-7] of v3[1], that you
have already queued up for linux-next.

- New DT compatible for PM Domain idle states.
- Update documentation for PM domain idle state
(Pls. note that this new compatible is yet to be approved by DT reviewers)
- Update device/domain documentation per your suggestion

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg536181.html

Lina Iyer (4):
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains
  dt-bindings: add domain-idle-state compatible to arm,idle-state
  dt-bindings: Update domain-idle-state binding to use correct
    compatibles
  PM / Domains: Use domain-idle-state compatible

 Documentation/devicetree/bindings/arm/idle-states.txt    |  3 +++
 Documentation/devicetree/bindings/power/power_domain.txt |  9 +++++----
 Documentation/power/devices.txt                          | 14 +++++++++++++-
 drivers/base/power/domain.c                              |  2 +-
 4 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.7.4
