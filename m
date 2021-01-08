Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAACC433DB
	for <linux-pm@archiver.kernel.org>; Fri,  8 Jan 2021 06:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509E4233EE
	for <linux-pm@archiver.kernel.org>; Fri,  8 Jan 2021 06:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbhAHG6k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 8 Jan 2021 01:58:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:23020 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbhAHG6k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 01:58:40 -0500
IronPort-SDR: 4oes7NwAemYn+UC6wgFAMs3wj2QD4OLMgVtcoJjZhQXMbNywdgpSAk8srNdfwoMF9Zh4mcfPoW
 93NWP8AizPRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="165242045"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="165242045"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:57:59 -0800
IronPort-SDR: UX4sIJ10CnzjtoxpQ5xCCnN31exee5xbOQYs3xmTPJnA8icZfulrGoue7+ucyj5orXc7CoPOML
 oOQCqOkfHoJA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="362244482"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:57:58 -0800
Date:   Fri, 8 Jan 2021 15:00:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 3/3] cpufreq: intel_pstate: Rename two functions
Message-ID: <20210108070024.GA20383@chenyu-office.sh.intel.com>
References: <5701645.lOV4Wx5bFT@kreacher>
 <6740994.gz1i9f73Yi@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6740994.gz1i9f73Yi@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 07:44:18PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rename intel_cpufreq_adjust_hwp() and intel_cpufreq_adjust_perf_ctl()
> to intel_cpufreq_hwp_update() and intel_cpufreq_perf_ctl_update(),
> respectively, to avoid possible confusion with the ->adjist_perf()
> callback function, intel_cpufreq_adjust_perf().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Tested-by: Chen Yu <yu.c.chen@intel.com>
