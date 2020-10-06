Return-Path: <SRS0=ZSVA=DN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C069C47095
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FE1206BE
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602013140;
	bh=esxM9ngH3Xs2Ut+gKUdeQ6ypzXoyEF4A53CkI6qV/Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z/Zfnng9RgZTQ282L6cJT9YIL2bu5SKkHRI/nE7A2qsVlIIDyOQgG5dids5jwzyiU
	 /1Ev9HXmp2sflhro+IPElAQW8FggM/aG2JSbMBwnAyIAfSiJQ5Zjj9x9TK/lWvrj+9
	 ZCQzLT/N2rqT0kdb8m3kARvt6MW9RRvUu/mrlqes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgJFTi7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:38:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45192 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJFTi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 15:38:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id f37so9868215otf.12;
        Tue, 06 Oct 2020 12:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqYmNdcba1X2zBYfUmvOF++PfDd8CuhGxZ7g4HEecZE=;
        b=JghTnOE3fgtsRpbi1CjfbfhOmygfK1zGdzBbde8s/n+nmL6k24J26z2/m3dS4hewrE
         c0Q2Yhx32YSFE0yLBZSXp+wJOygGh/7qQqo4kihAX2fadLLaioNvP/WB6eHTjJYY1NXH
         qMagxmgqHaABG5JPMk6vV8KA1g/UHtA3NtdRUhjcynofSgMvcJOz2iVaIM7cmwfYiCiK
         81ApWqtwx/3EYkA9vaud3NextV4z4eonBnxQj4cSr5uWQsevT5rK03Lr16uuXaP5Li5D
         tyhSTEw3x8GBkE7ByHL9YHjBri9m+nXJJAiigQIhpakSL4jRmRXshHtEQIuXcHyq0VEV
         rgWA==
X-Gm-Message-State: AOAM531aE7XHr6BOYOZX9NKISfQ2bW1FSFSotAhoqMfpzDrC4UyAFGlX
        MxTU/iT7y9lusGfL5xzuSg==
X-Google-Smtp-Source: ABdhPJz3nbs0BLBGLc7Xt8eDp3ZIh8VMut//oYe947BNCfVab2LNDOEU5hxoWKRnftmTTRirHJseUQ==
X-Received: by 2002:a9d:618c:: with SMTP id g12mr2184084otk.322.1602013136068;
        Tue, 06 Oct 2020 12:38:56 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 71sm1631074otm.81.2020.10.06.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:38:55 -0700 (PDT)
Received: (nullmailer pid 2702718 invoked by uid 1000);
        Tue, 06 Oct 2020 19:38:54 -0000
Date:   Tue, 6 Oct 2020 14:38:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-pm@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v6 01/10] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20201006193854.GA2702634@bogus>
References: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
 <20200930100203.1988374-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930100203.1988374-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Sep 2020 13:01:54 +0300, Dmitry Baryshkov wrote:
> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
