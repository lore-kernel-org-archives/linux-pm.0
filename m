Return-Path: <SRS0=UuxZ=6L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1024C54FD0
	for <linux-pm@archiver.kernel.org>; Mon, 27 Apr 2020 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC82214D8
	for <linux-pm@archiver.kernel.org>; Mon, 27 Apr 2020 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587977056;
	bh=awIxQSCMXYoZQDK52ZF9kACm/44AFjubUnt4fU/mK30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MNZXqCko3Bn6xJAEld2E2fBgMJskqzAkxBVwflTdMIf6tWth98D5m7kJD0KxbgS4h
	 /fLtHPcOTl3KNTMSihPXqSXdjafeaGjC7cpSMGQVFJJ1uQLubH1h3eQW1UgxtyeHPx
	 HdjJ0jLVUany2SaOXzghmIC33wsGA0b8fnQ0LXE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgD0IoN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:44:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36263 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0IoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 04:44:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id b13so24885555oti.3;
        Mon, 27 Apr 2020 01:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7PZSKjhCNlOl1JE2fl7JKkNcGODFwULz8sVcRzeFak=;
        b=isQmk7i6vBykZ+bqqp925veBDzWRs80XKqXKibKrTwuCtssGSwI7PZgaD4zGHmmngn
         TneDF83sUtmGHAb+wawf4mSbEias8vRLTDY1KOXX1JDQ6aTYz7xkGnvR2v3faFTepNE5
         Oz6B778zMLjwr2TbRSjLXmRtFtDTExJQJ3RvQDxwuPCaQRv1bn6HwTSOPjdncqtDFXpL
         s+LqvjV7b3BnmHNfY2PWRQdEyRUF1blfh2Hrgp04aRUQUq4H0pRMCOAE71TUV04f4RUv
         WxGSgQ72H4JJyHMuCQunJeKDpNZZU11bZr+C6EEcDAYzo6AXfbxsD13vCh/5tOyr79Xi
         BiNA==
X-Gm-Message-State: AGi0PuYWElwM4j2Vc0i2CeNSxmSvkUi31JhHlK9oQu02lBuGXMqsv1Yi
        S3LQ7jclN/z9SdMziN/TA+FuSkOXzYMnTZEhHo0=
X-Google-Smtp-Source: APiQypJUnWb3Dmq9g+U8cpYpdlem+kOYdhiTvns0Do1UHHo2sTY/VEP8OZ49UAjfixE3UKDsd1Qrgg/z0ro5DEZDEz0=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr17542881otq.262.1587977050743;
 Mon, 27 Apr 2020 01:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200424034016.42046-1-decui@microsoft.com> <2420808.aENraY2TMt@kreacher>
 <08f28683-4978-3e3c-e85a-303f6e46ef55@acm.org>
In-Reply-To: <08f28683-4978-3e3c-e85a-303f6e46ef55@acm.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Apr 2020 10:43:58 +0200
Message-ID: <CAJZ5v0gXHRWyoY29LNCMqYnkHcMN7jmFhvpO30c43Gte8Kmp=Q@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Freeze kernel threads in software_resume()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Michael Kelley <mikelley@microsoft.com>, longli@microsoft.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, wei.liu@kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 26, 2020 at 8:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-04-26 09:24, Rafael J. Wysocki wrote:
> > On Friday, April 24, 2020 5:40:16 AM CEST Dexuan Cui wrote:
> >> Currently the kernel threads are not frozen in software_resume(), so
> >> between dpm_suspend_start(PMSG_QUIESCE) and resume_target_kernel(),
> >> system_freezable_power_efficient_wq can still try to submit SCSI
> >> commands and this can cause a panic since the low level SCSI driver
> >> (e.g. hv_storvsc) has quiesced the SCSI adapter and can not accept
> >> any SCSI commands: https://lkml.org/lkml/2020/4/10/47
> >>
> >> At first I posted a fix (https://lkml.org/lkml/2020/4/21/1318) trying
> >> to resolve the issue from hv_storvsc, but with the help of
> >> Bart Van Assche, I realized it's better to fix software_resume(),
> >> since this looks like a generic issue, not only pertaining to SCSI.
> >>
> >> Cc: Bart Van Assche <bvanassche@acm.org>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> >> ---
> >>  kernel/power/hibernate.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> >> index 86aba8706b16..30bd28d1d418 100644
> >> --- a/kernel/power/hibernate.c
> >> +++ b/kernel/power/hibernate.c
> >> @@ -898,6 +898,13 @@ static int software_resume(void)
> >>      error = freeze_processes();
> >>      if (error)
> >>              goto Close_Finish;
> >> +
> >> +    error = freeze_kernel_threads();
> >> +    if (error) {
> >> +            thaw_processes();
> >> +            goto Close_Finish;
> >> +    }
> >> +
> >>      error = load_image_and_restore();
> >>      thaw_processes();
> >>   Finish:
> >
> > Applied as a fix for 5.7-rc4, thanks!
>
> Hi Rafael,
>
> What is not clear to me is how kernel threads are thawed after
> load_image_and_restore() has finished? Should a comment perhaps be added
> above the freeze_kernel_threads() call that explains how
> thaw_kernel_threads() is invoked after load_image_and_restore() has
> finished?

It isn't, because that is not necessary.

thaw_processes() will thaw them along with the user space.

Cheers!
