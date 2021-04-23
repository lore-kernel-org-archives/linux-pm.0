Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868C8C433ED
	for <linux-pm@archiver.kernel.org>; Fri, 23 Apr 2021 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AD06144A
	for <linux-pm@archiver.kernel.org>; Fri, 23 Apr 2021 09:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhDWJJ7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWJJ6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 05:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA8461422;
        Fri, 23 Apr 2021 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619168962;
        bh=92QnR4XOC2Ox/VZ3/+ThjkYwdNbdMZQj5ZUKFq4Cg7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXyi4ngfEwOkhsfiO95ELRM1g2hSBHCHITn59/Ir3JQ7PY0UkQu6jVjjDVreQmimn
         bnA+n2v5soHVunQ/ZsKX2ixjbC5PIFjAUKzEAAyoigD2GKruIkEvevADZEns2QKxGs
         SB3zleS54TTWjUrqYMUZmJG8MTUIOy5Z3q5rXdFk=
Date:   Fri, 23 Apr 2021 11:09:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: Use pm_pr_dbg() instead of pr_debug().
Message-ID: <YIKOv3h0xFAttYlq@kroah.com>
References: <20210423081223.26111-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423081223.26111-1-zhaoxiao@uniontech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 04:12:23PM +0800, zhaoxiao wrote:
> These prints are useful if we're doing PM suspend debugging. Having them
> at pr_debug() level means that we need to either enable DEBUG in this
> file, or compile the kernel with dynamic debug capabilities. Both of
> these options have drawbacks like custom compilation or opting into all
> debug statements being included into the kernel image. Given that we
> already have infrastructure to collect PM debugging information with
> CONFIG_PM_DEBUG and friends, let's change the pr_debug usage here to be
> pm_pr_dbg() instead so we can collect the wakeup information in the
> kernel logs.
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

Please use a "full" name.  Unless one word really is how you sign legal
documents?

> ---
>  drivers/base/power/main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f893c3c5af07..6e64e3fff84c 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -133,7 +133,7 @@ void device_pm_add(struct device *dev)
>  	if (device_pm_not_required(dev))
>  		return;
>  
> -	pr_debug("Adding info for %s:%s\n",
> +	pm_pr_dbg("Adding info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));

Why are these all just not normal dev_dbg() calls?  That handles the "no
bus" stuff automatically.

thanks,

greg k-h
