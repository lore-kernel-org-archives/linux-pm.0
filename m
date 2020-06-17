Return-Path: <SRS0=eD5R=76=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2EAC433E0
	for <linux-pm@archiver.kernel.org>; Wed, 17 Jun 2020 21:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1360721919
	for <linux-pm@archiver.kernel.org>; Wed, 17 Jun 2020 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592427791;
	bh=uInEkB+HT/2KqsuO8O1TSpB5xUIeWY3375gq2Sv4Wxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nyH7iZgMr7wb3jnDGu7c1eDx35TKVcXP5iwHCkA0w1BjfqHgVIQJZxKdXNqLPBJTb
	 9EMFWs+vYJexMxcseQIoi6m4nleImhIVlf7ogs8/EeCcwJl9iBTYChwsLDKQmX0xHB
	 zM2pl5wjEkzI0VkVtHvGZftWPxMEYS7N325kumg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQVDK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:03:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35573 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQVDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 17:03:10 -0400
Received: by mail-il1-f194.google.com with SMTP id l6so3747302ilo.2;
        Wed, 17 Jun 2020 14:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2pWRJW3ir9zz84FjRUTFElmgVjVrrix+gOBZgLc5ak=;
        b=deX4f500Rwh/XuhNDlS+bqey4KgYyk6yYwIoH1FaSV0SMOTHc0IO0QY842RG6+s7VJ
         OMmDGbgRYGqLt7NflHweC9Ttgu4BElTyubyXGabpBzBiROy1KSQ0DrEJVC8NtWh6IdHT
         fwCoDSWg1Rk22LgoJZ5jhPbfOriW/qmYHfQuylsSG1BNHXd3qYvVfn4Iot7AIr1mXnKL
         kwmID9tSPFj931ADb06NVqMNYTIGcmoPD6xKWcJc5Oe4cieShYbo4ktybWG/GcePA0FL
         sVRua2QRjcUS9A5fMnPGdTqaOHnsBlenWZ3VMbo+z0NL5FndHiYp3VU5nIuucYJxP8Jk
         jUgw==
X-Gm-Message-State: AOAM530EcWIidXJvb20lBqVMED29erwxdugDE8SHo1FDpCWgH3Ers78n
        FFOP8HkGY3aNbsY33k+gvg==
X-Google-Smtp-Source: ABdhPJzrVkrg6HOgMPJQb6/9AIoRaUc6RAJteP/WGGSlsJCUz6rlkyKSdDN7y1fo4MKb171bLHlrvw==
X-Received: by 2002:a92:dacf:: with SMTP id o15mr792880ilq.36.1592427789367;
        Wed, 17 Jun 2020 14:03:09 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p22sm538722iob.29.2020.06.17.14.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:03:08 -0700 (PDT)
Received: (nullmailer pid 2810706 invoked by uid 1000);
        Wed, 17 Jun 2020 21:03:06 -0000
Date:   Wed, 17 Jun 2020 15:03:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arm-msm@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, sibis@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: qcom-tsens: Add compatible for
 sm8150, sm8250
Message-ID: <20200617210306.GA2810638@bogus>
References: <cover.1591684754.git.amit.kucheria@linaro.org>
 <c3361043e66139812bd4cd85b917659d85e1564f.1591684754.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3361043e66139812bd4cd85b917659d85e1564f.1591684754.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 09 Jun 2020 12:14:54 +0530, Amit Kucheria wrote:
> Added tsens bindings for sm8150 and sm8250
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
