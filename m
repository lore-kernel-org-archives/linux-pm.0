Return-Path: <SRS0=+XkI=CE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C733C433DF
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 17:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594B120738
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598461243;
	bh=PK2AREGsgo2BJQkLoTxbptoSZnFMwBXWBdBmpLjVG8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0mPX89ZIseeoDZKMgWktpYy6Up5uyDh4lR7hW1p2kGOUy97XcUr10entYhgmC2VUL
	 SW9L/Ec7dIwj2T0AjciDBPL6UhmKXKsZt5DgnZIar5jFYkD2y5Z/idNnaURkVI3J3j
	 f5YVRJc12TMD4meKUeZriP9lhNS5dzqEdFHR5i1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHZRAm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:00:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41933 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgHZRAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 13:00:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id a65so2070528otc.8;
        Wed, 26 Aug 2020 10:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PK2AREGsgo2BJQkLoTxbptoSZnFMwBXWBdBmpLjVG8I=;
        b=nwlyG10eRuy3mSZoU5VhwnbQG1JvPDN82fzO4Y4zZR2hQ+AStUCG+S4y6ExJbMBut/
         40qg+4XTqqd4ofPf2AMzdiOaBhHO5rkcd/AyCW/2NndGdW2JPS27Hta0vKe6k0mrtw//
         fkV1fWVtjr5ywj5ROm2ACH1zK328tyzl+hzAQgJRIIXRX8NNOdftJS0P9TqippCTEtGb
         k7ZzRQ/xc6FMpyrOwlbMiP9cvDQv5C/YkqQ7CojIM9joGwErw8TcUbJHb14HoMJsw4HI
         VcpX9CIHMlfP4NtOQ7oL6USYs34E1vTtkXPiOwoN+2JN8voNRfWjHnigwTSUvl2DG+b3
         Dcqg==
X-Gm-Message-State: AOAM533zTReSVj6ZKKtmgAhtqeKzhJ55ntUiOKEkRLPkVDXDVzLfsYfN
        qrritDieDxDA58FnYawXO1wRrgxVw80JJ9k9h9k=
X-Google-Smtp-Source: ABdhPJzmuAPF17O9pdrF64IuZb2lUyWVFmVfah1qh0Pr2tFPah79a2+KuSIS9LNFrK10E4CYrQcBaK4YUihkpasyw0g=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr10580527otk.262.1598461239813;
 Wed, 26 Aug 2020 10:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
 <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
 <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
 <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
 <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
 <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
 <e9e6823d63fe2b9938e43a14c136b89aec0c503b.camel@gmail.com>
 <CAJZ5v0gPY+7YBeWwszoNBwsbKLFOEeuLaekdX62_gvbHXB8xoA@mail.gmail.com> <CAGX5Wg3bVpgaFXHb1=4ikGk0P+4=XRqROBU4pqw1mpsY06dbHQ@mail.gmail.com>
In-Reply-To: <CAGX5Wg3bVpgaFXHb1=4ikGk0P+4=XRqROBU4pqw1mpsY06dbHQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 19:00:28 +0200
Message-ID: <CAJZ5v0gJscMWLsjCm_L6jCDdZ2hdRB2mPtUBSgd1va7Xm7GyVA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Guilhem Lettron <guilhem@barpilot.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 6:46 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
>
> I've done more tests, maybe it can give you more hints.
> I don't see that much differences between both (with and without
> patches) in this cases.

OK, thanks!

I'm assuming that the topmost two sets of data are for the "without
the patch" case whereas the other three correspond to the "with the
patch" case.

If so, the processor clearly enters PC10 in both cases and the
residency percentages are similar.

The numbers of times the POLL state was selected in the first test
look kind of unusual (relatively very large), but other than this the
patch doesn't seem to make much of a difference, so I'm not going to
apply it.

Thanks!
