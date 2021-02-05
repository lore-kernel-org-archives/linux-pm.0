Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E658BC433E6
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 23:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF0364FAE
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 23:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhBEXTl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Feb 2021 18:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhBEKMx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 05:12:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEFA464FE8;
        Fri,  5 Feb 2021 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612519931;
        bh=hyxFqW+U+ERTl6fdQ6DabAaCml48h/TapiiG4RYoe50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkVDqZaaYwA/J8q/MaPhu50D66OdqLgjNfs6YwoLV+ROb7ZJkhX53K9EH3iYlYFay
         Za9lu2KxcWPM9xhI8onLwnl+vU1StbktYUNAk22YIiYPOX5lejfqRZluE8ViqVzpVI
         iRBQmXHmupdjq+JMLmuGUyermQXPBjLohaWPz2hk=
Date:   Fri, 5 Feb 2021 11:11:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: Re: [GIT PULL] interconnect changes for 5.12
Message-ID: <YB0Z7CeIdcdvaGpD@kroah.com>
References: <20210205095246.24577-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205095246.24577-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 05, 2021 at 11:52:46AM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.12-rc1
> merge window. These include two new drivers some driver consolidation.
> 
> Patches have been in linux-next without any reported issues. Please pull
> into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:
> 
>   Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.12-rc1

Pulled and pushed out, thanks.

greg k-h
