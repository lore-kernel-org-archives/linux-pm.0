Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E840C43334
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jul 2022 12:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGOMyP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Jul 2022 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiGOMyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 08:54:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1E625C2;
        Fri, 15 Jul 2022 05:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6E392CE2F46;
        Fri, 15 Jul 2022 12:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45039C34115;
        Fri, 15 Jul 2022 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657889649;
        bh=4JUzNF30UbskSiAI32cNuM3JoK+YAPBzhkadD+xwspY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsfOnxT1yqCXtBBnWJBaAiPF/UOaH5vXBERn/AAxvHT+wWhX5RmJmBXMX4q23xG5D
         Qwh2F8In+DhZ37MWI/ak8r6A4DrvTKBQ0t4bL8ethHIQ55PQN3q8AAP+h6onoA1nX8
         CT+frFLJTLNbztDIyD3B8BJwV2ArqRMPtvTjApj8=
Date:   Fri, 15 Jul 2022 14:54:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.20
Message-ID: <YtFjbhn3pveplLQb@kroah.com>
References: <20220715101021.30109-1-djakov@kernel.org>
 <YtFjOW77wGnToYt8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtFjOW77wGnToYt8@kroah.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 15, 2022 at 02:53:13PM +0200, Greg KH wrote:
> On Fri, Jul 15, 2022 at 01:10:21PM +0300, Georgi Djakov wrote:
> > Hello Greg,
> > 
> > This is the pull request with interconnect changes for the 5.20-rc1 merge
> > window. It contains driver updates. The details are in the signed tag.
> > 
> > All patches have been in linux-next during the last few days. No issues have
> > been reported so far. Please pull into char-misc-next.
> > 
> > Thanks,
> > Georgi
> > 
> > The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> > 
> >   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.20-rc1
> 
> Pulled and pushed out, thanks.

Oops, nope, I got the following error:

Fixes tag: Fixes: f0d8048525d7d("interconnect: Add imx core driver")
	Has these problem(s):
		- missing space between the SHA1 and the subject

I can rebase this and fix it up myself, or you can do it, which ever is
easier for you.

thanks,

greg k-h
