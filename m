From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/4] thermal: re-calculate k_po/k_pu when update sustainable power
Date: Wed,  6 Jan 2016 16:53:44 +0800
Message-ID: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

k_po/k_pu are two proportional term constants and essentially they have
fixed ratio compared with sustainable power. In current implementation,
k_po and k_pu are absolute value after calculation and cannot represent
the ratio relationship with sustainable power; as a result, when change
sustainable power we cannot smoothly change proportional term constant.

So this patch series introduces k_po_ratio and k_pu_ratio, which
represent the ratio value compared against sustainable power. Also add
sys file system nodes for them for easily update them from userspace and
update a bit in documentation.

Changes from v2:
* According to Eduardo' comments, move code from thermal_core to
  power_allocator file
* According to Daniel's review, v1 will introduce accumulated rounding
  errors; v2 patches can dismiss this issue

Changes from v1:
* Fix compiling error

Leo Yan (4):
  thermal: power_allocator: rework proportional parameter
  thermal: power_allocator: change k_pu_ratio/k_po_ratio as percentage
  thermal: add sys node for k_pu_ratio/k_po_ratio
  thermal: power_allocator: document k_pu_ratio/k_po_ratio

 Documentation/thermal/power_allocator.txt | 15 +++++++++++----
 drivers/thermal/power_allocator.c         | 18 ++++++++++++------
 drivers/thermal/thermal_core.c            | 23 +++++++++++++++++++++--
 include/linux/thermal.h                   |  4 ++--
 4 files changed, 46 insertions(+), 14 deletions(-)

-- 
1.9.1

