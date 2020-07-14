Return-Path: <SRS0=bP2c=AZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E8C433E3
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C2120658
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594760903;
	bh=5+7Oa6bGEY4INb0mM3mae8Q/Fewg5Jr8C8cF2pLqilA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iB/WxgqLnecQhNAg2sFhCHckmwhKYHeuj1spwYe6Aw9p29nZAb63KMi6LvjI7sHKE
	 i0bjIWoigr+jxz8szkxsE9P1VJlh4oX1i57B2XcDye5vJ0MagUE9Q7zpg6N/hzLe22
	 K2HYRCndbJL5Vf5xHfsKC36KcKkbz8y7+WqLOb6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGNVIT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:08:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39237 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGNVIT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 17:08:19 -0400
Received: by mail-il1-f193.google.com with SMTP id k6so57500ili.6;
        Tue, 14 Jul 2020 14:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=47xVzqClcakdpwxsWPSzbhTXJk9iY+clY3tNe/dil2Q=;
        b=LL4uvTkqgTWkNsTvc97n7Q+onw5+8y23ts5Q/NKy2mSW9RUd/z8uMRIHEJ5pTGE7J6
         QVYm9rhGZLRbo3+uSzCQPzEfqzF7W1+qMjOoJij1fatqv2ysrrAz97Y2NEpspElaF80U
         dfcvDeeRbG9BCojenUaO8WcBd4/HIaR9jXzo9o7envLQR4xRb/vR31IQXiFXW7v6Ox9M
         1BepSVNXBZuxwyqGECfsH++Zcu5KHa92WCeAw8orStL4UDjA30q5dTXsUrddBz+q7Xie
         g3bIMFNVSkndc1FF28vl/A32ZAIwsBYUtExOJLNMrI52yTVJt7vUKi1kWAaX3qRiVz/i
         cI+A==
X-Gm-Message-State: AOAM530447q/v6ZkOIyKdIxIpwWzALD0PCY1d0oSbB06PG0cNJI+Zp7K
        BCVaxSewU1FLrwcCvwGVHg==
X-Google-Smtp-Source: ABdhPJxk4CD0RmuAu+456Gzol2Zv7+diPbeNAwAx+o8KXZ40zRoA6BoDZbLLN1AGaDjYYmva06UBPg==
X-Received: by 2002:a92:cbd1:: with SMTP id s17mr6598323ilq.43.1594760897955;
        Tue, 14 Jul 2020 14:08:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n7sm84082iob.44.2020.07.14.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:08:17 -0700 (PDT)
Received: (nullmailer pid 2919365 invoked by uid 1000);
        Tue, 14 Jul 2020 21:08:16 -0000
Date:   Tue, 14 Jul 2020 15:08:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: power: supply: Extend max17040
 compatibility
Message-ID: <20200714210816.GA2918005@bogus>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
 <20200624155633.3557401-3-iskren.chernev@gmail.com>
 <20200713190310.GA546410@bogus>
 <c4dc5045-48ee-a27b-98a8-22fdb37d6ba9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4dc5045-48ee-a27b-98a8-22fdb37d6ba9@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 11:49:44AM +0300, Iskren Chernev wrote:
> 
> On 7/13/20 10:03 PM, Rob Herring wrote:
> > On Wed, Jun 24, 2020 at 06:56:29PM +0300, Iskren Chernev wrote:
> >> Maxim max17040 is a fuel gauge from a larger family utilising the Model
> >> Gauge technology. Document all different compatible strings that the
> >> max17040 driver recognizes.
> >>
> >> Some devices in the wild report double the capacity. The
> >> maxim,double-soc (from State-Of-Charge) property fixes that.
> >>
> >> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> >> ---
> >>  .../bindings/power/supply/max17040_battery.txt    | 15 ++++++++++++++-
> >>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> index 4e0186b8380fa..554bce82a08e6 100644
> >> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> @@ -2,7 +2,9 @@ max17040_battery
> >>  ~~~~~~~~~~~~~~~~
> >>
> >>  Required properties :
> >> - - compatible : "maxim,max17040" or "maxim,max77836-battery"
> >> + - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
> >> +         "maxim,max17044", "maxim,max17048", "maxim,max17049",
> >> +        "maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
> >>   - reg: i2c slave address
> >>
> >>  Optional properties :
> >> @@ -11,6 +13,10 @@ Optional properties :
> >>                  generated. Can be configured from 1 up to 32
> >>                  (%). If skipped the power up default value of
> >>                  4 (%) will be used.
> >> +- maxim,double-soc :         Certain devices return double the capacity.
> >> +                Specify this boolean property to divide the
> >> +                reported value in 2 and thus normalize it.
> >> +                SOC == State of Charge == Capacity.
> >
> > This can't be implied by the compatible string?
> >
> 
> >From what I can tell - no. Here are multiple examples of downstream code:

Okay,

Reviewed-by: Rob Herring <robh@kernel.org>
