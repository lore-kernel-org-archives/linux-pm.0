Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D5C4361A
	for <linux-pm@archiver.kernel.org>; Fri,  4 Dec 2020 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC0C2251F
	for <linux-pm@archiver.kernel.org>; Fri,  4 Dec 2020 13:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgLDNQA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:32954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgLDNQA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Dec 2020 08:16:00 -0500
Date:   Fri, 4 Dec 2020 14:16:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607087714;
        bh=4usi8EpDh/sOqpBg1SAsFlVt+TMuvQsm4GlC3Iaj8iQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5/YzjxwL/e9ons3wNOZvRKOkENxvzeuEPucwedjGunx931zRP02OtyJtL+E/rs0b
         ZHaJuUmJfKknVFg1ALTZfJUi8NmoweSzKFep0X8p1+v4m1tQxg2H+bKFqMnp2ApQ+k
         ufxDQiZB73JsYWMcUKVCLvk8VFY+Lzzh5+53AwU0=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.11
Message-ID: <X8o2qR9UpUeskllr@kroah.com>
References: <20201204100755.2350-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204100755.2350-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 04, 2020 at 12:07:55PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.11-rc1
> merge window. The highlight is a new driver for Samsung Exynos SoCs.
> 
> Patches have been in linux-next without any reported issues. Please pull
> into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:
> 
>   Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc1

Pulled and pushed out, thanks.

greg k-h
