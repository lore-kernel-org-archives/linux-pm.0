From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/4] PM / devfreq: Fix module autoload for platform drivers
Date: Wed, 19 Oct 2016 18:06:23 -0300
Message-ID: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:48269
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933233AbcJSVGn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 17:06:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hello,

I noticed that module autoload won't be working in some of the defreq
platform drivers. This patch series contains the fixes for these.

Best regards,
Javier


Javier Martinez Canillas (4):
  PM / devfreq: rk3399_dmc: Fix module autoload
  PM / devfreq: exynos-nocp: Fix module autoload
  PM / devfreq: rockchip-dfi: Fix module autoload
  PM / devfreq: exynos-ppmu: Fix module autoload

 drivers/devfreq/event/exynos-nocp.c  | 1 +
 drivers/devfreq/event/exynos-ppmu.c  | 1 +
 drivers/devfreq/event/rockchip-dfi.c | 1 +
 drivers/devfreq/rk3399_dmc.c         | 1 +
 4 files changed, 4 insertions(+)

-- 
2.7.4

