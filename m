Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66287C0018C
	for <linux-pm@archiver.kernel.org>; Mon,  7 Dec 2020 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116ED2388D
	for <linux-pm@archiver.kernel.org>; Mon,  7 Dec 2020 20:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLGU06 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGU06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 15:26:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7106C061794;
        Mon,  7 Dec 2020 12:26:17 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a38006ee8d6334d641c12.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3800:6ee8:d633:4d64:1c12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 110961EC03FA;
        Mon,  7 Dec 2020 21:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607372775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vO6PKikDefqjDt62fS1pdunv7loD9uEoyKIDr3CH+VQ=;
        b=o5bdf7vDyG47AykQbRsUbL4Iu3GqYemZwoMloKa9DOv7JCWbhhOT9e93jfR3J2uMJD97Xm
        uH86C/S+F2CnPfrRAbqKMO3sRnDWRfzYzp4xKt2lDsTKo+NPWOjC+MG0tEulRrKEekgTkb
        hOGseHz0N9pRkl/pJaNZMtkBUuJ0OSM=
Date:   Mon, 7 Dec 2020 21:26:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Huang <whuang2@amd.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, rjw@rjwysocki.net,
        wei.huang2@amd.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
Message-ID: <20201207202610.GG20489@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-3-punitagrawal@gmail.com>
 <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 07, 2020 at 02:20:55PM -0600, Wei Huang wrote:
> In summary, this patch is fine if Punit already verified it. My only
> concern is the list can potentially increase over the time, and we will
> keep coming back to fix override_acpi_psd() function.

Can the detection be done by looking at those _PSD things instead of
comparing f/m/s?

And, alternatively, what is this fixing?

So what if some zen2 boxes have correct _PSD objects? Why do they need
to ignore the override?

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
