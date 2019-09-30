Return-Path: <SRS0=EnsE=XZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F928C32792
	for <linux-pm@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA7E215EA
	for <linux-pm@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852530;
	bh=PXtxWpDmdWTau2Dakee48K9u96lf4TbmFa7hbXULlLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k8ZkwXU6CVW8SCkAlrksaX2W+TY+8m15d+p7i6bos+UtznPzbA1AJV3Bd4xmmaEQi
	 NqZrvJPJYRSrmvXNs/GVrB+T0unWm6rJMuJq88aEC6NhzeHk1mWHTXVopFrzIcHQzS
	 S93+mfn1CfUOL7whwYHP2/CcAOVjIYO/EaOHxYi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfI3OIt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbfI3OIt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13773216F4;
        Mon, 30 Sep 2019 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852528;
        bh=PXtxWpDmdWTau2Dakee48K9u96lf4TbmFa7hbXULlLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT9Dx3r+gjbRR4mnmUHKMFb+9NkvtkNJ9I7fBv+aHbC7lWnVl6e7XCsLAbYvG4UV3
         fOTGIJL7MtnRwIZ6HEf/FGgoUmFasTeTadmf1LWJ1UOmV4a6YAQBE4kwzHQeER3sPQ
         tpkqZBgtxq5nY6gcSdMwF9LLe6eC3RVU4dxzwR1g=
Date:   Mon, 30 Sep 2019 10:23:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     linux-pm@vger.kernel.org, madhuparnabhowmik03@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, sre@kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH 4/4] Driver: Power: Supply:
 abx500_chargalg: Fixed a few coding style errors
Message-ID: <20190930082303.GC2036553@kroah.com>
References: <20190929181906.GA21828@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929181906.GA21828@madhuparna-HP-Notebook>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 29, 2019 at 11:49:10PM +0530, Madhuparna Bhowmik wrote:
> This patch fixes a few coding style errors and warnings
> detected by checkpatch.pl:
> 
> WARNING: please, no space before tabs
> ERROR: code indent should use tabs where possible
> WARNING: please, no spaces at the start of a line
> WARNING: Unnecessary parentheses
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: Prefer 'long' over 'long int' as the int is unnecessary

I know for the subsystems I maintain, I would require this to be broken
up into "one logical change per patch" so be aware that this might also
need to be done here too.

good luck!

greg k-h
