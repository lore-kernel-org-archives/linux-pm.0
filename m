Return-Path: <SRS0=XwW7=AU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4BC433E0
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B4207D0
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594313696;
	bh=UznyOtaaICUoaaWynB3yxRxzQn6NRwVtjLug1/AzdeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NDDtbFSnFCBLr1zUq+OUMXFMv/mmPiaG4KIHo9PykNOuBfSj1/KuDrgXx7/qLix9y
	 e8fxE3ZfsFshZWx6u0hEj6sf8dApIOjlkTiap2VXvyAK+pNLDFXurQo4L1J6VNF0zo
	 T1mrvFu2GVrME1un+ZVXuDEg5ONp2OgaCgHn+Yu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGIQyv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:54:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37725 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQyu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 12:54:50 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so3065896iob.4;
        Thu, 09 Jul 2020 09:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGz/Zlxj80AaON4ZExXC6wPffqBZf12wYIQFvRvtTFU=;
        b=mjhxfGcDLXIH8n2jNgt6RvjU2fPWiJOC3gZMPuiDMa22/KsJ7O5RxItOEfwjW5ojnz
         a/loPK+quPsnxKPynDknLb9Cn9EUxlIryCr3NF+Sj+lcuQHQlyXFI6pEpFpp1/lsqT2p
         D6WiAXaXBxC5I8hjrxjJKrtQxAjYV7JfNIo4jeaQEqCRXS49Vp8uuZ9idpJPNUHGb9dR
         Jx3u1Fk/727u4zbNiuF+Jz1/1oqMsCLOkCC9BG74u68scjEESQtC2WMHcVdz6AqaT+K5
         1/DR9sQvCKXkLq+8CAqhzz83UA2Jy2jWavEQ8F3+c6be4RHJzeLY6mwsq5/1UJwQu0jH
         SX2A==
X-Gm-Message-State: AOAM530yrTBGMg5b9VbXL+uQ4tAL4H3oCwFJZuOTHpp6UpyX0kBdQVLY
        aZnxFCis3glcTa0M9LcEuw==
X-Google-Smtp-Source: ABdhPJwVHnWKGBfcmnHMtMLi5T9+D6bkCcY8zGSjmNL+jbQ/Q/bEuXfltsJTV1Viqjq6/RURN8zfZg==
X-Received: by 2002:a05:6638:252:: with SMTP id w18mr60811098jaq.42.1594313689499;
        Thu, 09 Jul 2020 09:54:49 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id l17sm1999262ilm.70.2020.07.09.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:54:48 -0700 (PDT)
Received: (nullmailer pid 510212 invoked by uid 1000);
        Thu, 09 Jul 2020 16:54:37 -0000
Date:   Thu, 9 Jul 2020 10:54:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     linux-gpio@vger.kernel.org, amit.kucheria@verdurent.com,
        linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        huangshuosheng@allwinnertech.com, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, wens@csie.org, lee.jones@linaro.org,
        clabbe@baylibre.com, p.zabel@pengutronix.de, icenowy@aosc.io,
        tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, liyong@allwinnertech.com,
        linux-i2c@vger.kernel.org, bage@linutronix.de, stefan@olimex.com,
        linus.walleij@linaro.org, rui.zhang@intel.com, tglx@linutronix.de,
        megous@megous.com, linux-pm@vger.kernel.org, mripard@kernel.org,
        anarsoul@gmail.com, mturquette@baylibre.com,
        srinivas.kandagatla@linaro.org, maz@kernel.org, sboyd@kernel.org
Subject: Re: [PATCH v3 06/16] dt-bindings: nvmem: SID: add binding for A100's
 SID controller
Message-ID: <20200709165437.GA509792@bogus>
References: <20200708071942.22595-1-frank@allwinnertech.com>
 <20200708071942.22595-7-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708071942.22595-7-frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 08 Jul 2020 15:19:32 +0800, Frank Lee wrote:
> Add a binding for A100's SID controller.
> 
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml: properties:compatible:enum:5: {'items': [{'const': 'allwinner,sun50i-a100-sid'}, {'const': 'allwinner,sun50i-a64-sid'}]} is not of type 'string'
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml: ignoring, error in schema: properties: compatible: enum: 5
warning: no schema found in file: ./Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml: ignoring, error in schema: properties: compatible: enum: 5
warning: no schema found in file: ./Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1325053

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

