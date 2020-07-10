Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B3FC433DF
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714BC20786
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594375262;
	bh=kOJc9WhNOM98kpWorCDKyqHEtzGaX9W9kQLh46fkPMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iQMLcYmNRIYb6dhPmSvrXWN/EhVeES4LBNPEygucoN49o9VfBkjYE2/inFjHhlLAj
	 Zm2YVAAEvEQKCC2s3qxbsd80VuBWGlwKLgnCWWk6AEGKtPzUnLnsJM8aICdbHWRmPD
	 lnUy/ZFJjIGckOqAszMrFrbOkeff98pz05O6dR0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGJKBB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGJKBB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 06:01:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC4520775;
        Fri, 10 Jul 2020 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594375261;
        bh=kOJc9WhNOM98kpWorCDKyqHEtzGaX9W9kQLh46fkPMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PX/99WvFuMWtVbE1zBdnuj4yudB9WY8DHvBlJ5+0jMoVerE52crOcsGmYht9pdhhM
         u1YIfQ4HAzGDrWGdmFwxmmmAYPM/OfubPy1L46CimGYUKuMxpdJeOxAPc5VmXskHtj
         GOl61RL4NCHb3f1CJCD0aDMdBGY/1F/TUjknv+Wc=
Date:   Fri, 10 Jul 2020 12:01:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH 3/5] power: supply: core: add wireless signal strength
 property
Message-ID: <20200710100106.GC1197607@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-3-yanziily@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084841.1933254-3-yanziily@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 04:48:39PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> reports wireless signal strength.
> The value show degree of coupling between tx and rx.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 9 ++++++++-
>  drivers/power/supply/power_supply_sysfs.c   | 1 +
>  include/linux/power_supply.h                | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2099cf194a89..1f42aa0c071e 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -730,4 +730,11 @@ Description:
>  
>  		Access: Read-Only
>  		Valid values: "ADAPTER_NONE", "ADAPTER_SDP", "ADAPTER_DCP", "ADAPTER_CDP",
> -		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
> \ No newline at end of file
> +		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
> +
> +What:		/sys/class/power_supply/<supply_name>/signal_strength
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		Reports wireless signal strength.
> +		The value show degree of coupling.

What units are this in?  The "value" means what?

thanks,

greg k-h
