Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD166C433FE
	for <linux-pm@archiver.kernel.org>; Tue, 22 Nov 2022 07:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKVHPj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKVHPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 02:15:38 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E0C83120D;
        Mon, 21 Nov 2022 23:15:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D17F88061;
        Tue, 22 Nov 2022 07:05:22 +0000 (UTC)
Date:   Tue, 22 Nov 2022 09:15:35 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Carl Klemm <carl@uvos.xyz>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        philipp@uvos.xyz, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
Message-ID: <Y3x3F4x+Y26pID0l@atomide.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
 <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
 <Y3OY/l2ZBX+WbRR4@atomide.com>
 <90314373-de30-019a-dc0c-f5cab57a48c6@gmail.com>
 <Y3W+M3/7zOutygEZ@atomide.com>
 <a04a2c13d21d3f381fcd525e5f47c217543d2c18.camel@uvos.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04a2c13d21d3f381fcd525e5f47c217543d2c18.camel@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Carl Klemm <carl@uvos.xyz> [221117 08:06]:
> 2. Personally i used the d4 for manny years with andorid without issue,
> giveing the battery manny cycles

Many cycles does not seem to be the issue, the issue seems to be leaving
the device connected to the charger for longer periods of time at higher
charge voltages.

No objection to having the capability there. But enabling it by default
is a different story. We need several folks test connected to a charger
for months with proper Tested-by if we want to enable it by default.

Regards,

Tony
