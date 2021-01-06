Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F6C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  6 Jan 2021 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68E32312A
	for <linux-pm@archiver.kernel.org>; Wed,  6 Jan 2021 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbhAFRyb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:54:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAFRyb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Jan 2021 12:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AB122311B;
        Wed,  6 Jan 2021 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609955630;
        bh=XJAFZWjemspt3J3J50rFVt4EXzDZy7yr03zuq4DmAZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zyY/fhCN7PFvWNCFVWkApb57WslG6VmiV82fLHDf/td1HyrfaeGcsMYzET3bx33s5
         ZDTefrLU6ail6u34jEw7r+ZPTDKEMuLyVvKFGUAX7S0sycBPReFbH8GSiN7UufdIuG
         qTi6EUUPEjXaAMq23ARr4AHqrifltGxMEmz7XwfY=
Date:   Wed, 6 Jan 2021 18:55:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.11-rc
Message-ID: <X/X5euQ0xgzVv/0R@kroah.com>
References: <20210106094723.563-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106094723.563-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 06, 2021 at 11:47:23AM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a pull request with a few interconnect fixes for 5.11-rc.
> More details are available in the signed tag. Please take them into
> char-misc-linus when possible. The patches have been in linux-next
> during the last few days.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc3

Pulled and pushed out, thanks.

greg k-h
