Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0BFC43334
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jul 2022 05:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGPFYP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 16 Jul 2022 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPFYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 01:24:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662C13F85;
        Fri, 15 Jul 2022 22:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4CB0B82F4A;
        Sat, 16 Jul 2022 05:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2E8C34114;
        Sat, 16 Jul 2022 05:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657949051;
        bh=QuRtITdnEE2PiZDgufabb8yEeEFK1c+W+EryTZj4nC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCt/7abKmhJp/N65NX2UpB5VQQubGffL05rQDSgrzjn9Inoqk/g2bQmyiIy/5/b5b
         SviuPA0P5hXnt/CZnzaQVGr95ZJUuEhwsWf0Ykm+6OkfrZl+27uethh5JD/4gVaUYC
         SguYDbXqMZWZdpkMkq/GQR64+n3DuE0zMyHnfe+I=
Date:   Sat, 16 Jul 2022 07:23:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] interconnect changes for 5.20
Message-ID: <YtJLS6FvyGNTBr6Q@kroah.com>
References: <20220715153146.26134-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715153146.26134-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 15, 2022 at 06:31:46PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the v2 pull request with interconnect changes for the 5.20-rc1 merge
> window. It contains driver updates. The details are in the signed tag.
> 
> I have fixed the "Fixes" tag, so now we should be all good. Please pull 
> into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.20-rc1-v2

Pulled and pushed out now, thanks.

greg k-h
