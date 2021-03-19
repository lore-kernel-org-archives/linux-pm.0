Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0255C433E0
	for <linux-pm@archiver.kernel.org>; Fri, 19 Mar 2021 10:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898B864F6B
	for <linux-pm@archiver.kernel.org>; Fri, 19 Mar 2021 10:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSKSl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:18:41 -0400
Received: from muru.com ([72.249.23.125]:44706 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhCSKSZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Mar 2021 06:18:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6330F80CE;
        Fri, 19 Mar 2021 10:19:14 +0000 (UTC)
Date:   Fri, 19 Mar 2021 12:18:19 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 02/38] dt-bindings: power: supply: cpcap-battery:
 Convert to DT schema format
Message-ID: <YFR6azU6YlEvfdtJ@atomide.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317134904.80737-3-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [210317 13:50]:
> Convert the binding to DT schema format. I also added the missing bits
> used by the only in-tree user and implemented in the driver.

Reviewed-by: Tony Lindgren <tony@atomide.com>
