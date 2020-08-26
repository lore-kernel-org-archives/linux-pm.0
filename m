Return-Path: <SRS0=+XkI=CE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FEC433E1
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF332080C
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgHZNSn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:18:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:47198 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZNSm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 09:18:42 -0400
IronPort-SDR: wZD6jzhinBVtLnBzsd/8zqTaWa82fyBxNTa4PWyaJUHaoFhWh9miD5GfaIbjpww0B9K9+HQkBB
 uhA0AstcNS4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="135837237"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="135837237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 06:18:36 -0700
IronPort-SDR: uE+qHqDiCg9W9XDdg+m8z1p3BaNNeyBJW2xC69uEujGqtb8m5zht3Flwsty/tl7Ne56q0xmMGS
 fKpquV164qJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="323188157"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 06:18:36 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id B6AAA5805ED;
        Wed, 26 Aug 2020 06:18:34 -0700 (PDT)
Message-ID: <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Guilhem Lettron <guilhem@barpilot.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 16:18:33 +0300
In-Reply-To: <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
References: <20200826120421.44356-1-guilhem@barpilot.io>
         <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
         <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
         <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 16:16 +0300, Artem Bityutskiy wrote:
> Just get a reasonably new turbostat (it is part of the kernel tree, you
> can compile it yourself) and run it for few seconds (like 'turbostat
> sleep 10'), get the output (will be a lot of it), and we can check what
> is actually going on with regards to C-states.

Oh, and if you could do that with and without your patch, we could even
compare things. But try to do it at least with the default (acpi_idle)
configuration.

Artem.

