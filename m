Return-Path: <SRS0=539E=7W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCCBC433E2
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jun 2020 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4716620820
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jun 2020 00:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgFIAQB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:16:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:9553 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgFIAPX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 20:15:23 -0400
IronPort-SDR: 0A6QxNPgstd7B6Bg7M9/cnZ3tw8+LV7TPGdZ07kvwvVfkqxE9yOq52F5m0mBJl0LtJVfnDRJS9
 ANgLvCXr7cuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 17:15:22 -0700
IronPort-SDR: lW1f/BmKLN9Wi6VuYnd3WCgBkqh499vtnJmRkvcOseJGs9cgHIgcaOebDazF7Ls/B/Ykbj37sM
 jR7hqWhD3INw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="259618088"
Received: from lkp-server01.sh.intel.com (HELO 12d5c0ac8e64) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2020 17:15:19 -0700
Received: from kbuild by 12d5c0ac8e64 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jiRvD-00000X-3F; Tue, 09 Jun 2020 00:15:19 +0000
Date:   Tue, 9 Jun 2020 05:23:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [RFC PATCH] power: supply: max17040: max17040_family[] can be static
Message-ID: <20200608212356.GA34456@af167214b55a>
References: <20200608182642.592848-2-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608182642.592848-2-iskren.chernev@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 max17040_battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 4fd6cf7b60c71..78f04aba4f26a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -62,7 +62,7 @@ struct chip_data {
 	u8  has_soc_alert;
 };
 
-struct chip_data max17040_family[] = {
+static struct chip_data max17040_family[] = {
 	[ID_MAX17040] = {
 		.reset_val = 0x0054,
 		.vcell_shift = 4,
