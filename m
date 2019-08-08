Return-Path: <SRS0=lDgx=WE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B23C433FF
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848821874
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gUlQs3SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfHHPYF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:24:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbfHHPYF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 11:24:05 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F68F1EC09A0;
        Thu,  8 Aug 2019 17:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565277844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sQZbmE19fkB3DVCEeojUm7espDrVCffaxf1WraoPyeg=;
        b=gUlQs3SL6VUnFR3n0YbXm63EGvqGH5LOg6kLqpO5EhCIX/67ikSskOkpmRlSlfLAFPU7oU
        iSBwvwjsHZhkz5Kt4XX/2K0yy+3lFzlvCaad0KmI4XEGblA7NHhtppZ3Il4ASD8jAfY6Oz
        DmcKTsa/XxPf5EdilmfU+IIhvEc4Ca0=
Date:   Thu, 8 Aug 2019 17:24:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808152453.GJ20745@zn.tnic>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <fb0e7bd3-d3b1-8163-2766-99a75de994d9@intel.com>
 <e2832973-6013-2b8a-90cb-ffcf54760bcd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2832973-6013-2b8a-90cb-ffcf54760bcd@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 08:44:11PM +0530, Bhardwaj, Rajneesh wrote:
> We have few patches that need this. They will soon follow once this is
> accepted.

You can always send it as the first patch together with the first user
patchset.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
