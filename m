Return-Path: <SRS0=Ia5J=CR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B6C43461
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D315920768
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594450;
	bh=IjecBUMNsGMpOyrwu++8aLByHfqCkW2ag00jaPPJmvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=10yNv8zGe5RFg2+XwxWZQWcatscvtKzO10DCAFfaDBxOeq5+K2KWWUTaNVPyFcjIf
	 Vi2EqoOEc80cu2BcyXlUcGqejh0+sKGO9qLwzHThrTkrPgQreRlTF6Hkx7Ac16uo0v
	 GTH+tdBs2Yr0NfFoQ290yI4/t9bdcVliqCgqdhPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgIHTrV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:47:21 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41278 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbgIHTqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 15:46:25 -0400
Received: by mail-il1-f195.google.com with SMTP id w8so64366ilj.8;
        Tue, 08 Sep 2020 12:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxfloW/du0FtuXMc7fb1vC2lzA6jvn4y8s0XgOBsOH8=;
        b=joOjemVdVg0rGYRBaxijCTLyXC1ABGQPRe2gGbBUAEeW+XdFTLbfsLdUrHUAMbqeHa
         oANjBrc104blQkYAqloN0iea2d/qzIolkNLff/850DXgQqsWxBWc4IJltjG8eJtdFJnr
         r2ujezMXMyzaIX2441IwVKZADWUpknZb1nzX/FhKUZ0kEZC21ZfwsqXhNAZ56z87SRrf
         5OLc3+muMIirACPQfYHEIdXptd7YkCBrlMP4TZCLmd7LK2Be+aSPMy0bk7Qorm6r2Qvi
         5lUIYdMA+4HtZpjmgLTkKZIoKjZ3g2jSrCUyoYwbz2XC5w5vz81wSDG4aJAPtwFXX5Z+
         t2kQ==
X-Gm-Message-State: AOAM531BCW2pmni1AlM7C/nchenW/oiYV+XC2M3LTPBLTN4NkzS9kRmQ
        PCLP2GLl9vlSj2/KfFoyBw==
X-Google-Smtp-Source: ABdhPJwfXlbhewMkiRkSXUg2HnOofi1QqFbxJeOtWC0GyonQWdvBxG98pU6ZFKLbPgzI9eeJYtTL3A==
X-Received: by 2002:a92:6b04:: with SMTP id g4mr376411ilc.192.1599594384637;
        Tue, 08 Sep 2020 12:46:24 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t10sm135379iog.49.2020.09.08.12.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:46:24 -0700 (PDT)
Received: (nullmailer pid 788543 invoked by uid 1000);
        Tue, 08 Sep 2020 19:46:22 -0000
Date:   Tue, 8 Sep 2020 13:46:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20200908194622.GA788479@bogus>
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906195103.1347-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 06 Sep 2020 22:50:59 +0300, Dmitry Osipenko wrote:
> Add binding document for the ENE KB930 Embedded Controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
