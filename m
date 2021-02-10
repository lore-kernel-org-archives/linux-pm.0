Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A33C433E0
	for <linux-pm@archiver.kernel.org>; Wed, 10 Feb 2021 08:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C5464E3E
	for <linux-pm@archiver.kernel.org>; Wed, 10 Feb 2021 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhBJIYV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Feb 2021 03:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBJIYK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 03:24:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E23064E3E;
        Wed, 10 Feb 2021 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612945409;
        bh=VJiP6abJMM0Su6pGO5hZby/1O1e5TrK9ylS0T3dXchg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ro0LhPtO3/RkuCZbLBlNIedsnLfyvIjyrCrQcrv/rd62fr8rYyE8wpglgI0xKSzp9
         3njnTgAMcyASVPxxH6qdZQc1YOnFdMeUWwowQcTHkFw1Kn2VCwBcq5ovZNLHSyVauj
         0OGSlYOWlDJtnGQeO2I8Kxl3izJDmCLxJouc+C0lI1Ix450e8NDwLCfKuPIhzAWLft
         nPY6rYOZMFQqPFUm6O2zllRUXvbAWT7oCtAhe3UvxWPVnnSw0kkGtQk14F9MIXey3t
         oa9XKOplMzdFn9vAl62Xmm5O3LMoAvttyqwR7I22a++7Q1wozjNgnx80YRORR2oiaH
         HhUOHotFhABFQ==
Received: by mail-ed1-f44.google.com with SMTP id y8so1829608ede.6;
        Wed, 10 Feb 2021 00:23:29 -0800 (PST)
X-Gm-Message-State: AOAM5330kHTI56FoC7g4og0Bma17mymD9qxwwH/hvuOmpRMhVAZucVkU
        rQ1xS4iz3qHf6akg4Tl1ElXpT2G3QccXIzqHdR8=
X-Google-Smtp-Source: ABdhPJwR0i+wMWRkRIdVXX5/+ms2VCS56xpQWXlXIB6AETk5jvmVA5tT2PWExKx1w84ltg5TAHvgJlkbYqYa+MEedJA=
X-Received: by 2002:a05:6402:1484:: with SMTP id e4mr2165360edv.104.1612945407649;
 Wed, 10 Feb 2021 00:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20210209230527.26712-1-r-rivera-matos@ti.com> <20210209230527.26712-2-r-rivera-matos@ti.com>
In-Reply-To: <20210209230527.26712-2-r-rivera-matos@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Feb 2021 09:23:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeqd7iMU+gVC-xT-MY6YKXrB88gsCyd9M0NX=wCtyWrmA@mail.gmail.com>
Message-ID: <CAJKOXPeqd7iMU+gVC-xT-MY6YKXrB88gsCyd9M0NX=wCtyWrmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: bq25980: Moves properties from battery node
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 10 Feb 2021 at 00:52, Ricardo Rivera-Matos
<r-rivera-matos@ti.com> wrote:
>
> fix: exposes POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT on the
>
> charger node

Why is this a fix? Why is exposing this property wrong? What is the
problem here? Why do you start sentences with a small letter? Your
commit message should answer such questions.

Best regards,
Krzysztof
