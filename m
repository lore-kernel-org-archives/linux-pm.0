Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678EC433DB
	for <linux-pm@archiver.kernel.org>; Fri,  8 Jan 2021 07:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6018233EA
	for <linux-pm@archiver.kernel.org>; Fri,  8 Jan 2021 07:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAHHA1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:00:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:32323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbhAHHA1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 02:00:27 -0500
IronPort-SDR: 6iMsA/HE7O4d2/HN67RFMEiBLjxqOLHhv6r/x53HHhodBJsOjRh3DDfvSWQ1MHZHqJ7zMlu5jN
 2bHil9jEYdzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="157333332"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="157333332"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:59:47 -0800
IronPort-SDR: rKoqaCrgPDURoG6Ya6gmu7XpPIAEW0IpGMlef91Hc6+Tdk+5LFdikTVKE5BHfc67ptdgw5Ihl/
 K42twj3nUlOA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="463305167"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:59:45 -0800
Date:   Fri, 8 Jan 2021 15:02:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 1/3] cpufreq: intel_pstate: Always read hwp_cap_cached
 with READ_ONCE()
Message-ID: <20210108070211.GC20383@chenyu-office.sh.intel.com>
References: <5701645.lOV4Wx5bFT@kreacher>
 <1993550.StjdRojnlU@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1993550.StjdRojnlU@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 07:42:15PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because intel_pstate_get_hwp_max() which updates hwp_cap_cached
> may run in parallel with the readers of it, annotate all of the
> read accesses to it with READ_ONCE().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
