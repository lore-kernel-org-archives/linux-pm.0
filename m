Return-Path: <SRS0=iBKh=7B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6FC433E0
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BD7207E8
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914720;
	bh=KHmfH0Dqv1jN/iwb/KLxuZ/N8mBlBL9Mmuv3MdY45Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NWpOY1CaMWZG72mz/Qxdws8ttDim2ifWYM6W6GjPBCI0ZcTn8T3R8IolQn8HzPAvN
	 PYpWLxNwTFSLsGRi9dCogVYxHYCaHz/vkZycbeai8sJFtJ6VdMzFcy/G+9HQyp3j/f
	 MYYdLQqanJZC/8AlRXAGl0fW6xF1ZdwYtHBlzGM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESS6k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 May 2020 14:58:40 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37266 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgESS6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 14:58:40 -0400
Received: by mail-il1-f193.google.com with SMTP id n11so495766ilj.4;
        Tue, 19 May 2020 11:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pz2Hy0uekLRSK4zEbTvfMRi5VWjthw7cjakL1s2c9Wk=;
        b=BvhmFbdwOYJbirkEeMTRuzrhF3GtVg/S1ewIgZA17hGwft63LLbPV7d4RuvtK1ZXUn
         eTQbXs3+T/LxOKTf6mr8C30QuWC9DMOUmNT/uqLCgIbvlUC82LdD+zSBh8vzoxBFEuFL
         Gg8wexxmIscKYUAXL4/8koDNQqmZLn31ZtvIFVmTMaJLLjN6Ru86tA4OSZy5ttC9vlSI
         mSWvKqEkyxnV/S/kNajX7Qqkb8opEoVe4IyVLb0F+7NkQy8FM48a2770Q8rL0leGX6tc
         QTqT2k2jFrzIM8ppKFDoQO9mawIRzmf2PWqQCZ57m38H+c5qwldRQRs91U3O8NOSx8t5
         pLoQ==
X-Gm-Message-State: AOAM532qr17B4Jhp/andht7IblOG3S4qmyHydWHEhts//+yc61+i2WvB
        qlYraSVX0kcZfgb8BH5MFQ==
X-Google-Smtp-Source: ABdhPJzshUXBVmvGEW5Z47e15MtAHv6KiX6o24ZE2GlhumzoLz2ASW/KbjAxaMT3gIiBCoHHAC20TA==
X-Received: by 2002:a92:8318:: with SMTP id f24mr468586ild.288.1589914717838;
        Tue, 19 May 2020 11:58:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z11sm191385iow.12.2020.05.19.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:58:37 -0700 (PDT)
Received: (nullmailer pid 475406 invoked by uid 1000);
        Tue, 19 May 2020 18:58:36 -0000
Date:   Tue, 19 May 2020 12:58:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/10] dt-bindings: interconnect: Add
 interconnect-tags bindings
Message-ID: <20200519185836.GA469006@bogus>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-10-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-10-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 12, 2020 at 03:53:26PM +0300, Georgi Djakov wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> Add interconnect-tags bindings to enable passing of optional
> tag information to the interconnect framework.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v8:
> * New patch, picked from here:
>   https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org
> 
>  .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 6f5d23a605b7..c1a226a934e5 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
>  			 * dma-mem: Path from the device to the main memory of
>  			            the system
>  
> +interconnect-tags : List of interconnect path tags sorted in the same order as the
> +		    interconnects property. Consumers can append a specific tag to
> +		    the path and pass this information to the interconnect framework
> +		    to do aggregation based on the attached tag.

Why isn't this information in the 'interconnect' arg cells?

We have 'interconnect-names' because strings don't mix with cells. An 
expanding list of 'interconnect-.*' is not a good pattern IMO.

Rob
