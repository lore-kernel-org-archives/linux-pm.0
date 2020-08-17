Return-Path: <SRS0=thCJ=B3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9B1C433E1
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 21:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5164C20674
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597698997;
	bh=NWa9t1whbz9NbDJgG9DlpAoY4Xbe3OwCuf6SMloP8E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zW9MXpFSk7DFXVahBP7V7PmhIoSC8yYx7YeuCAChdDCu6Sgy4ucWwrZyQzxDmWFeQ
	 tkGp5h/08jX1q7yzF7irtpEUarz/E4I///dK1I4XUtdPb2JRs/FXF+AITHq05g+XC/
	 /+eYasXo5wvioT0IjdBdKRayDsngRkSqmyiQyaOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHQVQg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:16:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44111 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHQVQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 17:16:35 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so19004768iow.11;
        Mon, 17 Aug 2020 14:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rDCtiJKzaqe7DNdchc5HjGPeD1uFdGtYifNPXbA1BIU=;
        b=AA5727xdv6IIZDImBS845sBOLI/989XiTXFNwBEFP5nPrkkq7F2lHEwSi/c9aXHZRq
         m0N0wOPwz2RXjGiP3ji5WLUwyqbfv38TOIy/8jK+XkV2OLUqyjhRi1mbrSlwC4ro6Acb
         Or3dlA/OgfTYMkTGkIau5BPhonDsUF8H2QtY5YVnFybQslkhNRCkaGWGep+ayQPwnTPb
         NZFA/0rLMnQdNinMf14xX0FSO5KPQKYcDA/vtE2FYpb9anIL2paMQOyZoVKoegXpTp7E
         iBauoKUDIkiPjPhKUQMFDDEo0l6ZMAgXjrt0zvoqLgce95sr6fHYHyDX67ZTB79CbvtF
         ZCFw==
X-Gm-Message-State: AOAM531MSv40h1TMOxXJQ6NI6PZ1fG2MCq2yBRzmcMuQG8czHj7T4Mo/
        Dn2YWYQl2WayqRrDl+CeAQBJZQ07ww==
X-Google-Smtp-Source: ABdhPJyxLh1TGAwhI6LTSdEgU+MfCWvN5NYlMapCQapWFTFmwVbyIOM2oW72MEdk6lokq4mO2c8AMA==
X-Received: by 2002:a6b:8b87:: with SMTP id n129mr13338602iod.160.1597698994177;
        Mon, 17 Aug 2020 14:16:34 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id o1sm9927469ils.1.2020.08.17.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:16:33 -0700 (PDT)
Received: (nullmailer pid 1577042 invoked by uid 1000);
        Mon, 17 Aug 2020 21:16:31 -0000
Date:   Mon, 17 Aug 2020 15:16:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jonathan@marek.ca, agross@kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: interconnect: Add OSM L3 DT binding on
 SM8150
Message-ID: <20200817211631.GA1576986@bogus>
References: <20200801123049.32398-1-sibis@codeaurora.org>
 <20200801123049.32398-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801123049.32398-2-sibis@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 01 Aug 2020 18:00:43 +0530, Sibi Sankar wrote:
> Add Operation State Manager (OSM) L3 interconnect provider binding on
> SM8150 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
