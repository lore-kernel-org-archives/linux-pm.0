Return-Path: <SRS0=NdGG=CY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE38C43461
	for <linux-pm@archiver.kernel.org>; Tue, 15 Sep 2020 01:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B187D21741
	for <linux-pm@archiver.kernel.org>; Tue, 15 Sep 2020 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600132212;
	bh=uCKDXjHm2Ax7BYcsobVUOKx5dOo1yCQaMxcMukxjsBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VRvHfUq+RfohRj1PbjA5oUQZwS3G57i3lhNf8y94iE4x5r4gH460JrcjIXdsKUaVJ
	 bolAkQi85Mqu+mcLXcVO/K/y3FEZrg7F76k6T9+jEssXGTvtdIob+t10Wq4rAiDKW5
	 vJCVOU3ZvndJDKjI+iCBgemyoCfdXZ8CdFOBHuz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIOBKD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:10:03 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39018 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgIOBKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 21:10:00 -0400
Received: by mail-il1-f196.google.com with SMTP id s88so1433494ilb.6;
        Mon, 14 Sep 2020 18:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+ubHNbgowG+FKXqwgKkoFVUEQa/UrXtkPaD7UAdTeo=;
        b=r9Ai9+xn7r2KbkpvH32bcmUOrxBwzq7lP1DgGeteKbmLMMMQKAozcZLx54YmXwkqXy
         PLfgVgEbjk54BLpIA8K++uy0RoVB8iU/Xoi03qjKAxuQwVI9eYq+agRcVUxoy6Fx8xkB
         7HxpqOCwd7E264eNTtElNJttEIDkBLwMozizG2XPYqxoPrpWyCdsApe/dxVg3ToauxYn
         0gdYsNaQ3aTJz6TyhB5SlVgn0jLwWGeINAh84vG1AEyKfIBU5g35W2rzaQ5AB63z8PLX
         coVkS57ID2vaG0sW9u31Za45pXj2R+dVtmnVXHy3i5J1hWw6Ip5y2BTjq84wr5gAabsb
         RDsA==
X-Gm-Message-State: AOAM530adUmghKVK2EUe7XXpeKPFxkp+Bb3k743kNzDSBXRvgkqV2+Mp
        VZLGE9heZt8gjBiFLaWmXQ==
X-Google-Smtp-Source: ABdhPJy+dLlIZlvHlEbwDPr1r0xUhTHfI6MJGs6OqbvnaPkvnb3Zn62zBR72VFuQze1UAZu9G4q0Bw==
X-Received: by 2002:a05:6e02:cc:: with SMTP id r12mr13133471ilq.122.1600132199077;
        Mon, 14 Sep 2020 18:09:59 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j20sm7722411ilq.6.2020.09.14.18.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:09:58 -0700 (PDT)
Received: (nullmailer pid 634966 invoked by uid 1000);
        Tue, 15 Sep 2020 01:09:56 -0000
Date:   Mon, 14 Sep 2020 19:09:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: power: ingenic,battery: add new
 compatibles
Message-ID: <20200915010956.GA634913@bogus>
References: <20200906144726.8852-1-contact@artur-rojek.eu>
 <20200906144726.8852-2-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906144726.8852-2-contact@artur-rojek.eu>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 06 Sep 2020 16:47:26 +0200, Artur Rojek wrote:
> This binding can support Ingenic JZ4725B and JZ4770 SoCs, as they are
> compatible with Ingenic JZ4740 battery.
> 
> Introduce the following compatible property combinations:
>  compatible = "ingenic,jz4725b-battery", "ingenic,jz4740-battery",
>  compatible = "ingenic,jz4770-battery", "ingenic,jz4740-battery"
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Changes:
>     v2: new patch
> 
>  .../devicetree/bindings/power/supply/ingenic,battery.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
