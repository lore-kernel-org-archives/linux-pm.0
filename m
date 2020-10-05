Return-Path: <SRS0=LE0X=DM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58603C4363A
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 11:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E92D2080C
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601897690;
	bh=Ff+T3/WRh1h/Ue8vSCN2s+MOdIGJb7NnWx3uvWPgX1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z1S4uzWRFth2PD2nTP6bC52+SJ/1ee10swpIkoe2R0bawzGbvHCMA/JNCHUCs7pv0
	 VYVLAkkmXYV662p5R2fRWzBjweepRzCWJeeDPmVkF1o5ZmYoltM24tTJCkrg4jyPWT
	 0KeaYqF3DYmj02oXz/aAnwP9XErSqz3En/9a93gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJELet (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Oct 2020 07:34:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39441 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJELet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 07:34:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id c13so8377269oiy.6
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 04:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6gY4bhrfB6SUv7OxXWkkMPAGlGzZ2ouw3/MLXRT6Yk=;
        b=BBCIE15GJlDTN8pMucDK0es8XJe0/Gb+G5OzAGoEonJb0qcKMpBdh+s51eEfT3A31z
         LsZzRPDHqLtpw11JbsruIFNvTuC5w4ASjgytL+ZKQH6rIubI5jj7x4ZFQnMsPhB2VU4R
         5FgZoPEKfRH9lo6IrtFp+6VaTOe1LOtHOEr0vQQ6rnlCxkoJv3ku4/I6CpHj/8hLwOhk
         B9sX2laxxqjNW/KOALh6WaMR98L4Stp860DSoiKzBIlwvSW+bDIOzeouNo+U+BRRm/KY
         ljsdQTylM4aimbV+j8k1aVsVJHGDR1EWWW1bcD8M35Vu6Z9hdnqhnljRR+Jr/C5a0HE8
         fcSA==
X-Gm-Message-State: AOAM530ND6v3C//tPM+LxU6/mpM7WX1Z2qnSDSLiGeUsoNeVM2GhGIqT
        64UhbhqRiMgrTy7CP9Linf0fR0XLJlg2wsEyt8TSaxsa
X-Google-Smtp-Source: ABdhPJyc3yf5b+giWfAJR/IKrtMpOEKm9MkoB7Nig5gfHgljuX+Bz6FEPvX/7dvBpveqA8Wg8oy9g6CIr9kqTBf8XXc=
X-Received: by 2002:aca:5c84:: with SMTP id q126mr5566490oib.71.1601897688846;
 Mon, 05 Oct 2020 04:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201005112522.uzs2iax3umhxvtcl@vireshk-i7>
In-Reply-To: <20201005112522.uzs2iax3umhxvtcl@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Oct 2020 13:34:33 +0200
Message-ID: <CAJZ5v0gMU6wne6E70Wqs-6Shp8PUFpd4hqPnG4RxnVOGJUT_Eg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.10-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 5, 2020 at 1:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - Return -EPROBE_DEFER properly from dev_pm_opp_get_opp_table()
>   (Stephan Gerhold).
>
> - Minor cleanups around required-opps (Stephan Gerhold).
>
> - Extends opp-supported-hw property to contain multiple versions
>   (Viresh Kumar).
>
> - Multiple cleanups around dev_pm_opp_attach_genpd() (Viresh Kumar).
>
> - Multiple fixes, cleanups in the OPP core for overall better design
>   (Viresh Kumar).
>
> -------------------------8<-------------------------
>
> The following changes since commit a4501bac0e553bed117b7e1b166d49731caf7260:
>
>   opp: Enable resources again if they were disabled earlier (2020-08-20 11:30:22 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to a5663c9b1e31c00e0bdfaf4d92eb51358fc3950f:
>
>   opp: Allow opp-level to be set to 0 (2020-09-16 14:02:34 +0530)

Pulled, thanks!
