Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93012C41535
	for <linux-pm@archiver.kernel.org>; Mon,  9 May 2022 05:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiEIFjB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 May 2022 01:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiEIFdF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 01:33:05 -0400
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 May 2022 22:29:10 PDT
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A740E78
        for <linux-pm@vger.kernel.org>; Sun,  8 May 2022 22:29:09 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 92F2430168;
        Mon,  9 May 2022 05:20:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 9A38C20025;
        Mon,  9 May 2022 05:20:02 +0000 (UTC)
Message-ID: <b2039ae7a9b33b61ea96919da2c53cbc3bca0049.camel@perches.com>
Subject: Re: [PATCH v6 4/4] thermal: k3_j72xx_bandgap: Add the bandgap
 driver support
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org, vigneshr@ti.com, krzysztof.kozlowski@linaro.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 May 2022 22:20:02 -0700
In-Reply-To: <202205030045.5GxgWkst-lkp@intel.com>
References: <202205030045.5GxgWkst-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A38C20025
X-Stat-Signature: d9zqnyyg63eizau1ckgb9u8dhfubqkb9
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/3ca4Q9WkkjlN21HSVOUaQ9HmljpP9naQ=
X-HE-Tag: 1652073602-450815
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2022-05-04 at 11:00 +0300, Dan Carpenter wrote:
> Hi Keerthy,
[]
> vim +/ref_table +521 drivers/thermal/k3_j72xx_bandgap.c
[]
> bb7f95a68cbaa1 Keerthy 2022-04-27  426  	ref_table = kzalloc(sizeof(*ref_table) * TABLE_SIZE, GFP_KERNEL);
> bb7f95a68cbaa1 Keerthy 2022-04-27  427  	if (!ref_table) {
> bb7f95a68cbaa1 Keerthy 2022-04-27  428  		ret = -ENOMEM;
> bb7f95a68cbaa1 Keerthy 2022-04-27  429  		goto err_alloc;
> bb7f95a68cbaa1 Keerthy 2022-04-27  430  	}

devm_kcalloc

> bb7f95a68cbaa1 Keerthy 2022-04-27  431  
> bb7f95a68cbaa1 Keerthy 2022-04-27  432  	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * TABLE_SIZE,
> bb7f95a68cbaa1 Keerthy 2022-04-27  433  				     GFP_KERNEL);

here too


