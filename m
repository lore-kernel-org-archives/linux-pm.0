From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 0/8] PM / Domains: DT support for domain idle states & atomic PM domains
Date: Fri,  7 Oct 2016 15:36:53 -0700
Message-ID: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33376 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbcJGWhJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 18:37:09 -0400
Received: by mail-pa0-f53.google.com with SMTP id cd13so28111098pac.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2016 15:37:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Hi all,

Changes since v1 [2] - 
- Addressed review comments from v1.
	- Fixes around dynamic allocation of genpd states
	- Used OF method for iterating phandles
	- Updated documentation, examples
	- Rename state variable (provider -> fwnode)
- The series is available at [3].

The changes from [1] are -
- Allocating memory for domain idle states dynamically
- Conform to naming conventions for internal and exported genpd functions
- DT binding example for domain-idle-state
- Use fwnode instead of of_node
- Handle atomic case for removal of PM Domain
- Rebase on top of Rafael's pm/genpd tree

Thanks,
Lina

Lina Iyer (8):
  PM / Domains: Make genpd state allocation dynamic
  PM / Domain: Add residency property to genpd states
  PM / Domains: Allow domain power states to be read from DT
  PM / Domains: Save the fwnode in genpd_power_state
  dt/bindings: Update binding for PM domain idle states
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains

 .../devicetree/bindings/power/power_domain.txt     |  38 +++
 Documentation/power/devices.txt                    |   9 +-
 arch/arm/mach-imx/gpc.c                            |  17 +-
 drivers/base/power/domain.c                        | 360 +++++++++++++++++----
 include/linux/pm_domain.h                          |  28 +-
 5 files changed, 380 insertions(+), 72 deletions(-)

-- 
2.7.4

[1]. https://www.spinics.net/lists/arm-kernel/msg526814.html
[2]. http://www.spinics.net/lists/arm-kernel/msg535106.html
[3]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-v2
