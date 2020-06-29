Return-Path: <SRS0=4COa=AK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A5BC433DF
	for <linux-pm@archiver.kernel.org>; Mon, 29 Jun 2020 22:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE95D206E9
	for <linux-pm@archiver.kernel.org>; Mon, 29 Jun 2020 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593471457;
	bh=5MJQJznnXjAAqH2IsfbyAP07tOgYQTg/CbKEJ3PGrAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/yjxstS5A6ydb0l85WMgmUhT/boDBqqllsZ775SkwqI5mShGRhe1YbKV7b9JftIA
	 PNS0P5g+pSJ80ZDEXwy686gt4eB8uSOo1Yx82CQE/PSfK4pcqMdKFH9F/uM/5Prx0q
	 BSk+jtvVEpCOZKUeZC4Wd0GDuhxKD2PuIkkfKP1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgF2W5d (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:57:33 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44844 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgF2W5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 18:57:32 -0400
Received: by mail-il1-f194.google.com with SMTP id w73so4148652ila.11;
        Mon, 29 Jun 2020 15:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dp0rGNgZmkxwh7zp+29hFN6emNIwuOOMBeYyx3CVAik=;
        b=LrwgjYpYvbOWJB9+8HJgaDN4FZLobwT8W8qETMZCZwe+v6/vpyTWe0jRMZ+Mkk6UB5
         GhNyPON7o5a+J4sXSO1Ga9Ul8NJruHojkD8RmFpRaUARvIpxJ8gW9Apwfht8dGx2ypAe
         /yxhT0zcBMWyk5FNAQ/OCo/qpz8ZElEJ+VXM3iNMfBG9zppohCiC4xtS55Y2FXx+3hwm
         ydQSkQkfCY+uqCIyB+pRA1oKUdcmJCUrsTNEU8e61b7WwNsc8JTfq5hFlsr6Hv9hagv2
         08NcjpFloYaJ1uhOltia6dCvfB3906q7Zw6WnIaaB05shBxfEVSAE+LJIgcsOl/g8MUK
         kD9Q==
X-Gm-Message-State: AOAM531jINgdmJhZQiZpqrc+TwZDraXx48dA6mhNxiDI1z2Pjgwuvddy
        l+U/HOs2aKNeVC1c9TauyQ==
X-Google-Smtp-Source: ABdhPJxwe1PjcRY+JXc5+U813s3C1AUlbXLLaCfBat76uCGtRfWqUuccOKkmM6ZqkcwcRMWCpSPskg==
X-Received: by 2002:a92:760d:: with SMTP id r13mr16384260ilc.68.1593471451159;
        Mon, 29 Jun 2020 15:57:31 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id p9sm498502ilc.78.2020.06.29.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:57:30 -0700 (PDT)
Received: (nullmailer pid 3124287 invoked by uid 1000);
        Mon, 29 Jun 2020 22:57:28 -0000
Date:   Mon, 29 Jun 2020 16:57:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-kernel@vger.kernel.org, sspatil@android.com, afd@ti.com,
        dmurphy@ti.com, sre@kernel.org, pali@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v13 3/4] dt-bindings: power: Add the bindings for the
 bq2515x family of chargers.
Message-ID: <20200629225728.GA3124127@bogus>
References: <20200622191837.9326-1-r-rivera-matos@ti.com>
 <20200622191837.9326-4-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622191837.9326-4-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 Jun 2020 14:18:36 -0500, Ricardo Rivera-Matos wrote:
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
>  .../bindings/power/supply/bq2515x.yaml        | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
