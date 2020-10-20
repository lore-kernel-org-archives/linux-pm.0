Return-Path: <SRS0=6IJd=D3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9002C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 20 Oct 2020 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724262177B
	for <linux-pm@archiver.kernel.org>; Tue, 20 Oct 2020 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603192050;
	bh=HTmxmKIf9MzMYvHSBAlNECRzB9g2RAoZ+MmrBvP8i8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mDpWMDY38KbDTWZIIOg7PuQS3J88qpwmYKQjGJZVQnPE+wtvqJFGm8Kg8XoM5YFUQ
	 NwO5AzrJHYXs+eU6Po/QWCZ/MwnGU8YnKCuCz1aVswPb26vWQjjZ1vzCMoH5Z2JU0j
	 R+X2K7NnStuk1OUVdwfdINWk8IfwpufeIS6DIB4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbgJTLH3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392472AbgJTLH3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 07:07:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC03021741;
        Tue, 20 Oct 2020 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603192047;
        bh=HTmxmKIf9MzMYvHSBAlNECRzB9g2RAoZ+MmrBvP8i8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bmxh5iJz8dDiq6NkpSvntHoic3gce2bQcvXgaOcOLitxMmwhkuCKuC0JGghGUPn4+
         0czu2h0BSwh2NVAn811gUiabFba5KoTmfLs6TjK2aRcD8a8vzvaIeRRBNGA5N7rZVp
         5Qv/9Tom0CoyKJHt+7gUKC1vsxRNNPeCrU2nw+Ng=
Date:   Tue, 20 Oct 2020 13:08:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Replace dpm_watchdog by sleep timer
Message-ID: <20201020110810.GA194512@kroah.com>
References: <20201020095611.1763815-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020095611.1763815-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 05:56:11PM +0800, Joseph Jang wrote:
> Since dpm_watchdog just cover device power management,
> we proposed sleep timer to cover not only device power management
> issues, but also core power management hand issue.
> 
> Add sleep timer and timeout handler to prevent device stuck during suspend/
> resume process. The timeout handler will dump disk sleep task at first
> round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> 
> Signed-off-by: Joseph Jang <josephjang@google.com>
> ---
>  drivers/base/power/main.c    | 69 ---------------------------
>  include/linux/console.h      |  1 +
>  kernel/power/Kconfig         | 27 ++++++-----
>  kernel/power/suspend.c       | 19 ++++++++
>  kernel/power/suspend_timer.h | 90 ++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c       |  5 ++
>  6 files changed, 128 insertions(+), 83 deletions(-)
>  create mode 100644 kernel/power/suspend_timer.h

Is this different from your previous patches?

If so, you need to properly version them, and put below the --- line
what changed.  Otherwise it is impossible to review.

Please fix up.

thanks,

greg k-h
