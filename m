Return-Path: <SRS0=fYoc=T3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DCCC07542
	for <linux-pm@archiver.kernel.org>; Mon, 27 May 2019 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB652173B
	for <linux-pm@archiver.kernel.org>; Mon, 27 May 2019 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558949800;
	bh=jh1bhLGtbTvFOluWYAgIyKUwfQLk932OWmNmU1oppsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mBMXXSpf72nzHiSZ5uryekhDw4+cA9BUK2AJLbTH6UFvVaFlugc+xKhhG/feXdXuz
	 yovbw4bXTBA3TglvnG5gJpQmIdLjg3XYkQo+jk7AWnCWOqdxbOfxfpZTX/9+ZlWhhy
	 Res3luJ7LQWcEcCMLQBsI2YgGYwv20L9XTnV8VIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfE0Jgk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 May 2019 05:36:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44104 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfE0Jgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 05:36:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id g18so14241219otj.11;
        Mon, 27 May 2019 02:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jh1bhLGtbTvFOluWYAgIyKUwfQLk932OWmNmU1oppsg=;
        b=AaRLvIJ2uDS7RKpZLW72BciueQgirg4vSGGreHHtKHqiymksmXYn3flBSQhfAiQqFk
         qMGrXGWCiwkdSfhIetarYRYUhAoYwsuXQ9o4oA0LgMia1MSWQhlaKHKsqKqQOgG2tn5a
         VMtv5sLo9PqL1CP5aMoocnBT14EBxMWfRXaJ6xjigqAHVPW1x5A6+VOkWXsqCx2l4IDH
         5ictpfLa0JJ4yBQ0859hSn3MdYYnfuInT/qS05pj4YKeg/raqaISDXy5Uf7k6T6k0kP+
         wC+hemd82Yv25NSnuRdiRrYwnf56YNr91zeJ4rPpmgdFiFBs++tzKIGWHgdJPGMW0av0
         muOQ==
X-Gm-Message-State: APjAAAXsGgQoyLF0yN6YlftOCVj11E6WQ/ztCUYPuImf0cm8AFIxGLiQ
        gtT5E0JKRvaoptUpJDx6NV1WV6+HVIeRdS+QdUU=
X-Google-Smtp-Source: APXvYqxFW8TLWAJxb5ENowF4ht3Bubl5gIMqOk/DUqYSn7tvXS3KKADxk+5fLcqtI7X3lc8s4FkXlwxHKSxSkQRweV4=
X-Received: by 2002:a9d:3285:: with SMTP id u5mr60156205otb.266.1558949798974;
 Mon, 27 May 2019 02:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <11319987.O9o76ZdvQC@kreacher> <20190520060239.GA31977@lst.de>
In-Reply-To: <20190520060239.GA31977@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 May 2019 11:36:28 +0200
Message-ID: <CAJZ5v0i25VzAxZPrTBgCv1pKqdRjXEBmnKNT8HtNUFSVeQBx4w@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Add kerneldoc comments to some functions
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 20, 2019 at 8:03 AM Christoph Hellwig <hch@lst.de> wrote:
>
> >
> > +/**
> > + * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
> > + *
> > + * To be called during system-wide power management transitions to sleep states.
> > + *
> > + * Return 'true' if the platform firmware is going to be invoked at the end of
> > + * the system-wide power management transition in progress in order to complete
> > + * it.
> > + */
>
> Ok, so this only returns true if the firmware gets invoked for this
> particular transition we are currently in.

Right.

> That was my main confusion here.
> Also any chance to add an example of why this might matter?

Sure, I will send an update shortly.
