Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86689C43334
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jun 2022 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiFJSuj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346510AbiFJSui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 14:50:38 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE45206115;
        Fri, 10 Jun 2022 11:50:36 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31332df12a6so1124747b3.4;
        Fri, 10 Jun 2022 11:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zg5nhfhR1dS86/PnlRjrVj5+Z4ny3+vV77W6zv430TA=;
        b=rVkv/0pp6SFG705BkuuAZ55Y7H28IPNEW/8IU9ViQzparFBniRPn8guOQPRR7dEa9v
         QhzBiScKRhMdHh2EeUx8cxIsaZPs6pEp1KeItSmnZyWolVyy852W/D2cfBdyIyplzANN
         bXIkKP0VrPQ+EdmW95NHUigO0XmWAEjdwjgcz0aE8YIaKrqgFrZI6vn9epOzu5bQfgWt
         hDPB7Hfpi/ALY7qNDdenMKH+NjFfunjVQGn/m1HBfWs9c4me2YHr5tF7yoxa5ERLP/nX
         qjNkwIZBk8eTBZvw0I9J2OI1Aa4aZXmeEK3qNIVe5I3+U3/jKGvt01l6WrSver7YVp+g
         d7ig==
X-Gm-Message-State: AOAM530DC8WIuN5Hr7LY3Wxndqbu7VSnuGua9i2Br3Szc8UZqV40s5Sh
        RtS1JIFoyKUd8X/lEPJ5t0yjraJJqosjII3Cs64C4v9e
X-Google-Smtp-Source: ABdhPJxWctd8PPEhgxmBSLosaS7ysilaQrgbqp0786xv4/4FewJt9dAKQU/8iL0985Vd14+b/WKc8co5X6xH/PPrwxA=
X-Received: by 2002:a81:3dc6:0:b0:313:cc8a:e39e with SMTP id
 k189-20020a813dc6000000b00313cc8ae39emr2350208ywa.196.1654887035305; Fri, 10
 Jun 2022 11:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jun 2022 20:50:24 +0200
Message-ID: <CAJZ5v0i-BD=00qDK_mZ1=BF3DJeGA5CPLV+tUpEd2iEz0YHmsw@mail.gmail.com>
Subject: Re: [GIT PULL] Power management fixes for v5.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 10, 2022 at 8:47 PM Rafał Wysocki <rjwysocki@gmail.com> wrote:
>
> Hi Linus,
>
> Please pull from the tag
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm-5.19-rc2
>
> with top-most commit 67e59f8d019fb097f35c82533cc9b27bb392e5b1
>
>  Merge branch 'pm-sysoff'
>
> on top of commit f2906aa863381afb0015a9eb7fefad885d4e5a56
>
>  Linux 5.19-rc1
>
> to receive power management fixes for 5.19-rc2.
>
> These fix an intel_idle issue introduced during the 5.16 development
> cycle and two recent regressions in the system reboot/poweroff code.
>
> Specifics:
>
>  - Fix CPUIDLE_FLAG_IRQ_ENABLE handling in intel_idle (Peter Zijlstra).
>
>  - Allow all platforms to use the global poweroff handler and make
>    non-syscall poweroff code paths work again (Dmitry Osipenko).
>
> Thanks!

This was sent from my personal e-mail address again, hopefully that's
not a problem.

Cheers,
Rafael
