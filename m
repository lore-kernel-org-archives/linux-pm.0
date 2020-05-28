Return-Path: <SRS0=p2W0=7K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A11C433E1
	for <linux-pm@archiver.kernel.org>; Thu, 28 May 2020 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C688A20888
	for <linux-pm@archiver.kernel.org>; Thu, 28 May 2020 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590674000;
	bh=GgDD9K8yK+7XaTib0YM9Q3AY45GwSnRIBW7BWyfsWbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TDlupFr+g6r9vBe51WtW/xx+qP3DyCOMfctPPR0XABWP53ngks2cVp5y9EelMKDh2
	 UW6fVl+9plKSxTSkE9SQwhan72yM9cq4OvN6ewxJor0gBc2jvC8nFTWv9o9RIJttwb
	 KoFo/Ml2rGd4byYEAhgmLtXt7zu10nxvgTaqyAn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbgE1NxT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 May 2020 09:53:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42564 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390605AbgE1NxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 09:53:15 -0400
Received: by mail-io1-f68.google.com with SMTP id d5so20518906ios.9;
        Thu, 28 May 2020 06:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieGt96JN2xk1TOCoMTNWk75fkEMxKG58KHD7sTOPT/8=;
        b=Az4x/+zJt5jNmLXgD/ItBVMeY+4seAUmClARv+Xhf2fLclf7eLRlg8aMDbH/hjsG/a
         m+5iYfA7m2LYNkPyxGXFBLAxDNkkyAKHathH5Yahgg2SL0thhkjmymv+E5jOQZzFlG35
         9uPyMePTSJKk/VEWv77GBcUuIb92ISdzdhHfqGrYzBQlOr6p+VCZB0AXY/oBFy4sBKN4
         h79+3gWTaGojoNZHjmBH2jZRLkk2L+O5ChZPgFyuMAbupVHIjZ8WvV6El37cnHz8XQnE
         hgijH8KHPynIKCZTo3aOQ9eZ8IW7lP19kULsjDLyPhJqYkCH0qrC75YKojHQoU4Gn07z
         Rs5w==
X-Gm-Message-State: AOAM530brOa0AtMXa2S8BKj0V2fnzRZ71ILv6zuZB7zRy/sV1DvNxOK+
        T88HmCWeRKB/ngsmVHY7/Q==
X-Google-Smtp-Source: ABdhPJzclyEODFLn0tQ20KW9iwr5ozig07HeYHOTUhqj9NGRtRSCqqxxF+0SsfY7jJguIxnWcUP8dA==
X-Received: by 2002:a02:5249:: with SMTP id d70mr2695772jab.121.1590673994229;
        Thu, 28 May 2020 06:53:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d10sm3253459ils.69.2020.05.28.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:53:13 -0700 (PDT)
Received: (nullmailer pid 4157616 invoked by uid 1000);
        Thu, 28 May 2020 13:53:12 -0000
Date:   Thu, 28 May 2020 07:53:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     dmurphy@ti.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sspatil@android.com,
        devicetree@vger.kernel.org, afd@ti.com, sre@kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v10 3/4] dt-bindings: power: Add the bindings for the
 bq2515x family of chargers.
Message-ID: <20200528135312.GA4156923@bogus>
References: <20200527231743.18066-1-r-rivera-matos@ti.com>
 <20200527231743.18066-4-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527231743.18066-4-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 May 2020 18:17:42 -0500, Ricardo Rivera-Matos wrote:
> The BQ2515X family of devices are highly integrated battery management
> ICs that integrate the most common functions for wearable devices
> namely a charger, an output voltage rail, ADC for battery and system
> monitoring, and a push-button controller.
> 
> Datasheets:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.yaml        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2515x.example.dt.yaml: charger@6b: 'low-power-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1299261

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

