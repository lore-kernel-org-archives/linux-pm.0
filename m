From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v4 0/3] PM / Runtime: Feature to power manage slave devices
Date: Mon, 09 Feb 2015 16:32:03 +0530
Message-ID: <1423479726-23140-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31424 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759882AbbBIK6F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 05:58:05 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, khilman@linaro.org, rjw@rjwysocki.net, len.brown@intel.com, ulf.hansson@linaro.org, tomasz.figa@gmail.com, kgene.kim@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, pankaj.dubey@samsung.com, m.szyprowski@samsung.com, geert+renesas@glider.be, Amit Daniel Kachhap <amit.daniel@samsung.com>

This patch is somewhat similar to V3 version but uses pm runtime framework to
register/fetch the information about the device which may be slave or master.
Since the power domain has the necessary information about devices so it invokes
the save/restore runtime callbacks for the slave devices.

There was objection raised by Kevin and others that V3 is hacky in nature so this
revision fixes it by keeping the slave device information in pm runtime framework.

The model works like,
    DEV1 (Attaches itself with PD but no support of  pm_runtime_get and
     /	pm_runtime_put. Registers itself as pm runtime slave device.
    /	Its local runtime_suspend/resume is invoked by PD.
   /	
  /
PD -- DEV2 (Implements complete PM runtime and calls pm_runtime_get and
  \	pm_runtime_put. This in turn invokes PD On/Off)
   \
    DEV3 (Similar to DEV1)

This work is continuation of earlier work,

In V3: Used the existing API pm_genpd_dev_need_restore to add a feature to force
	devices to perform restore/save during every power domain on/off
	operation. This API is now removed.
	Link (https://lkml.org/lkml/2014/12/13/74

In V2: Completely removed notfiers and add support for huge clock list to be
	suspended and restored. There was some issue in this as some clocks are
	not exposed and are just initialised by bootloaders. This approach
	required all of them to be exposed which is cumbersome. Also some
	clock API's set_parent are disabling the original parent clocks
	which is not required.
	Link (https://lkml.org/lkml/2014/11/24/290)

In V1: Implemented PM Domain notfier such as PD_ON_PRE, PD_ON_POST
	PD_OFF_PRE and PD_OFF_POST. This was not supported and other
	options suggested. link (http://www.spinics.net/lists/linux-samsung-soc/msg38442.html)

This work may also assist exynos iommu pm runtime posted earlier by Marek
http://lists.linaro.org/pipermail/linaro-mm-sig/2014-August/004099.html

Amit Daniel Kachhap (3):
  PM / Runtime: Add an API pm_runtime_set_slave
  PM / Domains: Save restore slave pm runtime devices
  clk: samsung: Add PM runtime support for clocks.

 drivers/base/power/domain.c  | 28 +++++++++++++
 drivers/base/power/runtime.c | 18 +++++++++
 drivers/clk/samsung/clk.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h    | 11 ++++++
 include/linux/pm.h           |  1 +
 include/linux/pm_runtime.h   |  2 +
 6 files changed, 153 insertions(+)

-- 
2.2.0

