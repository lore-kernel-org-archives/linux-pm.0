Return-Path: <SRS0=sttx=DX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F770C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 16:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2413A20897
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602865841;
	bh=tMQhVtgWTLUrHnXhHeGDTXy+R8Q9Ulj7YjmL8avZ4i0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ii7oGhLHa1g7N1qCZCbLJyVmYveDHhYtkVKFeBoJtHF09MN2pgOX+x5YFZUC7GfsB
	 oKMfCIFCvv+M367ccM5Ttf18pBZyomAgZMwA55+0QL1lLUOpk+eLnnpiYUqmDyVey2
	 4ppTogbbj9MZHe187uWsoRUpbxIoYnrGoE0+s4vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408617AbgJPQaj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:30:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44702 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408429AbgJPQaj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 12:30:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id x62so3030231oix.11;
        Fri, 16 Oct 2020 09:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMQhVtgWTLUrHnXhHeGDTXy+R8Q9Ulj7YjmL8avZ4i0=;
        b=DE3jpborKFPNieaEhZtYIXksMh5JzhzmsSjufIfwEsu6Tn4UBecGVS8Gb8R//Yzism
         GQckDH8ZOiBQtFy0XZbxZJBcUbrkA3oiyY62jX1MfEdHdNLd8auzrMKMOsuif/EZf+u+
         f1iDjKzKg18nKe4cEXUaOwsYa5PeXs8msukOzdigPhS6UcjK0sghh8d0/2eL6NtvwmQC
         BOVSjJNLOqim2JoBVxIzrS9flq4piRb20J726HG+A/NyhQBlBOwuvjtYGnxEbGfsTr9Y
         oHeEt5cTg8qVC/D9splOJfaf7PsU0Cq6dwMVP2At7W5PWqM1iBVotYJv4rAMs/8+/ihT
         r1HA==
X-Gm-Message-State: AOAM530IsYnKzK/OYdllv8bulHzODFurCEGK/j9JkN4wgBFTeo1JWODI
        A9NKwbY0IpwEbfQGhFfXYRKAq8+Lb9MRZcB7Qmg=
X-Google-Smtp-Source: ABdhPJzQyn0JbPc7rGxUTeQ87yBu9s0xoUvfAxPzQH1y7cn5aiMsjxR8zZkxZV3SmT3VwlwdAELK2xZWa48odZL1CHA=
X-Received: by 2002:aca:724a:: with SMTP id p71mr3049209oic.157.1602865839368;
 Fri, 16 Oct 2020 09:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
 <CAJZ5v0iNQ51C5WYUy-ZhzpFGMLxSAVV8=xxYBfMX9ia6FOpg1Q@mail.gmail.com> <CAPDyKFrLTsYWVhR03hQgRJGGEkmTk5etGR5RcKgMW+Nj60+vhQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrLTsYWVhR03hQgRJGGEkmTk5etGR5RcKgMW+Nj60+vhQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 18:30:28 +0200
Message-ID: <CAJZ5v0i6CeUy4aQnyMmNyAHfdunWbbB2TsQwtX4QwNwYk+71jg@mail.gmail.com>
Subject: Re: [PATCH 0/4] power: avs: Move drivers to the soc directories and
 drop avs
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 7, 2020 at 5:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Arnd
>
> On Wed, 7 Oct 2020 at 17:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 6, 2020 at 6:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > The avs drivers in drivers/power/avs/* are all SoC specific drivers that
> > > doesn't share any code. Instead they are located in a directory, mostly to keep
> > > similar functionality together. From a maintenance point of view, it makes
> > > better sense to collect SoC specific drivers like these, into the SoC specific
> > > directories.
> > >
> > > Therefore, this series moves the drivers, one by one - and in the end, it
> > > deletes the empty avs directory.
> > >
> > > It seems best to me, if this can be funneled via Rafael's linux-pm tree. Then
> > > when going forward, each driver should be managed through the SoC maintainer's
> > > trees.
> >
> > That's fine by me.
> >
> > I'd like to get an ACK from the arm-soc side on this, though.
>
> I have looped in Arnd, to get his opinion on this.
>
> Although, I think the people on cc already send pull requests to the
> arm-soc maintainers (or perhaps it was these people you were referring
> to), so just awaiting their acks should be fine, I guess.

OK

For now, I've taken patches [2-3/4] that have been ACKed.

When the [1/4] is ACKed, I'll take it too and apply the last one.

Thanks!
