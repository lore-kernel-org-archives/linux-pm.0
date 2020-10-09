Return-Path: <SRS0=Nxon=DQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1EC433E7
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 05:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EF82184D
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 05:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCoNHHpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgJIFPe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Oct 2020 01:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgJIFPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 01:15:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A68C0613D2
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 22:15:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so5876810pfb.4
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8Nv66WyfzDbZb96ZzpHY2rCT/XGW71eFKJ/39nR8TI=;
        b=XCoNHHpR6Vhu0dp1FPc+9nNkBsd5828pOu6BwS+P8s2Vdorubxx2Y2IAtZsi/nMaca
         e+TkRySMistYnVoFo5Z9bLk7QRa4W6weIKbFGeJH0Vz5orS5mNhLXq3Hxd9Fa5Tgf1sI
         NhlYxCX+6eRYUbGun4XXVlbz7e6EjJaYRoKlddaptvY/bK1P1mXBltBbFfrGjZpRJxNo
         8xmC36xR0mcZ2Hjz/k2WlRrVCyu5dIOr9dlLZQKsLf81SC+yNk2TPlU20njb/v3X2Szc
         S2LTCV6AQnPdmhhH3HzZywkVzzDzkuiRUNg86ydh+cG09bU/omt0wDu3NEc9XYv88M89
         xn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8Nv66WyfzDbZb96ZzpHY2rCT/XGW71eFKJ/39nR8TI=;
        b=MeRIGhb3/j1AvpwOAzK/rDUxD4Qfi+EvwKVNKSyI31+JVcqxGwxTKJZ8YPhRCIwucB
         QRxOxNFaxC7a9nQuBPdvgp51tXeCfkqXEdK8/z1CNhQS9YKlLMfesktP5LPw4Cg5wTkR
         qWfqKSUlqp7mXG2QXmNEaH63F3g/OqOISm59Uc33cs1ewHDkuKbPeLFYPc/go2xNkLVX
         j5QZ/N4oulxXGJJZ9iZOmrtmv6SOAy6uGf778rVcnM49ERXx6KRwWWzoxnakv8xqlvHF
         SljqH0vF6w6g3eBlX5yvLzgenKgHVl6XSc+wEm9SPYIXz9WlRQD2op9Gk4KWnvZrLAXP
         JGcw==
X-Gm-Message-State: AOAM532TgvoWlpOB0uyOfoOCRAnUxHWA10+WOJU9ie/S3Dmdg1CGYtiM
        FUa172ABA8lsIibM9SXJC+qztw==
X-Google-Smtp-Source: ABdhPJwMAbt3m8tzVuwutYCoq9Ex4jJiYU6jAHGkyZslmrwAEnxhVZ77mlrygUBEez+RF7uvOzZPlg==
X-Received: by 2002:a63:d046:: with SMTP id s6mr2103311pgi.76.1602220534209;
        Thu, 08 Oct 2020 22:15:34 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id gd14sm9188455pjb.31.2020.10.08.22.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 22:15:33 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:45:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Register EM power table
Message-ID: <20201009051531.gmlpv4wnpbtyqldt@vireshk-i7>
References: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
 <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
 <20201009041912.nzhvubzmfox2twxg@vireshk-i7>
 <1602218579.21446.57.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602218579.21446.57.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-10-20, 12:42, Hector Yuan wrote:
> On Fri, 2020-10-09 at 09:49 +0530, Viresh Kumar wrote:
> > On 08-10-20, 20:13, Hector Yuan wrote:
> > > From: "Hector.Yuan" <hector.yuan@mediatek.com>
> > > 
> > > Register CPU power table to energy model framework
> > > 
> > > Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> > > ---
> > >  drivers/cpufreq/mediatek-cpufreq-hw.c |   50 +++++++++++++++++++++++++--------
> > >  1 file changed, 38 insertions(+), 12 deletions(-)
> > 
> > I don't see this file in mainline. What am I missing ?
> > 
> Hi, Viresh:
> 
> Yes, I base on my patches which is currently reviewed by Rob for the
> Device tree part.
> As I mentioned in cover letter.
> 
> This patch depends on Mediatek cpufreq HW driver patch submitted by
> Hector Yuan.
>  https://lkml.org/lkml/2020/9/10/13
> 
> I have asked your approval for sending my new patches based on it and
> you said it's okay to you.
> I will stop sending new patches if you have any concerns.
> Thank you so much.

Sorry about that, I failed to see the details in the cover-letter.

-- 
viresh
