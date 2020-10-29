Return-Path: <SRS0=VPpk=EE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702CFC2D0A3
	for <linux-pm@archiver.kernel.org>; Thu, 29 Oct 2020 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB87320FC3
	for <linux-pm@archiver.kernel.org>; Thu, 29 Oct 2020 21:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qzniG/kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2V7k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:59:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgJ2V7k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 17:59:40 -0400
Received: from zn.tnic (p200300ec2f0ce900110dec7ebfc9cee3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:110d:ec7e:bfc9:cee3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D147E1EC047F;
        Thu, 29 Oct 2020 22:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604008779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SMDIV0AUgVE+B/1mmts8XBWIl/CuKX92lB7lGOJOYR4=;
        b=qzniG/kHEXT36hNlqjANTx6+7OCETgzBqhfgzezc0CtiaB+akINksKxcF75YNIByeajBGx
        crVTLpqO14bFj3tU5qQPLLN8kEryK16Du3u4BI9b5PsgsEjXbcusnjduUus3KZ1D6CMVjX
        JSWSIVeWM4gFoXnZCZIc29dvny7yiTM=
Date:   Thu, 29 Oct 2020 22:59:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
Message-ID: <20201029215929.GF31903@zn.tnic>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
 <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
 <20201016083754.GB8483@zn.tnic>
 <ca53e90a-f4eb-5007-a137-62729e3d74f0@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca53e90a-f4eb-5007-a137-62729e3d74f0@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 29, 2020 at 03:38:43PM -0600, Shuah Khan wrote:
> All of the other ones should be changed as such. Why add more?

Because a patch should do one thing and one thing only. So a separate
patch which converts them all in one go should come ontop. But if you
insist for the ones I'm adding to have error handling, I can do that, of
course.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
