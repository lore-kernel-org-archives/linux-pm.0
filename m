Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7CFEB64D9
	for <linux-pm@archiver.kernel.org>; Thu, 29 Jun 2023 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjF2WF4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 29 Jun 2023 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2WFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 18:05:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A130D1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 15:05:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688076353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njvcstOnjk9f1G4wP9Ifo73EIL7ph4QoeuonsulRnLw=;
        b=P5H/u4larK8p+WHUI9mzZdCYq6hZYVfkki+vL+IV5hwa3NTeMpeHkLUlHyS/WXXQml9hAC
        gISLYPoouBLJBRoYeX4ZxDiBjy3vDYOJqdhsZ4YQBsW5Pw9oO0Yn4kI++JixP29aOCXb64
        OCi8+m9Dy1X45OKW3cc0rmrqYiWYhnrKwOyq689oX4Il/juSdoVVf0vXD3M5RPipX51Vkf
        HLwD7Qe4yBLhyFTLP1aYOIe/E3O48b16dIKZUrycogMq1Sa6Cf5CIka1TYFAIptMhQYpHD
        IWgsOiFM/lLMpKFY5+ELEPXHCrFqWHEYiDtP+oxEBR9/goavSjaOGpMmpoQUlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688076353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njvcstOnjk9f1G4wP9Ifo73EIL7ph4QoeuonsulRnLw=;
        b=GvvNwOgf0/jycEf7nSM3BzsocbI4FqPiTOmCyA179AnKrImh1GyeXMNkgT7FDjU6KaG7Xt
        gMCJxqldLZa/0oBw==
To:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3 0/3] Sapphire Rapids C0.x idle states support
In-Reply-To: <20230610183518.4061159-1-dedekind1@gmail.com>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
Date:   Fri, 30 Jun 2023 00:05:52 +0200
Message-ID: <87zg4hzzy7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 10 2023 at 21:35, Artem Bityutskiy wrote:

Something is wrong with your patch mail script.

          [PATCH v3 0/3]

but then the actual patches are

          [PATCH v3 1/2]
          [PATCH v3 2/2]

Something does not add up here.

Thanks,

        tglx
