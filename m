Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B7C25B0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Aug 2022 11:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiHOLDn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Aug 2022 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbiHOLBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2022 07:01:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8F51237EC;
        Mon, 15 Aug 2022 04:01:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4EEC880FB;
        Mon, 15 Aug 2022 10:55:02 +0000 (UTC)
Date:   Mon, 15 Aug 2022 14:01:51 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, naresh.kamboju@linaro.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Bring back driver_deferred_probe_check_state()
 for now
Message-ID: <Yvonn9C/AFcRUefV@atomide.com>
References: <20220727185012.3255200-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727185012.3255200-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Saravana Kannan <saravanak@google.com> [700101 02:00]:
> More fixes/changes are needed before driver_deferred_probe_check_state()
> can be deleted. So, bring it back for now.
> 
> Greg,
> 
> Can we get this into 5.19? If not, it might not be worth picking up this
> series. I could just do the other/more fixes in time for 5.20.

Yes please pick this as fixes for v6.0-rc series, it fixes booting for
me. I've replied with fixes tags for the two patches that were causing
regressions for me.

Regards,

Tony
