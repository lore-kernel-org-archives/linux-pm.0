Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED8CC43334
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jun 2022 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiFNLQ1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiFNLQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 07:16:26 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A7DA21E2C;
        Tue, 14 Jun 2022 04:16:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4EDE780AE;
        Tue, 14 Jun 2022 11:11:41 +0000 (UTC)
Date:   Tue, 14 Jun 2022 14:16:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: runtime: Extend support for wakeirq for
 force_suspend|resume
Message-ID: <YqhuB4ayHZY42SBN@atomide.com>
References: <20220608153120.303070-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608153120.303070-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [220608 15:26]:
> A driver that makes use of pm_runtime_force_suspend|resume() to support
> system suspend/resume, currently needs to manage the wakeirq support
> itself. To avoid the boilerplate code in the driver's system suspend/resume
> callbacks in particular, let's extend pm_runtime_force_suspend|resume() to
> deal with the wakeirq.

Looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
