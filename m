Return-Path: <SRS0=Evqw=EL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A2C4741F
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDEF206C0
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604601766;
	bh=LI4taUA4kI6V/vPsIElZdoMFNUYj/hNeAXdLWpTV078=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p4BlStq9moPhT3NWPNnbqTv9oGJe53JCybDcASxXLgbdzjASUj7067eaOY6+if6dE
	 UvZVLVT0LSPP4rJTU8twhLtJzGZN5cV9CTQ7bDAVcXCbS33er8K3c5xd8JiCxdBloK
	 q19vONF9EhwmG++FdmCc1GYERvuH1ydAwCG9hMH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKESmq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:42:46 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:37000 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKESmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:42:45 -0500
Received: by mail-oo1-f67.google.com with SMTP id q1so679930oot.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 10:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pozbfy3e9rlL1NjPXnXCx5o5q0X6ulNy5++GPKEihq0=;
        b=PB2Wr8ItE49BaMQ+dVHx4x4AFl2UgC9AxUISPuuk7+AEGWh2eQoGD5YH5qTR9uwU16
         XEFoC83yD22sC8KZNzRbfNfMG7NbHtwMWtgRXELap/VaACeF/02YKm7L04TB5+/g7XUa
         QGRomadzEi01T1NuUQ1DIT1X/LL8IsCYiDMhMBg9ltXmkaQDtQngntHFmGfDiLAtokJT
         2nK2ECJUtAnR2370+ees/Oxie4n8dLzP43FTxucZ6zXAt+99h6LQJABBYQt66BpW7i5c
         gaF96Ag9QRR4B9GMccBJ0vM4DsdRArbo1nzA43aj+JIVKt1I0IkJjoC2FaV4RFfEhw8i
         Qc1Q==
X-Gm-Message-State: AOAM530EWkRcFIk57oURHIR1QvS8xnTVNPVttWmnrcb1lINGGjSZm8rx
        RhQragbP/iG7WaA4hTt3HMoGzx75LhUJZyh0kvw=
X-Google-Smtp-Source: ABdhPJyoHjcOGdqgd45SDhgiyg0LwcqJ9KqT2BmcPPBv6+L8C0vhbX0J+7tsqTVwGo9ChaueAdvyRkfMRsP39O2oRiM=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr2748828oob.1.1604601764839;
 Thu, 05 Nov 2020 10:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20201027100004.GA30670@tsappmail.ltts.com>
In-Reply-To: <20201027100004.GA30670@tsappmail.ltts.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 19:42:33 +0100
Message-ID: <CAJZ5v0hYeTWM0UPMNof0DceTLriJjazCRLC8-PHOoH8POgPmOA@mail.gmail.com>
Subject: Re: [PATCH] PM: Use WQ_MEM_RECLAIM flag for PM workqueue
To:     ravisankarreddylingareddy@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        masaya.takahashi@sony.com, Shingo.Takeuchi@sony.com,
        Srinavasa.Nagaraju@sony.com, soumya.x.khasnis@sonymobile.com,
        ravisankar.reddy@sony.com, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 11:15 AM <ravisankarreddylingareddy@gmail.com> wrote:
>
> Deadlock is seen under below high memory usage scenario.

I'm not sure what the "under below high" means.

> kswapd waiting to reclaim memory is blocked on i/o kworker and pm_wq
> context which needs to wakeup i/o kworker is waiting for kthread
> creation which is again blocked in memory reclaim path.

Can you explain in more detail how exactly you end up in that situation?

> Use WQ_MEM_RECLAIM flag for PM workqueue to avoid this deadlock.

This works, but this flag doesn't seem to be appropriate here, because
pm_wq doesn't actually participate in memory reclaim.

> Signed-off-by: Ravisankar Reddy (Sony) <ravisankarreddylingareddy@gmail.com>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 40f86ec4ab30..ff5f3349e76f 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -933,7 +933,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
>
>  static int __init pm_start_workqueue(void)
>  {
> -       pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
> +       pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
>
>         return pm_wq ? 0 : -ENOMEM;
>  }
> --
> 2.17.1
>
