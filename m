Return-Path: <SRS0=mEUM=W6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A22C3A59E
	for <linux-pm@archiver.kernel.org>; Tue,  3 Sep 2019 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE6722CF7
	for <linux-pm@archiver.kernel.org>; Tue,  3 Sep 2019 01:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEo9UD6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfICBeS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Sep 2019 21:34:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41632 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfICBeS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 21:34:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so15093844ota.8
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RyAJR0cZy5gUrJpmgleotGVW6Am+iWZW2mEmMmd/TI=;
        b=IEo9UD6CA5e2Wlj1p54d79TtAP8JAyvFbYls0jhsiuyDJ/VcOiVzT43lPXuavDqntP
         QMOW9VUOt10GQUAL2tHf1xwcjTQtxTjP3jilVhXPjA0Otxgz/VSCJznWdr6VtKG2HATU
         aCf52sJu/ctiCYWfUsQwlmswPsG174Z9R+x4fPcmOhcNV7PFmLwnshipHntpfo/PT5Ez
         17MfStpajZxrAhUjZK/0sKru663HXA7EnNDblOQCrGsNGFaEb/eYLY0kdL3cK1jSAAII
         ANNOGoaOk4GkDe0CuxqMQ07mC4imPv5gPf3e8ikX9t3ePfHqD+4frSeSRonsVBP7sRHr
         jJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RyAJR0cZy5gUrJpmgleotGVW6Am+iWZW2mEmMmd/TI=;
        b=NJwVMIXYyw72eGM7CVnJRM+KRFsyrOoC881Gc9/2w88VHO7LSadKPhW3YLrva/G1rn
         YKj3FE65DHheplyycyk5xITsxvA3n2qbuUGWdYgJTzLvaHCy1v9iys4PHp4fp5UzGw4W
         +BFP3BKNmx0GzlbQHBwDrg/mLh2HcqtXSeS1Qsv3U0QG4RpGeU+rVx2bAA4+/0Q0LyR0
         /V5AGMGXJJrp/hST5YC79kH0uiUG7+NqStezfu4aYbN4R5meewzYKTgPaR2H7onpiA8J
         S6o352hEiXOrILBh3L1F9+KZdLIym/Iuwp3y35INqOt0o3o5eymsl8QDZZFNpilgLhoC
         u+nQ==
X-Gm-Message-State: APjAAAVCUiOo/9jZFO443Uk4zSjM6mWBf8vlEKBJbzzEQ1mvBA0Qn3Al
        t2uoWkjvhjSzlyklQQGGCVCYrf/YHkBzzcnEwlgfdw==
X-Google-Smtp-Source: APXvYqwoH8r7iV28PdkpLbkgPHOKvEZqjvHZEuungti6w8x742pHbmbQLEilAiXKR4/T2TisQwpnAHUHB+WXyuzBEDk=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr913485otb.247.1567474457558;
 Mon, 02 Sep 2019 18:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564566425.git.baolin.wang@linaro.org> <20190902210409.c4mdm6akdlgctgsq@earth.universe>
In-Reply-To: <20190902210409.c4mdm6akdlgctgsq@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 3 Sep 2019 09:34:06 +0800
Message-ID: <CAMz4kuJzKgiPzecRROMMMzs73_2Vnf=NLF8fFMqbA0CBF7kn1Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Optimize the Spreadtrum SC27xx fuel gauge
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, yuanjiang.yu@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On Tue, 3 Sep 2019 at 05:04, Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Wed, Jul 31, 2019 at 06:00:22PM +0800, Baolin Wang wrote:
> > This patch set adds new attributes for userspace, and fixes the the
> > accuracy issue of coulomb counter calculation, as well as optimizing
> > the battery capacity calibration in some abnormal scenarios.
> >
> > Any comments are welcome. Thanks.
>
> Thanks, queued. I slightly modified patch 4, so that int_mode is
> 'bool' instead of 'int'.

OK. Thanks.

-- 
Baolin Wang
Best Regards
