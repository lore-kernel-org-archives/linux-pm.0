Return-Path: <SRS0=trew=CX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA47C43461
	for <linux-pm@archiver.kernel.org>; Mon, 14 Sep 2020 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FEB20E65
	for <linux-pm@archiver.kernel.org>; Mon, 14 Sep 2020 15:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kldHqlgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgINPmB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgINPl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 11:41:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23CC06178A
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 08:41:27 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 60so349031otw.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZELQhGU+/XtL/55nDBDugsi7ueM9gHLCZBficN7FL9w=;
        b=kldHqlgVGZ/L1PYKcsqUtEnMD/Q9aXDKd/gxzvCZ7KQiWwV87i0LUwBn0BrZo8xr4K
         FAAP45tRfhJ9KXuDoUxhjfwwcNO6alrS4tySG00FInO7DLbCqX+7pX/tDsyV5k2SI8xJ
         S7IBlUXutBVAu+M2zfeIH2IOfe1WdG2iNSOpBlqo2YR+ovIP4Lk427LLi70ohF/Ht7hn
         Jl02Kik0j6p5/XYhF/AK59H3zr4ZeAzThOSl8QjXW0ipDwsndDXaoow/H5mpu1yr3wYm
         H8OaA7NZjHv6Mq+h9JurK+57q9o3kbzIPUqme/9WuZut/XtoaemL9D87iVKfOmqNKEIp
         PB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZELQhGU+/XtL/55nDBDugsi7ueM9gHLCZBficN7FL9w=;
        b=Y+ey+k7ajCfo1VbPKIf/o9iBg8uvqDesQHFPgpeIusQTUmZcVQ2zK/w7pcZg4xCXGX
         kKBz0y/BTdvrIxTLSbQnb8wejNesfmEn9jaoLE5irZlXuJGG3Ja18xyA+uGipLcMyD1E
         h/EN9nE25RlRP9R6LLv6RbN1idmsrJRxXVcF2vHsavaqW7i89dIwiLvoOMZode8wHDhA
         2dIWruwBbOLm3q5UAjNTbexXbnrUe7Io7jK3smeALjUeDhqn0l2KVBVuBxWK4qEVKcya
         nboI2ALgRq9C4AZumDbRqL5LeADyTWckhk+prP7OGDDkbsqZExicVISKEcAMUlBSzJ3X
         vlZg==
X-Gm-Message-State: AOAM530EmiF6//JMZVRxmFlwEvWnMy3OIpO7j8YniUtrQbVGFARUr/ST
        HKPPKCD5JCNiuwX3XmLc4h2l07TqJQgZ2vz0hJ2sAw==
X-Google-Smtp-Source: ABdhPJxOXHJTmnoyvncutLUljQZPNcmmjD8ZnonC/r6sp0kl55kb8ZXthIsQjiYohus1Nn/JEPZJ+ZDFIEELZu6L0OY=
X-Received: by 2002:a9d:7350:: with SMTP id l16mr9254540otk.368.1600098086769;
 Mon, 14 Sep 2020 08:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
 <20200910140000.324091-9-dmitry.baryshkov@linaro.org> <20200913111544.20a03410@archlinux>
In-Reply-To: <20200913111544.20a03410@archlinux>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 14 Sep 2020 18:41:15 +0300
Message-ID: <CAA8EJpr4JSa9+3K1txbhyw64PgKdri_WNbW3yvQSkYMkD-zKYA@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] thermal: qcom: add support for adc-tm5 PMIC
 thermal monitor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 13 Sep 2020 at 13:15, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 10 Sep 2020 16:59:58 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > Add support for Thermal Monitoring part of PMIC5. This part is closely
> > coupled with ADC, using it's channels directly. ADC-TM support
> > generating interrupts on ADC value crossing low or high voltage bounds,
> > which is used to support thermal trip points.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> A few trivial things inline.  Only one I'm really fussed about is
> filling in the rest of the kernel-doc. I raised that in v2.

Ugh, please excuse me. Probably I missed that comment.

>
> With that fixed,
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
With best wishes
Dmitry
