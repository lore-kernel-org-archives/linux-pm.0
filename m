Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F2C6FD1D
	for <linux-pm@archiver.kernel.org>; Fri, 17 Mar 2023 08:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjCQIn7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 17 Mar 2023 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjCQIno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 04:43:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99B5DEDD
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 01:42:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="338230833"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="338230833"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712669987"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712669987"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2023 01:42:17 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 2B607580AFF;
        Fri, 17 Mar 2023 01:42:15 -0700 (PDT)
Message-ID: <4d94a2e6b0de0c6f07d92f0d34bb6ecc5433bda0.camel@gmail.com>
Subject: Re: [PATCH 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Fri, 17 Mar 2023 10:42:15 +0200
In-Reply-To: <20230314122450.GH1845660@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
         <20230306123418.720679-4-dedekind1@gmail.com>
         <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
         <CAJZ5v0gFrWCdyVNPUoU4tq2vTzcx5WtzvhbXVx1WeyTtt=Gqvg@mail.gmail.com>
         <20230308123222.GF2017917@hirez.programming.kicks-ass.net>
         <12e008c7fd280c8abc45f417f64bb782485a40b8.camel@gmail.com>
         <20230314122450.GH1845660@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2023-03-14 at 13:24 +0100, Peter Zijlstra wrote:
> ../scripts/config --enable INTEL_IDLE
> ../scripts/config --enable DEBUG_ENTRY
> ../scripts/config --enable IRQSOFF_TRACER

Thank you! I've checked that v2 of these patches addresses this issue. I've
added these to my defconfig too.

Artem.
