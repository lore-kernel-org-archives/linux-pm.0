Return-Path: <SRS0=qxav=BY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48689C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 14 Aug 2020 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E34A20855
	for <linux-pm@archiver.kernel.org>; Fri, 14 Aug 2020 06:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597385388;
	bh=c/lfw5JZTqHPS72/1poOsY6BXX2T5S4whSMwu1pt5eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SWc24063DA4HY55KUWVeukrOf6jo07nD9ivQVuIu9OtTtUfy+Grl/Kmq+eSVXQUBh
	 hIh8meIHoj61mgpl/+8+Z8yKf0ftL7AM6tZ1D1ENO+GW9yC/CaJJy/2XQ0lTmUk+3s
	 SKjuzKWXGSmVbmXXbhW36Tx8zQZtcROrpBYpYbsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgHNGJr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgHNGJq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Aug 2020 02:09:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB34420708;
        Fri, 14 Aug 2020 06:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597385386;
        bh=c/lfw5JZTqHPS72/1poOsY6BXX2T5S4whSMwu1pt5eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+8afEJYPSe8D5GzWDR+rbuzJP74xvyOyWi7jinVsDT4D5lcLOtbNCwVRwvg+JX/A
         SQMtwV3zfdxM5yW7ytNYJhgPEJ4PsLkF14iD7jhk860pQrsJnR1Z5gms4QRYoBvUpK
         7dt+cWsB70NvtYK+nqIHnY1AU/URLUWfbCIn2pCc=
Date:   Fri, 14 Aug 2020 08:09:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200814060909.GD1409566@kroah.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
 <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 14, 2020 at 11:46:54AM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
>  include/linux/power_supply.h                | 14 ++++++
>  4 files changed, 87 insertions(+)

You should also submit your driver that uses these new attributes at the
same time.  What happened to that request?  Otherwise no one really
knows how these are being used, or if they even are used by anyone.

thanks,

greg k-h
