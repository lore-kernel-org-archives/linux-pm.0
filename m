Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAFDC433EF
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiD0OJL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiD0OJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 10:09:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C74E389
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 07:05:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 15so1548581pgf.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OT8jLHi5I0OiZTy0LV6eIgEYpe0uYFZJA9KqVmBMVzw=;
        b=SrCfyOO36j1AT9uvoaS4hD0HxsHPiTi/Zy5MVVnulvhwb5YNHoxltXjGvslBhCNqbS
         iTySn/IB5d+64LM1C9WgYvoHu1w1KB+pV5D212QvcON3HhOiSUTmBWNTl/Iz98Yt02t8
         QpUsTbFJL0/uHrbDkPpawLRsJ5y7gKkxalTVnzG0seOeIIi662zyZNogfo2xOvcOEho8
         mrLpq8HQ5j5V4lkt17/dOwTt21cI8UJCNI+xWHO6lb5mHlZmdG2WhxheejJxdhi9CX60
         rOtpqy+b5DV79oHhBI11C0oj7NBXBVHtPD60/GoipuT6VI/3anhFYhCF4opst0xtVWlP
         ex2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OT8jLHi5I0OiZTy0LV6eIgEYpe0uYFZJA9KqVmBMVzw=;
        b=KviwkajkyHPc339MPvPp9PQp2PszK8+IwjUDY/coeRvZkUCFUijQ+QO6EDXAq7cwmm
         ZHmmaBibh1F8/3Hv/D2LnKifTEFRnyDBT+4EMnrv2P5XV5wRnujxWTO0pEWnuER9W4Ou
         T2bd8nTuTKWqhIRJ/eprzFcckzQoEJAMvzrCKe0RM6u4ZD2RTvVPqQzV1H6Pum8pwtKc
         5iugoHmUA7wP8K2BNXxGFA/WZQJKL+G7r5fa5wKbT8AuTaCLHQEGvhLfqcN8yzOwHtAl
         F+7hBCh2JsKEU+R/WAV6LGNEdnIipwBQCRWYs4Io/fHe5sPGKQB76cDaetbkBmU9NTDf
         2MKw==
X-Gm-Message-State: AOAM5333fskcNDHS5BHAiwL0z7yggAUjIv+N47i/hi+zIZkYZ0L9PcrC
        b9ONTWOqtC1nx4J+6lVkQrDVHg==
X-Google-Smtp-Source: ABdhPJyogLOjd4c37B198F/9gX6yPAM/D9FmoWqn+QNk98u1oleDEd359HLuknmbJwCvePhkv8ZUIA==
X-Received: by 2002:a63:6e0b:0:b0:397:f965:64a7 with SMTP id j11-20020a636e0b000000b00397f96564a7mr23830267pgc.581.1651068358118;
        Wed, 27 Apr 2022 07:05:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b004fdd5c07d0bsm18622190pfp.63.2022.04.27.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:05:57 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:05:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Message-ID: <20220427140550.GA560849@leoy-ThinkPad-X240s>
References: <20220416154013.1357444-1-leo.yan@linaro.org>
 <20220416154013.1357444-2-leo.yan@linaro.org>
 <YmhBE/JDV66qQIBv@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmhBE/JDV66qQIBv@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 26, 2022 at 01:59:31PM -0500, Rob Herring wrote:
> On Sat, Apr 16, 2022 at 11:40:09PM +0800, Leo Yan wrote:
> > To support path tag in icc-rpm driver, the "#interconnect-cells"
> > property is updated as enumerate values: 1 or 2.  Setting to 1 means
> > it is compatible with old DT binding that interconnect path doesn't
> > contain tag, if set to 2 for "#interconnect-cells" property, then the
> > second specifier in the interconnect path indicates the voting is for
> > which buckets.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > index 89853b482513..7464a50804db 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > @@ -118,7 +118,7 @@ allOf:
> >                    - qcom,msm8939-snoc-mm
> >  
> >                '#interconnect-cells':
> > -                const: 1
> > +                enum: [ 1, 2 ]
> 
> Describe what each cell value is here.

Will do.

Thanks,
Leo
