Return-Path: <SRS0=FWqo=EN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE40C2D0A3
	for <linux-pm@archiver.kernel.org>; Sat,  7 Nov 2020 00:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D08D206CB
	for <linux-pm@archiver.kernel.org>; Sat,  7 Nov 2020 00:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="d9u/hck3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGAmd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:42:33 -0500
Received: from onstation.org ([52.200.56.107]:48080 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgKGAmd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Nov 2020 19:42:33 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 19:42:32 EST
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 00BE03EFBC;
        Sat,  7 Nov 2020 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1604709448;
        bh=nWz/GnnI2ceO0QVg9HoA3H+cIJQoeMxqypBJNafHAKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9u/hck3qkywNgewXlbhiigNHHNu3IqAeD1NeJHmnYBQrBcbbb0dHaEqJ5B4GAC3N
         aEvRq2gBDd8cmNM1pS9MQLzpKvBD7/AHqZjIX3LN23eIxXI+kVtXCNvoVwy7wJRAWA
         49cdmLVcSUnYGWVaV2SyhR3zXxWQA4zRfTjIrBMY=
Date:   Fri, 6 Nov 2020 19:37:27 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, luca@z3ntu.xyz,
        bjorn.andersson@linaro.org, saravanak@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: msm8974: Prevent integer overflow in
 rate
Message-ID: <20201107003727.GD2775@onstation.org>
References: <20201106144847.7726-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106144847.7726-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 06, 2020 at 04:48:47PM +0200, Georgi Djakov wrote:
> When sync_state support got introduced recently, by default we try to
> set the NoCs to run initially at maximum rate. But as these values are
> aggregated, we may end with a really big clock rate value, which is
> then converted from "u64" to "long" during the clock rate rounding.
> But on 32bit platforms this may result an overflow. Fix it by making
> sure that the rate is within range.
> 
> Reported-by: Luca Weiss <luca@z3ntu.xyz>
> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>

