Return-Path: <SRS0=SH1q=CZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D35C43461
	for <linux-pm@archiver.kernel.org>; Wed, 16 Sep 2020 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CAF221E7
	for <linux-pm@archiver.kernel.org>; Wed, 16 Sep 2020 06:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600237613;
	bh=gC38JM6FBLhfaalO0Nuo7knnSRt6W60TtslSXBbHiQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=adYNa+5jgckmehhfrhhpPffStWz2P4f9D0vTYl2gFiAnXAG4YFlNEkj+qQJLXRMEv
	 WvKBHAN2hJzDO3GfSJ0nG/XsctjJghvJs33F39j/PmDq6m/Sa11qT4w+JPqlMJpKNM
	 8EQQjcq2x5JIQD07BQZug252T6Pv/c+ZLuVAhwfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIPG0w (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:26:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39599 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgIPG0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 02:26:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id b79so1652766wmb.4;
        Tue, 15 Sep 2020 23:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQSvi3AQDwgZ3cIv9Pssy5uEwdzPTRNpaJyNghcKf7E=;
        b=nu87SujOHu3dNsaT8taec1IBlkEGQPXi4HtZMErwAHdoIh8g0YfSkElw29GftHjvm4
         0v7VyjqGNnG7LZuX6HgU3TsPwQNLyJIEyqfFbTLrSS2SnzRTB5r7WqKl/S30BQooONub
         9eXsnpqQEFD6hMqJp6bqKt6WdpcDIqkhoi7mZp0rOSPAXVXwRxZ6cpmJo+pG91XkoZ3l
         5AQEkfVIwEnScVfuOqp4amX/J3ggACaR5yTFbhmRnqVbmEtXFi0Bib/hZYi7+nrQjjfM
         D0IFcGbe05zY2rfnqotIDNqp9x08qn0PBEzHtlrVaLreoVozzydRhs80HPRHrxmfx+GY
         I8qw==
X-Gm-Message-State: AOAM5315TvIKUcv7Bic4/hWLMIhttNcrVJ1ylbyRpKnjjK9kAmw5A6OL
        DcnXvsdswv/pnRinYPIkn68=
X-Google-Smtp-Source: ABdhPJwG3GLT7JBbKV8bo032isX4y0MBCOEJ7B4ZBBb2XAIS6iAf2toWE7hQxQ0XHGUyBsMjr20zZQ==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr2807249wma.87.1600237607973;
        Tue, 15 Sep 2020 23:26:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id h16sm32810557wre.87.2020.09.15.23.26.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 23:26:46 -0700 (PDT)
Date:   Wed, 16 Sep 2020 08:26:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: Correct interrupt flags in examples
Message-ID: <20200916062645.GA5958@kozik-lap>
References: <20200908145922.4502-1-krzk@kernel.org>
 <20200915165411.GA2113514@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915165411.GA2113514@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 10:54:11AM -0600, Rob Herring wrote:
> On Tue, 08 Sep 2020 16:59:22 +0200, Krzysztof Kozlowski wrote:
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> > These are simple defines so they could be used in DTS but they will not
> > have the same meaning:
> > 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> > 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> > 
> > Correct the interrupt flags, assuming the author of the code wanted some
> > logical behavior behind the name "ACTIVE_xxx", this is:
> >   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/power/supply/act8945a-charger.txt       | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Applied, thanks!

Hi Rob,

Did you mean Acked-by or are you taking this patch directly?

Best regards,
Krzysztof

