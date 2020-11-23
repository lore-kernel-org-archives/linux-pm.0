Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889FCC64E69
	for <linux-pm@archiver.kernel.org>; Mon, 23 Nov 2020 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571E62073C
	for <linux-pm@archiver.kernel.org>; Mon, 23 Nov 2020 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lC0DBGeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgKWQh4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:37:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389998AbgKWQhz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Nov 2020 11:37:55 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36F720665;
        Mon, 23 Nov 2020 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606149475;
        bh=fd1MNhuqG+19POurbD/cn0IxQcqtltG6o3OJUIPHdBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lC0DBGeTXvppMp2hHvEbX8JPeXPmMN4MxIwqcNhShfVBDIuEBjzJJBMg5yp/CaRbm
         gvTIa99nfZb8ENE6TpeM3KKFT7WuKotaLiPBv6UfMduPhLRSveO/jWdPmylgew7h9j
         7nekPy61fDhnszuP42dY2kWhKZaRRv9gWDIQfCeQ=
Date:   Mon, 23 Nov 2020 17:37:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.10-rc
Message-ID: <X7vlYNzKRXUlpNv7@kroah.com>
References: <20201123154130.26972-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123154130.26972-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 23, 2020 at 05:41:30PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a pull request with a few interconnect fixes for 5.10-rc.
> Please take them into char-misc-linus when possible. All patches
> have been reviewed and tested. They have been also in linux-next
> since last week.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.10-rc6

PUlled and pushed out, thanks.

greg k-h
