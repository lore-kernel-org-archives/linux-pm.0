Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86EC433DB
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 10:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D7E64E77
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 10:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBIKTP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:19:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:54266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhBIKRL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Feb 2021 05:17:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 866D1AD24;
        Tue,  9 Feb 2021 10:16:27 +0000 (UTC)
Date:   Tue, 9 Feb 2021 11:16:22 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 2/2] thermal: Move therm_throt there from x86/mce
Message-ID: <20210209101622.GA15909@zn.tnic>
References: <YCHzLQewQIylgyUj@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCHzLQewQIylgyUj@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Feb 09, 2021 at 11:27:57AM +0900, Sergey Senozhatsky wrote:
> Seems that the patch triggers some WARNs on my laptop.

yeah, that one is replaced with a better variant now and it should land
in the next linux-next, the one after next-20210208 :)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
