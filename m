Return-Path: <SRS0=HpGD=DT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743FC433E7
	for <linux-pm@archiver.kernel.org>; Mon, 12 Oct 2020 11:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9E4218AC
	for <linux-pm@archiver.kernel.org>; Mon, 12 Oct 2020 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602502340;
	bh=uqVTVg5KCfP+MGPioTq7sEjBeeRjqoms0QBCm4qjnPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B33GCUc3866i98kHYdQmRguWAaAvyoveKlszFwGfqZOrlZmguYbtC7VD7cKumA0k5
	 gmsSGumgxz6l7/3XfMn5kf9RovZyKGa8RK3CDCNDqXJEKhWvYZq0ViPZBPlRTlGenE
	 Jh1UM9CD3LMD6Hp/r33OEX5gX1/EWXXX62Nex5jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgJLLcS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:32:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33172 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbgJLLcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 07:32:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id t15so15588733otk.0;
        Mon, 12 Oct 2020 04:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4ZpKAn+stNCxSw5R7czdTo5agLU3Ug3iAu8crI2+nM=;
        b=tlEBwSjq+G0SF+o0Iu9daKYqmKAkl7YFAvIInGfT5S+Xx6D2au7FpWzJs242N4eDEB
         6/Tt2p/vGIPvXLrzl2IrdktGm72MhjQSPDFV64OqwAJ+DZ719DzqFI1pV/lDMJaVPwFN
         KQJYMmYNWz/MPRX+HTnQ+vioHpk2iMCxBQu43cdeB231gc9C4SvpN/GOCTsE3Razw47y
         4X1Zkco9iFq+LMJ9hFP+bUB2rokhFHzT89Jhz3O63Ck+rwJ0MBVW5HvMbLpXHNtwzGld
         XGSYt8Uo8OcJ8UJWx93aDGlDZHCqFNhQg7VyeZ/lSjtzxuMdEZ2nwUWp1UhVISL4Uqdw
         XqYg==
X-Gm-Message-State: AOAM530ime8s0NnCRvGLAEKDwYyC2nwJs9gVEQCmAL0phO8BLzDeofeF
        2iyaKiiGVd/srgyfNDq1r7hLs5Nd8TBJKgmj5XEt5T97
X-Google-Smtp-Source: ABdhPJyQpZgrxGbjpqXS/GpB4O13vCoPucQuy1qZ4GmUGOhXwGzKBJnr7tYz36CsKKqTb722800voTd29mUHK4f0dzo=
X-Received: by 2002:a9d:349:: with SMTP id 67mr18799651otv.321.1602502336753;
 Mon, 12 Oct 2020 04:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201010221806.2106-1-amonakov@ispras.ru> <CAJZ5v0iFj0s=ZNrLnBxQ34uUnn2NQ6bH+oriyNWrFu-g8HGfUg@mail.gmail.com>
 <alpine.LNX.2.20.13.2010121410490.15808@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2010121410490.15808@monopod.intra.ispras.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 13:32:05 +0200
Message-ID: <CAJZ5v0jzebmUJ8zYzCU1W08POdE7=+Uu5DGGjJaZLsp06+=YAw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: mention assumption that wbinvd is not needed
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 1:14 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> On Mon, 12 Oct 2020, Rafael J. Wysocki wrote:
>
> > > @@ -20,7 +20,11 @@
> > >   * All CPUs have same idle states as boot CPU
> > >   *
> > >   * Chipset BM_STS (bus master status) bit is a NOP
> > > - *     for preventing entry into deep C-stats
> > > + *     for preventing entry into deep C-states
> > > + *
> > > + * CPU will flush caches as needed when entering a C-state via MWAIT
> >
> > I would rephrase this to mention that the above actually is an assumption.
>
> This comment block is by itself a list of assumptions.

Ah, OK

> It begins with heading
> "Design Assumptions" and then lists two assumptions. This patch adds a third
> one.
>
> With that clarified, do you still need me to change this hunk?

No need.
