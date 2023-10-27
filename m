Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B28FC25B67
	for <linux-pm@archiver.kernel.org>; Fri, 27 Oct 2023 09:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjJ0Jg3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 27 Oct 2023 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Jg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 05:36:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B3DCE;
        Fri, 27 Oct 2023 02:36:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E47C433C8;
        Fri, 27 Oct 2023 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698399386;
        bh=WpQWKT5jaNJ/4/zQPkjvPeIl30M48VVe2aWU+SCOdq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPSQvs2kjrG1U6kdE8k/c2x0B8X5RkDN23aBbxqPxqOpLpPzgtlbbgNwX38UHdCG8
         BJAKtv0Wzi09/mSqyGjxdYSOUIEIJ5gmwgYfpPACyMuoCowjYyYoofPEXMa/dMDUMe
         yOzBOQ1wsjSjcQZVExv9vpMyoBWIbPCxtsxp3Zd8=
Date:   Fri, 27 Oct 2023 11:35:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.7
Message-ID: <2023102734-vagabond-possum-8148@gregkh>
References: <20231025145857.2212632-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025145857.2212632-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 25, 2023 at 05:58:56PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.7-rc1 merge
> window. This time it contains only driver updates. There is one new driver
> and fixes and cleanups in existing drivers and dt bindings. The summary is
> in the signed tag.
> 
> All patches have been in linux-next during the last week. Please pull into
> char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.7-rc1

Pulled and pushed out, thanks.

greg k-h
