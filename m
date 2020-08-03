Return-Path: <SRS0=ylYt=BN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D31C433DF
	for <linux-pm@archiver.kernel.org>; Mon,  3 Aug 2020 11:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46761207DF
	for <linux-pm@archiver.kernel.org>; Mon,  3 Aug 2020 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596455822;
	bh=1B32VBXkTOu6ya5xaGuX3/aemtBhFCxYL4uyodnisPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YFQw5jNLcYz6FpGsQCOZJNx4SjtV14B3a12Ga/xBi7HYyb9bLoPqXptBzOaSD3XXa
	 ZWXl19L6QPNdMMc5EWvvxH07FsDjAwmxVpNOZE420hhXMClx5SaHSNfzys8HCLERw9
	 zn491ImN2U7H8siFI/68Dd2wDpEXShhkzvtov8vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgHCL5C (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHCL5B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 07:57:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09522076C;
        Mon,  3 Aug 2020 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596455820;
        bh=1B32VBXkTOu6ya5xaGuX3/aemtBhFCxYL4uyodnisPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySAidrBqFvVbFJBiyKk5eKRAVNEPQTe1b/IakySXRyswxtAk+Rb0NnSrrwhcl5NyP
         6V6d/ViKOFYR+8cpXtDtVFD1TrgrQYhV45Xfq5uDIpa2QpodQbFboeVl7R+clRcRzV
         cV0nkP+1OGKBRp7hZM2gmAG+kQwbZquZHKdOQSlA=
Date:   Mon, 3 Aug 2020 13:56:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>, Qiwu Huang <yanziily@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200803115644.GC955269@kroah.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug>
 <20200802123742.GA257810@kroah.com>
 <20200802142825.GA20261@amd>
 <20200802165738.GA293244@kroah.com>
 <20200803114950.oyb3gzyiccybah3u@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803114950.oyb3gzyiccybah3u@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 03, 2020 at 01:49:50PM +0200, Sebastian Reichel wrote:
> More importantely I prefer not to merge new APIs without any users
> (i.e. a driver making use of those values). Having a reference
> driver means, that there is an example how to use the values
> correctly and proves it is actually needed upstream. Right now
> this looks like "let's modify the upstream kernel, so that we can
> easily maintain our out of tree driver".

Agreed.  Qiwu, can you also submit your driver so we can see these
values be used?

thanks,

greg k-h
