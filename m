From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Wed, 27 Sep 2017 05:02:44 -0700
Message-ID: <CAKvHMgR9kKj+3DPpoRkk52B7caA7OBf1B0Rjv1q5KxmxpFU=3Q@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170830002939.ns43wldvffmwqhuv@earth> <CAKvHMgSyr8aZ1cVd-Zf6WHNkwyTcSBvRaVuDWuHEnuNM=MStUA@mail.gmail.com>
 <alpine.DEB.2.20.1708311150440.3243@hadrien> <CAKvHMgSkuzi_BuicT7edYrM8Q87pnPJcgHRMDJEB21wdNKf8ow@mail.gmail.com>
 <alpine.DEB.2.20.1708311330570.3243@hadrien> <CAKvHMgSKLJk2wB9pefYuGyMG2aNp7bCCaOMABGRxXZ9ju-ivHw@mail.gmail.com>
 <CAKvHMgRzFpueUccSL1iu_-EazCe76cF8iSAPyYgcxJ3dNOZejA@mail.gmail.com>
 <alpine.DEB.2.20.1709052214030.2058@hadrien> <CAKvHMgTE-vypWKjhR7QgQNHFbVNdg99MgARmC-cTv6vfjgzZFg@mail.gmail.com>
 <alpine.DEB.2.20.1709180731060.2547@hadrien> <CAKvHMgSnULnEAtW5Axi1fyJG_2YW7hD3K_-N5P3Xdq_Gn72z4A@mail.gmail.com>
 <alpine.DEB.2.20.1709192355160.2518@hadrien> <CAKvHMgTF8C+7xcO31MvVeepCmSiP4V6tvvC4uVfcA4_JAfFHsw@mail.gmail.com>
 <alpine.DEB.2.20.1709201108070.3290@hadrien> <CAKvHMgTUrdF_ZmJYOB3jn020BMv-70MLpUBosBLstDrBN_KY9w@mail.gmail.com>
 <alpine.DEB.2.20.1709271154400.3186@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:38618 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdI0MCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 08:02:46 -0400
Received: by mail-io0-f193.google.com with SMTP id e9so6048320iod.5
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2017 05:02:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1709271154400.3186@hadrien>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "Andrew F. Davis" <afd@ti.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi Julia, thanks so much for your help!

On Wed, Sep 27, 2017 at 3:02 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> The github version of Coccinelle finally supports the semantic patch for
> your code.  I have attached the semantic patch.  I wonder what should be
> done with this?  Do you want to use it locally with make coccicheck?  Do
> you want it to be integrated into the kernel?  Everything in the semantic

Yes, our intent is to push it upstream. Can you submit a patch?

Did you test with 4.13? That should show a handful of dupes...

> patch depends on the occurrence of BQ27XXX_DATA, so if make coccicheck is
> used on files that don't contain this word, they should be ignored very
> efficiently.  So perhaps it is ok for scripts/coccinelle even if it is
> relevant to only one file.
>
> julia
