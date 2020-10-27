Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D8C388F9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79222076D
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603821565;
	bh=8glpQvDPAPzJdBnBBhAbfAEqPSEFYPrZ2FcWd8xWbzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vJYok7ruYRx94ULHbdKOURZAa3h1v7OI+gt+Mf5yhg9ANvTz1njCPo3pDVf3FcUxc
	 9s0CXEmti03qaXBS7rj0+A0fyYBhtrFMsAV/f9bQo0koaZ6zBLslGCsUW50NKotJvx
	 itL0/Oj/Bd1AM7pHTWaIelu1r1+NGyF4eJJIzYwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823651AbgJ0R7Y (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:59:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41985 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823549AbgJ0R7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 13:59:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id h62so1916040oth.9
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 10:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qz6haxnA0/Kp9xEp+4tUMLDiltCcrSwrtCBVhzLYlYI=;
        b=LOagPaZQ/516EXt06sYieKxFC3SwMt1HQDdBoVDYsnhdADkbYaVX3tRpWjSMhVVHvt
         nSu55Eg//lR9lVSWLjywBLoli7o+THooDL3rKDREC4mzoB5t5YmSxplfpvU9K8qAitfA
         +C0uGfBVpT6fyBvz0k7YS5iD5Op1VVFhXpLBxBqdllTWCMrWEGAWgdBMUYGFu99bdyIz
         AoOHKZEilzcDiZEa6bAedSQJ7P4uuCmm7bkCrm2IzPczHffHw2x4ioLRAETjrwUU0HOa
         3+OeIyeS1kphiaY0KNrWB0r8Lz4QKPJDsMdhWKQ2zsYopwHytHWUdg5iJ49SU42H2Qqg
         MkFQ==
X-Gm-Message-State: AOAM533CODQxIIjeZ7fWNjXLoxBqakRHhuUCBJQD/oIadmKjQt7uMUPJ
        8yKRh09WgwhVo1lDXvUKO2V3CkbkioFb8RQVuiU=
X-Google-Smtp-Source: ABdhPJz4qULWtWsbMxfCznZb4yHXIHiiZxVJdAy865U7X9k03xt4wtDUhtDO6EpHAsklXxSkjMMcYrLhNUw6LUPVGaM=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr2356817otq.321.1603821561412;
 Tue, 27 Oct 2020 10:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080801.ztqiud2zcbg4bwr5@vireshk-i7>
In-Reply-To: <20201027080801.ztqiud2zcbg4bwr5@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 18:59:09 +0100
Message-ID: <CAJZ5v0iTnyXKVo2azDyP4G7TiZfbacvGJk9anKQeXV=bfMwmQg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.10-rc2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 9:08 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following fixes:
>
> - Don't remove the static OPPs erroneously.
>
> - Check for the right condition before making an early exit.
>
> - Avoid a lockdep by reducing the size of the critical section.
>
> -------------------------8<-------------------------
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
>
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes
>
> for you to fetch changes up to e0df59de670b48a923246fae1f972317b84b2764:
>
>   opp: Reduce the size of critical section in _opp_table_kref_release() (2020-10-27 13:21:03 +0530)

Pulled, thanks!
